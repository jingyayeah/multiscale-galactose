library('shiny')
library('MultiscaleAnalysis')
lab

# GAMLSS models
fit.models <- load_models_for_prediction()
# GEC function to use
GEC_f <- GEC_functions(task='T1')







# Define server logic required to draw a histogram
shinyServer( function(input, output) {
  
  output$gender <- renderText({
    paste("Gender:", input$gender) 
  })
  output$age <- renderPrint({ input$age })
  output$height <- renderPrint({ input$height })
  output$bodyweight <- renderPrint({ input$bodyweight })
  
  output$hist <- renderPlot({
    # TODO: some input checking
    person <- data.frame(study='None', sex=input$gender, age=input$age, bodyweight=input$bodyweight, height=input$height, 
                         BSA=NA, volLiver=NA, volLiverkg=NA, stringsAsFactors=FALSE)
    print(person)
    
    liver.info <- predict_liver_people(person, Nsample=1000, Ncores=1)
    volLiver <- liver.info$volLiver
    flowLiver <- liver.info$flowLiver
    
    GEC.info <- calculate_GEC(GEC_f, volLiver, flowLiver)
    GEC <- GEC.info$values
    GECkg <- GEC/bodyweight
    
    # hist(GEC)
    index =1
    str(person)
    str(volLiver)
    str(flowLiver)
    str(GEC)
    individual_plot(person=person, vol=t(volLiver), flow=t(flowLiver),
                    data=t(GEC))
    
    #hist(rnorm(1000), main=gender)
  })
  
})
