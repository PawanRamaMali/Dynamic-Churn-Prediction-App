# body.R

body <- dashboardBody(tabItems( 
  # # Dashboard Tab ----

  
  # Data Selection Tab ----
  tabItem(tabName = "tab_data_selection",
          fluidPage(
            sidebarLayout(
              sidebarPanel(
                width = 3,
                h3("Import Dataset"),
                
                hr(),
                uiOutput('fileupload'),
                
                hr(),
                checkboxInput("show_rownames",
                              label = "Show row numbers"),
                hr(),
                fluidRow(
                  column(4,
                bsButton(
                  "submit_data",
                  label = "Import",
                  icon =   icon("upload",
                                lib = "glyphicon"),
                  block = F,
                  style = "success"
                )),
                column(4,
                bsButton(
                  "reset",
                  label = "Reset",
                  icon =   icon("repeat",
                                lib = "glyphicon"),
                  block = F,
                  style = "danger"
                ))
                ),
                fluidRow(
                  column(10,
                  br(),
                  hr(),
                  h3("Configure Variables"),
                
                  br(),
                         # Select variables to display ----
                         uiOutput("ui_select_target_variable"),
                  hr(),
                  uiOutput("ui_select_excluded_variable"),
                        
                 hr()
                )),
                fluidRow(
                  column(4,
                         bsButton(
                           "submit_target_variable",
                           label = "Submit",
                           icon =   icon("ok",
                                         lib = "glyphicon"),
                           block = F,
                           style = "success"
                         )))
                )
                ,
              
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
          
          sidebarLayout(
            sidebarPanel(
              width = 3,
              h1("Prediction"),
              
              hr(),
              # uiOutput('checkbox'),
              
              hr(),
              
              fluidRow(
                column(6,
                       bsButton(
                         "analyse",
                         strong("Predict Churn"),
                         icon = icon("refresh"),
                         style = "primary",
                         size = "medium"
                       )),
                column(6,
                       uiOutput("down"))
                
                
              )
            ),
            
            mainPanel(
                      dataTableOutput("results_data")
            )
          )
          
  ),
  
  
  
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