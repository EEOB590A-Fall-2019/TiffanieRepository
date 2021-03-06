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
fill (pollination,island, direction = c("down", "up", "downup", "updown"))
fill(pollination$island, direction = c("down"))
fill(site, direction = "down")

#5) Separate "Top color - Bowl color" into two different columns, with the first letter for the top color and the second letter for the bowl color. We do not need to save the original column. 
separate(pollination,'topcolor-bowlcolor', into, sep = "[^[:alnum:]]+", remove = TRUE )
#6) Use the complete function to see if we have data for all 3 transects at each location. Do not overwrite the poll dataframe when you do this. 

#which transects appear to be missing, and why? 

#7) Unite island, site, transect into a single column with no spaces or punctuation between each part. Call this column uniqueID. We need to keep the original columns too. 


#8) Now, make this "wide" dataset into a "long" dataset, with one column for the insect orders, and one column for number of insects. 

#9) And just to test it out, make your "long" dataset into a "wide" one and see if anything is different. 

#are you getting an error? Can you figure out why? 

#10) Now, join the "InsectData" with the "CollectionDates" tab on the excel worksheet. You'll need to read it in, and then play around with the various types of 'mutating joins' (i.e. inner_join, left_join, right_join, full_join), to see what each one does to the final dataframe. 

