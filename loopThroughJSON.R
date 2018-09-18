library(jsonlite)
library(rjson)
library(tidyverse)
library(tidyjson)
library(dplyr)


playerData = fromJSON(file = "C:/Users/Dharam/Downloads/MDCAS Files/LabelComputationFromJSON/labels.json")


names(playerData)


playerData[["sessiondetails"]] <- NULL
playerSeconds <- playerData[["details"]][["participant_file_0"]]

tempData <- data.frame(secondVal = NA, labelDetails = NA)

for (var in names(playerSeconds)){
  
  for (i in 1:length(playerSeconds[[var]])){
    
    labelList <- as.factor(playerSeconds[[var]][i])
    
    tempRow <- data.frame(secondVal = var, labelDetails = labelList)
    
    tempData <- rbind(tempData, tempRow)
    
  }
  
  
}

tempData <- tempData[-1,]


head(tempData)
