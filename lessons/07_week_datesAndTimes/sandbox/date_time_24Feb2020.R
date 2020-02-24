# Date 24 Feb. 2020
# data and times

#install.packages("lubridate")
library(lubridate)
library(tidyverse)
library(nycflights13)


today()
now()

TodayDate <- today()
TimeNow <- now()


mdy("February 24th 2020")
dmy("24-Feb-2020")

ymd("2017-10-06") # "2017-10-06"
ymd(20171006) # "2017-10-06"
ydm(20171006) # "2017-06-10"

ymd_hms("2017-10-06 18:10:42")



mdy("October 6th 2017")

ymd(20171006, tz = "UTC")

myTime <- now()
as_date(myTime)

today()
as_datetime(today())


# Consider these!
d1 <- "January 1, 2010"
d2 <- "2015-Mar-07"
d3 <- "06-Jun-2017"
d4 <- c("August 19 (2015)", "July 1 (2015)")
d5 <- "12/30/14" # Dec 30, 2014

datetime <- ymd_hms("2018-10-16 12:01:13")
month(datetime, label = TRUE) # short string

wday(datetime, label = TRUE, abbr = FALSE)


timeTable <- flights %>% select(year, month, day, hour, minute)
#what is this new table?
View(timeTable)
