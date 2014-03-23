from django.http.response import HttpResponse
from django.template import RequestContext, loader

from sim.models import SBMLModel, Core, Simulation, Timecourse, Task
from django.shortcuts import render_to_response


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

def simulations(request):
    '''
    Overview of simulations in the network.
    '''
    sim_list = Simulation.objects.order_by("-time_assign", "-time_create")
    template = loader.get_template('sim/simulations.html')
    context = RequestContext(request, {
        'sim_list': sim_list,
    })
    return HttpResponse(template.render(context))

def timecourses(request):
    '''
    Overview of Timecourses.
    '''
    tc_list = Timecourse.objects.all()
    template = loader.get_template('sim/timecourses.html')
    context = RequestContext(request, {
        'tc_list': tc_list,
    })
    return HttpResponse(template.render(context))

def model(request, model_id):
    return HttpResponse("You're looking at SBMLmodel %s." % model_id)

def integration(request, integration_id):
    response = "You're looking at integration parameters %s."
    return HttpResponse(response % integration_id)

def parameters(request, pcol_id):
    return HttpResponse("You're looking at parameter collection %s." % pcol_id)
