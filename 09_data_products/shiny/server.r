library(shiny)
library(UsingR)
data(galton)
custom_function <- function(x) {
	return(x + x)
}
shinyServer(
	function(input, output) {
		output$oid1 <- renderPrint({input$id1})
		output$oid2 <- renderPrint({input$id2})
		output$odate <- renderPrint({input$date})
		output$calcValue <- renderPrint({custom_function(input$id1)})
		output$plot <- renderPlot({hist(galton$child)
			text(63, 150, input$id1)})
	}
)