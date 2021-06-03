###################
# functions.R
# 

## Read Configuration File ----
read_config_file <- function(conf_path) {
  
  if (!file.exists(conf_path)) {
    print("Error : No configuration file found !! ")
    return()
  }
  
  config_table <- read.table(
                              conf_path,
                              header = FALSE,
                              sep = "\n",
                              stringsAsFactors = FALSE
                            )
  names(config_table) <- "Value"
  
  config_list <- list()
  for (i in 1:nrow(config_table)) {
    content <- gsub("^\\s+|\\s+$",
                "",
                unlist(strsplit(config_table[i, "Value"], "=", fixed = TRUE))
                )
    if (length(content) > 1) {
      config_list[[content[1]]] <-
        trimws(paste(content[2:length(content)], collapse = "="))
    } else{
      config_list[[content[1]]] <- ""
    }
  }
  return(config_list)
}
