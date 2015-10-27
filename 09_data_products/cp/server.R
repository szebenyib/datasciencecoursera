# RUN ONCE
## Load packages
library(shiny)
library(ggplot2)
library(dplyr)
library(psych)
library(GGally)
library(car)
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
percent <- function(n) {
  paste(sprintf("%0.1f",
                n * 100),
        '%',
        sep = "")
}
shinyServer(
  function(input, output) {
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
    output$coefficients <- renderTable({fit_summary()$coefficients})
    output$vif <- renderPrint({set_vif()})
  }
)