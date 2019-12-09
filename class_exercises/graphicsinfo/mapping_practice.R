#---
# Script for making simple maps in R 
# For EEOB 590A course, Fall 2019
# by Robert Johnson
#---


# load packages
library(tidyverse)   # the entire tidyverse (includes ggplot2)
library(maps)        # map data
library(mapdata)     # additional hi-res map data


# view maps contained in packages 
help(package="maps")
help(package="mapdata")



# create Italy as an object to use for mapping
# this creates a data frame of map data for use with ggplot()
italy = map_data("italy")


#---
# Practice plotting
#---

# Plot a map of Italy
windows()
ggplot() +
   # add the map layer
   # must group by "group" within aes()!!
   geom_polygon(data = italy,
                aes(x = long, y = lat, group = group)) +
   # scale lat and long correctly regardless of panel/window size
   coord_quickmap() +
   # remove background colors and grid lines
   theme_classic()


# Change lines and colors on the map
windows()
ggplot() +
   geom_polygon(data = italy,
                aes(x = long, y = lat, group = group),
                # color changes the borders around areas on a map
                color = "gray60") +
   coord_quickmap() +
   theme_classic()


windows()
ggplot() +
   geom_polygon(data = italy,
                aes(x = long, y = lat, group = group),
                # fill changes the color of a mapped area
                fill = "gray60") +
   coord_quickmap() +
   theme_classic()


# Change the x and y limits to zoom on one part of the map
# Let's zoom in on the island of Sardegna
windows()
ggplot() +
   geom_polygon(data = italy,
                aes(x = long, y = lat, group = group),
                fill = "gray60") +
   # change x and y limits for viewing
   coord_quickmap(xlim = c(7.5, 11), 
                  ylim = c(38, 42)) +
   theme_classic()


#---
# Add some data to the map
#---

# Call in the practice data set
sites = read_csv("example_data.csv")


# Add data points to the map of Italy
windows()
ggplot() +
   geom_polygon(data = italy,
                aes(x = long, y = lat, group = group),
                fill = "gray60") +
   coord_quickmap() +
   # add the points
   geom_point(data = sites,
              aes(x = long, y = lat),
              size=3) +
   theme_classic()


# Color data points by location
windows()
ggplot() +
   geom_polygon(data = italy,
                aes(x = long, y = lat, group = group),
                fill = "gray60") +
   coord_quickmap() +
   geom_point(data = sites,
              aes(x = long, y = lat, color = location),
              size=3) +
   theme_classic()


