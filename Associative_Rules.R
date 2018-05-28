#####################################
##### Do NOT delete this block #####
setwd(Sys.getenv('PROJECT_HOME'))
####################################

####################################
## write code to read input csv into data frame
df <- read.csv('data.csv')
####################################

## start writing your R code from here

library(dplyr)

#Create Dataframe with appropriate columns
NewDF <- df %>% select(LengthStay, Gender, AgeRange, GP_Tier, POV, StateAbb, Location, Country, NPS)

#Converting as factor
NewDF$LengthStay <- as.factor(NewDF$LengthStay)

## end your R code and logic 

####################################
##### write output file ############
write.csv(NewDF, file = 'rules_data.csv')
####################################



