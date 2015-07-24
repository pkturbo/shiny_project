library(shiny)

data <- read.csv("utility_usage.csv", sep=",", header=T)
colnames(data)[4] <- "Gas"
colnames(data)[7] <- "Electricity"
colnames(data)[10] <- "Water"

## Define a server for the Shiny app
shinyServer(function(input, output) {

  dataInput <- reactive({
    subset(data, select=c(input$energy), subset=(Year == input$year))
  })

  ## Fill in the spot we created for a plot
  output$plot1 <- renderPlot({

    ## Render a barplot
    yl <- 120
    if(input$energy=="Water") yl <- 10

    barplot(dataInput()[,input$energy],
            main=paste(input$energy, "in", input$year),
            ylab="Consumption (in EUR)", ylim=c(0,yl),
            xlab="Weeks (Jan to Dec)", xlim=c(1,52))
  })
})