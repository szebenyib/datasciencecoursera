library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Quick Regression via Shiny"),
  sidebarPanel(
    h3('Settings'),
    p('Use the following controls to setup the multivariate
      analysis and regression model variables.'),
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
                       selected = 'yrs.service'),
    p("Author: Balint Szebenyi")
    #submitButton('Submit') #optional
  ),
  mainPanel(
    tabsetPanel(position = "above",
      tabPanel("Description",
               h3("Intro"),
               h4("Credit"),
               p("This page was created as my course project
                           for the coursera class: Developing Data Products,
                 which is part of the Data Science Specialization taught by
                 the fantastic educators of the John Hopkins University.
                 My respect goes out to you, as you have really given me
                  a boost in knowledge and fantastic
                 tools to work and play with. I wish I had attended a major
                 in statistics with you."),
               h4("Usage"),
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
      tabPanel("Dataset",
               h3("Origin"),
               p("The data comes from Vincent Arel-Bundock, and it is available
                 from the following website:"),
              a("https://vincentarelbundock.github.io/Rdatasets/datasets.html"),
              h3("Overview"),
              p("It contains 397 observations of 7 variables."),
              p("The table below reveals the dataset."),
              dataTableOutput("df")),
      tabPanel("Univariate",
               h3("Univariate Analysis"),
               selectInput(inputId = "univariate_var",
                           label = "Choose a variable to analyze",
                           choices = names(df)[!(names(df) %in% c("X"))],
                           selected = "salary"),
               plotOutput('uni_plot'),
               verbatimTextOutput('uni_summary'),
               p("The plots are created with the awesome ggplot package.")),
      tabPanel("Multivariate",
               h3("Advanced scatterplot"),
               plotOutput('fit_plot'),
                p("The scatterplot is created using the psych package."),
                p("For more information about the interpretation,
                  check page 227 here: "),
                a("https://cran.r-project.org/web/packages/psych/psych.pdf")),
      tabPanel("Model",
               h3('Model Summary'),
               p("The created linear regression model's characteristics
                 are displayed below."),
               h4("R-squared"), textOutput('r_squared'),
               h4("Adjusted R-squared"), textOutput('adjusted_r_squared'),
               h4("Coefficients"), htmlOutput('coefficients'),
               h4("VIF"), verbatimTextOutput('vif'))
      )
    )
  )
)