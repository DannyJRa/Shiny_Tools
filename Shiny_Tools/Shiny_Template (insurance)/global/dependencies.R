
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