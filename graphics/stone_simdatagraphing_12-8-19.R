# Tiffanie Stone - Simulated Data 

###PART 4:  Simulated Vegetable Data Graphing

library(tidyverse)
library(ggplot2)
library(ggthemes)
library(ggridges)
library(dplyr)
library(forcats)
library(hrbrthemes)
library(viridis)


#The mean is slightly above 100 lb vegetables per year and the low income samples eat less vegetables on average, whereas the high income eat a little more vegetables per year though differences are not statistically significant and could be due to random variation. There is not a significant difference in vegetable consumption from year to year either. A trend might come to light if more years were tracked.

vegsim <- read.csv("data/tidydata/vegsim.csv")


#Graph vegetable consumption by year and income level

vegsimgraph1 <- ggplot(vegsim, aes(x = simveg, y = year, fill = incomelevel)) +
  geom_density_ridges(alpha=0.5) +
  theme_ridges() +
scale_y_discrete("Year", labels = c("1994-1998", "2003-2004", "2005-2006", "2007-2008")) +
scale_x_continuous("US Vegetable Consumption (lbs/year)") 


ggsave(plot= vegsimgraph1, filename= "graphics/ridgessimdatagraph1.jpg")


# Graph 2 - Vegetable Consumption side-by-side comparison
vegsimgraph2 <- vegsim %>%
ggplot(aes(fill= incomelevel, y=simveg, x=year)) + 
  geom_violin(position="dodge", alpha=0.5, outlier.colour="transparent") +
  scale_fill_viridis(discrete=T, name="") +
  theme_ipsum()  +
  xlab("Year") +
  ylab("Vegetable Consumption (lbs / year)") +
  ylim(0,200)


ggsave(plot= vegsimgraph2, filename= "graphics/violinsimdatagraph2.jpg")


#Graph 3 - Scatterplot, not as good of a graph
simgraph3 <- ggplot(vegsim, aes(incomelevel, simveg, colour = year)) +
  geom_point(position = "jitter") + 
  xlab("Income Levels") + 
  ylab("Vegetable Consumption (lbs/year)")+
theme_classic()


ggsave(plot= simgraph3, filename= "graphics/scatterplotsimdatagraph3.jpg")


simgraph4 <- vegsim %>%
  ggplot( aes(x=year, y=simveg, fill=incomelevel)) +
  geom_boxplot() +
  scale_fill_viridis(discrete = TRUE, alpha=0.6) +
  theme_ipsum() +
  theme(
    plot.title = element_text(size=11)
  ) +
  ggtitle("Food Consumption By Year") +
  xlab("Years")+
  ylab("Vegetable Consumption (lbs/year)")

ggsave(plot= simgraph4, filename= "graphics/scatterplotsimdatagraph4.jpg")

