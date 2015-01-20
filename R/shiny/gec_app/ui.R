library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  fluidRow(
      img(src = "virtual-liver.png", width=150),
      h1("Individual Liver Function"), 
      h2("Galatose Elimination Capacity (GEC)")
      ),
  
  sidebarLayout(
    sidebarPanel(
      #helpText("Calculate individualized GEC range based 
      #  on personal information."),
      selectInput("gender", label = h3("Gender"), 
                  choices = list("male" = "male", "female" = "female"), selected = 1),
      sliderInput("age", label = h3("Age [years]"),
                  min = 0, max = 100, value = 50),
      sliderInput("height", label = h3("Height [cm]"),
                  min = 40, max = 220, value = 170),
      sliderInput("bodyweight", label = h3("Bodyweight [kg]"),
                  min = 2, max = 140, value = 70),
      submitButton("Calculate")
    

    ),
    mainPanel(
              h3("Results"),
              h4("Person"),
              tableOutput("person"),
              h4("GEC Reference Range [2.5% - 97.5%]"),
              tableOutput("gec"),
              h4("Summary"),
              verbatimTextOutput("summary"),
              h4("Plots"),
              plotOutput("hist"),
              
              h3("Information"),
              p("Calculate your individualized galactose elimination capacity (GEC)."),
              p("Based on a comparable population sample the distribution of liver volumes
                and liver blood flows within this sample are calculated. This information is than used
                to scale the GEC per tissue and perfusion function.")
              ),    
  )
  
))
