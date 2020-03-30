# Date: 13 March 2020
# Map tutorial
# sometimes we need to put data on a map. Here is some code to help with putting data on a map.


# Based on code by Eric C. Anderson, modified by OBC 
#ref: http://eriqande.github.io/rep-res-web/lectures/making-maps-with-R.html

# if needed, install the libraries
#install.packages(c("ggplot2", "devtools", "dplyr", "stringr", "maps", "mapdata", "ggmap", "scales"))


rm(list = ls()) # clear all v
library(ggplot2)
library(devtools)
library(dplyr)
library(stringr)
#install.packages("maps")
library(maps)
#install.packages("mapdata")
library(mapdata)
# install.packages("ggmap")
library(ggmap)

# if necessary, install the following library
#devtools::install_github("dkahle/ggmap")
usa <- map_data("usa")
dim(usa)
head(usa)


tail(usa)


w2hr <- map_data("world2Hires")
#library(maps)

dim(w2hr)
head(w2hr)
tail(w2hr)

# build a filled-in map of usa
usa <- map_data("usa") # we already did this, but we can do it again
ggplot() + geom_polygon(data = usa, aes(x=long, y = lat, group = group)) +  coord_fixed(1.3)

# build in a line drawing of map
ggplot() + geom_polygon(data = usa, aes(x=long, y = lat, group = group), fill = NA, color = "red") + coord_fixed(1.3)

# add some colour to map
gg1 <- ggplot() + geom_polygon(data = usa, aes(x=long, y = lat, group = group), fill = "violet", color = "blue") + coord_fixed(1.3)

#make the plot
gg1


# Add some points to the map: first load data.frame() function containing points, and then load plotting code below
labs <- data.frame(
  long = c(-122.064873, -122.306417,-80.182403,-80.182403),
  lat = c(36.951968, 47.644855,41.6487607,41.6487607),
  names = c("SWFSC-FED", "NWFSC"),
  stringsAsFactors = FALSE
)  

gg1 + geom_point(data = labs, aes(x = long, y = lat), color = "black", size = 5) + geom_point(data = labs, aes(x = long, y = lat), color = "yellow", size = 4)


# put only Meadville on the map
meadville <- data.frame(
  long = c(-80.182403),
  lat = c(41.6487607),
  names = c("SWFSC-FED", "NWFSC"),
  stringsAsFactors = FALSE
)  

gg1 + geom_point(data = meadville, aes(x = long, y = lat), color = "black", size = 5) + geom_point(data = meadville, aes(x = long, y = lat), color = "yellow", size = 4)



# Plot California

ca_df <- subset(states, region == "california")
head(ca_df)
counties <- map_data("county")




########################
# PA
# Plot Pennsylvania


states <- map_data("state")
dim(states)
head(states)

tail(states)

ca_df <- subset(states, region == "pennsylvania")

head(ca_df)

# Now, let’s also get the county lines there
counties <- map_data("county")


# Pennsylvania
ca_county <- subset(counties, region == "pennsylvania")

head(ca_county)

ca_base <- ggplot(data = ca_df, mapping = aes(x = long, y = lat, group = group)) +  coord_fixed(1.3) + geom_polygon(color = "black", fill = "gray")

ca_base + theme_nothing()

# plot the boundaries
ca_base + theme_nothing() + geom_polygon(data = ca_county, fill = NA, color = "white") + geom_polygon(color = "black", fill = NA)  # get the state border back on top

# Put Meadville on the map
meadville <- data.frame(
  long = c(-80.182403),
  lat = c(41.6487607),
  names = c("SWFSC-FED", "NWFSC"),
  stringsAsFactors = FALSE)  


#plot state with meadville
ca_base + theme_nothing() + geom_polygon(data = ca_county, fill = NA, color = "white") + geom_polygon(color = "black", fill = NA)  + geom_point(data = meadville, mapping = aes(x = long, y = lat), inherit.aes = FALSE, color = "red")

ca_base + theme_nothing() + geom_polygon(data = ca_county, fill = NA, color = "white") + geom_polygon(color = "black", fill = NA)  + geom_point(data = meadville, mapping = aes(x = long, y = lat), inherit.aes = FALSE, color = "blue", size = 5) +  geom_point(data = meadville, mapping = aes(x = long, y = lat), inherit.aes = FALSE, color = "yellow", size = 4)


# state maps


ggplot(data = states) + geom_polygon(aes(x = long, y = lat, fill = region, group = group), color = "white") + coord_fixed(1.3) + guides(fill=FALSE)  # do this to leave off the color legend

#map of the west coast
west_coast <- subset(states, region %in% c("california", "oregon", "washington"))

ggplot(data = west_coast) + 
  geom_polygon(aes(x = long, y = lat), fill = "palegreen", color = "black") 

ggplot(data = west_coast) + 
  geom_polygon(aes(x = long, y = lat, group = group), fill = "palegreen", color = "black") + 
  coord_fixed(1.3)

