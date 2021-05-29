# Main controller ----


# * Load libraries ----
source('global.R')

# * Load UI ----
source('ui.R')

# * Load Server ----
source('server.R')

# Run App ----
shinyApp(ui = ui, server = server)

