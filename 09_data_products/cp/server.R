# RUN ONCE
## Load packages
library(shiny)
library(ggplot2)
library(dplyr)
library(psych)
library(GGally)
library(car)

## Data loading is taken care of globally

## Define functions
fit_model <- function(dependent, explanatory_variables, df) {
  f <- paste(dependent, "~",
             paste(explanatory_variables,
                   collapse = " + "))
  fit <- do.call("lm",
                 list(as.formula(f),
                      data = df))
  return(fit)
}
percent <- function(n) {
  paste(sprintf("%0.1f",
                n * 100),
        '%',
        sep = "")
}
gen_plot <- function(uni_var, dependent_var) {
  q <- ggplot(data = df) #df is global
  if (class(df[ , uni_var]) == "integer") {
    q <- q + geom_histogram(aes_string(x = uni_var))
    q <- q + labs(title = "Histogram")
  } else if (class(df[ , uni_var]) == "factor") {
    q <- q + geom_violin(aes_string(x = uni_var,
                                    y = dependent_var,
                                    color = uni_var))
    q <- q + labs(title = "Violin plot")
  } else {
    q <- NULL
  }
  return(q)
}

# Run every time
shinyServer(
  function(input, output, session) {
    # Dataset tab
    output$df <- renderDataTable(df)
    # Univariate tab
    generated_plot <- reactive({gen_plot(uni_var = input$univariate_var,
                                         dependent_var = input$dependent_var)})
    output$uni_plot <- renderPlot({generated_plot()})
    output$uni_summary <- renderPrint({summary(df[ ,input$univariate_var])})

    # Multivariate tab
    output$coefficients <- renderTable({fit_summary()$coefficients})

    # Model tab
    fit <- reactive({fit_model(dependent = input$dependent_var,
                     explanatory_variables = input$explanatory_vars,
                     df = df)})
    fit_summary <- reactive({summary(fit())})
    set_vif <- reactive({
      if (length(input$explanatory_vars) > 1) {
        vif(fit())
      } else {
        "-"
      }
    })
    output$fit_plot <- renderPlot({pairs.panels(df[ , c(input$dependent_var,
                                                        input$explanatory_vars)])})
    output$r_squared <- renderText({percent(fit_summary()$r.squared)})
    output$adjusted_r_squared <- renderText({percent(fit_summary()$adj.r.squared)})
    output$vif <- renderPrint({set_vif()})

    # Settings panel
    # At least one checkbox has to be selected
    observe({
      if(length(input$explanatory_vars) < 1) {
        updateCheckboxGroupInput(session,
                                 "explanatory_vars",
                                 selected= "yrs.service")
      }
    })
  }
)