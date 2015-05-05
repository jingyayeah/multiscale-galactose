'''
Helper tools to access galactose model information.

@author: Matthias Koenig
@date: 2015-05-05
'''
def get_ids_from_selection(name, selections, comp_type='H'):
    ''' Returns list of ids in selection for given name. '''
    ids = [item for item in selections if ( (item.startswith('[{}'.format(comp_type)) | item.startswith(comp_type)) 
                                    & (item.endswith('__{}]'.format(name)) | item.endswith('__{}'.format(name))) )]
    if len(ids) == 0:
        ids = [name, ]
    return ids