# Tiffanie Stone - Data Simulation - 10/24/2019

library(tidyverse)

#simulate response -- 1ST TRY
# data is assummed to be normally distributed - 
# I predict that fruit and vegetables will be lower that reccomended and that grain and meat will be higher than US reccomendations
avguscomp <- rnorm(n= 48, mean=c(50), sd = c(5)) #simulate avg US food consumption
avgloincome <- rnorm(n= 48, mean=c(48), sd = c(3)) #simulate avg low income food consumption
avghiincome <- rnorm(n= 48, mean=c(54), sd = c(4)) #simulate avg high income food consumption
response <- c(avguscomp, avgloincome,avghiincome)

#simulate predictors

foodtype <- rep(c("fruit", "veg", "dairy", "meat", "grain", "oil"), times = 8)
foodhomeawayhome <- factor(rep (c("fah", "afh"), each = 1, times = 24))
year <- factor(rep (c("94-98", "03-04", "05-06", "07-08"), each = 1, times = 12))

#combine all into a dataframe 

usfoodsimulation <- data.frame(response , foodtype, foodhomeawayhome, year)
write.csv(usfoodsimulation,"data/tidy/usfoodsimulation.csv")

#look at response

ggplot(usfoodsimulation, aes(foodtype, avguscomp))+
  geom_boxplot()

#Run a model with dataset

usfoodmodel <- lm(response~year*foodtype)
summary(usfoodmodel)




#Data Simulation - 2ND TRY - more accurate!

#Averages vary across foodtype I need to account for these variations. I plan to make 6 data frames by food category and bind them together at the end.

#Added additional high and low income data.

#took low and high data for each food type throughout years and averaged them to create approximate mean, used range/2 as standard dev.

fruit <- rnorm(n= 8, mean=c(98.11), sd = c(4.12)) #simulate avg fruit consumption each year
veg <- rnorm(n= 8, mean=c(106.11), sd = c(5.36)) #simulate avg veg consumption each year
dairy <- rnorm(n= 8, mean=c(174.93), sd = c(2.9)) #simulate avg dairy consumption each year
meat <- rnorm(n= 8, mean=c(88.02), sd = c(2.88)) #simulate avg meat consumption each year
grain <- rnorm(n= 8, mean=c(94.76), sd = c(2.43)) #simulate avg grain consumption each year
oil <- rnorm(n= 8, mean=c(34.1), sd = c(5.92)) #simulate avg oil consumption each year

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

