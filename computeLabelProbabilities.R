
JSONDataFrame <- JSONDataFrame[-1,]

# JSONDataFrame$SecNo <- NA
# 
# 
# for (row in 1:nrow(JSONDataFrame)){
#   
#   print(paste0("row number is ", row))
#   
#   k <- strsplit(JSONDataFrame$secondVal[row], "-")
#   JSONDataFrame$SecNo[row] <- as.numeric(k[[1]][2])
#   
# }


JSONDataFrame$secondVal <- as.factor(JSONDataFrame$secondVal)
JSONDataFrame$userLabel <- as.factor(JSONDataFrame$userLabel)


labelArray <- levels(JSONDataFrame$userLabel)

## Remove the NA row



labelProp <- data.frame(SecondPos = NA, Ambulation = NA, Sleep = NA, Sedentary = NA, Nonwear = NA, None = NA)

valIndex = 1

#JSONDataFrame$SecNo <- strsplit(JSONDataFrame$secondVal, "-")

for (value in levels(JSONDataFrame$secondVal)){
  
  print(paste0("the value is ", value))
  
  rowTemp <- data.frame(SecondPos = value, Ambulation = 0, Sleep = 0, Sedentary = 0, Nonwear = 0, None = 0)
  labelProp <- rbind(labelProp, rowTemp)
  
  secondSubset <- subset(JSONDataFrame, JSONDataFrame$secondVal == value)
  valIndex = valIndex + 1
  
  for (index in 1:nrow(secondSubset)){
    
    if (secondSubset$userLabel[index] == "ambulation"){
      
      labelProp$Ambulation[valIndex] = labelProp$Ambulation[valIndex] + 1
      
    } else if (secondSubset$userLabel[index] == "nonwear"){
      
      labelProp$Nonwear[valIndex] = labelProp$Nonwear[valIndex] + 1
      
    } else if (secondSubset$userLabel[index] == "sleep"){
      
      labelProp$Sleep[valIndex] = labelProp$Sleep[valIndex] + 1
      
    } else if (secondSubset$userLabel[index] == "sedentary"){
      
      labelProp$Sedentary[valIndex] = labelProp$Sedentary[valIndex] + 1
      
    } else if (secondSubset$userLabel[index] == "nota"){
      
      nota = strsplit(secondSubset$notaLabels[index], ",")
      nota = nota[[1]][-1]
      
      filteredList <- labelArray[which(!labelArray %in% nota)]
      
      #### Check the labels in the filtered list
      totalLabels = length(filteredList)
      
      if ('ambulation' %in% filteredList){
        labelProp$Ambulation[valIndex] = labelProp$Ambulation[valIndex] + (1/totalLabels)
      } else if ('nonwear' %in% filteredList){
        labelProp$Nonwear[valIndex] = labelProp$Nonwear[valIndex] + (1/totalLabels)
      } else if ('sleep' %in% filteredList){
        labelProp$Sleep[valIndex] = labelProp$Sleep[valIndex] + (1/totalLabels)
      } else if ('sedentary' %in% filteredList){
        labelProp$Sedentary[valIndex] = labelProp$Sedentary[valIndex] + (1/totalLabels)
      } else if ('nota' %in% filteredList) {
        labelProp$None[valIndex] = labelProp$None[valIndex] + (1/totalLabels)
      }
      
    }
  }
  
  
}


labelProp$SecNo <- NA

for (row in 1:nrow(labelProp)){
  
  print(paste0("row number is ", row))

  
  k <- strsplit(labelProp$SecondPos[row], "-")
  labelProp$SecNo[row] <- as.numeric(k[[1]][2])
  
}

labelProp <- labelProp[-1,]

labelProp <- labelProp[order(labelProp$SecNo), ]


### Get the maximim probable label and its probability

labelProp$TotalProp <- labelProp$Ambulation + labelProp$Sleep + labelProp$Sedentary + labelProp$Nonwear + labelProp$None

labelProp$AmbProp <- labelProp$Ambulation/labelProp$TotalProp
labelProp$SleepProp <- labelProp$Sleep/labelProp$TotalProp
labelProp$SedProp <- labelProp$Sedentary/labelProp$TotalProp
labelProp$NonwrProp <- labelProp$Nonwear/labelProp$TotalProp
labelProp$NoneProp <- labelProp$None/labelProp$TotalProp


labelProp$MaxProp <- NA
labelProp$FinalLabel <- NA

## Redo

for (rowIndex in 1:nrow(labelProp)){
  
  print(paste0("row number is ", rowIndex))
  
  L1 <- list(labelProp$AmbProp[rowIndex], labelProp$SleepProp[rowIndex], labelProp$SedProp[rowIndex], labelProp$NonwrProp[rowIndex], labelProp$NoneProp[rowIndex])
  
  labelProp$MaxProp[rowIndex] <- max(unlist(L1))
  
  ## Check the value assignment
  
  #labelProp$MaxProp[rowIndex] <- which.max(L1)
  
  #labelProp$FinalLabel[rowIndex] <- lapply(L1, function(x) x[which.is.max(x)])
  labelProp$FinalLabel[rowIndex] <- which.max(L1)
  
}

labelProp$FinalLabelProp <- NA

labelProp$MostProbableLabel[labelProp$FinalLabel == 1] <- "Ambulation"
labelProp$MostProbableLabel[labelProp$FinalLabel == 2] <- "Sleep"
labelProp$MostProbableLabel[labelProp$FinalLabel == 3] <- "Sedentary"
labelProp$MostProbableLabel[labelProp$FinalLabel == 4] <- "NonWear"
labelProp$MostProbableLabel[labelProp$FinalLabel == 5] <- "None"


# for (q in 1:nrow(labelProp)){
#   print(paste0("index is ", q))
#   labelProp$FinalLabelProp[q] <- labelProp$MaxProp[[1]][1]
# }

#labelProp <- labelProp[-13]



savePath = "C:/Users/Dharam/Downloads/MDCAS Files/MDCAS_ALGO_RAW_VIZ/Turk_Sept10/Labels/LabelsProp.csv"
write.csv(file = savePath, x = labelProp, quote = FALSE, row.names = FALSE, col.names = TRUE, sep = ",")

