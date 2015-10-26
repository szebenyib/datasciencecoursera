# RUN ONCE
## Load packages
library(shiny)
library(ggplot2)
library(dplyr)
library(psych)
library(GGally)
## Load data
df <- read.csv(file = "salaries.csv",
               header = TRUE,
               sep=",")

fit_model <- function(dependent, explanatory_variables, df) {
  f <- paste(dependent, "~",
             paste(explanatory_variables,
                   collapse = " + "))
  fit <- do.call("lm",
                 list(as.formula(f),
                      data = df))
  return(fit)
}
shinyServer(
  function(input, output) {
    fit <- reactive({fit_model(dependent = "salary",
                     explanatory_variables = input$explanatory_vars,
                     df = df)})
    fit_summary <- reactive({summary(fit())})
    output$fit_plot <- renderPlot({pairs.panels(df)})
    output$r_squared <- renderPrint({fit_summary()$r.squared})
    output$adjusted_r_squared <- renderPrint({fit_summary()$adj.r.squared})
    output$coefficients <- renderPrint({fit_summary()$coefficients})
    output$explanatory_vars <- renderPrint({input$explanatory_vars})
  }
)