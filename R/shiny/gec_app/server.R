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
  output$bsa <- renderText({ 
    person <- personInput()
    sprintf("%1.2f m<sup>2</sup>", person$BSA)
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
  
  # Validation function
  validate_GEC <- function(){
  # Validate experimental GEC data if provided
  if (!is.na(input$gec)){
    # print(input$gec>5)
    # print(input$gec<0)
    # print(input$gec<0 | input$gec>5)
    validate(
      need((input$gec>=0 & input$gec<=5), 'Experimental GEC should be between 0 and 5 [mmol/min]')
    )
  }
  }

  individual_GEC_box <- function(person, data, gec_exp=NA){
    # boundaries for plot
    min.value = min(data)
    max.value = max(data)
    if (!is.na(gec_exp)){
      min.value <- min(gec_exp, min.value)
      max.value <- max(gec_exp, max.value)
    }
    
    # normal ranges
    q <- quantile(data, probs=c(0.025, 0.975, 0.5) )
    #
    # xlim=c(min.value-0.1, max.value+0.1)
    plot(numeric(0), numeric(0), type='n', yaxt='n', xlim=c(min.value-0.2, max.value+0.2), ylim=c(0.7, 1.3), 
         main=sprintf('[%1.2f - %1.2f] mmole/min\n median %1.2f\n ', q[1], q[2], q[3]),
         xlab="GEC [mmole/min]", ylab="", font.lab=2, cex.lab=1.3, cex.main=1.5)
    

    
    box <- boxplot(data, notch=FALSE, col=(rgb(0,0,0,0.2)), range=0, horizontal=TRUE, add=TRUE, plot=FALSE)
    box$stats <- matrix(quantile(data, c(0.025, 0.25, 0.5, 0.75, 0.975)), nrow=5, ncol=1)
    bxp(z=box, notch=FALSE, range=0, ylim=c(0,5), horizontal=TRUE, add=TRUE, at=c(1.0), lty=1)
    
    
    # Plot polygons
    span = 0.75
    qdata <- quantile(data, c(0.025, .975))
    polygon(x=c(qdata[1]-span, qdata[1], qdata[1], qdata[1]-span), y=c(0, 0, 2, 2), col=rgb(1,0,0,0.1), border=rgb(1,0,0,0))
    polygon(x=c(qdata[2]+span, qdata[2], qdata[2], qdata[2]+span), y=c(0, 0, 2, 2), col=rgb(1,0,0,0.1), border=rgb(1,0,0,0))
    
    # Plot the experimental value
    if (!is.na(gec_exp)){
      col <- 'darkgreen'
      if ((gec_exp < q[1])|(gec_exp > q[2])){
        col <- 'red'
      }
      abline(v = gec_exp, lwd=3, col=col  ) 
    }
    
  }
  


  # Make the plot
  output$gec_box <- renderPlot({
   validate_GEC()
   d <- datasetInput()
   individual_GEC_box(person=d$person, data=d$GEC, gec_exp=input$gec)
   
   })

  # Make the plot
  output$gec_hist <- renderPlot({
    validate_GEC()

    d <- datasetInput()
    # individual_plot(person=d$person, vol=d$volLiver, flow=d$flowLiver,
    #                data=d$GEC)
    
    individual_GEC_plot(person=d$person, data=d$GEC)
  })
  
 output$flow_vol <- renderPlot({
  validate_GEC()
  d <- datasetInput()
  individual_vol_flow_plot(person=d$person, vol=d$volLiver, flow=d$flowLiver, data=d$GEC)
 })




})
