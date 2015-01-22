library('MultiscaleAnalysis')
print(packageVersion('MultiscaleAnalysis'))

# GAMLSS models

save_shiny_fit_models()
fit.models <- load_shiny_fit_models()
# fit.models <- load_models_for_prediction(dir="data/gamlss")
