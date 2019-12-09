# Tiffanie Stone - Data Simulation - 10/24/2019

library(tidyverse)
library(ggplot2)
library(ggthemes)
library(ggridges)

#Simulating a data set using means and 95% confidence intervals for the vegetable portion of the dataset. 

#Will account for annual variations and high and low income data.

#took low and high data for each food type throughout years and averaged them to create approximate mean, used range/2 as standard dev.

vegmean94 <- rnorm(n= 500, mean=c(109.87), sd = c(18.204)) #simulate avg veg consumption in 94-98

veglowinc94 <- rnorm(n=500, mean=c(105.69), sd = c(16.5994)) #simulate avg low income veg consumption in 94-98

veghighinc94 <- rnorm(n= 500, mean=c(111.76), sd = c(18.9233)) #simulate avg high income veg consumption in 94-98


vegmean03 <- rnorm(n= 500, mean=c(105.72), sd = c(23.7582)) #simulate avg veg consumption in 03-04

veglowinc03 <- rnorm(n=500, mean=c(103.77), sd = c(22.3607)) #simulate avg low income veg consumption in 03-04

veghighinc03 <- rnorm(n= 500, mean=c(106.94), sd = c(24.6526)) #simulate avg high income veg consumption in 03-04



vegmean05 <- rnorm(n= 500, mean=c(103.03), sd = c(24.1495)) #simulate avg veg consumption in 05-06

veglowinc05 <- rnorm(n=500, mean=c(104.21), sd = c(22.3607)) #simulate avg low income veg consumption in 05-06

veghighinc05 <- rnorm(n= 500, mean=c(102.48), sd = c(25.044)) #simulate avg high income veg consumption in 05-06



vegmean07 <- rnorm(n= 500, mean=c(102.76), sd = c(22.9197)) #simulate avg veg consumption in 07-08

veglowinc07 <- rnorm(n=500, mean=c(99.62), sd = c(21.2426)) #simulate avg low income veg consumption in 07-08

veghighinc07 <- rnorm(n= 500, mean=c(104.83), sd = c(24.0377)) #simulate avg high income veg consumption in 07-08

             simveg <- c(vegmean94, vegmean03, vegmean05, vegmean07, veglowinc94,veglowinc03,veglowinc05, 
                         veglowinc07, veghighinc94, veghighinc03, veghighinc05,veghighinc07)
#Together the dataset simulated has 2000 participants for low income, high income and average income per year
             
             
#simulate predictors
             
             year <- factor(rep (c("94-98", "03-04", "05-06", "07-08"), each = 500, times = 3))
             incomelevel <- factor(rep (c("mean", "low", "high"), each = 2000, times = 1))
             
             
             #combine all into a dataframe 
             
             vegsim <- data.frame(simveg, year, incomelevel)
             
             vegsim$incomelevel <- as.factor (vegsim$incomelevel)
             vegsim$year <- as.factor (vegsim$year)
             
             write.csv(vegsim,"data/tidydata/vegsim.csv")
             
             
  

             
             
            
              
             

             
      
             
             
