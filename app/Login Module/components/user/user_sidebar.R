###################
# sidebar.R
sidebar <- dashboardSidebar(
  sidebarMenu(
    
    menuItem("Data Selection",
             tabName = "tab_data_selection",
             icon = icon("table")),
    menuItem("Correlation",
             tabName = "tab_correlation",
             icon = icon("project-diagram")),
    menuItem("Prediction",
             tabName = "tab_app_prediction",
             icon = icon("product-hunt")),
    menuItem("App Settings", 
             tabName = "tab_app_settings",
             icon = icon("cog")),
    menuItem("About Me", 
             tabName = "tab_about_me",
             icon = icon("user")),
    menuItem("Logout", 
             tabName = "tab_logout",
             icon = icon("sign-out"))
    
  )
)
