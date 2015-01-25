library('shiny')

# GEC function to use
GEC_f <- GEC_functions(task='T1')

# Define server logic required to draw a histogram
shinyServer( function(input, output) {
  
  personInput <- reactive({
    BSA <- calculateBSA(bodyweight_kg=input$bodyweight, height_cm=input$height)
    person <- data.frame(study='None', sex=input$gender, age=input$age, bodyweight=input$bodyweight, height=input$height, 
                         BSA=BSA, volLiver=NA, volLiverkg=NA, stringsAsFactors=FALSE)
  })
  
  
  datasetInput <- reactive({
    # Create a Progress object
    progress <- shiny::Progress$new()
    progress$set(message = "Computing GEC range ...", value = 0)
    # Close the progress when this reactive exits (even if there's an error)
    on.exit(progress$close())
    
    person <- personInput()
    liver.info <- predict_liver_people(person, Nsample=2000, Ncores=1, debug=FALSE)
    GEC.info <- calculate_GEC(GEC_f, 
                              volLiver=liver.info$volLiver,
                              flowLiver=liver.info$flowLiver)
    GEC <- GEC.info$values
    GECkg <- GEC/input$bodyweight
    progress$set(message="... done.", value = 1)
    # browser()
    dataset <- list(person=person, volLiver=t(liver.info$volLiver), 
                    flowLiver=t(liver.info$flowLiver), GEC=t(GEC), GECkg=t(GECkg))
  }) 

  # Show GEC range
  output$gec <- renderText({ 
    d <- datasetInput()
    q <- quantile(d$GEC, probs = c(0.025, 0.25, 0.5, 0.75, 0.975))
    sprintf("[%.2f - %.2f] mmole/min", q[1], q[5])
  })
  
  output$gender <- renderText({ 
    sprintf("%s", input$gender)
  })
  output$age <- renderText({ 
    sprintf("%d years", input$age)
  })
  output$height <- renderText({ 
    sprintf("%d cm", input$height)
  })
  output$bodyweight <- renderText({ 
    sprintf("%d kg", input$bodyweight)
  })
  output$bsa <- renderText({ 
    person <- personInput()
    sprintf("%1.2f m<sup>2</sup>", person$BSA)
  })
  
  # Create test icon depending on GEC status
  output$icon <- renderImage({
    d <- datasetInput()
    q <- quantile(d$GEC, probs = c(0.025, 0.975))
    
    status <- 'healthy'
    if (!is.na(input$gec)){
      if(input$gec <q[1] | input$gec>q[2]){
        status <- 'disease'
      }
    }
    name <- paste(input$gender, '_', status, '.png', sep="")
    filename <- normalizePath(file.path('./www', name))
    print(filename)
  
    list(src = filename, contentType = 'image/png')
  }, deleteFile = FALSE)
  
  # Create test icon depending on GEC status
  output$icon_html <- renderUI({
    d <- datasetInput()
    q <- quantile(d$GEC, probs = c(0.025, 0.975))
    status <- 'healthy'
    if (!is.na(input$gec)){
      if(input$gec <q[1] | input$gec>q[2]){
        status <- 'disease'
      }
    }
    name <- paste(input$gender, '_', status, '.png', sep="")
    img(src = name, width=50)
  })
  
  
  
  # Generate a summary of the dataset
  output$summary <- renderPrint({
    d <- datasetInput();
    d2 <- data.frame(GEC=d$GEC, liverVolume=d$volLiver, liverBloodflow=d$flowLiver);
    summary(d2)
  })
  
  # Make the plot
  output$hist <- renderPlot({
    # Validate experimental GEC data if provided
    if (!is.na(input$gec)){
      print(input$gec>5)
      print(input$gec<0)
      print(input$gec<0 | input$gec>5)
      validate(
          need((input$gec>=0 & input$gec<=5), 'Experimental GEC should be between 0 and 5 [mmol/min]')
        )
    }

    d <- datasetInput()
    individual_plot(person=d$person, vol=d$volLiver, flow=d$flowLiver,
                    data=d$GEC)
  })

})
