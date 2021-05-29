fluidPage(
  theme = shinytheme("cerulean"),
  tags$head(HTML("<title>Churn Prediction</title> ")),
  navbarPage(
    id = "tabset",
    tags$li(class = "dropdown",
            tags$style(".navbar
             {min-height:100px }")),
    title = tags$div(img(src = "logo.png",
                         "Churn Prediction ")),
    position = "fixed-top",
    selected = "Import",
    inverse = F,
    
    # Import Data Panel ----
    
    tabPanel(
      title = "Import",
      icon = icon("upload"),
      
      fluidPage(column(
        12,
        
        
        bootstrapPage(
          useShinyjs(),
          br(),
          
          tags$h3(strong(em(
            "Customer Churn Prediction"
          )),
          style = "text-align:center;
          color:#034e91;
          font-size:190%"),
          
          
          withAnim(),
          
          uiOutput('fileupload'),
          uiOutput('checkbox'),
          uiOutput("button"),
          uiOutput("helptext"),
          br(),
          
          bsPopover(
            id = "check",
            title = "",
            content = "Note: I accept the Terms & Conditions.. Show the Analyse button",
            placement = "right"
          ),
          tags$div(
            bsButton(
              "reset",
              label = "Reset ?",
              icon =   icon("repeat", lib = "glyphicon"),
              block = F,
              style = "danger",
              size = "small"
            ),
            align = "center"
          )
        )
      ))
    ),
    
    # Logout ----
    tabPanel(  tags$a("Logout",
        href = "javascript:history.go(0)",
        style = "display:block; 
                 padding:inherit;"
    ))
    
    
  )
)