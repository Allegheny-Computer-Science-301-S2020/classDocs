# who said it first? An  analysis of speech
# date: 7 April 2020

# A basic machine learning program to demonstrate how word usage, 
# taken from two data sets, may be used to determine individual data 
# between the two sets. In this case, we are working with the speeches of 
# Obama and Trump. We train a model to recognize one type of speech from another
# and then randomly choose speeches from each set to ascertain whether our
# model is able to correctly place the speech with its correct speaker. 

# OverView of the program
# input two speeches in text
# outline of program
# init: set up libraries and initialize code
# clean the text: remove stopwords and misc words
# build Term document matrix (TDM) for each entered speech containing words and freqs
# attach name the TDM so that we know which is which
# stack: combin the input data matrices
# testing: hold-out (we do not tell model who said speech)
# model: use k-nearest neighbour to run comparisons between both data sets
# Assess accuracy for model: how well does it work? 

############################################################

#input two speeches in text
#outline of program

######################################################

rm(list = ls()) # remove all variables and start with a clean slate.

# init: set up libraries and initialize code
# library(tidyverse)
# library(tm)
# library(plyr)
# library(class)

# install.packages("tm")
libs <- c("tm","plyr","class", "tidyverse")
lapply(libs, require, character.only = TRUE)
# set options
options(stringsAsFactors = FALSE) # prevent nominal or catagorical variables in data set from being made from text or string values.

# set parameters: load the data files

# main speech data
candidates <- c("obama", "trump")


# path to the data sets.
pathname <- "tm/"

######################################################
# clean the text: remove stopwords and misc words
# clean up the documents of the corpus

cleanCorpus <- function(corpus){ 
  
  corpus.tmp <- tm_map(corpus, removePunctuation)
  corpus.tmp <- tm_map(corpus, stripWhitespace)
  corpus.tmp <- tm_map(corpus, tolower)
  corpus.tmp <- tm_map(corpus, removeWords, stopwords("english")) # remove parts of speech having no real meaning and which do not help to identify text's ideas. 
}


# build Term dot matrix matrix (TDM) for each entered speech containing words and freqs
######################################################


generateTDM <- function(cand, path){
  # take a data table and work with it
  print(cand)
  print(path)
  print(dir.exists(path))
  s.dir <- sprintf("%s/%s", path, cand) # format the path and filename of the dataset. 
  #  s.cor <- Corpus(DirSource(directory = s.dir, encoding = "ANSI")) # create the corpus based on the path and the data. 
  s.cor <- Corpus(DirSource(directory = s.dir)) # create the corpus based on the path and the data. 
  #  print(s.cor)
  s.cor.cl <- cleanCorpus(s.cor) # clean the text
  s.tdm <- TermDocumentMatrix(s.cor.cl) # prepare the Term Doc Matrix
  t.tdm <- removeSparseTerms(s.tdm, 0.7) # remove the words which are rarely used. 
  result <- list(name = cand, tdm = s.tdm)
}

tdm <- lapply(candidates, generateTDM, path = pathname)
str(tdm)

# attach name the TDM so that we know which is which
######################################################

bindCandidateToTDM <- function(tdm){
  s.mat <- t(data.matrix(tdm[["tdm"]])) #transpose tdm
  s.df <- as.data.frame(s.mat, stringsAsFactors = FALSE) # spreadsheet: each speech is on a row, terms on colunms. their intersection is a frequency value of the term in the speech.
  s.df <- cbind(s.df, rep(tdm[["name"]], nrow(s.df)))
  # column bind 
  colnames(s.df)[ncol(s.df)] <- "targetCandidate"
  return(s.df)
}

candTDM <- lapply(tdm,bindCandidateToTDM)
str(candTDM)


# stack: combin the input data matrices
######################################################

tdm.stack <- do.call(rbind.fill, candTDM) # row binding. terms in one and not in the other get an "na"
str(tdm.stack)

tdm.stack[is.na(tdm.stack)] <- 0 #replace the NA's with zeros
str(tdm.stack)

head(tdm.stack)

nrow(tdm.stack) # number of docs (speeches) in the corpus.
ncol(tdm.stack) # terms (across all speeches)

# hold-out (used for testing: we do not tell model who said speech)
######################################################

# training index by taking a sample
train.idx <- sample(nrow(tdm.stack), ceiling(nrow(tdm.stack) * 0.7)) # take 70 per cent of the rows to train.

str(train.idx)
head(train.idx)


# use the remaining 30 per cent to test
test.idx <- (1:nrow(tdm.stack)) [- train.idx]  

# we note the unused entities with the negation. i.e., -train.tdx
str(test.idx)

cat("Testing samples:")
head(test.idx)

cat("Training samples:")
head(train.idx)


# model: use k-nearest neighbour to run comparisons between both data sets
######################################################


tdm.cand <- tdm.stack[, "targetCandidate"]
tdm.stack.nl <- tdm.stack[,!colnames(tdm.stack) %in% "targetCandidate"]

knn.pred <- knn(tdm.stack.nl[train.idx, ], tdm.stack.nl[test.idx, ], tdm.cand[train.idx])

str(knn.pred)

# Assess accuracy for model: how well does it work? 

conf.mat <- table("Predictions" = knn.pred, Actual = tdm.cand[test.idx])
str(conf.mat)
conf.mat # confusion matrix
cat("True Positive, Predicted to be spoken by Obama: ",conf.mat[1,1])
cat("False Positve, Predicted to be spoken by Trump: ",conf.mat[1,2])
cat("False Negative left, Actually spoken by Obama (first num) or Trump (second num): ",conf.mat[,1])
cat("True Negative right, Actually spoken by Trump (first num) or Obama (second num): ",conf.mat[,2])

# Sample confusion matrix

#            Actual
# Predictions obama trump
#      obama     13    0
#      trump     0     6


# How to read the confusion matrix.
# On the left side are the predictions from the model: there were 
# 13 docs that were predicted to have been Obama speeches. On top 
# (going down columns) are the actual counts of documents which 
# were spoken by Obama. All 13 were actually spoken by Obama. There 
# were six predicted Trump speeches (reading left to right) of
# which six were actually spoken by Trump (looking down the right column.)


cat("Accuracy per cent :")
(accuracy <- sum(diag(conf.mat)) / length(test.idx) * 100) # how sure are we that the confusion matrix is correct?

  