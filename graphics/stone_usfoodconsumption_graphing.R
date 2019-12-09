###Tiffanie Stone R EEOB590A - Dataset for Analysis
# Repository: Uploading US Food Consumption Data from 1994 - 2008
# The purpose is to upload this national data set which will be used to find trends in food consumption over time and across low and high income groups of people. 

#This information will form a baseline for US food consumption as we explore food system sustainability in Des Moines
library(tidyverse)
library(ggplot2)
library(ggthemes)
library(ggridges)
library(DataExplorer)
library(skimr)
library(forcats)

#Import Wrangled Data
usfoodconsumption <- read_csv('data/tidydata/wrangledusconsump.csv')

usfoodconsumption <- usfoodconsumption %>%
  mutate_at(vars(foodtype, years, foodhomeawayhome, incomelevels), 
            factor)
levels(usfoodconsumption$foodtype)
levels(usfoodconsumption$incomelevels)


## Part 3: Graphics ---- 

#Here I compare low, average and high income food consumption, across food types and years  The income levels appear to be grouped very closely, there is not a wide variation. High income is slightly higher for meat, and low income is slightly higher for vegetables, dairy and fruit. This is a surprising result. Expected to see lower amounts of fruit and vegetable consumption for low income.

ggplot(usfoodconsumption, aes(x = avgconsumption, y = foodtype, fill = incomelevels)) +
  geom_density_ridges(alpha=0.5) +
  theme_ridges() +
  scale_y_discrete("Food Type", labels = c("Dairy", "Fruit", "Grain", "Meat", "Oil", "Vegetables")) +
  scale_x_continuous("Average US Vegetable Consumption in lb") 

#This chart is not complete but it helps me see the groupings of high income, low income and average consumption by food type


ggplot(data=usfoodconsumption) + geom_point(aes(x=years,y= avgconsumption, color = incomelevels)) + 
  geom_point(aes(x=years,y= lowconfidenceinterval, color = "red")) + 
  geom_point(aes(x=years ,y= highconfidenceinterval, color = "green")) 


# Oil decreased in 2007-2008 compared to all other years. Fruits and Vegetables both were trending up whereas grain, meat and dairy stayed relatively the same.

ggplot(usfoodconsumption, aes(x = avgconsumption, y = years, fill = foodtype)) +
  geom_density_ridges(alpha=0.5) +
  theme_ridges() +
  scale_y_discrete("Year", labels = c("1994-1998", "2003-2004", "2005-2006", "2007-2008")) +
  scale_x_continuous("Average US Vegetable Consumption") 


#This graph helps to visualize the food groups


ggplot(usfoodconsumption, aes(avgconsumption, incomelevels)) + 
  geom_point()+
  facet_grid(rows = vars(foodtype))

