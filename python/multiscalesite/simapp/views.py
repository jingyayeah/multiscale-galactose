from django.http.response import HttpResponse
from django.template import RequestContext, loader
from django.shortcuts import get_object_or_404

from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from simapp.models import CompModel, Core, Simulation, Result, Task, Method

PAGINATE_ENTRIES = 50

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
    core_list = Core.objects.order_by("-time")
    template = loader.get_template('simapp/cores.html')
    context = RequestContext(request, {
        'core_list': core_list,
    })
    return HttpResponse(template.render(context))

#===============================================================================
# Tasks
#===============================================================================
def tasks(request):
    """ Tasks overview. """
    task_list = Task.objects.order_by('pk').reverse()
    template = loader.get_template('simapp/tasks.html')
    context = RequestContext(request, {
        'task_list': task_list,
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
    """ 
        TODO: fix this
        TODO: cache, only create once !
        Most of the logic belongs in the Parameterfile.
        Here only the view should be generated.
    """
    import simapp.analysis.ParameterFiles as pf
    
    task = get_object_or_404(Task, pk=task_id)
    content = pf.createParameterInfoForTask(task)
    
    # TODO: is this done 2 time ?????
    # Only write the file once and provide link to it.
    
    # f = file(pf.getParameterFilenameForTask(task), 'w')
    # f.write(content)
    # f.close()
    # pf.createParameterFileForTask(task)
    return HttpResponse(content, content_type='text/plain')
    
#===============================================================================
# Methods
#===============================================================================
def methods(request):
    """ Overview of integration settings. """
    method_list = Method.objects.order_by("pk")
    template = loader.get_template('simapp/methods.html')
    context = RequestContext(request, {
        'method_list': method_list,
    })
    return HttpResponse(template.render(context))

#===============================================================================
# Simulations
#===============================================================================
from simapp.models import SimulationStatus


def simulations(request, status='ALL'):
    """ Simulations overview.
        TODO: fix the status parsing bug. Get enums from the status.
    """
    if status == 'ALL':
        sim_list = Simulation.objects.order_by("-time_assign", "-time_create")
    else:
        sim_list = Simulation.objects.filter(status=status).order_by("-time_assign", "-time_create")
        
    paginator = Paginator(sim_list, PAGINATE_ENTRIES)
    page = request.GET.get('page')
    try:
        simulation_list = paginator.page(page)
    except PageNotAnInteger:
        # If page is not an integer, deliver first page.
        simulation_list = paginator.page(1)
    except EmptyPage:
        # If page is out of range (e.g. 9999), deliver last page of results.
        simulation_list = paginator.page(paginator.num_pages)
    
    template = loader.get_template('simapp/simulations.html')
    context = RequestContext(request, {
        'simulation_list': simulation_list,
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
# Results
#===============================================================================
def results(request):
    """ Overview of Results. """
    results_all = Result.objects.all()
    paginator = Paginator(results_all, PAGINATE_ENTRIES)
    page = request.GET.get('page')
    try:
        result_list = paginator.page(page)
    except PageNotAnInteger:
        # If page is not an integer, deliver first page.
        # If page is not an integer, deliver first page.
        result_list = paginator.page(1)
    except EmptyPage:
        # If page is out of range (e.g. 9999), deliver last page of results.
        result_list = paginator.page(paginator.num_pages)
    
    template = loader.get_template('simapp/results.html')
    context = RequestContext(request, {
        'result_list': result_list,
    })
    return HttpResponse(template.render(context))


#===============================================================================
# About
#===============================================================================
def about(request):
    """ Overview project information.
    Provide additional resources, links, explanation, background.
    TODO: update template.
    """
    template = loader.get_template('simapp/about.html')
    context = RequestContext(request, {})
    return HttpResponse(template.render(context))
