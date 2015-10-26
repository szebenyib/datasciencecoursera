library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Quick Regression via Shiny"),
  sidebarPanel(
    h3('Settings'),
    selectInput('dependent_var', 'Dependent variable',
                choices = names(df),
                selected = "salary"),
    checkboxGroupInput('explanatory_vars', 'Explanatory variables',
                       c('Rank' = 'rank',
                         'Discipline' = 'discipline',
                         'Years since PhD.' = 'yrs.since.phd',
                         'Years in service' = 'yrs.service',
                         'Sex' = 'sex'),
                       selected = 'yrs.service')
    #submitButton('Submit') #optional
  ),
  mainPanel(
    verbatimTextOutput('explanatory_vars'),
    h3('Model Summary'),
    h4("R-squared"),
    verbatimTextOutput('r_squared'),
    h4("Adjusted R-squared"),
    verbatimTextOutput('adjusted_r_squared'),
    h4("Coefficients"),
    verbatimTextOutput('coefficients'),
    plotOutput('fit_plot')
  )
))