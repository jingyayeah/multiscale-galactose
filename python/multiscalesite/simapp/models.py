"""
Model definitions of for the simulation app.
    
TODO: handle all the selections via proper IntEnums -> much better storage than strings.
    

@author: Matthias Koenig
@date: 2015-05-10    
"""
from __future__ import print_function

import os
import tarfile
import logging
from datetime import timedelta

from django.db import models
from django.utils import timezone
from django.core.exceptions import ObjectDoesNotExist
from django.core.files import File

from simapp.storage import OverwriteStorage
from util.util_classes import EnumType, Enum


###################################################################################
# TODO: this has to be gone 
# Provide R preprocess function

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


#===============================================================================
# Core
#===============================================================================
from project_settings import COMPUTERS

class Core(models.Model):
    ''' Single computer core for simulation, defined by ip and cpu.
    Time corresponds to the last time the core object was accessed/used.
    This can be creation time or simulation time.
    '''
    ip = models.CharField(max_length=200)
    cpu = models.IntegerField()
    time = models.DateTimeField(default=timezone.now);
        
    def __unicode__(self):
        return '{}-cpu-{}'.format(self.ip, self.cpu)
    
    def _is_active(self, cutoff_minutes=10):
        ''' Test if simulation is still active. '''
        if not (self.time):
            return False
        return (timezone.now() <= self.time+timedelta(minutes=cutoff_minutes))
    
    active = property(_is_active)
    
    class Meta:
        verbose_name = "Core"
        verbose_name_plural = "Cores"
        unique_together = ("ip", "cpu")
        
    def _get_computer_name(self):
        return COMPUTERS.get(self.ip, self.ip)
            
    computer = property(_get_computer_name)

#===============================================================================
# CompModel
#===============================================================================
class CompModelException(Exception):
        pass

class CompModelType(EnumType, Enum):
    SBML = "SBML"
    CELLML = "CELLML"

class CompModel(models.Model):
    """ Storage class for models. """
    model_id = models.CharField(max_length=200, unique=True)
    model_type = models.CharField(max_length=10, choices=CompModelType.choices())
    file = models.FileField(upload_to='sbml', max_length=200, storage=OverwriteStorage())
    md5 = models.CharField(max_length=36)
    
    def __unicode__(self):
        return self.model_id
    
    class Meta:
        verbose_name = 'CompModel'
        verbose_name_plural = 'CompModels'
    
    def _filepath(self):
        return str(self.file.path)
    filepath = property(_filepath)
    
    def _is_sbml(self):
        return self.model_type == CompModelType.SBML.value
    is_sbml = property(_is_sbml)
    
    def _is_cellml(self):
        return self.model_type == CompModelType.CELLML.value
    is_cellml = property(_is_cellml)
    
    def _sbml_id(self):
        if self._is_sbml():
            return str(self.model_id)
        else:
            return None
    sbml_id = property(_sbml_id)
    
    def _md5_short(self, L=10):
        print('{}...'.format(self.md5[0:L]) )
        return '{}...'.format(self.md5[0:L])
    md5_short = property(_md5_short) 
    
    
    @classmethod
    def create(cls, model_id, folder, model_type=CompModelType.SBML):
        """ Create the model based on the model id. """
        filepath = os.path.join(folder, '{}.xml'.format(model_id))
        return cls.create_from_file(filepath)

    @classmethod
    def create_from_file(cls, filepath, model_type):
        """ Create model in database based file. """
        from util.util_classes import hash_for_file
        # is model_type supported
        CompModelType.check_type(model_type)
        # does file exist
        try:
            with open(filepath) as f: pass
        except IOError as exc:
            raise IOError("%s: %s" % (filepath, exc.strerror))
        
        # check if model id and filename are identical
        if model_type == CompModelType.SBML:
            model_id = cls._get_sbml_id_from_file(filepath)
            if ('{}.xml'.format(model_id) != os.path.basename(filepath)):
                raise CompModelException('SBML model id is not identical to basename of file:, {}, {}'.format(model_id, filepath))
        else:
            model_id = os.path.basename(filepath)
        
        # check via hash
        md5 = hash_for_file(filepath, hash_type='MD5')
        try:
            model = cls.objects.get(model_id=model_id)
            if model.md5 == md5:
                logging.info('CompModel already in database: {}'.format(model_id))
                return model;
            else:
                # the files are not identical
                logging.warn('Other CompModel with sbml_id exists in database, model is not created: {}'.format(model_id))
                return None;
            
        except ObjectDoesNotExist: 
            f = open(filepath, 'r')
            myfile = File(f)
            logging.info('CompModel created : {}'.format(model_id))
            return cls(model_id=model_id, file=myfile, md5=md5)
    
    @classmethod
    def _get_sbml_id_from_file(cls, filepath):
        """ Reads the SBML id from the given file. """
        import libsbml
        doc = libsbml.SBMLReader().readSBML(filepath)
        sbml_id = doc.getModel().getId()
        return sbml_id
   

#===============================================================================
# Settings
#===============================================================================
# TODO: lookup the allowed solver options for RoadRunner

class DataType(EnumType, Enum):
    STRING = 'STRING'
    BOOLEAN = 'BOOLEAN'
    DOUBLE = 'DOUBLE'
    INT = 'INT'   

class SettingKey(EnumType, Enum):
    INTEGRATOR = "INTEGRATOR",
    VAR_STEPS = "VAR_STEPS"
    ABS_TOL = "ABS_TOL"
    REL_TOL = "REL_TOL"
    T_START = "T_START"
    T_END = "T_END"
    STEPS = "STEPS"

class SimulatorType(EnumType, Enum):
    COPASI = "COPASI"
    ROADRUNNER = "ROADRUNNER"
    
 
class Setting(models.Model):
    SETTINGS_DATATYPE = {
        SettingKey.INTEGRATOR : DataType.STRING,
        SettingKey.VAR_STEPS : DataType.BOOLEAN,
        SettingKey.ABS_TOL : DataType.DOUBLE,
        SettingKey.REL_TOL : DataType.DOUBLE,
        SettingKey.T_START : DataType.DOUBLE,
        SettingKey.T_END : DataType.DOUBLE,
        SettingKey.STEPS : DataType.INT
    }

    SETTINGS_DEFAULT = {
        SettingKey.INTEGRATOR : SimulatorType.ROADRUNNER,
        SettingKey.VAR_STEPS : True,
        SettingKey.ABS_TOL : 1E-6,
        SettingKey.REL_TOL : 1E-6
    }
    
    name = models.CharField(max_length=40, choices=SettingKey.choices())
    datatype = models.CharField(max_length=40, choices=DataType.choices())
    value = models.CharField(max_length=40)

    def __unicode__(self):
        return "{}={}".format(self.name, self.value) 

    @classmethod
    def cast_value(cls, value, datatype):
        """ Cast setting to corresponding datatype. """
        if datatype == DataType.STRING:
            return str(value)
        elif datatype == DataType.DOUBLE:
            return float(value)
        elif datatype == DataType.INT:
            return int(value)
        elif datatype == DataType.BOOLEAN:
            return bool(value)
        
    def _cast_value(self):
        return Setting.cast_value(self.datatype, self.value)
    cast_value = property(_cast_value)      
    
    @staticmethod   
    def get_settings(cls, settings):
        ''' Get settings based on settings dictionary. 
        The settings dictionary is extened with the provided settings.
        '''    
        sdict = dict(cls.SETTINGS_DEFAULT.iteritems() 
                      + settings.iteritems())
        
        # get settings objects from DB
        settings = []
        for key, value in sdict.iteritems():
            datatype = Setting.SETTINGS_DATATYPE[key]
            s, _ = Setting.objects.get_or_create(name=key, value=str(value), 
                                                   datatype=datatype)
            settings.append(s)
        return settings

#===============================================================================
# Integration
#===============================================================================
class Integration(models.Model):
    """ Integration settings are managed via a collection of settings. """
    settings = models.ManyToManyField(Setting)

    def __unicode__(self):
        return 'I{}'.format(self.pk) 
    
    class Meta:
        verbose_name = 'Integration Setting'
        verbose_name_plural = "Integration Settings"
        
    def get_settings_dict(self):
        return {s.name : s.cast_value for s in self.settings.all()}
    
    def get_setting(self, key):
        s = self.settings.get(name=key)
        return s.cast_value
        
    def _get_integrator(self):
        return self.get_setting(SettingKey.INTEGRATOR)
    integrator = property(_get_integrator)
        
        
    @staticmethod
    def get_or_create_integration(settings):
        """
        Tests if the settings set is already defined as integration. 
        Equality is tested via set equality.
        """
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


#===============================================================================
# Parameter
#===============================================================================
class ParameterType(EnumType, Enum):
    GLOBAL_PARAMETER = 'GLOBAL_PARAMETER'
    BOUNDERY_INIT = 'BOUNDERY_INIT'
    FLOATING_INIT = 'FLOATING_INIT'
    NONE_SBML_PARAMETER = 'NONE_SBML_PARAMETER'    

class Parameter(models.Model):
    name = models.CharField(max_length=200)
    value = models.FloatField()
    unit = models.CharField(max_length=10)
    ptype = models.CharField(max_length=30, choices=ParameterType.choices())
    
    def __unicode__(self):
        return '{} = {} [{}]'.format(self.name, self.value, self.unit)
    
    class Meta:
        unique_together = ("name", "value")

#===============================================================================
# Task
#===============================================================================
class Task(models.Model):
    """ Tasks are defined sets of simulations under consistent conditions.
        Tasks are compatible on their integration setting and the
        underlying model.
        Task are uniquely identified via the combination of model, integration
        and the information string. Replicates of the same task can be run via
        modifying the info.
    """
    sbml_model = models.ForeignKey(CompModel)
    integration = models.ForeignKey(Integration)
    priority = models.IntegerField(default=0)
    info = models.TextField(null=True, blank=True)
    
    class Meta:
        unique_together = ("sbml_model", "integration", "info")
    
    def __unicode__(self):
        return "T%d" % (self.pk)

    def sim_count(self):
        return self.simulation_set.count()
    
    def _status_count(self, status):
        return self.simulation_set.filter(status=status).count()
    
    def done_count(self):
        return self._status_count(self, SimulationStatus.DONE)
    
    def assigned_count(self):
        return self._status_count(self, SimulationStatus.ASSIGNED)
    
    def unassigned_count(self):
        return self._status_count(self, SimulationStatus.UNASSIGNED)
    
    def error_count(self):
        return self._status_count(self, SimulationStatus.ERROR)
    
    def _get_integrator(self):
        return self._get_setting(SettingKey.INTEGRATOR)
    def _get_varSteps(self):
        return self._get_setting(SettingKey.VAR_STEPS)
    def _get_relTol(self):
        return self._get_setting(SettingKey.REL_TOL)
    def _get_absTol(self):
        return self._get_setting(SettingKey.ABS_TOL)  
    def _get_steps(self):
        return self._get_setting(SettingKey.STEPS)
    def _get_tstart(self):
        return self._get_setting(SettingKey.T_START)
    def _get_tend(self):
        return self._get_setting(SettingKey.T_END)
    
    def _get_setting(self, name):
        return self.integration.settings.get(name=name).cast_value
    
    integrator = property(_get_integrator)
    varSteps = property(_get_varSteps)
    relTol = property(_get_relTol)
    absTol = property(_get_absTol)
    steps = property(_get_steps)
    tstart = property(_get_tstart)
    tend = property(_get_tend)


#===============================================================================
# Simulation
#===============================================================================
class SimulationStatus(EnumType, Enum):
    UNASSIGNED = "UNASSIGNED"
    ASSIGNED = "ASSIGNED"
    DONE = "DONE"
    ERROR = "ERROR"

class ErrorSimulationManager(models.Manager):
    def get_queryset(self):
        return super(ErrorSimulationManager, 
                     self).get_queryset().filter(status=SimulationStatus.ERROR)

class UnassignedSimulationManager(models.Manager):
    def get_queryset(self):
        return super(UnassignedSimulationManager, 
                     self).get_queryset().filter(status=SimulationStatus.UNASSIGNED)

class AssignedSimulationManager(models.Manager):
    def get_queryset(self):
        return super(AssignedSimulationManager, 
                     self).get_queryset().filter(status=SimulationStatus.ASSIGNED)
                     
class DoneSimulationManager(models.Manager):
    def get_queryset(self):
        return super(DoneSimulationManager, 
                     self).get_queryset().filter(status=SimulationStatus.DONE)


class Simulation(models.Model):     
    task = models.ForeignKey(Task)
    parameters = models.ManyToManyField(Parameter)
    status = models.CharField(max_length=20, choices=SimulationStatus.choices(), 
                              default=SimulationStatus.UNASSIGNED)
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
        return self.status == SimulationStatus.ERROR
    def is_unassigned(self):
        return self.status == SimulationStatus.UNASSIGNED
    def is_assigned(self):
        return self.status == SimulationStatus.ASSIGNED
    def is_done(self):
        return self.status == SimulationStatus.DONE
    
    def _get_duration(self):
        if (not self.time_assign or not self.time_sim):
            return None
        else:
            return self.time_sim - self.time_assign
    
    def _is_hanging(self, cutoff_minutes=10):
        ''' Simulation did not finish '''
        if not (self.time_assign):
            return False
        elif (self.status != SimulationStatus.ASSIGNED):
            return False
        else:
            return (timezone.now() >= self.time_assign+timedelta(minutes=cutoff_minutes))
    
    duration = property(_get_duration)
    hanging = property(_is_hanging)


#===============================================================================
# Result
#===============================================================================
# TODO: handle as result file.
# This can be a timecourse, but could also be an FBA simulation.
# Define type.

def result_filename(instance, filename):
    name = filename.split("/")[-1]
    return '/'.join(['timecourse', str(instance.simulation.task), name])
       


class Timecourse(models.Model):
    ''' Timecourse for simulation. '''
    simulation = models.OneToOneField(Simulation, unique=True)
    file = models.FileField(upload_to=result_filename, max_length=200, storage=OverwriteStorage())
    
    def __unicode__(self):
        return 'Tc:%d' % (self.pk)
    
    def _get_zip_file(self):
        f = self.file.path
        return (f[:-3] + 'tar.gz')
    
    def zip(self):
        """ tar.gz the file """
        f = self.file.path
        tar = tarfile.open(self.zip_file, 'w:gz')
        tar.add(f, arcname=os.path.basename(f))
        tar.close()
        
    def unzip(self):
        """ Extract the file. """    
        tar = tarfile.open(self.zip_file, 'r:gz')
        dirname = os.path.dirname(self.zip_file)
        tar.extractall(path=dirname)   
        tar.close()
    
    def rdata(self):
        rpack.readData(self.file.path)
    
    zip_file = property(_get_zip_file)

  
         
#===============================================================================
# Plots and Analysis
#===============================================================================
