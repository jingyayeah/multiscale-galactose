from django.http.response import HttpResponse
from django.template import RequestContext, loader

from sim.models import SBMLModel


def index(request):
    latest_model_list = SBMLModel.objects.all()[:10]
    template = loader.get_template('simulation/index.html')
    context = RequestContext(request, {
        'latest_model_list': latest_model_list,
    })
    return HttpResponse(template.render(context))

def cores(request):
    '''
    Overview over the CPUs listening in the network for simulations.
    '''
    return HttpResponse("Overview of simulation cores")


def model(request, model_id):
    return HttpResponse("You're looking at SBMLmodel %s." % model_id)

def integration(request, integration_id):
    response = "You're looking at integration parameters %s."
    return HttpResponse(response % integration_id)

def parameters(request, pcol_id):
    return HttpResponse("You're looking at parameter collection %s." % pcol_id)
