# EEOB590A
# Data_wrangling part 2 practice exercise
# practice tidying and wrangling 

#from the tidy folder, read in the partialtidy file for pollination from last week's assignment
library("tidyverse")
library("lubridate")
library("readxl")
library("forcats")

getwd()

transplant <- read_csv("C:/Users/tiffa/OneDrive/Documents/R/Course-Materials/data/tidy/poll_long_partialtidy.csv")
str(transplant)
summary(transplant)

###########################################################
#####Part 1: finish tidying & wrangling dataframe #########

#1) Broad changes to the database

#1a) Change the class of each variable as appropriate (i.e. make things into factors or numeric)

transplant <- transplant %>%
  mutate_at(vars(uniqueID, island, site, transect, topcolor, bowlcolor, insectorder), 
            factor)



#2) Fix the errors below within cells 

summary(transplant)

summary(transplant$uniqueID)

summary(transplant$island)

summary(transplant$site)

summary(transplant$transect)

summary(transplant$topcolor)

summary(transplant$bowlcolor)

summary(transplant$insectorder)

summary(transplant$numinsects)

summary(transplant$'date traps out`)

summary(transplant$'date traps coll')


#I looked at the data column by column to check for errors or mistakes , I also looked at the factor levels with summary. -- No errors were detected.



##2a) Fix the levels of site so that they have consistent names, all in lowercase

levels(transplant$island)

transplant$uniqueID <- tolower(transplant$uniqueID)
transplant$island <- tolower(transplant$island)
transplant$site <- tolower(transplant$site)
transplant$transect <- tolower(transplant$transect)
transplant$insectorder <- tolower(transplant$insectorder)


transplant <- transplant %>%
  mutate_at(vars(uniqueID, island, site, transect, insectorder), factor)

levels(transplant$island)



##2b) What format are the dates in? Do they look okay? 

class(transplant$`date traps out`)

class(transplant$`date traps coll`)


#They are both classified as dates, I do not see a problem with them, they are reported year-month-day



##2c) Do you see any other errors that should be cleaned up? 

#No - but may want to remake uniqueID name because we changed the site names.



#3) Create a new column for the duration of time traps were out

transplant$duration <- transplant$'date traps coll' - transplant$'date traps out'

transplant$duration <- as.numeric(transplant$duration)

summary(transplant$duration)



#4) Arrange data by the number of insects

transplant <- transplant %>%
  arrange(numinsects)
  
  
  #Arranged from low to high by default
  #Initially gave me: Error in arrange(numinsects) : object 'numinsects' not found, not sure why
  

#5) Print tidied, wrangled database

write.csv(transplant, "data_wrangling/tidy/transplant_tidy.csv", row.names = F)

#####################################################
####Part 3: start subsetting & summarizing ##########

#6) Make a new dataframe with just the data from Guam at the racetrack site and name accordingly. 

 levels(transplant$site)
 
guamrace <- transplant %>%
filter(island == "guam", site == "racetrack")


#7) Make a new dataframe with just the uniqueID, island, site, transect, insectorder, numinsects, and duration columns. 

basic_transplant <- transplant %>%
  select( uniqueID, island, site, transect, insectorder, numinsects, duration)
  

#8) With the full database (not the new ones you created in the two previous steps), summarize data, to get: 
#8a) a table with the total number of insects at each site

trans_summ <- transplant %>%
group_by(site) %>%
  summarise(sum(numinsects))


#8b) a table that shows the mean number of insects per island

islandinsects <- transplant %>%
  group_by(island) %>%
  summarise(mean = mean(numinsects), na.rm = TRUE)
  
    #Not getting an expected result here - getting only NA for saipan and only 0.233 for guam - why?
  
  ?summarise
  
 islandinsects <- transplant %>%
  group_by(island, site, transect) %>%
  summarise(totalinstrans = sum(numinsects, na.rm=T))  %>%
  group_by(island)  %>%
  summarise(meaninsects = mean(totalinstrans,na.rm = T) 
  
  #Another try -- group by all three then by island

#8c) a table that shows the min and max number of insects per transect

trans_summ <- transplant %>%
  group_by(transect) %>%
  summarize (insectmin = min(numinsects),
            insectmax = max(numinsects), na.rm = TRUE)
            
  # No results found in transect 1 (NA) - the other two transects appear to be correct.

#9a) Figure out which insect order is found across the greatest number of sites

numinsectorder <- transplant %>%
  group_by(insectorder) %>%
  summarize (n_distinct(site))
  
?group_by

#I tried this both ways first grouping by site then summarizing insectorder and the reverse. They both say that all #orders are represented across all sites. So none are greater than another.-- Are 0s and NAs being included?

          numinsectorder <- transplant %>%
          group_by(insectorder) %>%
          summarize (n_distinct(site[site != 0]), na.rm = TRUE)   
          
#Same result without 0s and NAs -- this did not work

   numinsectorder <- transplant %>%
          group_by(insectorder) %>%
          filter(numinsects>0) %>%
          summarize (numsites = n_distinct(site)
          
  
#This works - use filter instead of square brackets - inside tidyverse


#9b) For that insect order, calculate the mean and sd by site. 

apoideameansd <- transplant %>%
group_by(site) %>%
select(site, insectorder[1])%>%

  summarise(avgnum = mean(numinsects),
            sdnum = sd(numinsects))
            
  #First part runs but the summarize portion produces an error - Error in .f(.x[[i]], ...) : object insectorder not found
            