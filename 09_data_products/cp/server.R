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
    fit <- fit_model(dependent = "salary",
                     explanatory_variables = "yrs.service",
                     df = df)
    fit_summary <- summary(fit)
    output$r_squared <- renderPrint({fit_summary$r.squared})
    output$adjusted_r_squared <- renderPrint({fit_summary$adj.r.squared})
    output$coefficients <- renderPrint({fit_summary$coefficients})
  }
)