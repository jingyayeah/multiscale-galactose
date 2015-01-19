library('shiny')
library('MultiscaleAnalysis')

# GAMLSS models
fit.models <- load_models_for_prediction()
# GEC function to use
GEC_f <- GEC_functions(task='T1')



# Define server logic required to draw a histogram
shinyServer( function(input, output) {
  
  output$gender <- renderText({
    paste("Gender:", input$gender) 
  })
  output$age <- renderText({
    paste("Age:", input$age, "years") 
  })
  output$height <- renderText({
    paste("Height:", input$height, 'cm') 
  })
  output$bodyweight <- renderText({
    paste("Age:", input$bodyweight, '') 
  })
  
  output$hist <- renderPlot({
    person <- data.frame(study='None', sex=input$gender, age=input$age, bodyweight=input$bodyweight, height=input$height, 
                         BSA=NA, volLiver=NA, volLiverkg=NA, stringsAsFactors=FALSE)
    
    liver.info <- predict_liver_people(person, Nsample=2000, Ncores=1)
    GEC.info <- calculate_GEC(GEC_f, 
                              volLiver=liver.info$volLiver,
                              flowLiver=liver.info$flowLiver)
    GEC <- GEC.info$values
    # GECkg <- GEC/bodyweight
    
    # hist(GEC)
    individual_plot(person=person, vol=t(liver.info$volLiver), flow=t(liver.info$flowLiver),
                    data=t(GEC))
  })
  
})
