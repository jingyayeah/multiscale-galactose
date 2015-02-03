## Cross-Validation (k-fold & leave-one-out) ##
# The drawback to leave-one-out CV is subtle but often decisive. Since each training
# set has n 􀀀 1 points, any two training sets must share n 􀀀 2 points. The models fit
# to those training sets tend to be strongly correlated with each other. Even though
# we are averaging n out-of-sample forecasts, those are correlated forecasts, so we are
# not really averaging away all that much noise. With k-fold CV, on the other hand,
# the fraction of data shared between any two training sets is just k􀀀2
# k􀀀1 , not n􀀀2 n􀀀1 , so even though the number of terms being averaged is smaller, they are less correlated.

## split-sample ##
# do a repeated split in training and test data 
# - fit the model
# - test the trainings data set

# splitdf function will return a list of training and testing sets
splitdf <- function(dataframe, seed=NULL) {
  if (!is.null(seed)) set.seed(seed)
  index <- 1:nrow(dataframe)
  trainindex <- sample(index, trunc(length(index)/2))
  trainset <- dataframe[trainindex, ]
  testset <- dataframe[-trainindex, ]
  list(trainset=trainset,testset=testset)
}

#apply the function
splits <- splitdf(d1, seed=808)
summary(splits)
lapply(splits,nrow)
lapply(splits,head, 20)
fun_1 <- function(df){
  table(df$study)
}
lapply(splits, fun_1)


set.s# model fitting & evaluation on training & testseteed(1234)
N = 20
for (k in 1:20){
  splits <- splitdf(d1)
  m.cv <- glm(formula[[1]], data=splits$trainset, family="binomial")
  fitpreds = predict(m.cv, newdata=splits$testset, type="response")
  fitpred = prediction(fitpreds, splits$testset$disease)
  fitperf = performance(fitpred,"tpr","fpr")
  plot(fitperf, col='lightgreen', add=TRUE, lwd="1")
}
