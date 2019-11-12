# Linear Model practice exercise

#We are going to work with a dataset on plant traits. We will test whether leaf thickness differs between tree species and island. Today, we will only do data exploration and model building/selection. We will assess model fit and interpret model results next week. 

#Helpful scripts to have open while you work on this include: DataExplorationDay2_practice_answers.R, DataExplorationDay2.R, and LinearModels.R (from class Tuesday)

#Response: thickness (leaf thickness)
#Predictors: species, island
#Random effects: none for right now, but could add some later

#Load libraries (you'll need the tidyverse)
library(tidyverse)

#Load dataset (tidyREUtraits.csv) and name it "traits". 
getwd()
setwd()
traits <- read_csv("data/tidy/tidyREUtraits.csv")

### Part 1: explore the dataset  #######

#1. Look at structure of dataset. 

str(traits)
dim(traits)
#2. Subset to rows that have a value for leaf thickness. How many rows did you lose? 
traits <- traits %>%
  filter(!is.na(thickness))

#Also we will subset to the species that were collected across all three islands. I'll give you the code for this below. 
traits <- traits %>%
  filter(species == "aglaia"| species == "aidia" | species == "guamia" | species == "cynometra" | species == "neisosperma" | species == "ochrosia" | species == "premna")  

## Explore single variables ##
ggplot(data =traits, aes(thickness))+
  geom_histogram()

ggplot(data =traits, aes(leaf_num))+
  geom_histogram()

table(traits$species)
#range from 60 - 171

table(traits$site)
#Wide spread of observations by site 5 to 171 and a range inbetween. 

#3. Start with continuous variables - of which we only have the response (thickness)
# a) Check for outliers
ggplot(data =traits, aes(thickness))+
  geom_histogram()
#Does not appear to have outliers

# b) Check for zero-inflation (not relevant bc it's a measurement not a count)
table(traits$thickness)

# c) Check for independence in the response (is each row independent?) or might there be some patterns we are not including. 

ggplot(traits, aes(island))+
  geom_bar()+
  facet_grid(.~species)


#do leaves by tree have similar leaf sizes?
ggplot(traits, aes(indiv_ID, area))+
  geom_point()

#Difficult to say they are similiar -- a lot of variation. Looks more related by species

#4. Now categorical predictors. Do you have an adequate sample size? How many measurements per level of island and per level of species? 

table(traits$species)
#range from 60 - 171

table(traits$site)
#Wide spread of observations by site 5 to 171 and a range inbetween

## Explore relationships between variables
#5) Check for correlations between predictors, or for categorical predictors, check to see if the sampling for each species is spread across each island. This is also useful for seeing whether you have adequate samples to run an island * site interaction. Try using group_by() and count(), and then graphing it using geom_bar() and facet_grid(). 

with(traits, table(island, site))
# sites are only on specific island

with(traits, ftable(island, site, species))
#This is very useful to determine frequency of species across sites and islands.

#6) Look at relationships of Y vs X’s to see if variances are similar for each X value, identify the type of relationship (linear, log, etc.)
#plot each predictor and random effect against the response
traitsthickspecies <- lm(thickness ~ species, data=traits)
summary(traitslm)

traitslmthickisland <- lm(thickness ~ island, data=traits)
summary(traitslm)
#No significant relationships between thickness and species or thickness and island

### Summary of data exploration ### 
#what did you find? 

#no significant relationships between thickness of leaves and island or species

### Linear model #### 
# Create a linear model to test whether leaf thickness varies by island, and whether that depends on the plant species. 

#Option 1: Create a full model, remove interaction if not significant, but otherwise do not simplify. 
traitsmod1 <- lm(thickness ~ species*island, data=traits)
anova(traitsmod1) 

#If insignificant remove interaction -- 

traitsmod1a <- lm(thickness ~ species + island, data = traits) 
anova(traitsmod1a) 

#interaction is significant - This is final model. 

#Option 2: Create a full model, remove any non-significant interactions to get final model.

traitsmod2 <- lm(thickness ~ island*species, data = traits)
anova(traitsmod2)

#all main effects & interaction significant - This is final model. 

#Option 3: Create a full model, and all submodels, and compare using Likelihood ratio tests (anova(mod1, mod2)) to choose the best fitting model. 
thick1 <- lm(thickness ~ island*species, data = traits)
thick2 <- lm(thickness ~ island + species, data = traits)
thick3 <- lm(thickness ~ island, data=traits)
thick4 <- lm(thickness ~ species, data = traits)
thick5 <- lm(thickness ~ 1, data = traits)

anova(thick1, thick2)
anova(thick1, thick3)
anova(thick1, thick4)
anova(thick1, thick5)
anova(thick2, thick3)
anova(thick2, thick4)
anova(thick2, thick5)
anova(thick3, thick4)
anova(thick3, thick5)
anova(thick4, thick5)

anova(thick1, thick2, thick3, thick4,thick5)
#? Not sure if this works well or not?
#stepaic
#Option 4: Create a full model and all submodels and compare AIC values to choose the best fitting model
thick1 <- lm(thickness ~ island*species, data = traits)
thick2 <- lm(thickness ~ island + species, data = traits)
thick3 <- lm(thickness ~ island, data=traits)
thick4 <- lm(thickness ~ species, data = traits)
thick5 <- lm(thickness ~ 1, data = traits)

AIC(thick1, thick2, thick3, thick4, thick5) #thick 1 is the best model - SMALLEST IS BEST

#Next week, we will assess model fit, and then interpret results. 
