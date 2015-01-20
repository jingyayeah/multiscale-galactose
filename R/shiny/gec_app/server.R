library('shiny')

# Define server logic required to draw a histogram
shinyServer( function(input, output) {

  
  
  
#   output$gender <- renderText({
#     paste("Gender:", input$gender) 
#   })
#   output$age <- renderText({
#     paste("Age:", input$age, "years") 
#   })
#   output$height <- renderText({
#     paste("Height:", input$height, 'cm') 
#   })
#   output$bodyweight <- renderText({
#     paste("Age:", input$bodyweight, '') 
#   })
  
  datasetInput <- reactive({
    # Create a Progress object
    progress <- shiny::Progress$new()
    progress$set(message = "Computing GEC range ...", value = 0)
    # Close the progress when this reactive exits (even if there's an error)
    on.exit(progress$close())
    
    person <- data.frame(study='None', sex=input$gender, age=input$age, bodyweight=input$bodyweight, height=input$height, 
               BSA=NA, volLiver=NA, volLiverkg=NA, stringsAsFactors=FALSE)
    
    
    liver.info <- predict_liver_people(person, Nsample=2000, Ncores=1)
    GEC.info <- calculate_GEC(GEC_f, 
                              volLiver=liver.info$volLiver,
                              flowLiver=liver.info$flowLiver)
    GEC <- GEC.info$values
    GECkg <- GEC/input$bodyweight
    progress$set(message="... done.", value = 1)
    dataset <- list(person=person, volLiver=t(liver.info$volLiver), 
                    flowLiver=t(liver.info$flowLiver), GEC=t(GEC), GECkg=t(GECkg))
    
  }) 
  # Show the first "n" observations
  output$person <- renderTable({
    d <- datasetInput()
    person <- d$person
    data.frame(sex=person$sex, age=person$age, bodyweight=person$bodyweight, height=person$height)
  })
  
  
  # Generate a summary of the dataset
  output$summary <- renderPrint({
    d <- datasetInput();
    d2 <- data.frame(GEC=d$GEC, liverVolume=d$volLiver, liverBloodflow=d$flowLiver);
    summary(d2)
  })
  

  
  
  output$hist <- renderPlot({
    d <- datasetInput()
    individual_plot(person=d$person, vol=d$volLiver, flow=d$flowLiver,
                    data=d$GEC)
  })
  

  
  
  
})
