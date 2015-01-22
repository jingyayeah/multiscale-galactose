library('shiny')

# GEC function to use
GEC_f <- GEC_functions(task='T1')

# Define server logic required to draw a histogram
shinyServer( function(input, output) {
  
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
  # Show the person
  output$person <- renderTable({
    d <- datasetInput()
    person <- d$person
    data.frame(sex=person$sex, age=person$age, bodyweight=person$bodyweight, height=person$height)
  })
  # Show GEC range
  output$gec <- renderText({ 
    d <- datasetInput()
    q <- quantile(d$GEC, probs = c(0.025, 0.25, 0.5, 0.75, 0.975))
    sprintf("[%.2f - %.2f]", q[1], q[5])
  })
  
  # Generate a summary of the dataset
  output$summary <- renderPrint({
    d <- datasetInput();
    d2 <- data.frame(GEC=d$GEC, liverVolume=d$volLiver, liverBloodflow=d$flowLiver);
    summary(d2)
  })
  
  # Make the plot
  output$hist <- renderPlot({
    d <- datasetInput()
    individual_plot(person=d$person, vol=d$volLiver, flow=d$flowLiver,
                    data=d$GEC)
  })

})
