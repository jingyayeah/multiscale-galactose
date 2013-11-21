from django.db import models
from django.utils import timezone

# Create your models here.
class SBMLModel(models.Model):
    sbml_id = models.CharField(max_length=200, unique=True)
    name = models.CharField(max_length=200)
    version = models.IntegerField()
    nc = models.IntegerField()
    nf = models.IntegerField()
    file = models.CharField(max_length=200, unique=True)
    # file = models.FileField(upload_to="~/multiscale-galactose-results/")
    
    def __unicode__(self):
        return self.sbml_id
    
class Integration(models.Model):
    t_end = models.FloatField()
    t_steps = models.IntegerField()
    t_start = models.FloatField(default=0.0)
    abs_tol = models.FloatField(default=1E-6)
    rel_tol = models.FloatField(default=1E-6)

class Parameter(models.Model):
    name = models.CharField(max_length=200)
    value = models.FloatField()
    
    def __unicode__(self):
        return self.name + " = " + self.value
    
class TimeCourse(models.Model):
    # file = models.FileField(upload_to="~/multiscale-galactose-results/
    file = models.CharField(max_length=200, unique=True)
    
    
class SimulationSet(models.Model):
    sbml_model = models.ForeignKey(SBMLModel)
    integration = models.ForeignKey(Integration)    
    
class Simulation(models.Model): 
    COMPUTERS = (
                        ('desktop', 'desktop'),
                        ('mint', 'mint'),
                        ('oldmint', 'oldmint'),
                        ('home', 'home'),
    )
    sim_set = models.ForeignKey(SimulationSet)
    timecourse = models.ForeignKey(TimeCourse)
    parameters = models.ForeignKey(Parameter)
    duration = models.FloatField()
    computer = models.CharField(max_length=200, choices=COMPUTERS)
    time = models.DateTimeField()



 

       




    
    