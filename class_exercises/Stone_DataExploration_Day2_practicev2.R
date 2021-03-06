#Data Exploration and visualization practice exercise
#EEOB590A

#Research Question: 
#does survival of seedlings depend on distance from nearest conspecific adult, and does that effect vary by species or canopy openness? 

library(ggplot2)
library(skimr)
library(tidyverse)
library(DataExplorer)
library(lubridate)

######### Get Dataset Prepared for Exploration ##################

#1) start with a tidy dataset. Load data/tidy/fencesurv_tidy.csv from the tidy folder
getwd()
seed <- read_csv("data/tidy/fencesurv_tidy.csv")

#############################################
#data dictionary
# "species"- six plant species     
# "disp" - disperser present on island - yes/no          
# "island" - island (guam, saipan, tinian, rota)     
# "site"    - 5 sites on Guam, 3 each on Rota, Tinian, Saipan         
# "fence"   - fence name (based on forest plot grid names)       
# "numalive"  - number seedlings alive in fence 
# "date"       - date fence checked     
# "observer"   - person collecting data      
# "dataentry"   - person entering data     
# "dateenter"    - date data entered    
# "uniqueidsppfence" - unique id for each spp:fence combo
# "canopydate"    - date canopy cover data taken 
# "north"          - canopy measurement 1  
# "east"           - canopy measurement 2     
# "south"            - canopy measurement 3  
# "west"             - canopy measurement 4   
# "avgcover"        -average canopy measurement (% cover)    
# "avgopen"          -average canopy measurement (% open)   
# "doubleplant"     - was this fence double planted? 
# "plantdt"          - planting data
# "dist"             - near or far from conspecific? 
# "soil"             - soil type within the fence
# "numseedplant"    - number of seedlings planted
# "DDsurvival_notes"  - notes
# "bird"             - bird presence or absence on the island
# "age"             - age of seedlings (since planting)
# "centavgopen"      - centered average open
# "adultdens_wdisp"  - adult tree density on islands with disperser for that spp
# "adultdens_wodisp" - adult tree density on islands without disperser for that spp
# "seedsize"       - seed size 
# "numtrees"        - number of conspecific trees in the plot 
# "area"            - area of the plot
# "dens_100m"       - calculated density per 100 m
# "regdens"         - density across all plots
# "regdenswd"       - density just from plots with dispersers for that species
# 
#############################################

#2) check structure to make sure everything is in correct class
#species, disp, island, 

seed <- seed %>%
  mutate(island = as.factor(island)) %>%
  mutate(disp = as.factor(disp)) %>%
  mutate(species = as.factor(species)) %>%
  mutate(centavgopen = as.factor(centavgopen))

#a) Make a new column for propalive by dividing numalive/numseedplant 
 seed <- seed %>%
   mutate(propsurvival= numalive / numseedplant)

#3) Subset to the dataset you will use for the analysis
#we will use the whole dataset for now, may subset & re-run later. 
subseed <- seed %>%
  select(centavgopen, propsurvival, dist, species, island, site)


#4) Decide which variables are your response variables and which are your predictors
# Response: cbind(numalive, numseedplant) or propalive
# Continuous predictors: distance, centavgopen
# Categorical predictors: species
# Random effects: island (n=4 usually), site (n=3/island)


############ Start Data Exploration ##########
#1) try the skim() functions from the skimr package and the create_report() function from DataExplorer package. Note anything that stands out to you from those. 

skim(subseed)
create_report(subseed)


########## INDIVIDUAL VARIABLES #####################
#2) Start with your continuous variables. 
# a) With your continuous response and predictor variables, use ggplot and geom_histogram or dotchart() to look for outliers. 
ggplot(subseed, aes(propsurvival))+
  geom_histogram()

#no outliers detected all are between 0 and 1

# b) With your continuous response variable, look for zero-inflation (count data only). Are there more than 25% zero's in the response? 

count(subseed, propsurvival == 0)

subseed %>%
  count (propsurvival == 0)
# 0's are 20.8%

# c) With your continuous response variable, look for independence. 
# Are there patterns in the data that are unrelated to the fixed or random effects identified above?  Consider patterns over time, for example. 

#There are three Predictors for this study - dist, species and centavgopen and one Response variable - propsurvival They will be charted against eachother to determine independence/colinearity.
  
  ggplot(subseed, aes(centavgopen, propsurvival, color=species))+
    geom_dotplot(bins = 20)
  
  #It is difficult to work with centavgopen because it is continous and propsurvival is categorical but with many bins so the graph is difficult to interpret -- Would a histogram work better here?
  
# 3) Now, explore your categorical predictors
   
  ggplot(subseed, aes(dist, propsurvival))+
    geom_boxplot()
  
  #This took the categorical dist and compared it to the propsurvival a continuous variable
  
  ggplot(subseed, aes(species, propsurvival))+
    geom_boxplot()
  
  #Four outliers were detected in papaya (sig higher than expected) propsurvival and two in psychotria (sig lower than expected) -- propsurvival appears to be independent of species -- wide variation accross species
  #Explored above when analyzing the predictors versus the response.


# a) assess whether you have adequate sample size. How many observations per level of each of your categorical predictors? Are there any that have fewer than 15 observations?  

  subseed %>%
    count('species') %>%
    count('dist') 
  
  #I could potentially use filter select the specific level as well here. 
  #Not fewer than 15 observations per level
  
########## RELATIONSHIPS BETWEEN VARIABLES #######################
# 4) Explore relationships between your predictor variables
  
# a) look for correlation/covariation between each of your predictors (fixed & random)
#If 2 continuous predictors, use ggplot, geom_point to plot against each other, or use pairs()
#If 1 continuous and 1 categorical predictor, use ggplot with geom_boxplot() 
#For two categorical predictors, use summarize or table (ftable for more than 2 categories)

# b) Interactions: need to make sure you have adequate data for any 2-way or 3-way interactions in your model. 
## We are interested in a species * distance * centavgopen interaction. Do we have adequate sampling across this interaction? 

# 5) Look at relationships of Y vs X’s to see if variances are similar for each X value, identify the type of relationship (linear, log, etc.)
#plot each predictor and random effect against the response


###############################################################
#Summary of data exploration - summarize your general results here. 

####### 1: Individual variables ########
#a) Continuous variables (propalive, canopy)

#### Outliers (response & predictors)

#### Zero-inflation (response)

#### Independence (response)


#b) Categorical predictors and Random effects (island, soil, species)


####### 2: Multiple  variables ########
#a: Predictor vs predictor

#### Collinearity: No strong collinearities. Heterogeneity, though. 

#### Interactions - do we have enough data? 

#b: Predictor vs response: 
#### Linearity & homogeneity- relationship of Y vs X's. 

