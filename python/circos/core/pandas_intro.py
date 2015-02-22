# -*- coding: utf-8 -*-
"""
Created on Sun Feb 22 19:50:22 2015

@author: mkoenig
"""
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

s = pd.Series([1,3,5,np.nan,6,8])
s
dates = pd.date_range('20130101',periods=6)
dates
df = pd.DataFrame(np.random.randn(6,4),index=dates,columns=list('ABCD'))
df
df.info()

df2 = pd.DataFrame({ 'A' : 1.,
                     'B' : pd.Timestamp('20130102'),
                     'C' : pd.Series(1,index=list(range(4)),dtype='float32'),
                     'D' : np.array([3] * 4,dtype='int32'),
                     'E' : pd.Categorical(["test","train","test","train"]),
                     'F' : 'foo' })
df2
# data types
df2.dtypes

# head and tail
df.head()
df.tail(3)

# Display the index,columns, and the underlying numpy data
df.index
df.columns
df.values

# Summary statistics via describe
df.describe
# Transposing data
df.T
# Sorting by an axis
df.sort_index(axis=1, ascending=False)
df.sort(columns='B')




# Note
# While standard Python / Numpy expressions for selecting and setting are 
# intuitive and come in handy for interactive work, for production code, 
# we recommend the optimized pandas data access methods, 
# .at, .iat, .loc, .iloc and .ix.


df2 = df.copy()
df2['E']=['one', 'one','two','three','four','three']
df2
df2[df2['E'].isin(['two','four'])]