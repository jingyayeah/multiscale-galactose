'''
Created on Dec 19, 2014

@author: mkoenig
'''

from roadrunner_tools import selection_dict

t_peak = 5000


def dilution_plot(s_list, selections, show=True, 
                   xlim=[t_peak-5, t_peak+30], ylim=[0, 0.5]):
    ''' 
        Plot of the dilution curves.
        TODO: make more general to handle not the hard coded pp/pv.
    '''
    
    compounds = ['gal', 'galM', 'rbcM', 'alb', 'suc', 'h2oM']
    ccols = ['gray', 'black', 'red', 'darkgreen', 'darkorange', 'darkblue']
    pp_ids = ['[PP__{}]'.format(sid) for sid in compounds]    
    pv_ids = ['[PV__{}]'.format(sid) for sid in compounds]
    ids = pp_ids + pv_ids
    cols = ccols + ccols
    
    # plot all the individual solutions    
    sel_dict = selection_dict(selections)
    
    import pylab as p    
    for s in s_list:
        times = s[:,0]
        for k, sid in enumerate(ids):
            index = sel_dict.get(sid, None)
            if not index:
                raise Exception("{} not in selection".format(sid))
            series = s[:, index]
            name = selections[index]
            p.plot(times, series, color=cols[k], label=str(name))
            # p.legend()
    # adapt the axis
    if xlim:
        p.xlim(xlim)
    if ylim:
        p.ylim(ylim)
    if show:
        p.show()
    

def dilution_plot_by_name(s_list, selections, name, xlim=[t_peak-5, t_peak+30], comp_type='H'):
    ''' 
        Plot of the dilution curves.    
        TODO: fix the problems if not enough colors are provided.
    '''
    print '#'*80    
    print name
    print '#'*80
    ids =  [item for item in selections if ( (item.startswith('[{}'.format(comp_type)) | item.startswith(comp_type)) 
                                    & (item.endswith('__{}]'.format(name)) | item.endswith('__{}'.format(name))) )]
    if len(ids) == 0:
        ids = [name, ]
    
    print ids
    cols=['red', 'darkblue', 'darkgreen', 'gray', 'darkorgange', 'black']   


    # plot all the individual solutions
    sel_dict = selection_dict(selections)    
    import pylab as p
    for ks, s in enumerate(s_list):
        times = s[:,0]
        for sid in ids:
            # find in which place of the solution the component is encoded
            index = sel_dict.get(sid, None)
            
            if not index:
                raise Exception("{} not in selection".format(id))
            series = s[:,index]
            name = selections[index]
            p.plot(times, series, color=cols[ks], label=str(name))
            # p.legend()
    p.xlim(xlim)
    #p.ylim(0, 0.4)
    p.show()
    