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


#Part 1: Import Wrangled Data --------
##See data wrangling file in project folder.


getwd()
usfoodconsumption <- read_csv('data/tidydata/wrangledusconsump.csv')

usfoodconsumption <- usfoodconsumption %>%
  mutate_at(vars(foodtype, years, foodhomeawayhome, incomelevels), 
            factor)
levels(usfoodconsumption$foodtype)
levels(usfoodconsumption$incomelevels)


#Part 2: Data Exploration -------


skim(usfoodconsumption)
#no missing data each has 48 values associated with it.numbers range between 14.29 (perhaps lb of oil per year) to 180.35 lb which is a reasonable range of data points.

create_report(usfoodconsumption)

#Report was interesting but not particularly helpful because I need to subset my data further.

ggplot(usfoodconsumption, aes(foodtype, meanus))+
  geom_boxplot()

#Wide variation is due to including both food at home and food away from home in box plot. Dairy, fruit and vegetables have more variation that meat, grains and oil do in the food at home when compared to food eaten out.


ggplot(usfoodconsumption, aes(year,avgconsum))+
  geom_boxplot()
#Checking for patterns across time

# This is to be expected - people ate about the same amount from year to year on average.


ggplot(usfoodconsumption, aes(avgconsum,loincomeavg, hiincomeavg, color=foodtype))+
  geom_point()

#Checking for outliers


 


