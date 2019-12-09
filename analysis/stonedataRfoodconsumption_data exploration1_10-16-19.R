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

#Report was interesting but not particularly helpful because I need to subset my data further.- there are no missing values

ggplot(usfoodconsumption, aes(foodtype, avgconsum))+
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


foodawayhome <- usfoodconsumption %>%
  filter(athomeawayfromhome == "afh")


foodathome <- usfoodconsumption %>%
  filter(athomeawayfromhome == "fah")

##I am now subsetting my data because food at home and the food eaten out need to be analyzed seperately. There is too much variation and it would be useful to look at one at a time.


ggplot(foodathome, aes(foodtype, avgconsum))+
  geom_boxplot()

#This box plot shows that the average consumption US citizen consumption does not vary much from year to year for food eaten at home. Dairy is the most lb per year fruit and vegetables which are of great interest are tied just above 100 lb. grains and meat are close behind at about 85 and 90 lb respectively.

ggplot(foodawayhome, aes(foodtype, avgconsum))+
  geom_boxplot()

#Food eaten out varies more year to year by food category that food eaten at home


top5foodtypes <- foodathome %>%
  group_by(foodtype) %>%
  arrange(desc(avgconsum)) %>%
  top_n(5, avgconsum) 

#This wasn't actually useful for this data set but I was curious about it as a sorting tool


  ggplot(data=foodathome) + geom_point(aes(x=year,y= avgconsum,size=10, color = "blue")) + 
  geom_point(aes(x=year,y= loincomeavg,size=10, color = "red")) + 
  geom_point(aes(x=year ,y= hiincomeavg,size=10, color = "green")) 
 
#Compare low, average and high income consumption, it is difficult to make any conclusions because I will need to seperate them by food types which vary widely before I can see the influence of income level. From a birds eye view, the income levels appear to be grouped very closely, there is not a wide variation.

ggplot(foodathome, aes(x = year, y = avgconsum))+
  geom_histogram()


ggplot(data = foodathome, mapping = aes(x = "year", y = (loincomeavg, hiincomeavg, avgconsum), color = foodtype)) +
  geom_dotplot()

ggplot(data = foodathome, mapping = aes(x = loincomeavg, y = )) +
  geom_point(na.rm = TRUE)

