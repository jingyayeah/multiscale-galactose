library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
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
      helpText("Calculate the individual reference range of your liver function based on hepatic 
               Galactose Elimination Capacity (GEC)."),
      selectInput("gender", label = h4("Gender"), 
                  choices = list("male" = "male", "female" = "female"), selected = 1),
      sliderInput("age", label = h4("Age [years]"),
                  min = 0, max = 100, value = 50),
      sliderInput("height", label = h4("Height [cm]"),
                  min = 40, max = 220, value = 170),
      sliderInput("bodyweight", label = h4("Bodyweight [kg]"),
                  min = 2, max = 140, value = 70),
      submitButton("Calculate")
    ),
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Results", 
                           h4("Person"),
                           tableOutput("person"),
                           h4("GEC Reference Range [2.5% - 97.5%]"),
                           textOutput("gec"),
                           h4("Summary"),
                           verbatimTextOutput("summary"),
                           h4("Plots"),
                           plotOutput("hist")
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
