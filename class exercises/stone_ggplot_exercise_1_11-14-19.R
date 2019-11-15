#ggplot exercise Day 1
#EEOB590

#We will use the forest trajectory dataset to make some graphs. These are from 25m transects conducted across three islands within 4 different forest types. We measured a bunch of things along each transect, so the dataframe is relatively complex. Be sure to use the ggplot_tutorial.R script to help you with this exercise. 

#Load libraries
library(tidyverse)
library(ggplot2)
library(ggthemes)

#Load data
foresttraj <- read.csv("data/tidy/foresttrajectory_site_tidy.csv")

#1) Replicate the figure in the graphics folder called spprich.adult.pdf. 

ggplot(foresttraj, aes(x = forest.type, y = num.adult.spp, fill=island)) +
  geom_boxplot()+
  theme_classic()+
  labs(x= "Forest Type", y="Species richness - adult trees")+
scale_fill_brewer(palette = "Blues", labels=c("Guam", "Rota", "Saipan"))+
scale_x_discrete(labels=c("Leucaena Thicket", "Mixed introduced forest", "Native limestone forest", "Shrub-Shrub"))
      

#2) Now, make a figure based on model output from the model below. The final figure should look like the one called num.adult.trees.pdf. Be sure to use the code in the ggplot_tutoria file for this. 

m1 <- glm(num.adults ~ island, data=foresttraj, family=poisson)

ggplot(m1, aes(x=island, y=))+
  geom_point(size=4)+
  geom_rangeframe(data=data.frame(x=c(1,4), y=c(0, 1)), aes(x, y))+
  scale_y_continuous(limits=c(0,1), "Proportion seeds without flesh") +
  scale_x_discrete("", labels=c("Rota", "Saipan", "Tinian"))+
  geom_errorbar(aes(ymin = plo, ymax = phi), width=0.2, size=0.5)+
  annotate("text", label = "a", x = 0.65, y = 1.00, size=3, fontface="bold")+
  theme_bw()+
  theme(axis.line = element_line(colour = "black"),
        axis.text.x=element_text(),
        axis.title.x=element_text(),
        axis.title.y=element_text(size=9, face="bold"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(),
        plot.margin = unit(c(1,1,1,1), units="lines"))

#3) Come up with a cool way to visualize the relationship between the number of adult species and the number of seedling species across the islands and forest types. 


#4) Find a cool graphical approach from the websites below, then create a graph of that type using data from the foresttraj dataset 
# http://www.r-graph-gallery.com/ 
# http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html 


