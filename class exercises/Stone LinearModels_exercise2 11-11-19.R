#Linear Models Exercise 2

library(tidyverse)
library(lme4)
library(ggResidpanel)
library(emmeans) 
#We will use the same dataset from last week

traits <- read_csv("data/tidy/tidyREUtraits.csv")

traits <- traits %>%
  filter(!is.na(thickness))

traits <- traits %>%
  filter(species == "aglaia"| species == "aidia" | species == "guamia" | species == "cynometra" | species == "neisosperma" | species == "ochrosia" | species == "premna")  

#1) Let's assess model fit for the model that came out on top for all 4 methods
thick1 <- lm(thickness ~ island*species, data = traits)
summary(thick1)
anova(thick1)
#Do data follow the assumptions of:
#1) independence? Index Plot
#2) normality? Q-Q Plot
#3) constant variance? Residual Plot
#4) linearity? Histogram - residuals not unevenly dist.

resid_panel(thick1)

#They fit pretty well, nothing too far off base.

#2) Now let's interpret the results, using each of the methods from last week: 

#Option 1: Traditional hypothesis testing (simplified model). 
#use emmeans to tell whether there are differences between islands for a given species
#which species differ between islands? 
thick1 <- lm(thickness ~ island*species, data = traits) #final model

thick <- emmeans(thick1, pairwise ~ island*species)
thick


#Option 2: Full model approach. 
#get confidence intervals using emmeans, and determine species
thick1 <- lm(thickness ~ island*species, data = traits) #final model

confint(thick1)

#Most are not significant, premna, ochrosia, neisosperma, cynometra did not intercept 0 across the islands.


#Option 3: Likelihood Ratio Test approach
#use emmeans to determine whether there are differences between species across all islands
thick1 <- lm(thickness ~ island*species, data = traits) #final model

confint(thick1)

#Option 4: Create a full model and all submodels and compare AIC values to choose the best fitting model
#just interpret the best fitting model. 
thick1 <- lm(thickness ~ island*species, data = traits) #final model


AIC(thick1) 
