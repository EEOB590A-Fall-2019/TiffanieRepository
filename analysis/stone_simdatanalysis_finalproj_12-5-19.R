# Tiffanie Stone - Simulated Data Analysis

#Part 3 - Statistical Analysis

#Simulated vegetable conusumption data is going to be statistically analyzed in this R script. First we need to load the packages and the csv file
library(tidyverse)
library(lme4)
library(ggResidpanel)
library(emmeans) 
library(Rmisc)

vegsim <- read_csv("data/tidydata/vegsim.csv")
vegsim$year <- as.factor(vegsim$year)
vegsim$year <- relevel(vegsim$year, "94-98")

vegsim$incomelevel <- as.factor(vegsim$incomelevel)
vegsim$incomelevel <- factor(vegsim$incomelevel, levels=rev(levels(vegsim$incomelevel)))

levels(vegsim$year)
# Will use Option 2: Fit-Full Model (simplified model accepted). 

#1) Access model fit
vegsimmod2a <- lm(simveg ~ incomelevel+year, data=vegsim)
anova(vegsimmod2a) 
summary(vegsimmod2a)



#Do data follow the assumptions of:
#1) independence? Index Plot
#2) normality? Q-Q Plot
#3) constant variance? Residual Plot
#4) linearity? Histogram - residuals not unevenly dist.

resid_panel(vegsimmod1a)

plot.design(vegsim)


