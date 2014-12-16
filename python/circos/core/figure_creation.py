'''
Created on Dec 16, 2014

@author: mkoenig

Creates the figure for given folder.


'''
circos_dir = "/home/mkoenig/multiscale-galactose-results/circos"


def get_task_from_folder(folder):
    tokens = folder.split('_')
    return tokens[2]


def get_circos_dir(folder):
    return circos_dir + '/' + folder

def read_time(folder):
    fname = folder + '/_time.csv'
    
    
    time 
    
    
    return time


def create_karyotype_file(folder):
    pass

def create_histogram_data(time, matrix):
    pass

def create_plots_conf(time):
    pass

def create_circos_conf(time):
    pass

def create_colors():
    pass


def create_circos_plot(time):
    pass


if __name__ == "__main__":
    folder = '2014-12-12_T2'   # Multiple indicator data
    dir_out = get_circos_dir(folder)
    print dir_out
   
