# EEOB590A
# Data_visualization practice exercise
# Please use ggplot2 for all graphing below
# And don't forget to use your dplyr functions like filter, group_by, summarize, and select


#1) Read in poll_long_tidy.csv
getwd()
pollination <- read_csv("data/tidy/poll_long_tidy.csv")

#2) Use table and dplyr to calculate the number of top colors and bowl colors at each transect. Each transect was supposed to have each topcolor represented once, with all four (b, r, w, and y) bowl colors under each top color. 

pollination <- unite(pollination, transect, site, col = "transite", remove=FALSE)
#or use unique ID

with(pollination, table(transite, bowlcolor))

with(pollination, table(transite, topcolor))

#These tables show the site and transect number by bowl color then top color
  
with(pollination, ftable(transite,bowlcolor,topcolor))

transplant %>%
  group_by(transite) %>%
  count(bowlcolor)

transplant %>%
  group_by(transite) %>%
  count(topcolor)

#With dyplyr funciton

#3a) Make a histogram for numinsects. 

numinsecthist <- ggplot(data = pollination, aes(numinsects))+
  geom_histogram()

numinsecthist

#3b) Make another histogram for numinsects but omit all rows with 0 insects
nozeropoll <- filter(pollination, numinsects != "0")

nozeronuminsecthist <- ggplot(data = nozeropoll, aes(numinsects))+
  geom_histogram()

nozeronuminsecthist

#4a) Make a barplot to show the counts for each level of the site. Were sites evenly sampled? 
ggplot(pollination, aes(site))+
  geom_bar()

#No! - ladtg is lowerabout 200 whereas the rest are between 600 and 700

#4b) Make a graph to visualize the duration pan traps were left out, and use a table to do the same thing. Is there any variation in duration that we will need to account for in a model? 

durationpanhist <- ggplot(pollination, aes(site, duration, color=site))+
  geom_boxplot()

durationpanhist

summary(pollination$duration)

#No  variation. - min, median and max all = 3

durationpan <- with(pollination, ftable(duration, site))

durationpan

#same result all = 3

#5) Figure out the top 6 most abundant orders (hint, use the top_n() function; google it for more info). Then, filter the original dataset so you only have those orders. Then, create boxplots of the number of insects per order with different colors indicating the island. Do you notice any general trends in insect abundances by islands? 
?top_n

mostnum <- pollination %>%
  top_n(numinsects)


mostorder <- pollination %>%
filter(insectorder, mostnum)

#come back to this one -- not sure how to use top_n()

mostorderhist <- ggplot(pollination, aes(insectorder, numinsects, color=island))+
  geom_boxplot()  
  
mostorderhist
#There are most insects on Saipan compared to Guam for almost all insect orders. Some insect orders (lepidoptera and Hemiptera) appear to be off the charts high.


#6) Use the top 6 orders dataset you created above, along with the facet_grid argument to create a set of graphs with insect order on the x axis, number of insects on the y, and rows of graphs for each topcolor and columns of graphs for the island. 

