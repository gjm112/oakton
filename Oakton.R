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

##########################################
## Data Visualization
##########################################




