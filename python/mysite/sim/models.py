from django.db import models
from django.utils import timezone
from django.core.exceptions import ValidationError

'''
    TODO: implement views
    
    TODO: implement write the views
    
    TODO: implement example code to generate simulation task
    TODO: call simulation with settings (CPP)
    TODO: write back simulation results 

    Pool of simulations is defined with the status 'OPEN'.
    The different computers get unassigned simulations from a simulation
    set. 
    Simulations change the status to ASSIGNED. After the simulation is 
    performed
     

'''

def validate_gt_zero(value):
    if value < 0:
        raise ValidationError(u'%s is not > 0' % value)

# Create your models here.
# todo get name via ip dictionary
class Core(models.Model):
    ip = models.CharField(max_length=200)
    cpu = models.IntegerField()
    time = models.DateTimeField(default=timezone.now);
    
    computer_names = {'10.39.34.27':'sysbio2',
                      '10.39.32.189':'sysbio1',
                      '10.39.32.113':'oldmint',
                      '10.39.32.106':'mint',
                      '10.39.32.111':'mkoenig-desktop'}
        
    def __unicode__(self):
        return self.ip + "-cpu-" +str(self.cpu)
    
    class Meta:
        verbose_name = "Core"
        verbose_name_plural = "Cores"
        unique_together = ("ip", "cpu")
        

    def _get_computer_name(self):
        "Returns the computer name from the IP."
        if self.computer_names.has_key(self.ip):
            return self.computer_names.get(self.ip)
        else:
            return self.ip 
        
    computer = property(_get_computer_name)


# Create your models here.
class SBMLModel(models.Model):
    sbml_id = models.CharField(max_length=200, unique=True)
    name = models.CharField(max_length=200)
    version = models.IntegerField(validators=[validate_gt_zero])
    nc = models.IntegerField(validators=[validate_gt_zero])
    nf = models.IntegerField(validators=[validate_gt_zero])
    # file = models.CharField(max_length=200, unique=True)
    # file = models.FileField(upload_to="sbml/%Y/%m/%d")
    file = models.FileField(upload_to="sbml")
    
    def __unicode__(self):
        return self.sbml_id
    
    class Meta:
        # ordering = ["sbml_id"]
        verbose_name = "SBML Model"
        verbose_name_plural = "SBML Models"

    
class Integration(models.Model):
    tend = models.FloatField()
    tsteps = models.IntegerField()
    tstart = models.FloatField(default=0.0)
    abs_tol = models.FloatField(default=1E-6)
    rel_tol = models.FloatField(default=1E-6)
    
    def __unicode__(self):
        return "[" + str(self.tstart) + ":" + str(self.tend) + "]" 
    
    class Meta:
        # ordering = ["sbml_id"]
        verbose_name = "Integration Setting"
        verbose_name_plural = "Integration Settings"
    

class Parameter(models.Model):
    UNITS = (
                        ('m', 'm'),
                        ('m/s', 'm/s'),
                        ('-', '-'),
    )
    name = models.CharField(max_length=200)
    value = models.FloatField()
    unit = models.CharField(max_length=10, choices=UNITS)
    
    def __unicode__(self):
        return self.name + " = " + str(self.value) + " ["+ self.unit +"]"
    
    class Meta:
        unique_together = ("name", "value")


class ParameterCollection(models.Model):
    '''
    Put Parameters of one simulation into a ParameterSet.
    Thereby the ParameterSets can be resused for different
    simulations.
    '''
    parameters = models.ManyToManyField(Parameter, related_name='collections')
    
    class Meta:
        # ordering = ["sbml_id"]
        verbose_name = "ParameterCollection"
        verbose_name_plural = "ParameterCollections"
        
    def __unicode__(self):
        return 'PSet [' + str(self.pk) + ']'
    
    def count(self):
        return self.parameters.count()
        
        
class Task(models.Model):
    sbml_model = models.ForeignKey(SBMLModel)
    integration = models.ForeignKey(Integration)
    
    class Meta:
        unique_together = ("sbml_model", "integration")


UNASSIGNED = "UNASSIGNED"
ASSIGNED = "ASSIGNED"
DONE = "DONE"

class UnassignedSimulationManager(models.Manager):
    def get_queryset(self):
        return super(UnassignedSimulationManager, 
                     self).get_queryset().filter(status=UNASSIGNED)

class AssignedSimulationManager(models.Manager):
    def get_queryset(self):
        return super(AssignedSimulationManager, 
                     self).get_queryset().filter(status=ASSIGNED)
                     
class DoneSimulationManager(models.Manager):
    def get_queryset(self):
        return super(DoneSimulationManager, 
                     self).get_queryset().filter(status=DONE)


class Simulation(models.Model):     
    SIMULATION_STATUS = (
                         (UNASSIGNED, 'unassigned'),
                         (ASSIGNED, 'assigned'),
                         (DONE, 'done'),
    )
    task = models.ForeignKey(Task)
    parameters = models.ForeignKey(ParameterCollection)
    status = models.CharField(max_length=20, choices=SIMULATION_STATUS, default=UNASSIGNED)
    priority = models.IntegerField(default=10)
    time_create = models.DateTimeField()
    
    time_assign = models.DateTimeField(null=True)
    core = models.ForeignKey(Core, null=True)
    time_sim = models.DateTimeField(null=True)
    duration = models.FloatField(null=True)
    
    objects = models.Manager();
    unassigned_objects = UnassignedSimulationManager()
    assigned_objects = AssignedSimulationManager()
    done_objects = DoneSimulationManager()
    
    def is_unassigned(self):
        return self.status == self.UNASSIGNED
    def is_assigned(self):
        return self.status == self.ASSIGNED
    def is_done(self):
        return self.status == self.DONE

class Timecourse(models.Model):
    '''
    A timecourse belongs to exactly on simulation. If the timecourse
    is saved changes have to be made to the simulation (mainly the 
    status).
    '''
    simulation = models.OneToOneField(Simulation)
    # file = models.FileField(upload_to="~/multiscale-galactose-results/
    file = models.CharField(max_length=200, unique=True)
    
    
    