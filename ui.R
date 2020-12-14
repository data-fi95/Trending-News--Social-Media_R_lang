
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Trending Topics on Twitter"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of Twitter Records:",
                  min = 500,
                  max = 5000,
                  value = 2000,
                  step = 500),
        dateInput('date_s',
                  label = 'Start date:',
                  value = Sys.Date()-30),
      dateInput('date_e',
                label = 'End date:',
                value = Sys.Date())
    ),
    

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))
