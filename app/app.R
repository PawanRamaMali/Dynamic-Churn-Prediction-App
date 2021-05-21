###################
# app.R
# 
# Main controller. 


args <- commandArgs( trailingOnly = TRUE ) # read arguments

if( length(args) > 0 ){
  setwd( args[1] ) # Get actual directory path from args passed by the shell/batch file.
} else {
 
}


library(shiny)
library(shinydashboard)

source('./ui.R')
source('./server.R')


shinyApp(ui, server)
