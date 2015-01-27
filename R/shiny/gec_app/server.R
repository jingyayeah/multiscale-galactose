library('shiny')

# GEC function to use
GEC_f <- GEC_functions(task='T1')

# boundaries for range
# q.low = 0.025
# q.up = 0.975


# Define server logic
shinyServer( function(input, output) {
  
  ## Reactive Expressions ###########################################
  
  # get person from input
  personInput <- reactive({
    BSA <- calculateBSA(bodyweight_kg=input$bodyweight, height_cm=input$height)
    person <- data.frame(study='None', sex=input$gender, age=input$age, bodyweight=input$bodyweight, height=input$height, 
                         BSA=BSA, volLiver=NA, volLiverkg=NA, stringsAsFactors=FALSE)
  })
  
  # calcuate GEC
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
    
    dataset <- list(person=person, volLiver=t(liver.info$volLiver), 
                    flowLiver=t(liver.info$flowLiver), GEC=t(GEC), GECkg=t(GECkg))
  }) 

  ## Output rendering ###########################################
  
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
  output$bsa <- renderUI({ 
    person <- personInput()
    HTML(sprintf("%1.2f m<sup>2</sup>", person$BSA))
  })
  
  # Create test icon depending on GEC status
#   output$icon <- renderImage({
#     d <- datasetInput()
#     q <- quantile(d$GEC, probs = c(0.025, 0.975))
#     
#     status <- 'healthy'
#     if (!is.na(input$gec)){
#       if(input$gec <q[1] | input$gec>q[2]){
#         status <- 'disease'
#       }
#     }
#     name <- paste(input$gender, '_', status, '.png', sep="")
#     filename <- normalizePath(file.path('./www', name))
#     print(filename)
#   
#     list(src = filename, contentType = 'image/png')
#   }, deleteFile = FALSE)
  
  # Create test icon depending on GEC status
  output$icon_html <- renderUI({
    d <- datasetInput()
    q <- quantile(d$GEC, probs=c(0.025, 0.975))
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
  
  # Validate experimental GEC data if provided
  validate_GEC <- function(){
  if (!is.na(input$gec)){
    validate(
      need((input$gec>=0 & input$gec<=5), 'Experimental GEC should be between 0 and 5 [mmol/min]')
    )
  }
  }


  # Boxplot of GEC range
  output$gec_box <- renderPlot({
   validate_GEC()
   d <- datasetInput()
   individual_GEC_box(person=d$person, data=d$GEC, gec_exp=input$gec)
   
   })

  # Histogram with additional information for GEC range
  output$gec_hist <- renderPlot({
    validate_GEC()
    d <- datasetInput()
    # individual_plot(person=d$person, vol=d$volLiver, flow=d$flowLiver,
    #                data=d$GEC)
    
    individual_GEC_plot(person=d$person, data=d$GEC)
  })
   
  # Histogram of predicted volumes and bloodflow
  output$flow_vol <- renderPlot({
   validate_GEC()
   d <- datasetInput()
   individual_vol_flow_plot(person=d$person, vol=d$volLiver, flow=d$flowLiver, data=d$GEC)
  })

  # GEC curves used for prediction
  output$gec_function <- renderPlot({
    plot_GEC_function(GEC_f)
  })


})
