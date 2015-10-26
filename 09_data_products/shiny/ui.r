library(shiny)
shinyUI(pageWithSidebar(
	headerPanel("Input intro"),
	sidebarPanel(
		h3('Sidebar text'),
		numericInput('id1', 'Numeric input, with html label id1', 0, min=0, max=10, step=1),
		checkboxGroupInput('id2', 'Checkbox',
    c('Value1' = '1',
      'Value2' = '2',
      'Value3' = '3')),
  dateInput('date', 'Date:')
  #submitButton('Submit') #optional
 ),
 mainPanel(
  h3('Main Panel text'),
  verbatimTextOutput('oid1'),
  verbatimTextOutput('oid2'),
  verbatimTextOutput('odate'),
  verbatimTextOutput('calcValue'),
  plotOutput('plot')
 )
))