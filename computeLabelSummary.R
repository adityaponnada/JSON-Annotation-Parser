labelFile <- read.csv("C:/Users/Dharam/Downloads/MDCAS Files/MDCAS_ALGO_RAW_VIZ/Turk_Nov26_MOBOTS/Labels/LabelsProp.csv", header = TRUE, sep = ",")


library(psych)

describe(labelFile$MaxProp)

describe.by(labelFile$MaxProp, group = labelFile$MostProbableLabel)
