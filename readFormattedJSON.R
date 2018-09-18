library(jsonlite)
library(rjson)
library(tidyverse)
library(tidyjson)
library(dplyr)


formattedJSON = fromJSON(file = "C:/Users/Dharam/Downloads/MDCAS Files/MDCAS_ALGO_RAW_VIZ/Turk_Sept10/secondLabelDetails.json")


names(formattedJSON)


JSONDataFrame <- data.frame(secondVal = NA, userLabel = NA, notaLabels = NA)

JSONSeconds <- formattedJSON[["details"]][["participant_file_0"]]


for (var in names(JSONSeconds)){
  
  for (i in 1:length(JSONSeconds[[var]])){
    
    print(paste0("i inside ", var, " is ", i))
    
    if (is.null(JSONSeconds[[var]][[i]][["other_labels"]])){
      pickedRow <- data.frame(secondVal = var, userLabel = JSONSeconds[[var]][[i]][["userLabel"]], notaLabels = NA)
      
    } else {
      
      labelsText = ""
      
      for (j in 1:length(JSONSeconds[[var]][[i]][["other_labels"]])){
        print(paste0("Inside j ", j))
        labelsText = paste0(labelsText, ",", JSONSeconds[[var]][[i]][["other_labels"]][[j]])
      }
      pickedRow <- data.frame(secondVal = var, userLabel = JSONSeconds[[var]][[i]][["userLabel"]], notaLabels = labelsText)
    }
    
    JSONDataFrame <- rbind(JSONDataFrame, pickedRow)
    
  }
  
  
}
