"""
Interaction of python with R for testing the conversion of the binary files.

@author: Matthias Koenig
@date: 2015-05-06
"""

if __name__ == "__main__":
    import os
    print 'R_script'
    f = "/home/mkoenig/multiscale-galactose-results/django/timecourse/T55/Galactose_v25_Nc20_dilution_Sim92022_roadrunner.csv"
    print f
    
    # zip the file
    f_tar = f[:-3] + 'tar.gz'
    print f_tar
    
    import tarfile
    tar = tarfile.open(f_tar, "w:gz")


    print(os.path.basename(f))
    tar.add(f, arcname=os.path.basename(f))
    tar.close()
    
    # convert to Rdata file
    f_rdata = f + '.Rdata'
    print f_rdata
    
    # call a r function
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
    rpack.readData(f)