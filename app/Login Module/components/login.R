

## make login screen
ui1 <- function() {
  fluidPage(includeCSS("./components/style.css"),
            
            tagList(
              tags$style(
                HTML(
                  'body {font-family:"Verdana",Georgia,Serif; background-color:#446e9b}'
                )
              ),
              div(
                id = "container",
                align = "center",
                div(
                  id = "login",
                  # make login panel
                  wellPanel(
                    id = "well",
                    style = "overflow-y: ;width:100%;height:100%",
                    
                    HTML(
                      paste0(
                        '
                                <h2>
                                Hello, ',
                        good_time(),
                        '</h2>',
                        '<h3>
                                <br>Login</br>
                                </h3>'
                      )
                    ),
                    br(),
                    br(),
                    tags$div(textInput("userName", "Username", width = "100%"), align =
                               "left"),
                    br(),
                    tags$div(passwordInput("passwd", "Password", width = "100%"), align =
                               "left"),
                    br(),
                    # button
                    tags$div(actionButton("Login", "Log in"), align =
                               "center"),
                    # login error message
                    tags$div(uiOutput("message"), align = "center")
                  )
                  
                )
              )
              # css for container
              
            ))
}
