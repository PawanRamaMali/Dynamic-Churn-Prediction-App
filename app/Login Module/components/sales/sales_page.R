library(shinydashboard)

source('./components/sales/sales_header.R')
source('./components/sales/sales_sidebar.R')
source('./components/sales/sales_body.R')


dashboardPage(
  header = header,
  sidebar =  sidebar,
  body = body)