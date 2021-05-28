# global.R

rm(list=ls())

# LIBRARIES ----

# Shiny
library(shiny)
library(bslib)

# Modeling
#library(modeldata)
library(DataExplorer)

# Widgets
library(plotly)

# Core
library(tidyverse)
#if (!require("DT")) install.packages('DT')
library(DT)

library(ggplot2)

library(rmarkdown)
library(knitr)
library(pander)

library(shiny)
library(shinydashboard)
library(shinyAce)
library(shinyWidgets)
library(data.table)
library(esquisse)
library(rvg)
library(magrittr)

## Temp
## 
library(shiny)
library(shinydashboard)
library(shinythemes)
library(shinyanimate)
library(shinyBS)
library(shinyjs)
library(plotly)
library(readxl)
library(shinyWidgets)
library(DT)
library(magrittr)
library(anomalize) #tidy anomaly detectiom
library(tidyverse) #tidyverse packages like dplyr, ggplot, tidyr
#library(coindeskr) #bitcoin price extraction from coindesk
library(ggthemes) 
library(ggpubr)
library(ggplot2)
library(forecast)
library(tseries)
library(shinyBS)
library(shiny)
library(shinydashboard)
library(randomForest)
library(DT)
library(plyr)
library(randomForest)
library(DT)
set.seed(1000000)
load("rfm.rda")
library(shiny)
library(neuralnet)
library(nnet)
library(DT)

## Setting Upload Size to 1GB
options(shiny.maxRequestSize = 1000000000)
options("esquisse.display.mode" = "browser")

# LOAD DATASETS ----
utils::data("stackoverflow", "car_prices", "Sacramento", package = "modeldata")

data_list = list(
  "StackOverflow" = stackoverflow,
  "Car Prices"    = car_prices,
  "Sacramento Housing" = Sacramento
)

# Load functions ---- 
# 
source("functions.R")
gm= tags$h3(strong("Good Morning",style="color:#446e9b"))
ga= tags$h3(strong("Good Afternoon",style="color:#446e9b"))
ge= tags$h3(strong("Good Evening",style="color:#446e9b"))


## STARTING LOGGED VALUE ----
Logged = FALSE

