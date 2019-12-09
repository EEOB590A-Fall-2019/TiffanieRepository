# Tiffanie Stone - Simulated Data Exploration

#Part 3 - Data Exploaration

#Simulated vegetable conusumption data is going to be explored in this R script. First we need to load the packages and the csv file
library(tidyverse)
library(lme4)
library(ggResidpanel)
library(emmeans) 
library(Rmisc)

vegsim <- read_csv("data/tidydata/vegsim.csv")


## Explore Continous variables (only vegsim is continous - it is the lbs of vegetables consumed annually) 
## Then check for outliers
ggplot(data =vegsim, aes(simveg))+
  geom_histogram()


#They fit well, appear to be normally distributed based on histogram.
# b) Check for zero-inflation - not relevant it's a measurement not a count.


#Not applicable because there are only three variables in this simulated dataframe 1 response and 2 predictors

#4. Now categorical predictors. 

table(vegsim$incomelevel)
#There are 2000 observations at each income level

table(vegsim$year)
#There are 1500 observations for each year

## Explore relationships between variables
#5) Check for correlations between predictors, or for categorical predictors, also useful for seeing whether you have adequate samples. Use group_by() and count(), and then graphing it using geom_bar() and facet_grid(). 

ggplot(vegsim, aes(year, simveg))+
  geom_boxplot()

ggplot(vegsim, aes(incomelevel, simveg))+
  geom_boxplot()

ggplot(vegsim, aes(year, simveg), color=incomelevel)+
geom_bar()

#6) Look at relationships of Y vs X’s to see if variances are similar for each X value, identify the type of relationship (linear, log, etc.)

#Do data follow the assumptions of:
#1) independence? Index Plot
#2) normality? Q-Q Plot
#3) constant variance? Residual Plot
#4) linearity? Histogram - residuals not unevenly dist.

resid_panel(vegsimmod1a)

# Appears to be linear and normally distributed

#plot each predictor and random effect against the response

lmvegsimincome <- lm(simveg ~ incomelevel, data=vegsim)
summary(lmvegsimincome)


lmvegsimyear <- lm(simveg ~ year, data=vegsim)
summary(lmvegsimyear)

### Summary of data exploration ### 

#Both predictors are significant but the interaction between them is not.

### Linear model #### 
# Create a linear model to test whether vegetable consumption varies by income level or year -- I am only going to compare three options I think will produce the best fitting model.

#Option 1: Create a full model, remove interaction if not significant, but otherwise do not simplify. 
vegsimmod1 <- lm(simveg ~ incomelevel*year, data=vegsim)
anova(vegsimmod1) 

#If insignificant remove interaction -- 

vegsimmod1a <- lm(simveg ~ incomelevel + year, data = vegsim) 
anova(vegsimmod1a) 
summary(vegsimmod1a)

#interaction is not significant can remove year and income interaction.

#Option 2: Create a full model, remove any non-significant interactions to get final model.

vegsimmod2 <- lm(simveg ~ incomelevel*year, data=vegsim)
anova(traitsmod2)

#interaction are not significant.

vegsimmod2a <- lm(simveg ~ year+incomelevel, data=vegsim)
anova(traitsmod2)

#This model will be accepted


#Option 3: Create a full model and all submodels and compare AIC values to choose the best fitting model
aicsimveg1 <- lm(simveg ~ incomelevel*year, data=vegsim)
aicsimveg2 <- lm(simveg ~ incomelevel + year, data = vegsim)
aicsimveg3 <- lm(simveg ~ incomelevel, data=vegsim)
aicsimveg4 <- lm(simveg ~ year, data = vegsim)
aicsimveg5 <- lm(simveg ~ 1, data = vegsim)

AIC(aicsimveg1, aicsimveg2, aicsimveg3, aicsimveg4, aicsimveg5) #aicsimveg2 is best - SMALLEST IS BEST
