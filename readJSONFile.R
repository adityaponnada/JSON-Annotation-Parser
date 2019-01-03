library(jsonlite)
library(rjson)
library(tidyverse)




##jsonLink <- "http://ec2-35-173-124-198.compute-1.amazonaws.com/s3/initialization/fileStatus/singleFileStatus.php"

##jsonFile <- read_json("C:/Users/Dharam/Downloads/MDCAS Files/LabelComputationFromJSON/labels.json", simplifyVector = TRUE)

jsonFile2 <- fromJSON(file = "C:/Users/Dharam/Downloads/MDCAS Files/MDCAS_ALGO_RAW_VIZ/Turk_Nov26/labels_Nov_26.json")

#testFile <- fromJSON(jsonLink)

testFile <- as.data.frame(jsonFile2)

testString <- x$x[1]


jsonFile2[["sessiondetails"]] <- NULL

testFrame <- jsonFile2[["details"]][["participant_file_0"]]

testFrame <- as.data.frame(testFrame)


testFrameSecond <- as.list(jsonFile2[["details"]][["participant_file_0"]][["s-1"]])

testFrameSecond2 <- jsonFile2[["details"]][["participant_file_0"]]

for (var in colnames(testFrameSecond2)){
  
  testFrameSecond2$var <- as.factor(testFrameSecond2$var)
  
}

library(tidyjson)
library(dplyr)

testFrameSecond2 %>% as.tbl_json %>% gather_keys %>% json_types










