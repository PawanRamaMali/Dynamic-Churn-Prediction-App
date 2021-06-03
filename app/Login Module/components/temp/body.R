# body.R

body <- dashboardBody(tabItems( 
  # # Dashboard Tab ----
  
  # tabItem(tabName = "dashboard",
  #         fluidPage(h2("Dashboard View"))),
  
  
  
  # Data Selection Tab ----
  
  
  tabItem(tabName = "tab_data_selection",
          fluidPage(
            sidebarLayout(
              sidebarPanel(
                width = 3,
                h1("Import Dataset"),
                
                # shiny::selectInput(
                #   inputId = "dataset_choice",
                #   label   = "Data Connection",
                #   choices = c("StackOverflow", "Car Prices", "Sacramento Housing")
                # ),
                
                hr(),
                
                # Moved to settings Panel
                # checkboxInput("show_rownames",
                #               label = "Show row numbers"),
                # checkboxInput("show_features_responsive",
                #               label = "Responsive Layout")
              ),
              
              mainPanel(dataTableOutput("show_data"))
            )
          )),
  
  
  
  # Correlation Tab ----
  
  
  tabItem(tabName = "tab_correlation",
          fluidPage(
            title = "Correlation Plot",
            mainPanel(
              plotlyOutput("corrplot", height = 700)
            )
          )),
  
  
  
  
  # Prediction Tab ----
  
  
  tabItem(tabName = "tab_app_prediction",
          fluidPage(
            title = "Prediction",
            
            mainPanel(
              h1("Reload Data"),
              hr(),
              uiOutput('fileupload'),
              uiOutput('checkbox'),
              uiOutput("button"),
            
              br(),
              bsPopover(
                id = "check",
                title = "",
                content = "Note: I accept the Terms & Conditions.. Show the Analyse button",
                placement = "right"
              ),
              
              bsButton(
                "reset",
                label = "Reset ?",
                icon =   icon("repeat", lib = "glyphicon"),
                block = F,
                style = "danger",
                size = "small"
              )
              
            )
            
            
            
          )),
  
  
  
  # Settings Tab ----
  # 
  tabItem(tabName = "tab_app_settings",
          fluidPage(
            title = "Settings",
            
            mainPanel(
              h1("Custom Settings"),
              hr(),
              checkboxInput("show_rownames",
                            label = "Show row numbers"),
              checkboxInput("show_features_responsive",
                            label = "Responsive Layout")
              
            )
            
            
            
          )),
  
  
  # About Me Tab ----
  
  
  tabItem(tabName = "tab_about_me",
          fluidPage(sidebarPanel(
            width = 3,
            h2("About Me"),
         
            hr(),
            h5(" I am Pawan Rama Mali"),
            h6(" I'm currently working on Software Development"),
            h6(" Also, I'm currently learning Artificial Intelligence"),
            h5(
              tags$a(href = "https://www.github.com/PawanRamaMali", "GitHub Link")
            ),
            h5(
              tags$a(href = "https://pawanramamali.github.io/", "Website Link")
            )
          ))),
  
  # Logout Tab ---- 
  # 
    tabItem(tabName = "tab_logout",
          fluidPage(sidebarPanel(
            width = 3,
            h2("Logout"),
            
            hr(),
            h5(" Make sure you have saved your changes before logout. "),
            h5(" Have a great day !"),
            br(),
            br(),
            tags$div(
              tags$a(
                href = "javascript:history.go(0)",
                bsButton(
                  "logoutadmin",
                  label = "Logout",
                  icon =   icon("repeat", lib = "glyphicon"),
                  block = F,
                  style = "success"
                ),
                style = "text-align:center"
              ),
              align = "center"
            ),
            br()
            
          )))
  
 
  
))