
dependencies <- c(
  "shiny",
  "shinydashboard",
  "ggplot2",
  "dplyr",
  "ggedit",
  "brew"
  )

new.packages <- dependencies[!(dependencies %in% installed.packages()[,"Package"])]
if(length(new.packages)>0) install.packages(new.packages)

lapply(dependencies, library, character.only = TRUE)



rm(dependencies, new.packages)


library(shiny)
library(shinydashboard)
library(tibble)
library(dplyr)
library(highcharter)
library(DT)
library(lubridate)
library(tidyr)
library(shinyWidgets)
library(shinyjs)
library(shinycssloaders)
library(rhandsontable)
library(shiny)
#library(tychobratools)

library(shinythemes)
library(sde)
library(readr)
library(xts)
