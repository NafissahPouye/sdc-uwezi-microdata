library(readxl)      #for excel, csv sheets manipulation
library(sdcMicro)    #sdcMicro package with functions for the SDC process 
library(tidyverse)   #optional #for data cleaning

#Import data
setwd("C:/Users/LENOVO T46OS/Desktop/sdc-uwezi-microdata")
data <- read_excel("twaweza_szw_data_taxation_round5.xlsx")

selectedKeyVars <- c('respondent_gender','respondet_age','sub_county')

weightVars <- c('iwht')

#Convert variables into factors
cols =  c('respondent_gender',	'sub_county', 'respondet_age')

data[,cols] <- lapply(data[,cols], factor)

#Convert the sub file into dataframe
subVars <- c(selectedKeyVars, weightVars)
fileRes<-data[,subVars]
fileRes <- as.data.frame(fileRes)

objSDC <- createSdcObj(dat = fileRes, 
                       keyVars = selectedKeyVars, weightVar = weightVars)

print(objSDC, "risk")

#Generate an internal report
report(objSDC, filename = "index",internal = T, verbose = TRUE) 
