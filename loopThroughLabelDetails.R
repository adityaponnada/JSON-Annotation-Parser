

tempData$playerLabel <- NA
tempData$NotTheseList <- NA



## Extract the player label

for (i in 1:nrow(tempData)){
  
  print(paste0("at i ", i))
  
  x <- strsplit(tempData$labelDetails[i], ",")
  
  y <- x[[1]][2]
  
  y <- strsplit(y, '"')
  
  tempData$playerLabel[i] <- y[[1]][2]
  
}


