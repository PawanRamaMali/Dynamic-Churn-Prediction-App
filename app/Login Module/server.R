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
      print("Data file is NULL")
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
    print("Sending data to process")
    final_tab <- process_data(data=data)
    
  })
  
  
  # Reset Data m,
  observeEvent(input$reset, {
    reset(id = "file")
    rv$data_set <- NULL
 
  })
  
  output$fileupload <- renderUI({
    input$reset
    fileInput(
      "file",
      label = "Click Browse to upload data",
      accept = c('csv', 'comma-seperated-values', '.csv')
    )
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
  
  # Admin Dashboard Page Server ----
  rv <- reactiveValues()
  
  
  observeEvent(input$submit_data, {
    
    if (is.null(input$file)){
      print("OE submit data input$file is NULL ")
      return(NULL)
    }
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
  

  # Dynamically generate UI input when data is uploaded ----
  output$ui_select_target_variable <- renderUI({
    selectInput(inputId = "select_var", 
                       label = "Select target variable", 
                       choices = names(rv$data_set))
  })
  
  # Dynamically generate UI input when data is uploaded ----
  output$ui_select_excluded_variable <- renderUI({
    selectInput(inputId = "exclude_var", 
                label = "Select variables to exclude", 
                choices = names(rv$data_set),
                multiple = TRUE)
  })
  
  observeEvent(input$submit_target_variable, {
    if (is.null(input$file)){
      print("OE submit_target_variable input$file is NULL ")
      return(NULL)
    }
    
    print("Target Variable Selected is ")
    print(input$select_var)
    print("Variable Excluded are")
    print(input$exclude_var)
  
    
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
