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
data<- as.data.frame(cbind(c(1:10), c("A","A","A","A","A","B","B","B","B","B"),
                            c("absent","present","absent","present","absent","absent","present","absent","present","absent"),
                            c("absent","absent","present","absent","absent","absent","absent","absent","absent","absent"),
                            c("present","absent","present","present","present","present","present","present","present","present")))
names(data)<-c("upn", "arm", "liver", "lung", "brain")
  

## -----------------------------------------------------------------------------
summarySCI::summaryLevels(data=data,
                      vars = c("liver", "lung", "brain"),
                      label = "Site of progression",
                      levels= "present",)

## -----------------------------------------------------------------------------
summarySCI::summaryLevels(data=data,
                      vars = c("liver", "lung", "brain"),
                      group = "arm",
                      label = "Site of progression",
                      levels= "present")

## -----------------------------------------------------------------------------
summarySCI::summaryLevels(data=data,
                      vars = c("liver", "lung", "brain"),
                      group = "arm",
                      label = "Site of progression",
                      levels= "present",
                      overall = TRUE)

## -----------------------------------------------------------------------------
summarySCI::summaryLevels(data=data,
                      vars = c("liver", "lung", "brain"),
                      group = "arm",
                      label = "Site of progression",
                      test = TRUE,,
                      levels= "present")

## -----------------------------------------------------------------------------
summarySCI::summaryLevels(data=data,
                      vars = c("liver", "lung", "brain"),
                      group = "arm",
                      levels= "present",
                      label = "Site of progression",
                      test = TRUE,
                      test_cat = "chisq.test")

## -----------------------------------------------------------------------------
summarySCI::summaryLevels(data=data,
                      vars = c("liver", "lung", "brain"),
                      group = "arm",
                      label = "Site of progression",
                      levels= "present",
                      test = TRUE,
                      test_cat = "fisher.test",
                      ci=TRUE,
                      conf_level = 0.9,
                      overall = FALSE)

