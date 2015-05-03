'''
Created on Apr 30, 2015

@author: mkoenig
'''
import h5py
h5py.enable_ipython_completer() # ipyhon tools

import numpy as np

# run the tests
# h5py.run_tests()

# opening and creating files
f = h5py.File("mytestfile.hdf5", 'w')

# creating a dataset 
dset = f.create_dataset("mydataset", shape=(100,), dtype='i')

# The object we created isn’t an array, but an HDF5 dataset. Like NumPy arrays, datasets have both a shape and a data type:
dset.shape
dset.dtype
# They also support array-style slicing. This is how you read and write data from a dataset in the file:
dset[...] = np.arange(100)
dset[0]
dset[9]

# groups and hierarchical organization
dset.name
f.name
# Creating a subgroup is accomplished via the aptly-named create_group:
grp = f.create_group("subgroup")
dset2 = grp.create_dataset("another_dataset", (50,), dtype='f')
dset2.name

dset3 = f.create_dataset('subgroup2/dataset_three', (10,), dtype='i')
dset3.name

# Groups support most of the Python dictionary-style interface. You retrieve objects in the file using the item-retrieval syntax:
dataset_three = f['subgroup2/dataset_three']
dataset_three.shape
dataset_three[5]

# Iterating over a group provides the names of its members:
for name in f:
    print name

"mydataset" in f
"subgroup/another_dataset" in f

# Since iterating over a group only yields its directly-attached members, 
# iterating over an entire file is accomplished with the Group methods visit() and visititems(), which take a callable:
def printname(name):
    print name
f.visit(printname)

# Attributes
# Attributes are a critical part of what makes HDF5 a “self-describing” format. 
# They are small named pieces of data attached directly to Group and Dataset objects. 
# This is the official way to store metadata in HDF5.
# Store dictionary of information here.
dset.attrs['temperature'] = 99.5
dset.attrs['temperature']
'temperature' in dset.attrs

# What happens when assigning an object to a name in the group? 
# It depends on the type of object being assigned. For NumPy arrays or other data, 
# the default is to create an HDF5 datasets:
grp = f.create_group("bar")
grp["name"] = 42
out = grp["name"]
# hardlinks ! objects can be stored in multiple groups

## HDF5 Datasets
# Datasets are very similar to NumPy arrays. They are homogenous 
# collections of data elements, with an immutable datatype and (hyper)rectangular shape. 
# Unlike NumPy arrays, they support a variety of transparent storage features such as compression, 
# error-detection, and chunked I/O.

# They are represented in h5py by a thin proxy class which supports familiar NumPy operations like slicing, 
# along with a variety of descriptive attributes:

# initialiaze with existing numpy array
arr = np.arange(100)
dset = f.create_dataset("init", data=arr)

# Chunking
# Chunking has performance implications. It’s recommended to keep the total size of your chunks 
# between 10 KiB and 1 MiB, larger for larger datasets. Also keep in mind that when any element 
# in a chunk is accessed, the entire chunk is read from disk.

# filter pipeline
# Chunked data may be transformed by the HDF5 filter pipeline. The most common use is 
# applying transparent compression. Data is compressed on the way to disk, and automatically 
# decompressed when read. Once the dataset is created with a particular compression filter applied, 
# data may be read and written as normal with no special steps required.
# Enable compression with the compression keyword to Group.create_dataset():
dset = f.create_dataset("zipped", (100, 100), compression="gzip")

## HDF5 Dimension scales
# Attributes are a critical part of what makes HDF5 a “self-describing” format. 
# They are small named pieces of data attached directly to Group and Dataset objects. 
# This is the official way to store metadata in HDF5.

f = h5py.File('foo.h5', 'w')
f.close()
f['data'] = np.ones((4, 3, 2), 'f')
f['data'].dims[0].label = 'z'
f['data'].dims[2].label = 'x'

# Variable length strings
f = h5py.File('foo.hdf5')

ds = f.create_dataset('VLDS', (100,100), dtype=dt)
ds.dtype.kind
h5py.check_dtype(vlen=ds.dtype)

# write strings
f1 = h5py.File('foo1.h5', 'w')
test = ['A', 'B', 'C']
f1.create_dataset("string_ds", data=test, dtype="S10")



filename = "/home/mkoenig/multiscale-galactose-results/tmp_sim/T2/Koenig2014_demo_kinetic_v7_Sim18_roadrunner.h5"
f = h5py.File(filename, 'r')
def printname(name):
    print name
f.visit(printname)
dset = f.get('test')
dset[0:10, :]




# write the column headers in HDF5
import pandas as pd
from pandas import DataFrame
df = DataFrame()
store = pd.HDFStore('test.h5')
store.append('my_df', df)