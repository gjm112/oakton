library(Lahman)
library(tidyverse)
##########################################
## Structure of the files
##########################################
#Rectangular files.  
#Rows are observations 
#Columns are variables 

#####################
## Input/Output
#####################
#Output
# write.csv(Pitching, file = "./data/Pitching.csv", row.names = FALSE)
# write.csv(Batting, file = "./data/Batting.csv", row.names = FALSE)
# write.csv(Teams, file = "./data/Teams.csv", row.names = FALSE)

#Input
# Batting <- read.csv("./data/Batting.csv")
# Pitching <- read.csv("./data/Pitching.csv")
# Teams <- read.csv("./data/Teams.csv")

##########################################
## Data sets we're gonna use
##########################################
#Pitching, Batting, and Teams
#Pitching
#Batting
#Teams

##########################################
## Tidyverse
##########################################
#filter: subset the rows
#select: subset the columns
#mutate: derive new columns
#group_by: creates a hidden grouping variable
#summarize: summarizes within the group (if there is a grouping var)
#arrange: sorts by a column



##########################################
## Examples
##########################################
Teams %>% View()

#filter
Teams %>% filter(franchID %in% c("CHC","CHW")) 
Teams %>% filter(franchID %in% c("CHC","CHW") & yearID >= 2000) 

#select
Teams %>%
  filter(franchID %in% c("CHC","CHW") & yearID >= 2000) %>% 
  select(franchID, yearID, W, L)

#mutate
Teams %>%
  filter(franchID %in% c("CHC","CHW") & yearID >= 2000) %>% 
  select(franchID, yearID, W, L) %>% 
  mutate(winpct = W/(W+L))

#arrange
Teams %>%
  filter(franchID %in% c("CHC","CHW") & yearID >= 2000) %>% 
  select(franchID, yearID, W, L) %>% 
  mutate(winpct = W/(W+L)) %>% 
  arrange(winpct)

Teams %>%
  filter(franchID %in% c("CHC","CHW") & yearID >= 2000) %>% 
  select(franchID, yearID, W, L) %>% 
  mutate(winpct = W/(W+L)) %>% 
  arrange(desc(winpct))

#group_by and summarize
Teams %>%
  filter(franchID %in% c("CHC","CHW") & yearID >= 2000) %>% 
  select(franchID, yearID, W, L) %>% 
  group_by(franchID) %>% 
  summarize(W = sum(W), L = sum(L), n = n())


Teams %>%
  filter(franchID %in% c("CHC","CHW") & yearID >= 2000) %>% 
  select(franchID, yearID, W, L) %>% 
  group_by(franchID) %>% 
  summarize(W = sum(W), L = sum(L), n = n()) %>% 
  mutate(winpct = W/(W+L)) 


#Questions
#Batting: Find the player who had the lowest batting average in a season where they hit over 40HR. 
Batting %>% group_by(playerID, yearID) %>%
  summarize(HR = sum(HR), H = sum(H), AB = sum(AB)) %>%
  filter(HR >= 40) %>% mutate(BA = H/AB) %>% arrange(BA) %>% head()

#Pitching: What pitcher had the lowest HR rate (i.e. HR/IPouts) among all pitchers who pitched at least 100 innings in a season?

#Advanced: You'll need to merge! Find the 

##########################################
## Data Visualization
##########################################
Teams %>% filter(franchID %in% c("CHC","CHW") & yearID >= 2000) %>% ggplot(aes(x = W)) + geom_histogram() + theme_bw()
Teams %>% filter(franchID %in% c("CHC","CHW") & yearID >= 2000) %>% ggplot(aes(x = W)) + geom_density() + theme_bw()
Teams %>% filter(franchID %in% c("CHC","CHW") & yearID >= 2000) %>% ggplot(aes(y = W)) + geom_boxplot() + theme_bw()
Teams %>% filter(franchID %in% c("CHC","CHW") & yearID >= 2000) %>% ggplot(aes(x = franchID, y = W, color = franchID)) + geom_boxplot() + theme_bw()

#Scatter/line plots
Teams %>% filter(franchID %in% c("CHC","CHW")) 
Teams %>% filter(franchID %in% c("CHC","CHW") & yearID >= 2000) %>% ggplot(aes(x = yearID, y = W, color = franchID)) + geom_point() + geom_line() + scale_color_manual(values = c("CHC" = "blue", "CHW" = "black")) + theme_bw()

Teams %>% filter(franchID %in% c("CHC","CHW") & yearID >= 2000) %>% 
  ggplot(aes(x = yearID, y = W)) + 
  facet_grid(~franchID) + 
  geom_point() +
  geom_line() 




