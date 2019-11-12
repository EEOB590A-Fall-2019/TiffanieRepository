# Tiffanie Stone - Data Simulation - 10/24/2019

library(tidyverse)

#Simulating a data set using means and 95% confidence intervals for the vegetable portion of the dataset. 

#Will account for annual variations and high and low income data.

#took low and high data for each food type throughout years and averaged them to create approximate mean, used range/2 as standard dev.

vegmean94 <- rnorm(n= 250, mean=c(109.87), sd = c(4.12)) #simulate avg veg consumption in 94-98

veglowinc94 <- rnorm(n= , mean=c(106.11), sd = c(5.36)) #simulate avg low income veg consumption in 94-98

veghighinc94 <- rnorm(n= 8, mean=c(174.93), sd = c(2.9)) #simulate avg high income veg consumption in 94-98



             avgconsum2 <- c(fruit, veg, dairy, meat, grain, oil)

  #Repeat for low and high income 
             # Expect slightly more oil and grain by 2 lb for low income and less fruits and vegetables by 2 lb. Same standard dev.
             fruitlo <- rnorm(n= 8, mean=c(96.11), sd = c(4.12)) #simulate low income fruit consumption each year
             veglo <- rnorm(n= 8, mean=c(104.11), sd = c(5.36)) #simulate low income veg consumption each year
             dairylo <- rnorm(n= 8, mean=c(174.93), sd = c(2.9)) #simulate low income dairy consumption each year
             meatlo <- rnorm(n= 8, mean=c(88.02), sd = c(2.88)) #simulate low income meat consumption each year
             grainlo <- rnorm(n= 8, mean=c(96.76), sd = c(2.43)) #simulate low income grain consumption each year
             oillo <- rnorm(n= 8, mean=c(36.1), sd = c(5.92)) #simulate low income oil consumption each year
             
             loconsum2 <- c(fruitlo, veglo, dairylo, meatlo, grainlo, oillo)
             
             #Expecting slightly more fruit and vegetables by 2 lb higher mean for high income. Same standard dev.
             
             fruithi <- rnorm(n= 8, mean=c(100.11), sd = c(4.12)) #simulate low income fruit consumption each year
             veghi <- rnorm(n= 8, mean=c(108.11), sd = c(5.36)) #simulate low income veg consumption each year
             dairyhi <- rnorm(n= 8, mean=c(174.93), sd = c(2.9)) #simulate low income dairy consumption each year
             meathi <- rnorm(n= 8, mean=c(88.02), sd = c(2.88)) #simulate low income meat consumption each year
             grainhi <- rnorm(n= 8, mean=c(94.76), sd = c(2.43)) #simulate low income grain consumption each year
             oilhi <- rnorm(n= 8, mean=c(34.1), sd = c(5.92)) #simulate low income oil consumption each year
             
             hiconsum2 <- c(fruithi, veghi, dairyhi, meathi, grainhi, oilhi)

#simulate predictors

foodtype2 <- rep(c("fruit", "veg", "dairy", "meat", "grain", "oil"), each= 8, times = 6)            
foodhomeawayhome2 <- factor(rep (c("fah", "afh"), each = 4, times = 12))
year2 <- factor(rep (c("94-98", "03-04", "05-06", "07-08"), each = 1, times = 12))


#combine all into a dataframe 

usfoodsim2 <- data.frame(avgconsum2, hiconsum2, loconsum2, foodtype2, foodhomeawayhome2, year2)
write.csv(usfoodsimulation,"data/tidy/usfoodsim2.csv")

#look at response

ggplot(usfoodsim2, aes(foodtype2, avgconsum2))+
  geom_boxplot()

ggplot(usfoodsim2, aes(foodtype2, loconsum2))+
  geom_boxplot()

ggplot(usfoodsim2, aes(foodtype2, hiconsum2))+
  geom_boxplot()


#Run a model with dataset

usfoodmodel2 <- lm(avgconsum2 ~ year2*foodtype2)
summary(usfoodmodel2)


##Other ways to seperate out different food types which vary in quantity -- oil lower than grains for example.
?aggregate
#usfoodsimulation %>%
 # aggregate(avghiincome ~ avguscomp, foodtype, data = avgloincome, mean)
#aggregate(breaks ~ wool + tension, data = warpbreaks, mean)
#aggregate(cbind(Ozone, Temp) ~ Month, data = airquality, mean)
#aggregate( foodtype ~ oil, 10, 10)

