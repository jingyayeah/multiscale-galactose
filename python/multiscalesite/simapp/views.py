from django.http.response import HttpResponse
from django.template import RequestContext, loader
from django.shortcuts import get_object_or_404

from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

from simapp.models import CompModel, Core, Simulation, Timecourse, Task, Integration

PAGINATE_ENTRIES = 30

#===============================================================================
# Models
#===============================================================================
def models(request):
    """ Models overview. """
    model_list = CompModel.objects.order_by("-pk")
    template = loader.get_template('simapp/models.html')
    context = RequestContext(request, {
        'model_list': model_list,
    })
    return HttpResponse(template.render(context))

#===============================================================================
# Cores
#===============================================================================
def cores(request):
    """ Cores overview. """
    cores_list = Core.objects.order_by("-time")
    template = loader.get_template('simapp/cores.html')
    context = RequestContext(request, {
        'cores_list': cores_list,
    })
    return HttpResponse(template.render(context))

#===============================================================================
# Tasks
#===============================================================================
def tasks(request):
    """ Tasks overview. """
    tasks_list = Task.objects.order_by('pk').reverse()
    template = loader.get_template('simapp/tasks.html')
    context = RequestContext(request, {
        'tasks_list': tasks_list,
    })
    return HttpResponse(template.render(context))

def task(request, task_id):
    """ View of single task. """
    task = get_object_or_404(Task, pk=task_id)
    template = loader.get_template('simapp/task.html')
    context = RequestContext(request, {
        'task': task,
    })
    return HttpResponse(template.render(context))
    
    
def task_parameters(request, task_id):
    """ TODO: cache, only create once !
        Most of the logic belongs in the Parameterfile.
        Here only the view should be generated.
    """
    import simapp.analysis.ParameterFiles as pf
    
    task = get_object_or_404(Task, pk=task_id)
    # TODO: is this done 2 time ?????
    # Only write the file once and provide link to it.
    content = pf.createParameterInfoForTask(task)
    f = file(pf.getParameterFilenameForTask(task), 'w')
    f.write(content)
    f.close()
    
    pf.createParameterFileForTask(task)
    return HttpResponse(content, content_type='text/plain')
    
#===============================================================================
# Integrations
#===============================================================================
def integrations(request):
    """ Overview of integration settings. """
    integrations_list = Integration.objects.order_by("pk")
    template = loader.get_template('simapp/integrations.html')
    context = RequestContext(request, {
        'integrations_list': integrations_list,
    })
    return HttpResponse(template.render(context))

#===============================================================================
# Simulations
#===============================================================================
def simulations(request, status='ALL'):
    """ Simulations overview. """
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
    
    template = loader.get_template('simapp/simulations.html')
    context = RequestContext(request, {
        'simulations': simulations,
        'status': status,
    })
    return HttpResponse(template.render(context))


def simulation(request, simulation_id):
    """ Overview of single simulation. """
    sim = get_object_or_404(Simulation, pk=simulation_id)
    try:
        sim_previous = Simulation.objects.get(pk=(sim.pk-1))
    except:
        sim_previous = None
    try:
        sim_next = Simulation.objects.get(pk=(sim.pk+1))
    except:
        sim_next = None
        
    template = loader.get_template('simapp/simulation.html')
    context = RequestContext(request, {
        'sim': sim,
        'sim_previous': sim_previous,
        'sim_next': sim_next,
    })
    return HttpResponse(template.render(context))


#===============================================================================
# Timecourses
#===============================================================================
def timecourses(request):
    """ Overview of Timecourses. """
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
    template = loader.get_template('simapp/timecourses.html')
    context = RequestContext(request, {
        'timecourses': timecourses,
    })
    return HttpResponse(template.render(context))


#===============================================================================
# Documentation 
#===============================================================================
def documentation(request):
    ''' Documentation information. 
        TODO: update documentation.
    '''
    template = loader.get_template('simapp/documentation.html')
    context = RequestContext(request, {})
    return HttpResponse(template.render(context))
