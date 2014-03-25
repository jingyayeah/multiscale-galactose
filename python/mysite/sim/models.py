from django.db import models
from django.utils import timezone
from django.core.exceptions import ValidationError, ObjectDoesNotExist
from django.core.files import File

'''
    TODO: implement views for the database content
    TODO: store timecourse files and config files

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
# TODO: get name via ip dictionary
class Core(models.Model):
    ip = models.CharField(max_length=200)
    cpu = models.IntegerField()
    time = models.DateTimeField(default=timezone.now);
    
    computer_names = {'10.39.34.27':'sysbio2',
                      '10.39.32.189':'sysbio1',
                      '10.39.32.113':'oldmint',
                      '10.39.32.106':'mint',
                      '10.39.32.111':'mkoenig-desktop',
                      '127.0.0.1':'mkoenig-zenbook'}
        
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
    '''
    Storage of SBMLmodels for the simulation.
    '''
    sbml_id = models.CharField(max_length=200, unique=True)
    file = models.FileField(upload_to="sbml")
    
    def __unicode__(self):
        return self.sbml_id
    
    class Meta:
        # ordering = ["sbml_id"]
        verbose_name = "SBML Model"
        verbose_name_plural = "SBML Models"
    
    @classmethod
    def create(cls, sbml_id, folder):
        '''
            Create the model based on the model id.
        '''
        try:
            model = SBMLModel.objects.get(sbml_id=sbml_id)
            return model;
        except ObjectDoesNotExist:
            print 'model is created'
            filename = folder + "/" + sbml_id + ".xml" 
            f = open(filename, 'r')
            myfile = File(f)
            # ?? TODO: where to close the file [ f.close() ]
            # Create the SBMLmodel
    
            return cls(sbml_id = sbml_id, file = myfile)
            
    
class Integration(models.Model):
    tend = models.FloatField()
    tsteps = models.IntegerField()
    tstart = models.FloatField(default=0.0)
    abs_tol = models.FloatField(default=1E-6)
    rel_tol = models.FloatField(default=1E-6)
    
    def __unicode__(self):
        return "[{},{}] {} ".format(self.tstart, self.tend, self.tsteps) 
    
    class Meta:
        # ordering = ["sbml_id"]
        verbose_name = "Integration Setting"
        verbose_name_plural = "Integration Settings"
    

class Parameter(models.Model):
    UNITS = (
                        ('m', 'm'),
                        ('m/s', 'm/s'),
                        ('mM', 'mM'),
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
    parameters = models.ManyToManyField(Parameter)
    
    class Meta:
        # ordering = ["sbml_id"]
        verbose_name = "ParameterCollection"
        verbose_name_plural = "ParameterCollections"
        
    def __unicode__(self):
        return 'PC%d' % (self.pk)
    
    def count(self):
        return self.parameters.count()
    
    #def get_collection_for_pararmeters(self, plist):
    #    pass
        
        
class Task(models.Model):
    sbml_model = models.ForeignKey(SBMLModel)
    integration = models.ForeignKey(Integration)
    
    class Meta:
        unique_together = ("sbml_model", "integration")
    
    def __unicode__(self):
        return "T:%d [%s | Int:%d]" % (self.pk, self.sbml_model, self.integration.pk)


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
    time_create = models.DateTimeField(default=timezone.now())
    # set during assignment
    time_assign = models.DateTimeField(null=True)
    core = models.ForeignKey(Core, null=True)
    file = models.FileField(upload_to='timecourse/%Y-%m-%d' , null=True)
    # set after simulation
    time_sim = models.DateTimeField(null=True)
    
    objects = models.Manager();
    unassigned_objects = UnassignedSimulationManager()
    assigned_objects = AssignedSimulationManager()
    done_objects = DoneSimulationManager()

    class Meta:
        unique_together = ("task", "parameters")
    
    def __unicode__(self):
        return 'Sim:%d' % (self.pk)
    
    def is_unassigned(self):
        return self.status == self.UNASSIGNED
    def is_assigned(self):
        return self.status == self.ASSIGNED
    def is_done(self):
        return self.status == self.DONE
    
    def _get_duration(self):
        if (not self.time_assign or not self.time_sim):
            return None
        else:
            return self.time_sim - self.time_assign
    
    duration = property(_get_duration)
    
class Timecourse(models.Model):
    '''
    A timecourse belongs to exactly on simulation. If the timecourse
    is saved changes have to be made to the simulation (mainly the 
    status).
    '''
    simulation = models.OneToOneField(Simulation, unique=True)
    # file = models.FileField(upload_to="~/multiscale-galactose-results/
    file = models.FileField(upload_to='timecourse/%Y-%m-%d')
    
    def __unicode__(self):
        return 'Tc:%d' % (self.pk)

TIMECOURSE = "TIMECOURSE"
STEADYSTATE = "STEADYSTATE"
  
class Plot(models.Model):
    PLOT_TYPES = (
        (TIMECOURSE, 'Timecourse'),
        (STEADYSTATE, 'SteadyState'),
    )
    timecourse = models.ForeignKey(Timecourse)
    plot_type = models.CharField(max_length=20, choices=PLOT_TYPES, default=TIMECOURSE)
    file = models.FileField(upload_to="plot/%Y-%m-%d")
    
    