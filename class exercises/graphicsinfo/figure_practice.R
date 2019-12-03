#---
# Script for changing visual aesthetics of figures with ggplot2
# For EEOB 590A course, Fall 2019
# by Robert Johnson
#---


# This script is meant as a continuation of the "mapping_practice.R" script
# This script will demonstrate various functions and ways to control different
# visual aspects of your ggplot figures. 


# load packages
library(tidyverse)   # the entire tidyverse (includes ggplot2)
library(cowplot)     # package for combining figures
library(maps)        # map data
library(mapdata)     # additional hi-res map data


#---
# Italy map
italy = map_data("italy")

# data
sites = read_csv("class exercises/graphicsinfo/example_data.csv")
#---


# Manually change colors used for data point locations
windows()
ggplot() +
   # map
   geom_polygon(data = italy,
                aes(x = long, y = lat, group = group),
                fill = "gray60") +
   coord_quickmap() +
   # data points
   geom_point(data = sites,
              aes(x = long, y = lat, color = location),
              size=3) +
   # use a manual scale to specify your own options
   # the scale to use is based upon the aesthetic your set in the geom
   scale_color_manual(breaks = c("Italy", "Sardegna", "Sicilia"),
                      values = c("firebrick2", "seagreen3", "dodgerblue4")) +
   theme_classic()


# Manually change symbols used for data point locations
windows()
ggplot() +
   # map
   geom_polygon(data = italy,
                aes(x = long, y = lat, group = group),
                fill = "gray60") +
   coord_quickmap() +
   # data points
   geom_point(data = sites,
              aes(x = long, y = lat, shape = location),
              size=3) +
   # use a manual scale to specify your own options
   # the scale to use is based upon the aesthetic your set in the geom
   scale_shape_manual(breaks = c("Italy", "Sardegna", "Sicilia"),
                      values = c(21, 17, 19)) +
   theme_classic()


# Change aspects of the legend 
windows()
ggplot() +
   # map
   geom_polygon(data = italy,
                aes(x = long, y = lat, group = group),
                fill = "gray60") +
   coord_quickmap() +
   # data points
   geom_point(data = sites,
              aes(x = long, y = lat, color = location),
              size=3) +
   # manual scale
   scale_color_manual(breaks = c("Italy", "Sardegna", "Sicilia"),
                      values = c("firebrick2", "seagreen3", "dodgerblue4"),
                      # change the name of the legend
                      name = "Region",
                      # change the name of the individual labels
                      labels = c("italy", "sardinia", "sicily")) +
   theme_classic()


# Color the data points by their value rather than location
windows()
ggplot() +
   # map
   geom_polygon(data = italy,
                aes(x = long, y = lat, group = group),
                fill = "gray60") +
   coord_quickmap() +
   # data points
   geom_point(data = sites,
              aes(x = long, y = lat, color = value),
              size=3) +
   theme_classic()


# Manually alter the color gradient
windows()
ggplot() +
   # map
   geom_polygon(data = italy,
                aes(x = long, y = lat, group = group),
                fill = "gray60") +
   coord_quickmap() +
   # data points
   geom_point(data = sites,
              aes(x = long, y = lat, color = value),
              size=3) +
   # manual color gradient
   scale_color_gradient(breaks = c(0, 25, 50),
                        limits = c(0, 50),
                        low = "firebrick2", high = "dodgerblue4",
                        name = "Tree density") +
   theme_classic()


#---
# Changing visual aspects of plots
#---

### Display of information (data or text)
# "geom_", "scale_", "labs()"

### Visual aesthetics of non-data components
# theme()

### Adding non-data components to the plotting area
# annotate()


###
# Create a map of Italy, with data points, for which we will change/add components
p1 = ggplot() +
   # map
   geom_polygon(data = italy,
                aes(x = long, y = lat, group = group),
                fill = "gray60") +
   coord_quickmap() +
   # data points
   geom_point(data = sites,
              aes(x = long, y = lat, color = value),
              size=3) +
   # manual color gradient
   scale_color_gradient(breaks = c(0, 25, 50),
                        limits = c(0, 50),
                        low = "firebrick2", high = "dodgerblue4",
                        name = "Tree density") +
   theme_classic()
###


# 
windows()
p1 +
   # axis labels
   labs(x = "Longitude",
        y = "Latitude") +
   # axis tick mark placement
   scale_x_continuous(breaks = seq(8, 18, 2)) +
   scale_y_continuous(breaks = seq(35, 47, 2)) +
   # visual aspects of non-data components
   theme(panel.border = element_rect(fill=NA, color="black"),   # add a rectangle around the plotting area
         # increase the size of axis labels
         axis.title = element_text(size=12),
         # make x-axis bold and add some padding
         axis.title.x = element_text(face="bold", margin = margin(t=0.5, b=0, r=0, l=0, unit="line")),
         # increase size of y-axis tick labels
         axis.text.y = element_text(size=15),
         # increase size of x-axis tick marks
         axis.ticks.length.x = unit(3, "mm")
   )


# Add a non-data element to the plotting region
windows()
p1 +
   # add text labels to the map
   annotate("text", x = 9, y = 38,
            label = "Sardegna", fontface="italic") +
   annotate("text", x = 14, y = 36,
            label = "Sicilia", fontface="bold") +
   # add lines to the map
   annotate("segment", x = 8, xend = 15, y = 43, yend = 45, size=2) +
   # add a box around Sardegna
   annotate("rect", xmin = 8, xmax = 10, ymin = 38.5, ymax = 41.5,
            color="black", fill=NA)


#---
# Making multipanel figures


#---

# the 'cowplot' package adds functions to plot multiple figures together

# first make two figures

# Map of Italy
map_italy =
   ggplot() +
   geom_polygon(data = italy,
                aes(x = long, y = lat, group = group),
                color = "cornflowerblue", fill = "gray60") +
   coord_quickmap() +
   theme_classic() +
   theme(panel.border = element_rect(fill = NA, color = "black"))

# Map of France
france = map_data("france")
map_france = 
   ggplot() +
   geom_polygon(data = france,
                aes(x = long, y = lat, group = group),
                color = "cornflowerblue", fill = "gray60") +
   coord_quickmap() +
   theme_classic() +
   theme(panel.border = element_rect(fill = NA, color = "black"))


# combine the figures
windows(height=4, width=8)
plot_grid(map_italy, map_france,
          # add subplot labels to the upperleft corners
          labels = "auto")


#---
# Adding a figure inset
#---

# functions also from the 'cowplot' package

windows()
# add a drawing layer to a plot region
ggdraw(map_italy) +
   # add the second plot on top of the first
   # all values are a proportion (0 to 1) of the plotting canvas
   draw_plot(map_france, x = 0.2, y = 0.05, height = 0.3, width = 0.3)

