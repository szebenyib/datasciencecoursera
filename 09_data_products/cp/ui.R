library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Quick Regression via Shiny"),
  sidebarPanel(
    h3('Settings'),
    p('Use the following controls to setup the multivariate and model parameters.'),
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
                           for the coursera class: Developing data products.'),
               p('Navigate along the sections to gain insight into the data.'),
               p('The univariate section provides a univariate analysis.
                 By choosing the desired variable a plot is constructed. In case
                 of categorical variables this is violin plot, in case of
                 continuous variables this is a simple histogram. Alongside
                 the chart simple statistics are also computed.'),
               p('The multivariate section creates a scatterplot for all
                 variables and also provides some additional information'),
               p('The model section reveals a simple regression model with the
                possibility given to the user to choose the explanatory
                 variables.')),
      tabPanel("Univariate",
               selectInput(inputId = "univariate_var",
                           label = "Choose a variable to analyze",
                           choices = names(df)[!(names(df) %in% c("X"))],
                           selected = "salary"),
               plotOutput('uni_plot'),
               verbatimTextOutput('uni_summary')),
      tabPanel("Multivariate",
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