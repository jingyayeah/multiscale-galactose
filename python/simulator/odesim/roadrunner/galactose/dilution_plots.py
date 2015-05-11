'''
Created on Dec 19, 2014

@author: mkoenig
'''

from roadrunner_tools import get_ids_from_selection, position_in_list

t_peak = 5000

def dilution_plot_pppv(s_list, selections, show=True, 
                   xlim=[t_peak-5, t_peak+30], ylim=[0, 0.5]):
    ''' 
    Plot of the periportal and perivenious components of the dilution 
    curves.
    '''
    print '#'*80    
    print 'Dilution curves'
    print '#'*80
        
    compounds = ['gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM']
    ccols = ['gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue']
    
    pp_ids = ['[PP__{}]'.model_format(sid) for sid in compounds]    
    pv_ids = ['[PV__{}]'.model_format(sid) for sid in compounds]
    ids = pp_ids + pv_ids
    cols = ccols + ccols
    print ids
    
    import pylab as p
    # p.figure(1, figsize=(9,6))
    for s in s_list:
        times = s['time']
        for k, sid in enumerate(ids):
            p.plot(times, s[sid], color=cols[k], label=sid)
            # p.legend()
    p.title('Dilution curves PP & PV')
    p.xlabel('time [s]')
    p.ylabel('concentration [mM]')
    font = {'family' : 'monospace',
        'weight' : 'bold',
        'size'   : '12'}
    p.rc('font', **font)  # pass in the font dict as kwargs    
    
    # adapt the axis
    if xlim:
        p.xlim(xlim)
    if ylim:
        p.ylim(ylim)
    
    p.savefig('plots/dilution_plot_pppv.png', dpi=200)
    if show:
        p.show()
  

def dilution_plot_by_name(s_list, selections, name, xlim=[t_peak-5, t_peak+30], comp_type='H'):
    """ Plot of the dilution curves. """
    # TODO: problems if not enough colors are provided.
    print '#'*80    
    print name
    print '#'*80
    ids = get_ids_from_selection(name, selections, comp_type=comp_type)
    cols=['red', 'darkblue', 'darkgreen', 'gray', 'darkorgange', 'black']   
    print ids
  
    import pylab as p
    # p.figure(1, figsize=(9,6))
    for ks, s in enumerate(s_list):
        times = s['time']
        for sid in ids:
            p.plot(times, s[sid], color=cols[ks], label=sid)
    p.xlim(xlim)
    p.title(name)
    p.xlabel('time [s]')
    p.ylabel(name)    
    
    
    #p.ylim(0, 0.4)
    p.savefig('plots/{}.png'.model_format(name))
    p.show()
    