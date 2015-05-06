'''
    Definition of the database model.
    
    @author: Matthias Koenig
    @date: 2014-06-14
    
'''
from __future__ import print_function
import logging

import os
import tarfile

from django.db import models
from django.utils import timezone
from datetime import timedelta
from django.core.exceptions import ValidationError, ObjectDoesNotExist
from django.core.files import File
from sbmlsim.storage import OverwriteStorage


###################################################################################

# Provide R preprocess function
# TODO: this has to be 
from rpy2.robjects.packages import SignatureTranslatedAnonymousPackage
  
string = r"""
    trim <- function (x){
      gsub("^\\s+|\\s+$", "", x)
    } 
    readData <- function(fname){
      library('data.table')
      # read data
      data <- fread(fname, header=T, sep=',')
  
      # replace 'X..' if header given via '# '
      names(data) <- gsub('X..', '', names(data))
      names(data) <- gsub('#', '', names(data))
      names(data) <- gsub('\\[', '', names(data))
      names(data) <- gsub('\\]', '', names(data))
  
      # necessary to trim
      setnames(data, trim(colnames(data)))
  
      # fix strange behavior via cast
      data <- as.data.frame(data)
      # save the data 
  
      save(data, file=paste(fname, '.Rdata', sep=''))
    }
"""
rpack = SignatureTranslatedAnonymousPackage(string, "rpack")



###################################################################################
# General definitions of datatypes and settings
DT_STRING = 'string'
DT_BOOLEAN = 'boolean'
DT_DOUBLE = 'double'
DT_INT = 'int'

datatypes = dict(zip( 
            ['condition', 'integrator', 'varSteps', 'tstart', 'tend', 'steps', 'absTol', 'relTol'],
            [DT_STRING, DT_STRING, DT_BOOLEAN, DT_DOUBLE, DT_DOUBLE, DT_INT, DT_DOUBLE, DT_DOUBLE]
))

def cast_value(key, value):
    '''
    Casts the value to the correct datatype.
    '''
    dtype = datatypes[key]
    if dtype == DT_STRING:
        return str(value)
    elif dtype == DT_INT:
        return int(value)
    elif dtype == DT_DOUBLE:
        return float(value)
    elif dtype == DT_BOOLEAN:
        return bool(value)

# integrators
COPASI = "COPASI"
ROADRUNNER = "ROADRUNNER"
###################################################################################

def validate_gt_zero(value):
    if value < 0:
        raise ValidationError(u'%s is not > 0' % value)


class Core(models.Model):
    ip = models.CharField(max_length=200)
    cpu = models.IntegerField()
    time = models.DateTimeField(default=timezone.now);
    
    computer_names = {'10.39.34.27':'core',
                      '10.39.32.189':'sysbio1',
                      '10.39.32.106':'mint',
                      '10.39.32.111':'sysbio2',
                      '10.39.32.236':'zenbook',
                      '192.168.1.100':'home',
                      '192.168.1.99':'zenbook',
                      '127.0.0.1':'localhost'}
        
    def __unicode__(self):
        return self.ip + "-cpu-" +str(self.cpu)
    
    def _is_active(self, cutoff_minutes=10):
        if not (self.time):
            return False;
        else:
            return (timezone.now() <= self.time+timedelta(minutes=cutoff_minutes))
    
    active = property(_is_active)
    
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

class SBMLModelException(Exception):
        pass

class SBMLModel(models.Model):
    ''' Storage of SBMLmodels. 
        TODO: add a file hash and check if the hash of the file is correct.
            possible problems with identical ids.
    '''
    sbml_id = models.CharField(max_length=200, unique=True)
    file = models.FileField(upload_to="sbml", max_length=200, storage=OverwriteStorage())
    
    def __unicode__(self):
        return self.sbml_id
    
    class Meta:
        verbose_name = "SBML Model"
        verbose_name_plural = "SBML Models"
    
    @classmethod
    def create(cls, sbml_id, folder):
        ''' Create the model based on the model id. '''
        filepath = os.path.join(folder, '{}.xml'.format(sbml_id))
        return cls.create_from_file(filepath)

    @classmethod
    def create_from_file(cls, filepath, sbml_id=None):
        ''' Create model in database based on SBML file. 
            # TODO: check model identity via file hash 
            # cls.check_model_identity()
        '''
        try:
            with open(filepath) as f: pass
        except IOError as exc:
            raise IOError("%s: %s" % (filepath, exc.strerror))
        
        # check if model id and filename are identical
        sbml_id = cls._get_sbml_id_from_file(filepath)
        if ('{}.xml'.format(sbml_id) != os.path.basename(filepath)):
            raise SBMLModelException('SBML model id is not identical to basename of file:, {}, {}'.format(sbml_id, filepath))
        
        try:
            model = SBMLModel.objects.get(sbml_id=sbml_id)
            logging.warn('SBMLModel for id exists in database, no new model created : {}'.format(sbml_id))
            return model;
        except ObjectDoesNotExist: 
            f = open(filepath, 'r')
            myfile = File(f)
            logging.info('SBMLModel created : {}'.format(sbml_id))
            return cls(sbml_id = sbml_id, file = myfile)
    
    @classmethod
    def _get_sbml_id_from_file(cls, filepath):
        ''' Reads the SBML id from the given file. '''
        import libsbml
        doc = libsbml.SBMLReader().readSBML(filepath)
        sbml_id = doc.getModel().getId()
        return sbml_id
        
    
# TODO: move in settings
default_settings = dict(zip(['integrator', 'varSteps', 'absTol', 'relTol'], 
                            [ROADRUNNER, True, 1E-6, 1E-6]))
       
class Setting(models.Model):
    '''
    Store all settings for algorithm in general framework.
    Special settings are collected in 
    '''
    NAMES = zip(datatypes.keys(), datatypes.keys())
    DATATYPES = (
                        (DT_STRING, 'string'),
                        (DT_DOUBLE, 'double'),
                        (DT_INT, 'int'),
                        (DT_BOOLEAN, 'boolean'),
    )
    name = models.CharField(max_length=20, choices=NAMES)
    datatype = models.CharField(max_length=10, choices=DATATYPES)
    value = models.CharField(max_length=20)

    def __unicode__(self):
        return "{}={}".format(self.name, self.value) 

    def _cast_value(self):
        if self.datatype == DT_STRING:
            return str(self.value)
        elif self.datatype == DT_DOUBLE:
            return float(self.value)
        elif self.datatype == DT_INT:
            return int(self.value)
        elif self.datatype == DT_BOOLEAN:
            return bool(self.value)
        
    cast_value = property(_cast_value)      
    

    @staticmethod
    def get_settings(settings):
        ''' Get settings based on settings dictionary. '''
        # add the default settings
        sdict = dict(default_settings.items() + settings.items())
        
        # get all settings objects from db
        settings = []
        for key, value in sdict.iteritems():
            value = cast_value(key, value)        
            s, _ = Setting.objects.get_or_create(name=key, value=str(value), 
                                                   datatype=datatypes[key])
            settings.append(s)
        return settings


class Integration(models.Model):
    '''
    Integration settings are managed via a collection of settings.
    - tolerances
    Depending on the solver the meaning of the settings can vary.
    -> in RoadRunner the absTol is on the amounts, with the smallest
        compartments the absTol on the concentrations has to be calculated
    -> if varSteps is set RoadRunner performs variable step size integration
        even with available defined steps
        
    ! Only create integrations via special interface to make sure 
      the integrations are unique in respect to the available settings.
    '''
    settings = models.ManyToManyField(Setting)

    def __unicode__(self):
        return "I{}".format(self.pk) 
    
    class Meta:
        verbose_name = "Integration Setting"
        verbose_name_plural = "Integration Settings"
        
    def get_settings_dict(self):
        sdict = dict()
        for s in self.settings.all():
            sdict[s.name] = cast_value(s.name, s.value)
        return sdict
    
    def get_setting(self, key):
        s = self.settings.get(name=key)
        return cast_value(key, s.value)
        
    def _get_integrator(self):
        return self.get_setting('integrator')
    def _get_condition(self):
        return self.get_setting('condition') 
    integrator = property(_get_integrator)
    condition = property(_get_condition)    
        
    @staticmethod
    def get_or_create_integration(settings):
        ''' 
        Tests if the settings set is already defined as integration. 
        Equality is tested via set equality.
        '''
        settings_set = frozenset(settings)
    
        integration = None
        for int_test in Integration.objects.all():
            # the uniqueness is tested via the set equality 
            if settings_set==frozenset(int_test.settings.all()):
                integration = int_test
                break
        if not integration:
            integration = Integration()
            integration.save()
            integration.settings.add(*settings)
            
        return integration



GLOBAL_PARAMETER = 'GLOBAL_PARAMETER'
BOUNDERY_INIT = 'BOUNDERY_INIT'
FLOATING_INIT = 'FLOATING_INIT'
NONE_SBML_PARAMETER = 'NONE_SBML_PARAMETER'
PTYPES = (GLOBAL_PARAMETER, BOUNDERY_INIT, FLOATING_INIT, NONE_SBML_PARAMETER)

class ParameterTypeException(Exception):
    ''' Raise if wrong parameter type. '''
    pass

def check_parameter_type(ptype):
    if ptype not in PTYPES:
        raise ParameterTypeException('ptype not supported: {}'.format(ptype))

class Parameter(models.Model):
    UNITS = (
                        ('m', 'm'),
                        ('m/s', 'm/s'),
                        ('mM', 'mM'),
                        ('mole_per_s', 'mole_per_s'),
                        ('-', '-'),
    )
    PARAMETER_TYPE = zip(PTYPES, PTYPES)
    
    name = models.CharField(max_length=200)
    value = models.FloatField()
    unit = models.CharField(max_length=10, choices=UNITS)
    ptype = models.CharField(max_length=20, choices=PARAMETER_TYPE)
    
    def __unicode__(self):
        return self.name + " = " + str(self.value) + " ["+ self.unit +"]"
    
    class Meta:
        unique_together = ("name", "value")


class Task(models.Model):
    '''
        Tasks are compatible on their integration setting and the
        underlying model.
        Task are uniquely identified via the combination of model, integration
        and the information string. Replicates of the same task can be run via
        modifying the info.
    '''
    sbml_model = models.ForeignKey(SBMLModel)
    integration = models.ForeignKey(Integration)
    priority = models.IntegerField(default=0)
    info = models.TextField(null=True, blank=True)
    
    class Meta:
        unique_together = ("sbml_model", "integration", "info")
    
    def __unicode__(self):
        return "T%d" % (self.pk)

    def sim_count(self):
        return self.simulation_set.count()
    
    def done_count(self):
        return self.simulation_set.filter(status=DONE).count()
    
    def assigned_count(self):
        return self.simulation_set.filter(status=ASSIGNED).count()
    
    def unassigned_count(self):
        return self.simulation_set.filter(status=UNASSIGNED).count()
    
    def error_count(self):
        return self.simulation_set.filter(status=ERROR).count()
    
    def _get_integrator(self):
        return self._get_setting('integrator')
    def _get_varSteps(self):
        return self._get_setting('varSteps')
    def _get_relTol(self):
        return self._get_setting('relTol')
    def _get_absTol(self):
        return self._get_setting('absTol')  
    def _get_steps(self):
        return self._get_setting('steps')
    def _get_tstart(self):
        return self._get_setting('tstart')
    def _get_tend(self):
        return self._get_setting('tend')
    
    def _get_setting(self, name):
        return self.integration.settings.get(name=name).cast_value
    
    integrator = property(_get_integrator)
    varSteps = property(_get_varSteps)
    relTol = property(_get_relTol)
    absTol = property(_get_absTol)
    steps = property(_get_steps)
    tstart = property(_get_tstart)
    tend = property(_get_tend)


UNASSIGNED = "UNASSIGNED"
ASSIGNED = "ASSIGNED"
DONE = "DONE"
ERROR = "ERROR"

class ErrorSimulationManager(models.Manager):
    def get_queryset(self):
        return super(ErrorSimulationManager, 
                     self).get_queryset().filter(status=ERROR)

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
                         (ERROR, 'error'),
                         (DONE, 'done'),
    )
    task = models.ForeignKey(Task)
    parameters = models.ManyToManyField(Parameter)
    status = models.CharField(max_length=20, choices=SIMULATION_STATUS, default=UNASSIGNED)
    time_create = models.DateTimeField(default=timezone.now)
    time_assign = models.DateTimeField(null=True, blank=True)
    core = models.ForeignKey(Core, null=True, blank=True)
    time_sim = models.DateTimeField(null=True, blank=True)
    
    # Model managers
    objects = models.Manager();
    error_objects = ErrorSimulationManager()
    unassigned_objects = UnassignedSimulationManager()
    assigned_objects = AssignedSimulationManager()
    done_objects = DoneSimulationManager()
    
    def __unicode__(self):
        return 'S%d' % (self.pk)
    
    def is_error(self):
        return self.status == self.ERROR
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
    
    def _is_hanging(self, cutoff_minutes=10):
        ''' Simulation did not finish '''
        if not (self.time_assign):
            return False
        elif (self.status != ASSIGNED):
            return False
        else:
            return (timezone.now() >= self.time_assign+timedelta(minutes=cutoff_minutes))
    
    duration = property(_get_duration)
    hanging = property(_is_hanging)


    
def timecourse_filename(instance, filename):
    name = filename.split("/")[-1]
    return '/'.join(['timecourse', str(instance.simulation.task), name])


class Timecourse(models.Model):
    '''
    A timecourse belongs to exactly on odesim. If the timecourse
    is saved changes have to be made to the odesim (mainly the 
    status).
    '''
    simulation = models.OneToOneField(Simulation, unique=True)
    file = models.FileField(upload_to=timecourse_filename, max_length=200, storage=OverwriteStorage())
    
    def __unicode__(self):
        return 'Tc:%d' % (self.pk)
    
    def _get_zip_file(self):
        f = self.file.path
        return (f[:-3] + 'tar.gz')
    
    def zip(self):
        ''' tar.gz the file '''    
        f = self.file.path
        tar = tarfile.open(self.zip_file, "w:gz")
        tar.add(f, arcname=os.path.basename(f))
        tar.close()
        
    def unzip(self):
        ''' tar.gz the file '''    
        tar = tarfile.open(self.zip_file, 'r:gz')
        dirname = os.path.dirname(self.zip_file)
        tar.extractall(path=dirname)   
        tar.close()
    
    def rdata(self):
        rpack.readData(self.file.path)
    
    zip_file = property(_get_zip_file)
         
