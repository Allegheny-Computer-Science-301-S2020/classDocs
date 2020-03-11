library(tidyverse)
# install.packages("psych")
library(psych)
#open lung capacity data
lc <-file.choose()
dataLungCap <- read.csv(lc)
View(dataLungCap)


# model creation
                                   #y = m_1*x_1  + m_2*x_2 + b
mod <- lm(data = dataLungCap, LungCap ~ Age + Height)
# get a report of the model
summary(mod)


library(psych)
pairs.panels(dataLungCap)
pairs.panels(dataLungCap, lm = TRUE)
confint(mod, conf.level = 0.95)
