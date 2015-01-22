library('MultiscaleAnalysis')
cat(sprintf('MultiscaleAnalysis v%s', packageVersion('MultiscaleAnalysis')[1]))

# GAMLSS models
fit.models <- load_shiny_fit_models()
# fit.models <- load_models_for_prediction(dir="data/gamlss")
