library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Quick Regression via Shiny"),
  sidebarPanel(
    h3('Settings'),
    selectInput('dependent_var', 'Dependent variable',
                choices = "salary",
#restriction                choices = names(df),
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
    tabsetPanel(position = "above",
      tabPanel("Description",
               p('This page was created as my course project
                           for the coursera class: Developing data products.')),
      tabPanel("Univariate",
               selectInput(inputId = "univariate_var",
                           label = "Choose a variable to analyze",
                           choices = names(df)[!(names(df) %in% c("X"))],
                           selected = "salary"),
               plotOutput('uni_plot')),
               #summary
               #plot
      tabPanel("Scatterplot",
               plotOutput('fit_plot')),
      tabPanel("Model",
               h3('Model Summary'),
               h4("R-squared"), textOutput('r_squared'),
               h4("Adjusted R-squared"), textOutput('adjusted_r_squared'),
               h4("Coefficients"), htmlOutput('coefficients'),
               h4("VIF"), verbatimTextOutput('vif'))
      )
    )
  )
)