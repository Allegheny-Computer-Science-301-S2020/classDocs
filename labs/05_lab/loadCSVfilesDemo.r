# open the data file and load it.


rm(list = ls())
datafile <- file.choose()
dataset <- read.csv(datafile, header=FALSE)
View(dataset)
