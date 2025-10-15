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
data<-NULL
visit <- c(paste0(rep("Visit ", 10), rbind(c(1:10))),
           paste0(rep("Visit ", 10), rbind(c(1:10))),
           paste0(rep("Visit ", 10), rbind(c(1:10))))
data <- as.data.frame(cbind( visit, rnorm(30)))
data<-as.data.frame(rbind(data, data, data, data, data))
data$visitgroup<- ifelse(data$visit %in% c("Visit 1", "Visit 2"), "Baseline", ifelse(data$visit %in% c("Visit 3", "Visit 4"), "Treatment", "Follow-up"))
data$visitgroup<-factor(data$visitgroup, levels = c("Baseline", "Treatment", "Follow-up"))
data$LDH<-rnorm(150)
data$Lymphocytes<-rnorm(150)
data$ANC<-rnorm(150)
data$LDH[3]<-NA
data$arm<- c(rep("Arm A", 70), rep("Arm B", 80))

## -----------------------------------------------------------------------------
summaryByVisit(data,
         vars = c("LDH", "Lymphocytes", "ANC"),
         visit = "visit", 
         add_n = TRUE)

## -----------------------------------------------------------------------------
summaryByVisit(data,
         vars = c("LDH", "Lymphocytes", "ANC"),
         visitgroup = "visitgroup",
         visit = "visit")

## -----------------------------------------------------------------------------
summaryByVisit(data,
         vars = c("LDH", "Lymphocytes", "ANC"),
         group = "arm",
         visitgroup = "visitgroup",
         visit = "visit")

## -----------------------------------------------------------------------------
summaryByVisit(data,
         vars = c("LDH", "Lymphocytes", "ANC"),
         group = "arm",
         overall = TRUE,
         visitgroup = "visitgroup",
         visit = "visit")

## -----------------------------------------------------------------------------
summaryByVisit(data,
         vars = c("LDH", "Lymphocytes", "ANC"),
         group = "arm",
         overall = TRUE,
         visitgroup = "visitgroup",
         visit = "visit",
         add_n = TRUE)

