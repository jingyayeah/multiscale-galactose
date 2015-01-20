library('MultiscaleAnalysis')

# GAMLSS models
fit.models <- load_models_for_prediction(dir="data/gamlss")
# GEC function to use
GEC_f <- GEC_functions(task='T1')