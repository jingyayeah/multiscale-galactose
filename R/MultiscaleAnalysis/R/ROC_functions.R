################################################################################
# ROC functions for predictions
################################################################################
# Predict liver volume, blood flow and metabolic functions for the data consisting
# of gender, age, bodyweight, height
# Based on the individual samples of blood flow an liver the GEC clearance
# is calculated.
#
# author: Matthias Koenig
# date: 2015-02-19
################################################################################

#' Overview of GEC & GECkg data in given classification data
#' 
#' @export
create_GEC_histogram <- function(data){
  par(mfrow = c(1,2))
  bins = seq(from=0, to=5, by=0.07)
  hist(data$GEC[data$disease==1], breaks=bins, xlim=c(0,5), xlab=lab[['GEC']], col=rgb(1,0,0,0.5), freq=FALSE)
  hist(data$GEC[data$disease==0], breaks=bins, xlim=c(0,5), xlab=lab[['GEC']], col=rgb(0.5,0.5,0.5, 0.5), freq=FALSE, add=TRUE)
  
  bins = seq(from=0, to=0.12, by=0.001)
  hist(data$GECkg[data$disease==1], breaks=bins, xlim=c(0,0.12), xlab=lab[['GECkg']], freq=FALSE, col=rgb(1,0,0,0.5))
  hist(data$GECkg[data$disease==0], breaks=bins, xlim=c(0,0.12), xlab=lab[['GECkg']], freq=FALSE, col=rgb(0.5,0.5,0.5, 0.5), add=TRUE)
  par(mfrow = c(1,1))
  rm(bins)
}

#--------------------------------------
# Subsetting Classification data
#--------------------------------------
# data subsets corresponding to the respective predictors in the 
# formula a generated (i.e. subsets of data which have all predictor variables)

#' Get field names of subset from formula
#' 
#' @export 
subset_from_formula <- function(f){
  s <- strsplit(f, '~')[[1]]
  left <- trim(s[1])
  if (grepl('+', s[2])){
    right <- trim(strsplit(s[2], '\\+')[[1]])
  } else {
    right <- trim(s[2])
  }
  return(c(left, right))
}

#' Create data subset from given field names
#' 
#' @export
d_subset <- function(data, subset){
  indices <- complete.cases(data[, subset])
  list(df=data[indices,], 
       indices=indices)
}

#' Data subset based on regression formula.
#' 
#' @export
create_data_subset <- function(data, formula){
  d <- list()
  indices <- list()
  for (k in seq_along(formula)){
    f <- formula[[k]]
    ss <- subset_from_formula(f)  
    d.ss <- d_subset(data, ss)
    d.tmp <- d.ss$df
    indices[[k]] <- d.ss$indices
    # if sex part of model, remove the all (only male/female)
    if ('sex' %in% ss){
      d.tmp <- d.tmp[d.tmp$sex != 'all', ]
    }
    d[[k]] <- d.tmp
  }
  names(d) <- ids
  names(indices) <- ids
  list(d=d, indices=indices)
}

#' Create overview table of data subsets
#' @export 
create_subset_table <- function(d, formula){
  tmp <- rep(NA, length(formula))
  d.table <- data.frame(id=ids, formula=as.character(formula), H=tmp, D=tmp, C=tmp)
  rm(tmp)
  rownames(d.table) <- ids
  for (k in seq_along(d)){
    d.tmp <- d[[k]]
    H <- sum(d.tmp$disease == 0)
    D <- sum(d.tmp$disease == 1)
    C = nrow(d.tmp)
    d.table[k, c('H', 'D', 'C')] <- c(H, D, C)
  }
  d.table  
}

#--------------------------------------
# Best models (full data for training)
#--------------------------------------
#' Create plot of the predicted values for baseline model m1
#' @export
create_m1_plot <- function(m.all, d){
  
  d_m1 <- list()
  d_m1$rankP <- predict(m.all[[1]], newdata = d[[1]], type = "response")
  d1_c <- data.frame(GEC=seq(from=0, to=5, by=0.1))
  d1_c$rankP <- predict(m.all[[1]], newdata = d1_c, type = "response")
  
  plot(d[[1]]$GEC, d[[1]]$rankP, xlim=c(0,5), xlab=lab[['GEC']], ylim=c(-0.1,1.1),
       main='Logistic regression: disease ~ GEC',
       ylab='probability liver disease')
  lines(d1_c$GEC, d1_c$rankP)
  points(d[[1]]$GEC, d[[1]]$disease, pch=21, col="black", bg=rgb(0,0,1, 0.5))  
}

#--------------------------------------
# Bootstrap models
#--------------------------------------
#' Bootstrap calculation of model fitting based on data and formula
#'
#' @export 
m_bootstrap <- function(df, formula, B=100){
  # fit all the bootstrap models
  m.boot <- as.list(rep(NA, B))
  
  # calculate for bootstrap samples
  N <- nrow(df)
  for (k in 1:B){
    inds <- sample(seq(1,N), size=N, replace=TRUE)
    # create the bootstrap data.frame
    df.boot <- df[inds, ]
    # fit model with bootstrap data
    m.boot[[k]] <- glm(formula, data=df.boot, family="binomial")
  }
  return(m.boot)
}

#--------------------------------------
# Split sample models
#--------------------------------------
#' Splits dataset randomly into 50% training and testing set.
#' 
#' @export
splitdf <- function(df, seed=NULL) {
  if (!is.null(seed)) set.seed(seed)
  index <- 1:nrow(df)
  trainindex <- sample(index, trunc(length(index)/2))
  trainset <- df[trainindex, ]
  testset <- df[-trainindex, ]
  list(trainset=trainset,testset=testset)
}

#' Split sample calculation of model fitting based on data and formula
#'
#' @export 
m_split_sample <- function(df, formula, B=100){
  m.split <- as.list(rep(NA, B))
  splits <- as.list(rep(NA, B))
  # calculate split sample model
  N <- nrow(df)
  for (k in 1:B){
    splits[[k]] <- splitdf(df)
    m.split[[k]] <- glm(formula, data=splits[[k]]$trainset, family="binomial")
  }
  return(list(m.split=m.split, splits=splits))
}

#--------------------------------------
# Multiscale Model Classification
#--------------------------------------
#' Predict liver disease based on multiscale-model predictions of GEC.
#' 
#' The GEC multiscale classifier works via comparing the predicted GEC range 
#' with the experimental value and uses the location of the experimental
#' data relative to the theoretical prediction based on the anthropomorphic
#' features for evaluation.
#' 
#' @export
disease_predictor <- function(GEC_exp, GEC, q=0.05){
  N <- length(GEC_exp)
  predictor <- rep(NA, N)
  mean_gec <- rep(NA, N)
  sd_gec <- rep(NA, N)
  q_gec <- rep(NA, N)
  
  # predict every row
  for (k in 1:length(GEC_exp)){
    # TODO: fix prediction bug => why single NA in special case???
    if (any(is.na(GEC[k, ])))
      warning('NAs in predicted GEC')
    
    q_gec[k] <- quantile(GEC[k, ], probs=q, na.rm = TRUE)
    
    mean_gec[k] <- mean(GEC[k, ])
    sd_gec[k] <- sd(GEC[k, ])
  }
  # predictor = abs(mean_gec - GEC_exp)/sd_gec
  predictor = (q_gec - GEC_exp)/sd_gec 
  # predictor = (q_gec - GEC_exp)
  
  return(list(predictor=predictor, gec_exp=GEC_exp, mean_gec=mean_gec, sd_gec=sd_gec))
}
