from django.http.response import HttpResponse
from django.template import RequestContext, loader


from django.shortcuts import get_object_or_404
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

from sbmlsim.models import SBMLModel, Core, Simulation, Timecourse, Task, Integration
from sbmlsim.analysis.ParameterFiles import createParameterInfoForTask, getParameterFilenameForTask
from sbmlsim.analysis.ParameterFiles import createParameterFileForTask

PAGINATE_ENTRIES = 30

def models(request):
    '''
    Home of the project and providing overview over models
    '''
    model_list = SBMLModel.objects.order_by("-pk")
    template = loader.get_template('sim/models.html')
    # template = loader.get_template('sim/test.html')
    context = RequestContext(request, {
        'model_list': model_list,
    })
    return HttpResponse(template.render(context))

def cores(request):
    '''
    Overview over the CPUs listening in the network for simulations.
    '''
    #return HttpResponse("Overview of odesim cores")
    cores_list = Core.objects.order_by("-time")
    template = loader.get_template('sim/cores.html')
    context = RequestContext(request, {
        'cores_list': cores_list,
    })
    return HttpResponse(template.render(context))

def tasks(request):
    '''
    Overview over the Tasks.
    '''
    tasks_list = Task.objects.order_by('pk').reverse()
    template = loader.get_template('sim/tasks.html')
    context = RequestContext(request, {
        'tasks_list': tasks_list,
    })
    return HttpResponse(template.render(context))


def task(request, task_id):
    ''' View of single task. '''    
    task = get_object_or_404(Task, pk=task_id)
    # generate histograms
    # folder = "/home/mkoenig/multiscale-galactose-results"
    # PlotSimulation.createTaskPlots(task, folder)
    # render template
    template = loader.get_template('sim/task.html')
    context = RequestContext(request, {
        'task': task,
    })
    return HttpResponse(template.render(context))
    
    
def task_parameters(request, task_id):
    
    task = get_object_or_404(Task, pk=task_id)
    
    content = createParameterInfoForTask(task)
    f = file(getParameterFilenameForTask(task), 'w')
    f.write(content)
    f.close()
    
    createParameterFileForTask(task)
    return HttpResponse(content, content_type='text/plain')
    
    
def integrations(request):
    ''' Overview of integation settings. '''
    integrations_list = Integration.objects.order_by("pk")
    template = loader.get_template('sim/integrations.html')
    context = RequestContext(request, {
        'integrations_list': integrations_list,
    })
    return HttpResponse(template.render(context))


def simulations(request, status='ALL'):
    '''
    Overview of simulations in the network.
    Simulations are paginated in view.
    '''
    if (status == 'ALL'):
        sim_list = Simulation.objects.order_by("-time_assign", "-time_create")
    else:
        sim_list = Simulation.objects.filter(status=status).order_by("-time_assign", "-time_create")
        
    paginator = Paginator(sim_list, PAGINATE_ENTRIES)
    
    page = request.GET.get('page')
    try:
        simulations = paginator.page(page)
    except PageNotAnInteger:
        # If page is not an integer, deliver first page.
        simulations = paginator.page(1)
    except EmptyPage:
        # If page is out of range (e.g. 9999), deliver last page of results.
        simulations = paginator.page(paginator.num_pages)
    
    template = loader.get_template('sim/simulations.html')
    context = RequestContext(request, {
        'simulations': simulations,
        'status': status,
    })
    return HttpResponse(template.render(context))


def simulation(request, simulation_id):
    ''' Overview of single odesim. '''
    sim = get_object_or_404(Simulation, pk=simulation_id)
    try:
        sim_previous = Simulation.objects.get(pk=(sim.pk-1))
    except:
        sim_previous = None
    try:
        sim_next = Simulation.objects.get(pk=(sim.pk+1))
    except:
        sim_next = None
    
    # create the plots for the simulation
    # TODO: problem when the files are not available
    # folder = "/home/mkoenig/multiscale-galactose-results/tmp_plot"
    # PlotSimulation.createSimulationPlots(sim, folder)
    
    
    template = loader.get_template('sim/odesim.html')
    context = RequestContext(request, {
        'sim': sim,
        'sim_previous': sim_previous,
        'sim_next': sim_next,
    })
    return HttpResponse(template.render(context))


def timecourses(request):
    ''' Overview of Timecourses. '''
    tc_list = Timecourse.objects.all()
    paginator = Paginator(tc_list, PAGINATE_ENTRIES)
    
    page = request.GET.get('page')
    try:
        timecourses = paginator.page(page)
    except PageNotAnInteger:
        # If page is not an integer, deliver first page.
        timecourses = paginator.page(1)
    except EmptyPage:
        # If page is out of range (e.g. 9999), deliver last page of results.
        timecourses = paginator.page(paginator.num_pages)
    
    tc_list = Timecourse.objects.all()
    template = loader.get_template('sim/timecourses.html')
    context = RequestContext(request, {
        'timecourses': timecourses,
    })
    return HttpResponse(template.render(context))


# def plots(request):
#     '''
#     Overview of Plots.
#     '''
#     plots_list = Plot.objects.all()
#     template = loader.get_template('sim/plots.html')
#     context = RequestContext(request, {
#         'plots_list': plots_list,
#     })
#     return HttpResponse(template.render(context))

def documentation(request):
    '''
    Documentation page.
    '''
    template = loader.get_template('sim/documentation.html')
    context = RequestContext(request, {
        
    })
    return HttpResponse(template.render(context))
