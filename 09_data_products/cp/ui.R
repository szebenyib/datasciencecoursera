library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Quick Regression via Shiny"),
  sidebarPanel(
    h3('Settings'),
    selectInput('dependent_var', 'Dependent variable',
                choices = names(df),
                selected = "salary"),
    checkboxGroupInput('explanatory_vars', 'Explanatory variables',
                       c('Value1' = '1',
                         'Value2' = '2',
                         'Value3' = '3')),
    dateInput('date', 'Date:')
    #submitButton('Submit') #optional
  ),
  mainPanel(
    h3('Model Summary'),
    h4("R-squared"),
    verbatimTextOutput('r_squared'),
    h4("Adjusted R-squared"),
    verbatimTextOutput('adjusted_r_squared'),
    h4("Coefficients"),
    verbatimTextOutput('coefficients')
  )
))