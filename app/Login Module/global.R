# global.R

rm(list = ls())
gc(verbose=TRUE)

# LIBRARIES ----

# Shiny
library(shiny)
library(bslib)

# Modeling

# Core
library(tidyverse)
#if (!require("DT")) install.packages('DT')
library(DT)
library(ggplot2)
library(rmarkdown)
library(knitr)
library(pander)

library(shinydashboard)
library(shinyAce)
library(shinyWidgets)
library(data.table)
library(esquisse)
library(rvg)
library(magrittr)

## Temp
## 

library(shinythemes)
library(shinyanimate)
library(shinyjs)
library(readxl)


library(anomalize) #tidy anomaly detectiom
library(tidyverse) #tidyverse packages like dplyr, ggplot, tidyr
library(ggthemes) 
library(ggpubr)

library(forecast)
library(tseries)
library(shinyBS)
library(plotly)


library(plyr)
library(randomForest)
library(DT)
set.seed(1000000)
load("rfm.rda")

library(neuralnet)
library(nnet)
library(DT)

## Setting Upload Size 
options(shiny.maxRequestSize=30*1024^2)
options(shiny.error = traceback)

Logged = FALSE;

# LOAD DATASETS ----

# Load functions ---- 
# 
source("functions.R")

gm= tags$h3(strong("Good Morning",style="color:#446e9b"))
ga= tags$h3(strong("Good Afternoon",style="color:#446e9b"))
ge= tags$h3(strong("Good Evening",style="color:#446e9b"))



