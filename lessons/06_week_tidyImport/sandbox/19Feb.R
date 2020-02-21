library(tidyverse)
read_csv("a,b,c
          1,2,3
          4,5,6")


myData <- read_csv("a,b,c
                    1,2,3
                    4,5,6")


myData2 <- read_csv("a,b,c \n 1,2,3 \n 4,5,6")


xData <- read_csv("1,2,3 \n 4,5,6", col_names = FALSE)

names(xData) <- c("First", "Second", "Third")


# file loading
sunSpotData1 <- read.table(file.choose(), sep=",",header = TRUE)

# path is: /home/o/obonhamcarter/Desktop/0_quoiDeNeuf/aujourdhui/cs301_06_week_tidyImport/sunSpots.csv

sunSpotData1_myPath <- read.table("/home/o/obonhamcarter/Desktop/0_quoiDeNeuf/aujourdhui/cs301_06_week_tidyImport/sunSpots.csv", sep=",",header = TRUE)

View(sunSpotData1_myPath)

ggplot(data = sunSpotData1) + geom_point(mapping = aes(x = fracOfYear, y = sunspotNum, color = month))

library(tidyverse)

sunSpotData1_myPath <- read.table("/home/o/obonhamcarter/Desktop/0_quoiDeNeuf/aujourdhui/cs301_06_week_tidyImport/sunSpots.csv", sep=",",header = TRUE)

ggplot(data = sunSpotData1_myPath) + geom_point(mapping = aes(x = fracOfYear, y = sunspotNum, color = month))


# tidy data
library(tibble)
tibble(x = 1:5, y = 1, z = x ^ 2 + y)

table1 %>% count(year, wt = cases)

table1 %>% count(country, wt = as.numeric(population))

ggplot(table1, aes(year, cases)) + geom_line(aes(group = country),colour = "grey50") + geom_point(aes(colour = country))



newTable <-
  table4a %>%
  gather(`1999`,`2000`,
         key = "year",
         value = "cases")


spread(table2,key = type,value = count)

table3 %>% separate(rate, into = c("cases","population"), sep = "/")

table3 %>% separate(year, into = c("century", "year"), sep = 2)


table5 %>% unite(new, century, year)

table5 %>% unite(centuryYear, century,year, sep = "")


stocks_missing <- tibble(
  year = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr  = c(1, 2, 3, 4, 2, 3, 4), 
  return = c(1.88, 0.59, 0.35, NA, 0.92, 0.17, 2.66))


stocks %>% spread(year, return)


stocks %>% spread(year, return) %>% gather(year, return, `2015`:`2016`, na.rm = TRUE)





library(tibble)
#Create a table with missing entries
treatment <- tribble(
  ~ person, ~ treatment, ~response,
  "Derrick Whitmore", 1, 7,
  NA, 2, 10,
  NA, 3, 9,
  "Katherine Burke", 1, 4)

library(tidyverse)

treatment %>%
  fill(person)
