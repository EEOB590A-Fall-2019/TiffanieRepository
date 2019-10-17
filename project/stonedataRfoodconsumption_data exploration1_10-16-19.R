# Repository: Uploading US Food Consumption Data from 1994 - 2008
# The purpose is to upload this national data set which will be used to find trends in food consumption over time and across low and high income groups of people. 
#This information will form a baseline for US food consumption as we explore food system sustainability in Des Moines.

#Part 1: Data Import 

library(readxl)
getwd()


usfoodconsumption <- read_excel('C:/Users/tiffa/OneDrive/Documents/R/Repository/project/tidydata/foodconsumptionRdata.xlsx', col_names = c("foodtype", "year", "athomeawayfromhome", "avgconsum", "avgconsumloconf", "avgconsumhiconf", "loincomeloconf", "loincomeavg", "loincomehiconf", "hincomeloconf", "hiincomeavg", "hiincomehiconf"), col_types = c("text", "text", "text", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), skip = 2)
# Read in file, named columns, set column data types to options available with read_excel function. Still need to convert some to factors.

usfoodconsumption$foodtype <- as.factor(usfoodconsumption$foodtype)
usfoodconsumption$year <- as.factor(usfoodconsumption$year)
usfoodconsumption$athomeawayfromhome <- as.factor(usfoodconsumption$athomeawayfromhome)
# Changed text to factors because they are all categorical factors.

# The data is now imported and able to be used for further data analysis
#Data Wrangling is complete - See data wrangling file in project folder. Tidy data is ready for data exploration

#Part 2: Data Exploration -- 


library(tidyverse)
library(ggplot2)
library(DataExplorer)
library(skimr)
library(forcats)

skim(usfoodconsumption)
#no missing data each has 48 values associated with it.numbers range between 14.29 (perhaps lb of oil per year) to 180.35 lb which is a reasonable range of data points.

create_report(usfoodconsumption)

#Report was interesting but not particularly helpful because I need to subset my data further.

ggplot(usfoodconsumption, aes(foodtype, avgconsum))+
  geom_boxplot()

#Wide variation is due to including both food at home and food away from home in box plot. Dairy, fruit and vegetables have more variation that meat, grains and oil do in the food at home when compared to food eaten out.
view("athomeawayfromhome")

ggplot(usfoodconsumption, aes("year", avgconsum))+
  geom_bar()
#ERROR - MUST NOT BE USED WITH Y AESTHETIC? (WHY?)

#Checking for outliers

ggplot(usfoodconsumption, aes(avgconsum,loincomeavg, hiincomeavg, color=foodtype))+
  geom_point()

#This is not chart is not complet but it helps me see the groupings of high income, low income and average consumption by food type - Next time I want to do side by side histograms to give me an even stronger comparison


#Checking for patterns across time (no sites variation)

foodawayhome <- usfoodconsumption %>%
  filter ("athomeawayfromhome" == "afh") 

foodathome <- usfoodconsumption %>%
  filter(fahafh == "fah")


ggplot(foodathome, mapping = aes(x = foodtype)) +
  geom_freqpoly()

ggplot(foodathome, aes(foodtype, avgconsum))+
  geom_boxplot()

#This box plot shows that the average consumption US citizen consumption does not vary much from year to year for food eaten at home. Dairy is the most lb per year fruit and vegetables which are of great interest are tied just above 100 lb. grains and meat are close behind at about 85 and 90 lb respectively.

foodawayhome <- usfoodconsumption %>%
  filter("fahafh" =="afh")
nrow(foodawayhome)

#I am now subsetting my data because food at home and the food eaten out need to be analyzed seperately. There is too much variation and it would be useful to look at one at a time.

top6orders <- poll %>%
  group_by(insectorder) %>%
  summarize(totalins = sum(numinsects, na.rm=T)) %>%
  arrange(desc(totalins)) %>%
  top_n(6, totalins)  #this is a new function but it's cool. 


ggplot(foodathome, aes(foodtype, avgconsum))+
  geom_boxplot()




