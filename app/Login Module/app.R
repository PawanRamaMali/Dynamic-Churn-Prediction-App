# Main controller ----
# require(shiny,quietly = TRUE, warn.conflicts = FALSE)
# require(shinyjs,quietly = TRUE, warn.conflicts = FALSE)
# .libPaths("./R-Portable/App/R-Portable/library")
# browser.path = file.path(getwd(),"GoogleChromePortable/GoogleChromePortable.exe")
# options(browser = browser.path)
# shiny::runApp("./Shiny/",port=8888,launch.browser= TRUE,quiet=TRUE)

# * Load libraries ----
source('global.R')

# * Load UI ----
source('ui.R')

# * Load Server ----
source('server.R')

# Run App ----
shinyApp(ui = ui, server = server)

