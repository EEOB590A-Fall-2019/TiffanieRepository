# Repository: Uploading US Food Consumption Data from 1994 - 2008
# The purpose is to upload this national data set which will be used to find trends in food consumption over time and across low and high income groups of people. 
#This information will form a baseline for US food consumption as we explore food system development in Des Moines.
library(readxl)
getwd()


usfoodconsumption <- read_excel('C:/Users/tiffa/OneDrive/Documents/R/Repository/project/tidydata/foodconsumptionRdata.xlsx', col_names = c("foodtype", "year", "fahafh", "lowus", "meanus", "upus", "lowlincome", "meanlincome", "uplincome", "lowhincome", "meanhincome", "uphincome"), col_types = c("text", "text", "text", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), skip = 2)
# Read in file, named columns, set column data types to options available with read_excel function. Still need to convert some to factors.

usfoodconsumption$foodtype <- as.factor(usfoodconsumption$foodtype)
usfoodconsumption$year <- as.factor(usfoodconsumption$year)
usfoodconsumption$fahafh <- as.factor(usfoodconsumption$fahafh)
# Changed text to factors because they are all categorical factors.

# The data is now imported and able to be used for further data analysis


