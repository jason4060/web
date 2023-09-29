#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)
# ui.R
shinyUI(fluidPage(
  titlePanel("Simple Shiny App"),
  sidebarLayout(
    sidebarPanel(
      textInput("user_input", "Enter a Number:", value = ""),
      actionButton("calculate", "Calculate")
    ),
    mainPanel(
      textOutput("result")
    )
  )
))


# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')
    })
}
# server.R
shinyServer(function(input, output) {
  observeEvent(input$calculate, {
    user_input <- as.numeric(input$user_input)
    if (!is.na(user_input)) {
      result <- user_input * 2
      output$result <- renderText(paste("Result: ", result))
    } else {
      output$result <- renderText("Invalid input. Please enter a number.")
    }
  })
})


# Run the application 
shinyApp(ui = ui, server = server)
