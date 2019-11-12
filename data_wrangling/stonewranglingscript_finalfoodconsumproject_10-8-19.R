# Tiffanie Stone
# Data Wrangling Script for US Food Consumption Data from 1994 - 2008
# The purpose is to use this national data set to find trends in food consumption over time and across low and high income groups of people. 
#This information will form a baseline for US food consumption as we explore food system development in Des Moines.

library("tidyverse")
library("lubridate")
library("readxl")
library("forcats")
getwd()


usfoodconsumption <- read_excel('data/tidydata/foodconsumptionRdata.xlsx', skip = 1)
# Read in file, named columns, set column data types to options available with read_excel function. Still need to convert some to factors.

usfoodconsumption$foodtype <- as.factor(usfoodconsumption$foodtype)
usfoodconsumption$years <- as.factor(usfoodconsumption$years)
usfoodconsumption$'fah/afh' <- as.factor(usfoodconsumption$'fah/afh')
# Changed text to factors because they are all categorical factors.

# The data is now imported and ready to be Wrangled

# Wrangling: First Explore
str(usfoodconsumption)


## Step 1: Fix cells within columns (e.g. naming, capitalization) #####
summary(usfoodconsumption)
#need to fix capitalization, spelling, whitespace? --- Not necessary Data looks clean ---


#1.1:Check levels within a column are lower case. 
# Use levels & tolower which changes character vector, so would need to mutate back to factor.

names(usfoodconsumption)[3]<-"foodhomeawayhome"

#All columns and levels are lower case -- changed name of column three for clarity - it differenciates food consumed at home and food consumed away from home.


###4) Print tidy, wrangled database

write.csv(usfoodconsumption, "data/tidydata/usfoodsconsumption_tidy_clean.csv", row.names = F)

########################################################################
#Part 3: Subsetting and grouping

#2) Subset data (filter, select)
#use filter to extract rows according to some category

foodawayhome <- usfoodconsumption %>%
  filter(`foodhomeawayhome` == "afh")


foodathome <- usfoodconsumption %>%
  filter(`foodhomeawayhome` == "fah")

##I am now subsetting my data because food at home and the food eaten out need to be analyzed seperately. There is too much variation and it would be useful to look at one at a time.


ggplot(foodathome, aes(foodtype, meanus))+
  geom_boxplot()

#This box plot shows that the average consumption US citizen consumption does not vary much from year to year for food eaten at home. Dairy is the most lb per year fruit and vegetables which are of great interest are tied just above 100 lb. grains and meat are close behind at about 85 and 90 lb respectively.

ggplot(foodawayhome, aes(foodtype, meanus))+
  geom_boxplot()

#Food eaten out varies more year to year by food category that food eaten at home


#3) Summarize data (summarise, count) #################
#use summarize to compute a table using whatever summary function you want (e.g. mean, length, max, min, sd, var, sum, n_distinct, n, median)

#use count to count the number of rows in each group

foodathome %>%
  count(foodhomeawayhome)  #piping approach


##### 4 Group data (group_by) ################
#use group_by to split a dataframe into different groups -- I want to make this wide data set long by combining the columns together making the income category (low, mean, high) a row


olddata_wide$subject <- factor(olddata_wide$subject)  


foodathome <- foodathome[c("foodtype", "years", "foodhomeawayhome", "meanus", "meanlincome", "meanhincome", "lowus", "upus", "lowlincome", "uplincome", "lowhincome", "uphincome" )]

meanconsump <- gather(foodathome, "incomelevels", "meanincome", 4:6)

 

#  longfah <- foodathome %>%
 #   pivot_longer(c(meanus, meanlincome, meanhincome)
                 

meanconsump <- meanconsump %>%
  group_by(foodtype)

  summarize (meanconsump)



###7) Print summary database

write.csv(meanconsump, "data/tidydata/transplant_summary.csv", row.names=F)


