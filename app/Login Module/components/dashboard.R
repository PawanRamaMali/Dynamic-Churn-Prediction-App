library(shinydashboard)

source('./components/header.R')
source('./components/sidebar.R')
source('./components/body.R')


dashboardPage(
  header = header,
  sidebar =  sidebar,
  body = body)