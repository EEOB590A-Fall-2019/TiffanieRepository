# 26 September 2019 ####

#data wrangling part 1, practice script
#we will be working with a real insect pan traps dataset that I've amended slightly in order to practice the skills from Tuesday. 
getwd()

#1) load libraries - you will need tidyverse and readxl
library(tidyverse)
library(readxl)
#2) Read in data
pollination <- read_excel("3. Data wrangling/Data_wrangling_day1_pollination.xlsx")

#3) rename columns. Leave insect families with capital letters, but make all other columns lowercase. Remove any spaces. Change "location" to "site". Change "tract" to "transect". 
pollination <- pollination %>%  
  rename(island = Island, 
         site = Location, 
         transect = Tract, 
         'topcolor-bowlcolor' = 'Top color - Bowl color',
         Diptera = Diptera, 
         Hemiptera = Hemiptera, 
         Coleoptera = Coleoptera, 
         Formicidae = Formicidae, 
         Apoidea = Apoidea, 
         Crabronidae = Crabronidae, 
         Lepidoptera = Lepidoptera, 
         Blattodea = Blattodea, 
         Araneae = Araneae, 
         Isoptera = Isoptera, 
         Partial = Partial, 
         Trichoptera = Trichoptera, 
         Other = Other)


#4) Add missing data. Note that the people who entered the data did not drag down the island or location column to fill every row. 
pollination <- pollination %>%
  fill(island, site)

view (pollination)


#5) Separate "Top color - Bowl color" into two different columns, with the first letter for the top color and the second letter for the bowl color. We do not need to save the original column. 

pollination1 <- pollination %>%
  separate('topcolor-bowlcolor', into=c("topcolor", "bowlcolor"), sep="-", remove = T) 

view (pollination1)
#6) Use the complete function to see if we have data for all 3 transects at each location. Do not overwrite the poll dataframe when you do this.
pollination1_complete <- pollination1 %>%
  complete(site, transect)

view(pollination1_complete)

#which transects appear to be missing, and why? 
missing <- pollination1_complete[is.na(pollination1_complete$island),]
#latg transect L1, L2, L3 are all missing observations everything from island on down is NA. 

#7) Unite island, site, transect into a single column with no spaces or punctuation between each part. Call this column uniqueID. We need to keep the original columns too. 

pollination1 <- pollination1 %>%
  unite(uniqueID, c(island, site,transect), sep="", remove=FALSE)

#8) Now, make this "wide" dataset into a "long" dataset, with one column for the insect orders, and one column for number of insects. 
pollination1_long <- pollination1 %>%
  gather(insectorder, numinsects, 7:19)

#9) And just to test it out, make your "long" dataset into a "wide" one and see if anything is different. 
pollination1_wide <- pollination1_long %>%
  spread(insectorder, numinsects)

#are you getting an error? Can you figure out why? 
#Yes, I got an error: Each row of output must be identified by a unique combination of keys. Keys are shared for 78 rows:
#Lookinat at the data, they have the same unique identifier, should dates have been included
#to specify which is which?

#10) Now, join the "InsectData" with the "CollectionDates" tab on the excel worksheet. You'll need to read it in, and then play around with the various types of 'mutating joins' (i.e. inner_join, left_join, right_join, full_join), to see what each one does to the final dataframe. 

dates <- read_excel("3. Data wrangling/Data_wrangling_day1_pollination.xlsx", sheet = 2)

pollinationdate_inner <- pollination1%>%
  inner_join(dates)

pollinationdate_left<- pollination1%>%
  left_join(dates)

pollinationdate_right <- pollination1%>%
  right_join(dates)

pollinationdate_full <- pollination1%>%
  full_join(dates)
