server = shinyServer(function(input, output,session){
  
  options(shiny.maxRequestSize=30*1024^2) 
  
  ## Temporary Credentials ----
  users <- data.frame(User="pawan",Password="12345")
  
  ## Login Set Value ----
  USER <- reactiveValues(Logged = Logged)
  
  ## Validate Login ----
  observeEvent(input$Login,{
    
    #* Login Error Message ----
    output$message <- renderUI({
      if(!is.null(input$Login)){
        my_username <- length(users$User[grep(pattern = input$userName, x = users$User)])
        my_password <- length(users$User[grep(pattern = input$passwd, x = users$Password)])
        if(input$Login > 0){
          if(my_username < 1 ||  my_password < 1){
            HTML("<div id='error-box'>
                 Incorrect Username or Password. Please, 
                 try again. If you continue to have problems,
                 <a href='https://github.com/pawanramamali'>
                 <u>Contact Us..</u></a>
                 </div>")
          }
        }
      }
    })
    
    # * Verify Input ----
    if (USER$Logged == FALSE) {
      if (!is.null(input$Login)) {
        if (input$Login > 0) {
          Username <- isolate(input$userName)
          Password <- isolate(input$passwd)
          Id.username <- which(users$User == Username)
          Id.password <- which(users$Password == Password)
          if (length(Id.username) > 0 & length(Id.password) > 0) {
            if (Id.username %in% Id.password) {
              USER$Logged <- TRUE
            }
          }
        }
      }
    }
  })
  
  ## Display UI ----
  observe({
    # * Logged Status False ----
    if (USER$Logged == FALSE) {
      output$page <- renderUI({
        div(class="outer",do.call(bootstrapPage,c("",login_page())))
      })
    }
    
    # * Logged Status True  ----
    if (USER$Logged == TRUE) 
    {
      ## Current user's authorization level check
      user_log <- toupper(input$userName)
      
      if(user_log == "PAWAN" ){
        output$page <- renderUI({
          # Admin Page ----
          fluidPage(
           
            theme = shinytheme("cerulean"),
            tags$head(
              HTML(
                "<title>Churn Prediction</title> "
              )
            ),
            navbarPage(
              id = "tabset",
              tags$li(class = "dropdown",
                      tags$style(".navbar {min-height:100px }")
              ),
              title = tags$div(
                img(
                  src = "logo.png",
                  "Churn Prediction "
                )
              ), 
              position = "fixed-top",
              selected = "Import",
              inverse = F,
              
              # Import Data Panel ----
              
              tabPanel(title = "Import", 
                       icon = icon("upload"),
                       
                     fluidPage(
                       
                     column(12,
                              
                              
                              bootstrapPage(
                                useShinyjs(),
                                br(),
                                
                                tags$h3(strong(em(
                                  "Customer Churn Prediction"
                                )),
                                style = "text-align:center;color:#034e91;font-size:190%"),
                                
                            
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
                       )
                       
                       
                       
                     )),
            
            
            
            
            # tabPanel(title = strong("|")),         
           tabPanel(tags$div(tags$a(
             href = "javascript:history.go(0)",
             bsButton(
               "logoutadmin",
               label = "Logout",
               icon =   icon("repeat", lib = "glyphicon"),
               block = F,
               style = "success"
             )
           )))
            

            )
          )
        })
      }
      
      # if standard user
      else{
        output$page <- renderUI({
          
          
        })
      }
    }
  })
  
  ####################################################### server #############################################################################################
  
  
  
  out<-reactive({
    file1 <- input$file
    if(is.null(file1)) {return(NULL)}
    data <- read.csv(file1$datapath,header=TRUE)
    withProgress(message='Loading table',value=30,{
      n<-10
      
      for(i in 1:n){
        incProgress(1/n,detail=paste("Doing Part", i, "out of", n))
        Sys.sleep(0.1)
      }
    })
    #data = read.csv("Telco-Customer-Churn- original data - Copy.csv",header = T)
    data$Gender_1<- ifelse(data$gender=="Male",1,0)
    data$partner_1<- ifelse(data$Partner=="Yes",1,0)
    data$Dependents_1 <- ifelse (data$Dependents=="Yes",1,0)
    data$PhoneService_1 <- ifelse(data$PhoneService=="Yes",1,0)
    data$MultipleLines_1 <- revalue(data$MultipleLines, c("Yes"=1, "No"=0, "No phone service"=2))
    data$InternetService_1 <- revalue(data$InternetService, c("DSL"=1, "Fiber optic"=2, "No"=0))
    data$OnlineSecurity_1 <- revalue(data$OnlineSecurity, c("Yes"=1, "No"=0, "No internet service"=2))
    data$OnlineBackup_1 <- revalue(data$OnlineBackup, c("Yes"=1, "No"=0, "No internet service"=2))
    data$DeviceProtection_1 <- revalue(data$DeviceProtection, c("Yes"=1, "No"=0, "No internet service"=2))   
    data$TechSupport_1 <- revalue(data$TechSupport, c("Yes"=1, "No"=0, "No internet service"=2))
    data$StreamingTV_1 <- revalue(data$StreamingTV, c("Yes"=1, "No"=0, "No internet service"=2))
    data$StreamingMovies_1 <- revalue(data$StreamingMovies, c("Yes"=1, "No"=0, "No internet service"=2))
    data$PaperlessBilling_1 <- revalue(data$PaperlessBilling, c("Yes"=1, "No"=0))
    data$Churn_1 <- revalue(data$Churn, c("Yes"=1, "No"=0))
    final_data <- data[-c(1,2,4,5,7,8,9,10,11,12,13,14,15,17,21)]
    
    set.seed(1000000)
    pred<- data.frame(predict(rf,data=final_data ,type = "prob"))
    Prediction <- ifelse(pred[,2] < 0.26,"Not_Churn","Churn")
    probability <- round(pred[,2],3)
    final_tab<- data.frame(data[1],Prediction)
    final_tab
    
  })
  
  
  
  observeEvent(input$reset,{
    reset(id = "file")
  })
  
  output[["fileupload"]] <- renderUI({
    input$reset
    tags$div(fileInput("file",label = tags$h4(strong(em("Upload data..")),style="color:#034e91;font-size:160%"),accept=c('csv','comma-seperated-values','.csv')),align="center")
    
  })
  
  output[["checkbox"]] <- renderUI({
    input$reset
    tags$div(checkboxInput("check",tags$a(href = "https://github.com/pawanramamali", "Terms & Conditions",style="color:green;"),value = TRUE),align="center")
    
  })
  
  output[["button"]] <- renderUI({
    if(input$check==TRUE){
      tags$div(bsButton("analyse",strong("Predict Churn"),icon = icon("refresh"),style = "primary",size="medium"),
               style="color:white;font-weight:100%;",align="center")
    }
  })
  
  
  output[["helptext"]] <- renderUI({
    if(input$check==TRUE){
      tags$div(helpText("Click the Predict button to view Prediction !",style="text-align:center"),align="center")
    }
  })
  
  
  observe(addHoverAnim(session, 'logo1', 'pulse'))
  observe(addHoverAnim(session, 'logo2', 'pulse'))
  observe(addHoverAnim(session, 'analyse', 'shake'))
  observe(addHoverAnim(session, 'reset', 'shake'))
  
  
  observeEvent(input$analyse, {
    confirmSweetAlert(
      session = session,
      inputId = "confirmation",
      type = "warning",
      title = "Are you sure ?",
      btn_labels = c("No", "Yes"),
      danger_mode = TRUE
    )
  })
  
  observeEvent(input$confirmation, {
    if(input$confirmation==TRUE){
      showModal(tags$div(id="modal1", modalDialog(
        inputId = 'Dialog1', 
        title = HTML('<span style="color:#034e91; font-size: 20px; font-weight:bold; font-family:sans-serif ">Output<span>
                       <button type = "button" class="close" data-dismiss="modal" ">
                       <span style="color:white; ">x <span>
                       </button> '),
        footer = modalButton("Close"),
        size = "l",
        dataTableOutput("outdata"),
        uiOutput("down"),
        easyClose = F
      )))
    }
  })
  
  output[["down"]]<-renderUI({
    tags$div(downloadButton("downloadData","Download..!"),align="center")
  })
  
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("Customer Churn Prediction", ".csv", sep = "")
    },
    content = function(file) {
      write.csv(out(), file, row.names = FALSE)
    }
  )
  
  observeEvent(input$confirmation, {
    if(input$confirmation==TRUE){
      output[["outdata"]]<- renderDataTable({
        datatable(out(),extensions = c('Scroller'),
                  options = list(
                    dom = 'Bfrtip',
                    deferRender = TRUE,
                    scrollY = 500,
                    scroller = TRUE
                  ),filter = "top")
      })
    }
  })
  
 
}) 
