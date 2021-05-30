library(shinydashboard)

source('./components/header.R')
source('./components/admin/admin_sidebar.R')
source('./components/admin/admin_body.R')


dashboardPage(
  header = header,
  sidebar =  sidebar,
  body = body)