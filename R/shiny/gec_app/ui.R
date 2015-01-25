library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = "bootstrap-cosmo.css",
  
  fluidRow(
    column(2,
           img(src = "virtual-liver.png", width=150)
    ),
    column(10,
           h2("Galactose Elimination Capacity (GEC)") 
    )
  ),
  sidebarLayout(
    sidebarPanel(
      helpText("Calculate your individual liver function based on your hepatic 
               Galactose Elimination Capacity (GEC). Provide an experimental GEC value for evaluation."),
      selectInput("gender", label = h4("Gender"), 
                  choices = list("male" = "male", "female" = "female"), selected = 1),
      sliderInput("age", label = h4("Age [years]"),
                  min = 0, max = 100, value = 50),
      sliderInput("height", label = h4("Height [cm]"),
                  min = 40, max = 220, value = 170),
      sliderInput("bodyweight", label = h4("Bodyweight [kg]"),
                  min = 2, max = 140, value = 70),
      numericInput("gec", label = h4("GEC [mmole/min]"), 
                          value = NA),  
      submitButton("Calculate")
    ),
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Results", 
                           
                           h4("GEC Reference Range"),
                           fluidRow(
                             column(1,
                                    # imageOutput("icon", width = "100%", height = "100%", inline = FALSE)
                                    htmlOutput("icon_html", inline = FALSE)
                             ),
                             column(4,
                                    textOutput("gender"),
                                    textOutput("age"),
                                    textOutput("height"),
                                    textOutput("bodyweight"),
                                    textOutput("bsa")
                             ),
                             column(4,
                                    p(strong("GEC Range [2.5% - 97.5%]")),
                                    strong(textOutput("gec"))
                                    
                             )
                           ),
                           h4("Details"),
                           plotOutput("hist"),
                           
                           h4("Summary"),
                           verbatimTextOutput("summary")
                           
                  ), 
                  tabPanel("About", 
                           h4("Information"),
                           p("Calculate your individualized galactose elimination capacity (GEC)."),
                           p("Based on a comparable population sample the distribution of liver volumes
                                and liver blood flows within this sample are calculated. This information is than used
                                to scale the GEC per tissue and perfusion function."),
                           h4("Version"),
                           p("0.8 beta"),
                           h4("Contact"),
                           p("matthias.koenig@charite.de")
                  
                  )
      )     
    )
  )
))
