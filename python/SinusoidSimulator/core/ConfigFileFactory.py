'''
Created on Mar 21, 2014

@author: mkoenig
'''



def create_config_file(sim):
    '''
    Necessary to generate the Config file consisting of the parameters
    and the integration settings.
    
    ############################
    [Simulation]
    sbml = Dilution
    timecoure_id = tc1234
    pars_id = pars1234
    timestamp = 2014-03-27

    [Timecourse]
    t0 = 0.0
    dur = 100.0
    steps = 1000
    rTol = 1E-6
    aTol = 1E-6

    [Parameters]
    flow_sin = 60E-6
    PP__gal = 0.00012
    ############################
    '''
    
    # TODO: timestamp and author stamp
    
    # Create config file
    folder = "/home/mkoenig/multiscale-galactose-results/"
    sbml_id = sim.task.sbml_model.sbml_id
    filename = folder + sbml_id + "_Sim" + str(sim.pk) + '_config.ini'
    f = open(filename, 'w')
    f.write('[Simulation]\n')
    f.write('Simulation = {}\n'.format(sim.pk) )
    f.write("Task = {}\n".format(sim.task.pk) )
    f.write("SBML = {}\n".format(sim.task.sbml_model.pk))
    f.write("ParameterCollection = {}\n".format(sim.parameters.pk))
    f.write("sbml = {}\n".format(sim.task.sbml_model.sbml_id))
    f.write("\n")
    f.write("[Timecourse]\n")
    f.write("t0 = {}\n".format(sim.task.integration.tstart))
    f.write("dur = {}\n".format(sim.task.integration.tend))
    f.write("steps = {}\n".format(sim.task.integration.tsteps))
    f.write("rTol = {}\n".format(sim.task.integration.rel_tol))
    f.write("aTol = {}\n".format(sim.task.integration.abs_tol))
    f.write("\n")
    f.write("[Parameters]\n")
    pc = ParameterCollection.objects.get(pk=sim.parameters.pk)
    for p in pc.parameters.all():
        f.write("{} = {}\n".format(p.name, p.value) )
    
    f.close()
    return filename


if __name__ == "__main__":
    '''
    Test the creation of config files for defined simulations.
    '''
    