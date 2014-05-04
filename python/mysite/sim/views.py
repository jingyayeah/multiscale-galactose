from django.http.response import HttpResponse
from django.template import RequestContext, loader

from sim.models import SBMLModel, Core, Simulation, Timecourse, Task, Plot, Integration,\
    UNASSIGNED
from django.shortcuts import render_to_response, render, get_object_or_404
from sim.plot import PlotSimulation
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

PAGINATE_ENTRIES = 30

def index(request):
    '''
    Homepage and overview over models.
    '''
    model_list = SBMLModel.objects.all()
    template = loader.get_template('sim/index.html')
    context = RequestContext(request, {
        'model_list': model_list,
    })
    return HttpResponse(template.render(context))

def cores(request):
    '''
    Overview over the CPUs listening in the network for simulations.
    '''
    #return HttpResponse("Overview of simulation cores")
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
    tasks_list = Task.objects.all()
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
    
    
def integrations(request):
    ''' Overview of integation settings. '''
    int_list = Integration.objects.all()
    paginator = Paginator(int_list, PAGINATE_ENTRIES) # Show 25 simulations per page
    
    page = request.GET.get('page')
    try:
        integrations = paginator.page(page)
    except PageNotAnInteger:
        # If page is not an integer, deliver first page.
        integrations = paginator.page(1)
    except EmptyPage:
        # If page is out of range (e.g. 9999), deliver last page of results.
        integrations = paginator.page(paginator.num_pages)
    
    template = loader.get_template('sim/integrations.html')
    context = RequestContext(request, {
        'integrations': integrations,
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
    })
    return HttpResponse(template.render(context))


def simulation(request, simulation_id):
    ''' Overview of single simulation. '''
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
    
    template = loader.get_template('sim/simulation.html')
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


def plots(request):
    '''
    Overview of Plots.
    '''
    plots_list = Plot.objects.all()
    template = loader.get_template('sim/plots.html')
    context = RequestContext(request, {
        'plots_list': plots_list,
    })
    return HttpResponse(template.render(context))


def model(request, model_id):
    return HttpResponse("You're looking at SBMLmodel %s." % model_id)

def integration(request, integration_id):
    response = "You're looking at integration parameters %s."
    return HttpResponse(response % integration_id)

def parameters(request, pcol_id):
    return HttpResponse("You're looking at parameter collection %s." % pcol_id)
