
# Date: 20 Feb 2020
# Exercise to analyze Trump poll data

# Website plot: https://projects.fivethirtyeight.com/trump-approval-ratings/
# Ref of data: https://projects.fivethirtyeight.com/trump-approval-ratings/?ex_cid=rrpromo

library(tidyverse)


# pollist
pollist <- read.csv(file.choose(), header = TRUE) # file: approval_polllist_20Feb2020.csv
View(pollist)


l_mod <- lm(pollist$samplesize ~ pollist$weight)

#approval

cat("Adjusted Approval Polls")
# approval
ggplot(data = pollist) + geom_point(mapping=aes( x = 1:length(adjusted_approve), y = adjusted_approve, col = adjusted_approve))


cat("Adjusted Approval Polls")
# approval and smooth line
ggplot(data = pollist) + geom_point(mapping=aes(x = 1:length(adjusted_approve), y = adjusted_approve, col = adjusted_approve)) + geom_smooth(mapping=aes(x = 1:length(adjusted_approve), y = adjusted_approve, colour = adjusted_approve))


# disapproval
ggplot(data = pollist) + geom_point(mapping=aes(x = 1:length(adjusted_disapprove), y = adjusted_disapprove, colour = adjusted_disapprove))


# disapproval and smooth line
ggplot(data = pollist) + geom_point(mapping=aes(x = 1:length(adjusted_disapprove), y = adjusted_disapprove, colour = adjusted_disapprove)) + geom_smooth(mapping=aes(x = 1:length(adjusted_disapprove), y = adjusted_disapprove, colour = adjusted_disapprove))



# approval and disapproval
ggplot(data = pollist) + geom_point(mapping=aes(x = 1:length(adjusted_approve), y = adjusted_approve, col = adjusted_approve)) + geom_smooth(mapping=aes(x = 1:length(adjusted_approve), y = adjusted_approve, col = adjusted_approve )) + geom_point(mapping=aes(x = 1:length(adjusted_approve), y = adjusted_approve, col = adjusted_approve)) + geom_smooth(mapping=aes(x = 1:length(adjusted_approve), y = adjusted_approve, col = adjusted_approve)) +  geom_hline(yintercept = (range(pollist$adjusted_approve)[1] + range(pollist$adjusted_disapprove)[2])/2)



cat("H-line at the avg of means of each sample")

# Approval over disapproval and smoothlines
ggplot(data = pollist) + geom_point(mapping=aes(x = 1:length(adjusted_approve), y = adjusted_approve, col = adjusted_approve),color="Blue") + geom_smooth(mapping=aes(x = 1:length(adjusted_approve), y = adjusted_approve, col = adjusted_approve),color="darkBlue") + geom_point(mapping=aes(x = 1:length(adjusted_disapprove), y = adjusted_disapprove, col = adjusted_disapprove),color="Purple") + geom_smooth(mapping=aes(x = 1:length(adjusted_disapprove), y = adjusted_disapprove, col = adjusted_disapprove),color="Red") + geom_hline(yintercept = (mean(pollist$Adj_approval_percent) + mean(pollist$Adj_disapproval_percent))/2) + labs(y="Approval (blue)\n disapproval (Purple)", x = "Survey Number")



png("pollist.png")
# Approval over disapproval and smoothlines
ggplot(data = pollist) + geom_point(mapping=aes(x = 1:length(adjusted_approve), y = adjusted_approve, col = adjusted_approve),color="Blue") + geom_smooth(mapping=aes(x = 1:length(adjusted_approve), y = adjusted_approve, col = adjusted_approve),color="darkBlue") + geom_point(mapping=aes(x = 1:length(adjusted_disapprove), y = adjusted_disapprove, col = adjusted_disapprove),color="Purple") + geom_smooth(mapping=aes(x = 1:length(adjusted_disapprove), y = adjusted_disapprove, col = adjusted_disapprove),color="Red") + geom_hline(yintercept = (mean(pollist$Adj_approval_percent) + mean(pollist$Adj_disapproval_percent))/2) + labs(y="Approval (blue)\n disapproval (Purple)", x = "Survey Number")

dev.off()


# plotly

library(plotly)

p <- ggplot(data = pollist) + geom_point(mapping=aes(x = 1:length(adjusted_approve), y = adjusted_approve, col = adjusted_approve),color="Blue") + geom_smooth(mapping=aes(x = 1:length(adjusted_approve), y = adjusted_approve, col = adjusted_approve),color="darkBlue") + geom_point(mapping=aes(x = 1:length(adjusted_disapprove), y = adjusted_disapprove, col = adjusted_disapprove),color="Purple") + geom_smooth(mapping=aes(x = 1:length(adjusted_disapprove), y = adjusted_disapprove, col = adjusted_disapprove),color="Red") + geom_hline(yintercept = (mean(pollist$Adj_approval_percent) + mean(pollist$Adj_disapproval_percent))/2) + labs(y="Approval (blue)\n disapproval (Purple)", x = "Survey Number")

ggplotly(p)
