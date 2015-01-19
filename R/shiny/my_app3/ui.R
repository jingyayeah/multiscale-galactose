library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  fluidRow(
      img(src = "virtual-liver.png", width=150),
      h1("Personalized GEC calculation")
      ),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("select", label = h3("Gender"), 
                  choices = list("male" = 1, "female" = 2), selected = 1),
      numericInput("age", 
                   label = h3("Age [years]"), 
                   value = 50),
      numericInput("height", 
                   label = h3("Height [cm]"), 
                   value = 170),
      numericInput("bodyweight", 
                   label = h3("Bodyweight [kg]"), 
                   value = 70),
      actionButton("calculate", label = "Calculate")
    

    ),
    mainPanel(h3("Information"),
              p("Calculation of individualized galactose elimination capacity (GEC)."),
              code("GEC"),
              h3("Results"))
  )
  
))
