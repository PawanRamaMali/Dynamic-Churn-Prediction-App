library(shinydashboard)

source('./components/header.R')
source('./components/user/user_sidebar.R')
source('./components/user/user_body.R')


dashboardPage(
  header = header,
  sidebar =  sidebar,
  body = body)