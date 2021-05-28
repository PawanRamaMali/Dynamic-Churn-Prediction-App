###################
# ui.R
# 
# Initializes the ui. 
# Used to load in your header, sidebar, and body components.
###################

# If shinydashboard library is not imported here, the dashboard does not work 
# on Shiny Server.

# library(shinydashboard)
# 
# source('./components/header.R')
# source('./components/sidebar.R')
# source('./components/body.R')

## make login screen
ui <<- function(){
  
  tagList(tags$style(HTML('body {font-family:"Verdana",Georgia,Serif; background-color:#446e9b}')),
          div(id="container",align="center",
              div(id = "login",
                  # make login panel
                  wellPanel(id="well",style = "overflow-y: ;width:100%;height:100%",
                            
                            HTML(paste0('
                                <h2>
                                Hello, ', 
                                        good_time(),
                                        '</h2>',
                                        '<h3>
                                <br>Login</br>
                                </h3>')
                            ),
                            br(),
                            br(),
                            tags$div(textInput("userName", "Username",width = "100%"),align="left"),
                            br(),
                            tags$div(passwordInput("passwd", "Password",width = "100%"),align="left"),
                            br(),
                            # button
                            tags$div(actionButton("Login", "Log in"),align="center"),
                            # login error message
                            tags$div(uiOutput("message"),align="center")
                  )
                  
              )
          ),
          # css for container
          tags$style(type = "text/css", 
                     "#container{
                   display: flex;
                   justify-content: center;
                   margin-top: 150px;
                   }"),
          # css for login well panel
          tags$style(type="text/css", "
                   #login,{
                   font-size:14px; 
                   width: 360px;}"),
          # well panel
          tags$style(type="text/css",
                     "#well{
                    padding: 50px;
                    background: white;
                   border: 1px;
                   box-shadow: ;}"),
          # welcome text css
          tags$style(type = 'text/css',
                     "h2, h3{
                   color: #525252;}"),
          # input fields
          tags$style(type="text/css",
                     "#userName, #passwd{
                        box-shadow: none;
                        outline:none;
                        border: none;
                        padding-left: 0;
                        border-bottom: 2px solid #446e9b;
                        border-radius: 0;
                   }
                   #userName:focus, #passwd:focus{
                   box-shadow: 0px 10px 10px -5px lightgray;
                   }"),
          # button css
          tags$style(type='text/css',
                     "#Login{
                    outline: none;
                   margin-left: 0px;
                   width: 100px;
                   font-size: 12pt;
                   background: transparent;
                   border: 2px solid #446e9b;
                   color: #446e9b;
                   border-radius: 10px;
                   transition: 0.8s ease-in-out;
                   }
                   #Login:hover{
                   background: #446e9b;
                   color: white;}"),
          # error box - fadeOut animation
          tags$style(type="text/css",
                     "@-webkit-keyframes fadeOut {
                        from {
                            opacity: 1;
                        }
                        to {
                            opacity: 0;
                        }
                    }
                    @keyframes fadeOut {
                        from {
                            opacity: 1;
                        }
                        to {
                            opacity: 0;
                        }
                    }"),
          tags$style(type="text/css",
                     "#error-box{
                   margin-top: 20px;
                   margin-left: 0px;
                   padding: 5px 10px 5px 10px;
                   text-align: center;
                   width: 325px;
                   color: white;
                   background: #ef3b2c;
                   border: 1px solid #ef3b2c;
                   border-radius: 5px;
                   -webkit-animation: fadeOut;
                   animation: fadeOut;
                   opacity: 0;
                   animation-duration: 15s;}")
  )
}

