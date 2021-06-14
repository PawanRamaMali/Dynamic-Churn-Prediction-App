server <- function(input, output, session) {
  ## Temporary Credentials ----
  cred <- read.csv("cred.csv")
  users <- as.data.frame(cred)
  
  ## Login Set Value ----
  USER <- reactiveValues(Logged = Logged)
  
  
  ## Validate Login ----
  observeEvent(input$Login, {
    
    #* Login Error Message ----
    output$message <- renderUI({
      
      if (as.character(input$userName) == "" || as.character(input$passwd) == ""){
        HTML(
          "<div id='error-box'>
                Username or password cannot be blank !! 
                 </div>"
        )
      }
      
      else if (!is.null(input$Login)) {
        my_username <-
          length(users$User[grep(pattern = input$userName, x = users$User)])
        my_password <-
          length(users$User[grep(pattern = input$passwd, x = users$Password)])
        if (input$Login > 0) {
          if (my_username < 1 ||  my_password < 1) {
            HTML(
              "<div id='error-box'>
                 Incorrect Username or Password. Please,
                 try again. If you continue to have problems,
                 <a href='https://github.com/pawanramamali'>
                 <u>Contact Us..</u></a>
                 </div>"
            )
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
        div(class = "outer",
            do.call(bootstrapPage,
            c("", login_page())))
      })
    }
    
    # * Logged Status True  ----
    if (USER$Logged == TRUE)
    {
      ## Current user's authorization level check
      uid <- which(users$User ==input$userName)
      user_dept <- users$Dep[uid]
      if (user_dept == "agent") {
        output$page <- renderUI({
          # User Page ----
          source('./components/user/user_page.R')
        })
      }
      
      else if (user_dept == "sales") {
        output$page <- renderUI({
          # Sales Page ----
          source('./components/sales/sales_page.R')
        })
      }
      
      else if (user_dept == "admin") {
        output$page <- renderUI({
          # Admin Page ----
          source('./components/admin/admin_page.R')
        })
      }
      
      # if user not assigned dept
      else{
        output$page <- renderUI({
          div(class = "outer",
              do.call(bootstrapPage,
              c("", login_page())))
        })
      }
    }
  })
  
  
  # Server ----
  
  out <- reactive({
    
    if (is.null(input$file)) {
      return(NULL)
    }
    
    
    data <- read.csv(input$file$datapath, header = TRUE)
    withProgress(message = 'Loading data', value = 30, {
      n <- 10
      
      for (i in 1:n) {
        incProgress(1 / n, detail = paste("Doing Part", i, "out of", n))
        Sys.sleep(0.1)
      }
    })
    
    #data = read.csv("Telco-Customer-Churn- original data - Copy.csv",header = T)
    data$Gender_1 <- ifelse(data$gender == "Male", 1, 0)
    
    data$partner_1 <- ifelse(data$Partner == "Yes", 1, 0)
    
    data$Dependents_1 <- ifelse (data$Dependents == "Yes", 1, 0)
    
    data$PhoneService_1 <- ifelse(data$PhoneService == "Yes", 1, 0)
    
    data$MultipleLines_1 <-
    
      revalue(data$MultipleLines,
              c(
                "Yes" = 1,
                "No" = 0,
                "No phone service" = 2
              ))
    data$InternetService_1 <- revalue(data$InternetService, c(
        "DSL" = 1,
        "Fiber optic" = 2,
        "No" = 0
      ))
    data$OnlineSecurity_1 <-
      revalue(data$OnlineSecurity,
              c(
                "Yes" = 1,
                "No" = 0,
                "No internet service" = 2
              ))
    data$OnlineBackup_1 <-
      revalue(data$OnlineBackup,
              c(
                "Yes" = 1,
                "No" = 0,
                "No internet service" = 2
              ))
    data$DeviceProtection_1 <-
      revalue(data$DeviceProtection,
              c(
                "Yes" = 1,
                "No" = 0,
                "No internet service" = 2
              ))
    data$TechSupport_1 <-
      revalue(data$TechSupport,
              c(
                "Yes" = 1,
                "No" = 0,
                "No internet service" = 2
              ))
    data$StreamingTV_1 <-
      revalue(data$StreamingTV,
              c(
                "Yes" = 1,
                "No" = 0,
                "No internet service" = 2
              ))
    data$StreamingMovies_1 <-
      revalue(data$StreamingMovies,
              c(
                "Yes" = 1,
                "No" = 0,
                "No internet service" = 2
              ))
    data$PaperlessBilling_1 <-
      revalue(data$PaperlessBilling, c("Yes" = 1, "No" = 0))
    data$Churn_1 <- revalue(data$Churn, c("Yes" = 1, "No" = 0))
    final_data <-
      data[-c(1, 2, 4, 5, 7, 8, 9, 10, 11, 12, 13, 14, 15, 17, 21)]
    
    set.seed(1000000)
    pred <- data.frame(predict(rf,
                               data = final_data ,
                               type = "prob"))
    Prediction <- ifelse(pred[, 2] < 0.26, "Not_Churn", "Churn")
    probability <- round(pred[, 2], 3)
    final_tab <- data.frame(data[1], Prediction)
    final_tab
    
  })
  
  
  
  observeEvent(input$reset, {
    reset(id = "file")
    rv$data_set <- NULL
  })
  
  output[["fileupload"]] <- renderUI({
    input$reset
    tags$div(fileInput(
      "file",
      label = tags$h4(strong("Upload data."),
                      style = "color:#034e91;font-size:100%"),
      accept = c('csv', 'comma-seperated-values', '.csv')
    ), align = "center")
    
  })
  

  observeEvent(input$analyse, {
    if (input$show_features_responsive) {
      features <-  c("Responsive")
    }
    else
      features <-  c("FixedHeader")
    
    print("Generating Results")
     output$results_data <- renderDataTable({
       out() %>%
        datatable(
          rownames = input$show_rownames,
          options = list(scrollX = TRUE),
          extensions = features
        )
    })
     
    ## Writing Results in Output ----
    
     write.csv(out(),
               "Output\\output.csv", row.names = TRUE)
     
     
  })
  
  
  output[["down"]] <- renderUI({
    tags$div(downloadButton("downloadData",
                            "Download Results"))
  })
  
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("Customer Churn Prediction", ".csv", sep = "")
    },
    content = function(file) {
      write.csv(out(), file, row.names = FALSE)
    }
  )
  
  # Dashboard Page Server ----
  rv <- reactiveValues()
  
  
  observeEvent(input$submit_data, {
    if (input$show_features_responsive) {
      features <-  c("Responsive")
    }
    else
      features <-  c("FixedHeader")
    
    print("Importing dataset")
    rv$data_set <- read.csv(input$file$datapath, header = TRUE)
    output$show_data <- renderDataTable({
      rv$data_set %>%
        datatable(
          rownames = input$show_rownames,
          options = list(scrollX = TRUE),
          extensions = features
        )
    })
    
  })
  
  
  # Correlation Tab ----
  #
  
  output$corrplot <- renderPlotly({
    
    g <- DataExplorer::plot_correlation(rv$data_set)
    
    plotly::ggplotly(g)
  })
  
  
  
  
  observeEvent(input$Sales_View_Data_Button, {
    if (input$show_features_responsive) {
      features <-  c("Responsive")
    }
    else
      features <-  c("FixedHeader")
    
    print("Generating Sales_View_Data_Table")
    results_df <- as.data.frame(read.csv("output/output.csv"))
    output$Sales_View_Data_Table <- renderDataTable({
      results_df %>%
        datatable(
          rownames = input$show_rownames,
          options = list(scrollX = TRUE),
          extensions = features
        )
    })
    
  })
}
