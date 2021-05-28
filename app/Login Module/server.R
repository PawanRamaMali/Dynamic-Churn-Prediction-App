# server.R

server <- function(input, output, session) {
  
  
  options(shiny.maxRequestSize=30*1024^2) 
  
  
  users <- data.frame(User="churn",Password="customer")
  ## BEGIN BUILD LOG IN SCREEN
  USER <- reactiveValues(Logged = Logged)
  
  ## ERROR CHECKING
  observeEvent(input$Login,{
    
    ## output error message
    output$message <- renderUI({
      if(!is.null(input$Login)){
        my_username <- length(users$User[grep(pattern = input$userName, x = users$User)])
        my_password <- length(users$User[grep(pattern = input$passwd, x = users$Password)])
        if(input$Login > 0){
          if(my_username < 1 ||  my_password < 1){
            HTML("<div id='error-box'>
                             Sorry, that's not the right username or password. Please, 
                             try again. If you continue to have problems,
                             <a href='https://github.com/sailogeshh'>
                             <u>Contact Us..</u></a>
                             </div>")
          }
        }
      }
    })
    
    ## CHECK INPUT
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
  
  ## Make UI
  observe({
    # What to do when logged = F
    if (USER$Logged == FALSE) {
      output$page <- renderUI({
        div(class="outer",do.call(bootstrapPage,c("",ui())))
      })
    }
    
    # Render UI when logged = T
    if (USER$Logged == TRUE) 
    {
      ## get the current user's authorization level 
      user_log <- toupper(input$userName)
      
      # if admin ("input.SELECT == 1 || input.FED == 2" )
      if(user_log == "CHURN" ){
        output$page <- renderUI({
          ###################################################### ADMIN UI PAGE ###################################################################################################################
          fluidPage(
            tags$style(HTML('body {font-family:"Verdana",Georgia,Serif; background-color:white}')),
            theme = shinytheme("united"),
            withAnim(),
            #setBackgroundImage(src = "w.jpg"),
            tags$head(
              tags$style(type = 'text/css', 
                         HTML('
                                      .navbar-default .navbar-brand{color: ;}
                                      .tab-panel{ background-color: #; color: #}
                                      .navbar-default .navbar-nav > .active > a, 
                                      .navbar-default .navbar-nav > .active > a:focus, 
                                      .navbar-default .navbar-nav > .active > a:hover {
                                      color: #e6e6e6;
                                      background-color: #;
                                      
                                      }')
              )
            ),
            
            tags$style(HTML(".navbar  {
                                    background-color:#105da2; }
                                    
                                    .navbar .navbar-nav {float: right; margin-right: 35px;
                                    margin-top: 26px;
                                    color: #; 
                                    font-size: 18px; 
                                    background-color: #; }
                                    
                                    .navbar.navbar-default.navbar-static-top{ 
                                    color: #; 
                                    font-size: 23px; 
                                    background-color: # ;}
                                    
                                    .navbar .navbar-header {
                                    float: left;
                                    background-color: # ;}
                                    
                                    .navbar-default .navbar-brand { color: #e6e6e6; 
                                    margin-top: 10px;
                                    font-size: 24px; 
                                    background-color: # ;} 
                                    
                                    ")),
            tags$style(type="text/css",
                       "#well0{
                               padding: 100px;
                               background: white;
                               border: 1px;
                               box-shadow:2px 2px;}"),
            tags$style(type="text/css",
                       "#well2{
                               padding: 100px;
                               background: #;
                               border: 1px;
                               box-shadow:2px 2px;}"),
            tags$style(type="text/css",
                       "#well8{
                               padding: 100px;
                               background: #;
                               border: 1px;
                               box-shadow: 2px 2px;}"),
            tags$style(type="text/css",
                       "#rrr{
                               padding: 100px;
                               background: #;
                               border: 0px;
                               box-shadow: 0px 0px;}"),
            tags$head(
              tags$style(HTML("
                                      input[type=\"number\"] {
                                      font-size: 20px;height:50px;
                                      }
                                      
                                      "))
            ),
            #tags$style(type='text/css','#qq {background-color: #d2d3d4; color: #004264;font-size:120%}'),
            #tags$style(type='text/css','#qqq {background-color: #d2d3d4; color: #004264;font-size:120%}'),
            #tags$style(type='text/css','#qqqq {background-color: #d2d3d4; color: #004264;font-size:120%}'),
            #tags$style(type='text/css','#qqqqq {background-color: #d2d3d4; color: #004264;font-size:120%}'),
            
            tags$head(HTML("<title>Predictive Analytics</title> <link rel='icon' type='image/gif/png' href='t.png'>")),
            navbarPage(id="tabset",tags$li(class = "dropdown",
                                           tags$style(".navbar {min-height:100px }")
            ),
            #title = ,position = "fixed-top",selected = "Upload",inverse = TRUE,
            title = tags$div(img(src="log.png","Customer churn - Telecom", style="margin-top: -4px;margin-left: 30px;", height = 60)),position = "fixed-top",selected = "Upload",inverse = F,
            tabPanel(title = "Upload",icon = icon("upload"),
                     
                     fluidPage(
                       
                       tags$style(" #modal1 .modal-header {background-color:#; border-top-left-radius: 0px; border-top-right-radius: 0px}"),
                       
                       tags$style(type="text/css",
                                  ".shiny-output-error { visibility: hidden; }",
                                  ".shiny-output-error:before { visibility: hidden; }"
                       ),
                       tags$head(tags$style("#pppp{color:black; font-size:35px; font-style:italic; text-align=center;
                                                    overflow-y:scroll; max-height: 300px; background: ghostwhite;}")),
                       tags$head(tags$style("#roi{color:black; font-size:35px; font-style:italic; text-align=center;
                                                    overflow-y:scroll; max-height: 300px; background: ghostwhite;}")),
                       
                       
                       br(),
                       br(),
                       
                       
                       column(7,
                              
                              # tags$h3(strong(em("Aim of this Analysi(s):")),style="text-align:center;color:#004264;font-size:180%"),br(),
                              # tags$div(h4("The identification of rare items, events or observations which raise suspicions",style="text-align:center;color:dimgrey"),align="center"),
                              # tags$div(h4("by differing significantly from the majority of the data.",style="text-align:center;color:dimgrey"),align="center"),
                              br(),br(),br(),br(),br(),
                              tags$div(id = 'logo1',img(src="eee.png",height='70%',width='70%'),align="center")
                       ),
                       
                       br(),
                       br(),
                       
                       column(5,
                              
                              
                              bootstrapPage(useShinyjs(),
                                            br(),
                                            
                                            tags$h3(strong(em("Predictive Analytics (Customer Churn)")),style="text-align:center;color:#034e91;font-size:190%"),
                                            
                                            tags$div(id = 'logo2',img(src="ee.png",height='50%',width='50%'),align="center"),
                                            
                                            withAnim(),
                                            
                                            uiOutput('fileupload'), 
                                            uiOutput('checkbox'),
                                            uiOutput("button"),
                                            uiOutput("helptext"),
                                            br(),
                                            
                                            bsPopover(id="check",title = "",content = "Note: I accept the Terms & Conditions.. Show the Analyse button",placement = "right"),
                                            tags$div(bsButton("reset", label = "Reset ?", icon =   icon("repeat",lib = "glyphicon"),block = F, style="danger",size = "small"),align="center"),
                                            
                                            
                                            #tags$h1(actionButton("myuser","Logout",icon=icon("user")),style="text-align:center"),
                                            
                                            
                                            tags$div(class = "header", checked = NA,style="text-align:center;color:#929292;font-size:100%",
                                                     tags$tbody("Need Help ?"),
                                                     tags$a(href = "https://github.com/sailogeshh", "Contact Us...")
                                            )
                              )
                       )
                       
                       
                       
                     )),
            
            
            
            
            tabPanel(title = strong("|")),         
            
            
            navbarMenu("More",icon = icon("plus-square"),
                       tabPanel(
                         tags$div(tags$a(href="javascript:history.go(0)",bsButton("logoutadmin", label = "Logout", icon =   icon("repeat",lib = "glyphicon"),block = F, style="success"),style="text-align:center"),align="center"),
                         br()
                       )
            ))
          )
          
          
          #########################################################################################################################################################################
          
          
          
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
    tags$div(checkboxInput("check",tags$a(href = "https://github.com/sailogeshh", "Terms & Conditions",style="color:green;"),value = TRUE),align="center")
    
  })
  
  output[["button"]] <- renderUI({
    if(input$check==TRUE){
      tags$div(bsButton("analyse",strong("Lets Go..!"),icon = icon("refresh"),style = "primary",size="medium"),
               style="color:white;font-weight:100%;",align="center")
    }
  })
  
  
  output[["helptext"]] <- renderUI({
    if(input$check==TRUE){
      tags$div(helpText("To get results, click the 'Lets go!' button...",style="text-align:center"),align="center")
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
      title = "Are you sure the data was uploaded ?",
      btn_labels = c("Nope", "Yep"),
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
  
  
  
  
}
