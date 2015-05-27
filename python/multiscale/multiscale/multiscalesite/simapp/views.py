from django.http.response import HttpResponse
from django.template import RequestContext
from django.shortcuts import get_object_or_404, render_to_response
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

from simapp.models import CompModel, Core, Simulation, Result, Task, Method

PAGINATE_ENTRIES = 50

# ===============================================================================
# Models
# ===============================================================================
def models(request):
    """ Models overview. """
    model_list = CompModel.objects.order_by("-pk")
    return render_to_response('simapp/models.html',
                              {'model_list': model_list},
                              context_instance=RequestContext(request))

def model(request, model_id):
    """ View of single model. """
    model = get_object_or_404(CompModel, pk=model_id)
    return render_to_response('simapp/model.html',
                              {'model': model},
                              context_instance=RequestContext(request))

# ===============================================================================
# Cores
# ===============================================================================
def cores(request):
    """ Cores overview. """
    core_list = Core.objects.order_by("-time")
    return render_to_response('simapp/cores.html',
                              {'core_list': core_list},
                              context_instance=RequestContext(request))


# ===============================================================================
# Tasks
# ===============================================================================
def tasks(request):
    """ Tasks overview. """
    task_list = Task.objects.order_by('pk').reverse()
    return render_to_response('simapp/tasks.html',
                              {'task_list': task_list},
                              context_instance=RequestContext(request))


def task(request, task_id):
    """ View of single task. """
    task = get_object_or_404(Task, pk=task_id)
    return render_to_response('simapp/task.html',
                              {'task': task},
                              context_instance=RequestContext(request))


def task_parameters(request, task_id):
    """ Most of the logic belongs in the Parameterfile.
        Here only the view should be generated.
    """
    # TODO: cache, only create once !
    import simapp.reports.task_report as pf

    task = get_object_or_404(Task, pk=task_id)
    content = pf.createParameterInfoForTask(task)

    # TODO: is this done 2 time ?????
    # Only write the file once and provide link to it.

    # f = file(pf.getParameterFilenameForTask(task), 'w')
    # f.write(content)
    # f.close()
    # pf.createParameterFileForTask(task)
    return HttpResponse(content, content_type='text/plain')


# ===============================================================================
# Methods
# ===============================================================================
def methods(request):
    """ Overview of simulation methods. """
    method_list = Method.objects.order_by("pk")
    return render_to_response('simapp/methods.html',
                              {'method_list': method_list},
                              context_instance=RequestContext(request))

def method(request, method_id):
    """ View of single simulation method. """
    method = get_object_or_404(Method, pk=method_id)
    return render_to_response('simapp/method.html',
                              {'method': method},
                              context_instance=RequestContext(request))

# ===============================================================================
# Simulations
# ===============================================================================
from simapp.models import SimulationStatus


def simulations(request, status='ALL'):
    """ Simulations overview. """
    if status == 'ALL':
        sim_list = Simulation.objects.order_by("-time_assign", "-time_create")
    else:
        status_type = SimulationStatus.rev_labels[status]
        sim_list = Simulation.objects.filter(status=status_type).order_by("-time_assign", "-time_create")

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

    return render_to_response('simapp/simulations.html',
                              {
                                  'simulation_list': simulation_list,
                                  'status': status,
                              },
                              context_instance=RequestContext(request))


def simulation(request, simulation_id):
    """ Overview of single simulation. """
    sim = get_object_or_404(Simulation, pk=simulation_id)
    try:
        sim_previous = Simulation.objects.get(pk=(sim.pk - 1))
    except Simulation.DoesNotExist:
        sim_previous = None
    try:
        sim_next = Simulation.objects.get(pk=(sim.pk + 1))
    except Simulation.DoesNotExist:
        sim_next = None

    return render_to_response('simapp/simulation.html', {
        'sim': sim,
        'sim_previous': sim_previous,
        'sim_next': sim_next,
        },
        context_instance=RequestContext(request))


# ===============================================================================
# Results
# ===============================================================================
def results(request):
    """ Overview of Results. """
    results_all = Result.objects.all()
    paginator = Paginator(results_all, PAGINATE_ENTRIES)
    page = request.GET.get('page')
    try:
        result_list = paginator.page(page)
    except PageNotAnInteger:
        result_list = paginator.page(1)  # If page is not an integer, deliver first page.
    except EmptyPage:
        # If page is out of range (e.g. 9999), deliver last page of results.
        result_list = paginator.page(paginator.num_pages)

    return render_to_response('simapp/results.html',
                              {'result_list': result_list},
                              context_instance=RequestContext(request))


# ===============================================================================
# About
# ===============================================================================
def about(request):
    """ Overview project information.
    Provide additional resources, links, explanation, background.
    """
    # TODO: update template
    return render_to_response('simapp/about.html', {},
                              context_instance=RequestContext(request))
