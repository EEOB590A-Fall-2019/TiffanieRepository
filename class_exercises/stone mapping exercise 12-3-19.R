#---
# Tiffanie Stone 
# Simple Map in R
# 11-27-2019
#---

# load packages
library(tidyverse)   # the entire tidyverse (includes ggplot2)
library(maps)        # map data
library(mapdata)     # additional hi-res map data


# view maps contained in packages 
help(package="maps")
help(package="mapdata")

# this creates a data frame of map data for use with ggplot()

usmap = map_data("stateMapEnv")	#United States State Boundaries Map

map('state', fill = TRUE, col = palette())

#Plot map
states <- map_data("state")
dim(states)
head(states)
tail(states)

ggplot(data = states) +
  geom_polygon(aes(x = long, y = lat, fill = region, group = group), color = "white") +
  coord_fixed(1.3) +
  guides(fill=FALSE) 

# Map of midwest - study region 
midwest <- subset(states, region %in% c("minnesota", "wisconsin", "iowa", "illinois","indiana"))

ggplot(data = midwest) +
  geom_polygon(aes(x = long, y = lat, group = group), fill = "grey", color = "black") +
  coord_fixed(1.3)

ia_df <- subset(states, region == "iowa")

head(ia_df)

counties <- map_data("county")
ia_county <- subset(counties, region == "iowa")

head(ia_county)

# Iowa map with county borders 
iamap <-  ggplot(data = ia_df, mapping = aes(x = long, y = lat, group = group)) +
  coord_fixed(1.3) +
  geom_polygon(color = "black", fill = "gray") +
  geom_polygon(data = ia_county, fill = NA, color = "white") +
geom_polygon(color = "black", fill = NA) 


single_county <- subset(ia_story, subregion=="iowa")
  
  
  