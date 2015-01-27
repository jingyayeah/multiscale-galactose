library(shiny)

disclaimer_model = "This prediction software is based on a predictive computational model."
disclaimer = "The software is provided \"AS IS\", without warranty of any kind, express or implied, including but not limited to the warranties of merchantability,
fitness for a particular purpose and noninfringement. In no event shall the
authors or copyright holders be liable for any claim, damages or other liability, whether in an action of contract, tort
or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software."


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
                           p(),
                           fluidRow(
                             column(1,
                                    # imageOutput("icon", width = "100%", height = "100%", inline = FALSE)
                                    htmlOutput("icon_html", inline = FALSE)
                             ),
                             column(3,
                                    textOutput("gender"),
                                    textOutput("age"),
                                    textOutput("height"),
                                    textOutput("bodyweight"),
                                    htmlOutput("bsa")
                             ),
                             column(6,
                                    h4("GEC Reference Range [2.5% - 97.5%]"),
                                    plotOutput("gec_box", height = 200)
                             )
                           ),
                           fluidRow(
                             column(5,
                                    plotOutput("gec_hist")
                             ),
                             column(5,
                                    plotOutput("flow_vol")
                             )
                           ),
                           fluidRow(
                             column(5,
                                    plotOutput("gec_function")
                             ),
                             column(5,
                                    p()
                             )
                           ),  
                           tags$small(tags$small(tags$b(helpText("Disclaimer")))),
                           tags$small(tags$small(helpText(disclaimer_model))),
                           tags$small(tags$small(helpText(disclaimer)))
                           
                  ), 
                  tabPanel("About", 
                           # TODO: add references to the literature & cohort data used for model fitting
                           # TODO: add references to the actual model publication & model
                           # TODO: justify the text in paragraphs with css
                           h4("Information"),
                           p("The galactose elimination capacity (GEC) is an established liver function test, which measures the
                             ability of the liver to clear galactose."),
                           p("This application calculates your expected normal range of galactose clearance by the liver. The
                             individual GEC is calculated based on predictive computational models
                             for the distribution of liver volumes and hepatic blood flow for a population sample with the identical 
                             anthromorphic features, i.e. the same gender, age, height and bodyweight."),
                           p("This application allows a personalized evaluation of the measured GEC."),
                           
                           h4("Contact"),
                           p("For any questions, comments and suggestions please contact matthias.koenig@charite.de"),
                           h4("Version"),
                           p("GEC App v0.81 beta"),
                           tags$br(),
                           tags$br(),
                           tags$small(tags$small(tags$b(helpText("Disclaimer")))),
                           tags$small(tags$small(helpText(disclaimer_model))),
                           tags$small(tags$small(helpText(disclaimer)))
                  )
      )     
    )
  )
))
