###PART 3:  Simulated Vegetable Data Graphing

library(tidyverse)
library(ggplot2)
library(ggthemes)
library(ggridges)


#The mean is slightly above 100 lb vegetables per year and the low income samples eat less vegetables on average, whereas the high income eat a little more vegetables per year though differences are not statistically significant and could be due to random variation. There is not a significant difference in vegetable consumption from year to year either. A slight trend upwards might come to light if more years were tracked.

vegsim <- read.csv(vegsim,"data/tidydata/vegsim.csv")
#Look at response
ggplot(vegsim, aes(year, simveg))+
  geom_boxplot()

ggplot(vegsim, aes(incomelevel, simveg))+
  geom_boxplot()

#Graph vegetable consumption by 

vegsimgraph1 <- ggplot(vegsim, aes(x = simveg, y = year, fill = incomelevel)) +
  geom_density_ridges(alpha=0.5) +
  theme_ridges() 
scale_y_discrete("Year", labels = c("1994-1998", "2003-2004", "2005-2006", "2007-2008")) +
  scale_x_continuous("US Vegetable Consumption (lbs/year)") 


#scale_fill_manual(name = "Income Levels",
#labels = c("High Income", "Low Income", "Average Food Consumption")
?ggsave     
ggsave(plot= vegsimgraph1, filename= "graphics/ridgessimdatagraph1.jpg")

