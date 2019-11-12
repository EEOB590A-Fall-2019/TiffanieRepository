###Tiffanie Stone R EEOB590A - Dataset for Analysis
# Repository: Uploading US Food Consumption Data from 1994 - 2008
# The purpose is to upload this national data set which will be used to find trends in food consumption over time and across low and high income groups of people. 

#This information will form a baseline for US food consumption as we explore food system sustainability in Des Moines


#Part 1: Data Import 

library(readxl)
getwd()

usfoodconsumption <- read_excel('data/tidydata/foodconsumptionRdata.xlsx', skip = 1)
# Read in file, named columns, set column data types to options available with read_excel function. Still need to convert some to factors.

usfoodconsumption$foodtype <- as.factor(usfoodconsumption$foodtype)
usfoodconsumption$years <- as.factor(usfoodconsumption$years)
usfoodconsumption$'fah/afh' <- as.factor(usfoodconsumption$'fah/afh')
# Changed text to factors because they are all categorical factors.


# The data is now imported and able to be used for further data analysis
#See data wrangling file in project folder. Tidy data is ready for data exploration

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

#This chart is not complete but it helps me see the groupings of high income, low income and average consumption by food type


  ggplot(data=foodathome) + geom_point(aes(x=year,y= avgconsum,size=10, color = "blue")) + 
  geom_point(aes(x=year,y= loincomeavg,size=10, color = "red")) + 
  geom_point(aes(x=year ,y= hiincomeavg,size=10, color = "green")) 
 
#Here I am trying to compare low, average and high income consumption, it is difficult to make any conclusions because I will need to seperate them by food types which vary widely before I can see the influence of income level. From a birds eye view, the income levels appear to be grouped very closely, there is not a wide variation.

  
  ### Key Question: How do I make a chart that can usefully compare the information in 3 column - low income, high income and average income graphing by food category to  be able to visualize the spread.

  #I am still working with the graphs below - they are not running properly and I am not able to answer any important questions with them yet.
  ggplot(foodathome, aes(x = year, y = avgconsum))+
  geom_histogram()


ggplot(data = foodathome, mapping = aes(x = "year", y = (meanlincome, meanhincome, meanus), color = foodtype)) +
  geom_dotplot()
facet_grid(foodtype~ year, scales="free_y")

ggplot(data = foodathome, mapping = aes(x = loincomeavg, y = )) +
  geom_point(na.rm = TRUE)


ggplot()
facet_grid(foodtype~ year, scales="free_y" )

