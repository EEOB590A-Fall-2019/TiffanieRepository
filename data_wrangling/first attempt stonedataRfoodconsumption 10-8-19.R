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
usfoodconsumption$year <- as.factor(usfoodconsumption$year)
usfoodconsumption$fahafh <- as.factor(usfoodconsumption$fahafh)
# Changed text to factors because they are all categorical factors.

# The data is now imported and ready to be Wrangled

# Wrangling: First Explore
str(usfoodconsumption)


## Step 1: Fix cells within columns (e.g. naming, capitalization) #####
summary(usfoodconsumption)
#need to fix capitalization, spelling, whitespace? --- Not necessary Data looks clean ---


#1.1:Check levels within a column are lower case. 
# Use levels & tolower which changes character vector, so would need to mutate back to factor.

#All columns and levels are lower case 


#1.2: Change levels of a variable, forcats approach

#usfoodconsumption <- usfoodconsumption %>%
 # mutate(fah/afh = fct_recode(fah/afh, "homefood" = "fah", "awayfood" = "afh"))



#1.3: Get rid of ghost levels (not always necessary, but sometimes you get rid of a level and R still thinks it is there) use usfoodconsumption$foodtype <- droplevels(usfoodconsumption$foodtype) or factor then levels()


#1.4: Re-order levels within a variable. usfoodconsumption$foodtype <- factor(usfoodconsumption$fah/afh, levels = c("afh", "fah"))


#1.5: delete a certain # of characters from the values within a vector
#this is saying "keep the 1st-4th elements (start at 1, stop at 4)".
#transplant$site<-as.factor(substr(transplant$site, 1, 4)) #this makes all levels 4 characters long
 ##Not necessary for this data set

#1.6: Remove trailing whitespace
#transplant$site <- as.factor(trimws(transplant$site))

##Not necessary - no trailing spaces

#1.7: Center continuous predictors and make new column for this variable, may help with convergence
transplant$websize_c <- as.numeric(scale(transplant$websize))

#1.8: Deal with dates
#Change date format to standard yyyymmdd format
#helpful site: https://www.r-bloggers.com/date-formats-in-r/
class(transplant$startdate)

# use lubridate to tell R the format of hte date
transplant$startdate <- dmy(transplant$startdate)
transplant$enddate <- dmy(transplant$enddate)

#now, can do math on your dates!
transplant$duration <- transplant$enddate - transplant$startdate
transplant$duration <- as.numeric(transplant$duration)
summary(transplant$duration)

###2) Create new columns (mutate) ##################
transplant$webarea <- ((transplant$websize/2)/100)^2*pi #base R approach; #assume circle, divide in half to get radius, divide by 100 to get from cm to m, calculate area

mutate(transplant, webarea = ((websize/2)/100)^2*pi) #tidyverse

transplant %>%
  mutate(webarea = ((websize/2)/100)^2*pi) %>%
  head()      #tidyverse with piping

####3) Arrange rows of data by the levels of a particular column (arrange)
#default goes from low to high
arrange(transplant, websize)  #arranging transplant rows based on websize, without using piping

#with piping
transplant <- transplant %>%
  arrange(websize)

#use desc inside the arrange fx to go from high to low
transplant %>%
  arrange(desc(websize))

###4) Print tidy, wrangled database

write.csv(transplant, "data/tidy/transplant_tidy_clean.csv", row.names = F)

########################################################################
#Part 3: Subsetting and grouping

#2) Subset data (filter, select)
#use filter to extract rows according to some category
athomeonsump <- usfoodconsumption %>%
  filter(fah/afh == "fah", meanus == "anao")

#use select to choose columns
basic_transplant <- transplant %>%
  select(island, site, websize, duration)

transplant %>%
  select(island, site, websize, duration)

#3) Summarize data (summarise, count) #################3
#use summarize to compute a table using whatever summary function you want (e.g. mean, length, max, min, sd, var, sum, n_distinct, n, median)
trans_summ <- transplant %>%
  summarise(avg = mean(websize), numsites = n_distinct(site))

#use count to count the number of rows in each group
count(transplant, site) #base R approach

transplant %>%
  count(site)  #piping approach

##### 4 Group data (group_by) ################
#use group_by to split a dataframe into different groups, then do something to each group

transplant %>%
  group_by(island) %>%
  summarize (avg = mean(websize))

trans_summ <- transplant %>%
  group_by(island, site, netting) %>%
  summarize (avgweb = mean(websize),
             avgduration = mean(duration))



###7) Print summary database

write.csv(trans_summ, "data/tidy/transplant_summary.csv", row.names=F)


