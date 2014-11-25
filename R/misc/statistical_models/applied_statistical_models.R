# Applied predictive modeling
install.packages('AppliedPredictiveModeling')

#######################################
# 3.8 Computing
#######################################
rm(list=ls())
library(AppliedPredictiveModeling)
data(segmentationOriginal)
names(segmentationOriginal)
head(segmentationOriginal)
summary(segmentationOriginal)

# training data
segData <- subset(segmentationOriginal, Case == "Train")
cellID <- segData$Cell
class <- segData$Class
case <- segData$Case
# Now remove the columns
segData <- segData[, -(1:3)]
statusColNum <- grep("Status", names(segData))
statusColNum
segData <- segData[, -statusColNum]

# transformation
# As previously discussed, some features exhibited significantly skewness. The skewness function in the e1071 package calculates the sample skewness statistic

install.packages('e1071')
library(e1071)
skewness(segData$AngleCh1)
skewValues <- apply(segData, 2, skewness)
head(skewValues)
# To determine which type of transformation should be used, the MASS package contains the boxcox function.
install.packages('caret')
library(caret)
Ch1AreaTrans <- BoxCoxTrans(segData$AreaCh1)
Ch1AreaTrans

# The original data
head(segData$AreaCh1)

# After Box-Cox transformation
predict(Ch1AreaTrans, head(segData$AreaCh1))

# Another caret function, preProcess, applies this transformation to a set of predictors. This function is discussed below. The base R function prcomp can be used for PCA. In the code below, the data are centered and scaled prior to PCA.
pcaObject <- prcomp(segData, center = TRUE, scale. = TRUE)

# Calculate the cumulative percentage of variance which each component accounts for.
percentVariance <- pcaObject$sd^2/sum(pcaObject$sd^2)*100
percentVariance[1:5]

# The transformed values are stored in pcaObject as a sub-object called x:
head(pcaObject$x[, 1:5])

# The another sub-object called rotation stores the variable loadings, where rows correspond to predictor variables and columns are associated with the components:
head(pcaObject$rotation[, 1:3])

# Also, these data do not have missing values for imputation. To impute missing values, the impute package has a function, impute.knn, that uses Knearest neighbors to estimate the missing data. The previously mentioned preProcess function applies imputation methods based on K-nearest neighbors or bagged trees. To administer a series of transformations to multiple data sets, the caret class preProcess has the ability to transform, center, scale, or impute values, as well as apply the spatial sign transformation and feature extraction. The function calculates the required quantities for the transformation. After calling the preProcess function, the predict method applies the results to a set of data. For example, to Box–Cox transform, center, and scale the data, then execute PCA for signal extraction, the syntax would be:
trans <- preProcess(segData, method = c("BoxCox", "center", "scale", "pca"))
trans

# Apply the transformations:
transformed <- predict(trans, segData)
# These values are different than the previous PCA components since they were transformed prior to PCA
head(transformed[, 1:5])

## Filtering ##
# To filter for near-zero variance predictors, the caret package function nearZero. Var will return the column numbers of any predictors that fulfill the conditions outlined in Sect. 3.5. For the cell segmentation data, there are no problematic predictors:
nearZeroVar(segData)

# Similarly, to filter on between-predictor correlations, the cor function can calculate the correlations between predictor variables:
correlations <- cor(segData)
dim(correlations)
correlations[1:4, 1:4]

#
To visually examine the correlation structure of the data, the corrplot package
contains an excellent function of the same name.