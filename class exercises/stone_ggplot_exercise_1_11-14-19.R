#ggplot exercise Day 1
#EEOB590

#We will use the forest trajectory dataset to make some graphs. These are from 25m transects conducted across three islands within 4 different forest types. We measured a bunch of things along each transect, so the dataframe is relatively complex. Be sure to use the ggplot_tutorial.R script to help you with this exercise. 

#Load libraries
library(tidyverse)
library(ggplot2)
library(ggthemes)
library(ggridges)

#Load data
foresttraj <- read.csv("class exercises/class data tidy/foresttrajectory_site_tidy.csv")

#1) Replicate the figure in the graphics folder called spprich.adult.pdf. 

ggplot(foresttraj, aes(x = forest.type, y = num.adult.spp, fill=island)) +
  geom_boxplot()+
  theme_classic()+
  labs(x= "Forest Type", y="Species richness - adult trees")+
scale_fill_brewer(palette = "Blues", labels=c("Guam", "Rota", "Saipan"))+
scale_x_discrete(labels=c("Leucaena Thicket", "Mixed introduced forest", "Native limestone forest", "Shrub-Shrub"))
      

#2) Now, make a figure based on model output from the model below. The final figure should look like the one called num.adult.trees.pdf. Be sure to use the code in the ggplot_tutoria file for this. 

m1 <- glm(num.adults ~ island, data=foresttraj, family=poisson)
  

#FIRST: Add error bars --- create dataframe over which to predict model results
preddata <- with(foresttraj, expand.grid(island = levels(island)))

#predict model results
preddata2 <- as.data.frame(predict(m1, newdata=preddata, type="link", se.fit=TRUE))
preddata2<-cbind(preddata, preddata2)

#calculate upper and lower CI's
preddata2 <- within(preddata2, {
  pred <- exp(fit)
  lwr <- exp(fit - (1.96 * se.fit))
  upr <- exp(fit + (1.96 * se.fit))
})

ggplot(preddata2, aes(island, pred))+
  geom_point()+
  geom_errorbar(aes(ymin=lwr, ymax=upr), width=0.2)+
theme_classic()+
  scale_y_continuous("Number of Adult Trees per Transect") +
  scale_x_discrete("Island", labels=c("Guam", "Rota", "Saipan"))

  

#3) Come up with a cool way to visualize the relationship between the number of adult species and the number of seedling species across the islands and forest types. 
ggplot(foresttraj, aes(x = num.adult.spp, y = num.seedling.spp, color =island))+
  geom_point()+
  facet_grid(.~forest.type)+
theme_minimal()+
  scale_x_continuous("Number of Adult Trees per Transect") +
  scale_y_continuous("Number of Seedling Species") +
  scale_colour_brewer(palette = "Dark2", labels = c("Guam", "Rota", "Saipan"), name = "Island")



#4) Find a cool graphical approach from the websites below, then create a graph of that type using data from the foresttraj dataset 
# http://www.r-graph-gallery.com/ 
# http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html 



ggplot(foresttraj, aes(x = num.adult.spp, y = forest.type, fill = island)) +
  geom_density_ridges(alpha=0.4) +
  theme_ridges() + 
  theme(legend.position = "none")+
scale_y_discrete("Forest Type", labels = c("Scrub Shrub", "Native Limestone", "Mixed Introduced", "Leucaena Thicket")) +
  scale_x_continuous("Number of Adult Species") 