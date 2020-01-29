# date: 29 Jan 2020
# ggplot cheat sheet code

##### Sunspot data #####

library(tidyverse)

# load the data
sunData <- read.table(file.choose(), header = TRUE, sep = ",")

# See what the data looks like
View(sunData)

# Load a data file directly from a path:
#sunData <- read.table("path/sunSpots.csv", header = TRUE, sep = ",")
names(sunData)

ggplot(data = sunData) +  geom_point(mapping = aes(x = fracOfYear, y = sunspotNum))

# Add a smooth line to see general trends
ggplot(data = sunData) +  geom_point(mapping = aes(x = fracOfYear, y = sunspotNum)) + geom_smooth(mapping = aes(x = fracOfYear, y = sunspotNum))

# Color by year
ggplot(data = sunData) +  geom_point(mapping = aes(x = fracOfYear, y = sunspotNum, color = fracOfYear)) + geom_smooth(mapping = aes(x = fracOfYear, y = sunspotNum))

# Color by month
ggplot(data = sunData) +  geom_point(mapping = aes(x = fracOfYear, y = sunspotNum, color = month)) + geom_smooth(mapping = aes(x = fracOfYear, y = sunspotNum, color = fracOfYear))

####
# Save the file
# what is the difference between the two graphs below?

png("sunSpots_yearVersusSunspots_1.png")
ggplot(data = sunData) +  geom_point(mapping = aes(x = fracOfYear, y = sunspotNum, color = fracOfYear)) + geom_smooth(mapping = aes(x = fracOfYear, y = sunspotNum))
dev.off()

ggsave("sunSpots_yearVersusSunspots_1.png")
ggplot(data = sunData) +  geom_point(mapping = aes(x = fracOfYear, y = sunspotNum, color = month)) + geom_smooth(mapping = aes(x = fracOfYear, y = sunspotNum, color = fracOfYear))
dev.off()


# Save the other file
png("sunSpots_yearVersusSunspots_2.png")
ggplot(data = sunData) +  geom_point(mapping = aes(x = fracOfYear, y = sunspotNum, color = fracOfYear)) + geom_smooth(mapping = aes(x = fracOfYear, y = sunspotNum, color = fracOfYear))
dev.off()


# Another way to save the file.
ggsave("sunSpots_yearVersusSunspots_2_i.png")
