## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  echo = TRUE,
  eval = TRUE,
  warning=FALSE,
  fig.height = 6,
  fig.width = 9,
  fig.align='center'
)

## ----color-function, echo = FALSE---------------------------------------------
colorize <- function(text, color) {
  if (knitr::is_latex_output()) {
    sprintf("\\textcolor{%s}{%s}", color, text)
  } else if (knitr::is_html_output()) {
    sprintf("<span style='color: %s;'>%s</span>", color, text)
  } else text
}


## ----setup, echo = FALSE, message = FALSE, warning = FALSE--------------------
library(dplyr)
library(tidyverse)
library(gtsummary)
library(summarySCI)
library(flextable)

## ----message = FALSE----------------------------------------------------------
library(survival)
data(cancer, package="survival")

colon1 <-  colon %>%
  group_by(id) %>%
  slice(1) %>% # Select the first row within each id group
  ungroup()
  

## ----echo = FALSE-------------------------------------------------------------
n_patients <- nrow(colon)

## -----------------------------------------------------------------------------
set.seed(123)
colon2 <- colon1 %>%
  select(rx, sex, age, extent) %>%
  filter(rx != "Lev") %>%
  mutate(rx = if_else(rx == "Obs", "Control", rx),
         extent = if_else(row_number() %in% sample(row_number(), size = round(0.1 * n())), NA, extent)) %>% 
  rename(Male = sex) %>% 
  mutate(extent = as.factor(extent))



## -----------------------------------------------------------------------------
head(colon2)

## -----------------------------------------------------------------------------
summaryTable(data = colon2)

## -----------------------------------------------------------------------------
summaryTable(data = colon2, 
             vars = c("Male", "age", "extent"), 
             group = "rx")

## -----------------------------------------------------------------------------
summaryTable(data = colon2, 
             group = "rx",
             labels = list(age = "Age", extent = "Extent"))

## -----------------------------------------------------------------------------
summaryTable(data = colon2, 
             group = "rx",
            labels = list(rx = "Arm", age = "Age", extent = "Extent"), 
             add_n = FALSE)

## -----------------------------------------------------------------------------
summaryTable(data = colon2, 
             group = "rx",
             overall = TRUE, 
             labels = list(age = "Age", extent = "Extent"))

## -----------------------------------------------------------------------------
summaryTable(data = colon2,
             group = "rx",
             vars = "Male",
            labels = list(age = "Age"), 
            dichotomous_as = "dichotomous", 
            value = list(Male ~ "1"),
            missing = FALSE)

## -----------------------------------------------------------------------------
summaryTable(data = colon2, group = "rx", 
             stat_cont = "median_IQR", 
             stat_cat = "n_N",
              labels = list(age = "Age", sex = "Sex", extent = "Extent"))

## -----------------------------------------------------------------------------
summaryTable(data = colon2, 
             group = "rx", 
             vars = c("age", "extent"), 
             stat_cont = "mean_sd", 
             test = TRUE,
             ci = TRUE,
             labels = list(age = "Age", extent = "Extent")
             )

## -----------------------------------------------------------------------------
summaryTable(data = colon2, 
             group = "rx", 
             vars = "extent", 
             test = TRUE,
             ci = TRUE,
             missing_percent = FALSE,
             labels = list(extent = "Extent")
             )

summaryTable(data = colon2, 
             group = "rx", 
             vars = "extent", 
             test = TRUE,
             ci = TRUE,
             missing_percent = TRUE,
             labels = list(extent = "Extent")
             )

## -----------------------------------------------------------------------------
summaryTable(data = colon2, 
             group = "rx", 
             vars = "extent", 
             missing_percent = "both", 
             test = TRUE,
              labels = list(extent = "Extent")
             )


