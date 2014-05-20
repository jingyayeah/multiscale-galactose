'''
Created on May 20, 2014

@author: mkoenig
'''
def test(sim, folder):
    sbml_file = sim.task.sbml_model.file.path
    sbml_id = sim.task.sbml_model.sbml_id
    config_file = create_config_file_in_folder(sim, folder)
    timecourse_file = folder + "/" + sbml_id + "_Sim" + str(sim.pk) + '_copasi.csv'
    
    #Store the config file in the database
    f = open(config_file, 'r')
    sim.file = File(f)
    sim.save()
        
    # Choose simulator
    simulator = sim.simulator
    
    if (simulator == ROADRUNNER):
            # run an operating system command
            # call(["ls", "-l"])
            call_command = COPASI_EXEC + " -s " + sbml_file + " -c " + config_file + " -t " + timecourse_file;
            print call_command
            call(shlex.split(call_command))
            print 'Roadrunner not supported yes'
        
    
        # Store Timecourse Results
        f = open(timecourse_file, 'r')
        myfile = File(f)
        tc, created = Timecourse.objects.get_or_create(simulation=sim)
        if (not created):
            print 'Timecourse already exists and is overwritten!'
        tc.file = myfile
        tc.save();
    
        # simulation finished (update simulation information and save)
        sim.time_sim = timezone.now()
        sim.status = DONE
        sim.save()
        
if __name__ == "__main__":
    