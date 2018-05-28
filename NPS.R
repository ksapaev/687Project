#####################################
##### Do NOT delete this block #####
setwd(Sys.getenv('PROJECT_HOME'))
####################################

####################################
## write code to read input csv into data frame
df <- read.csv('data.csv')
####################################

## start writing your R code from here


#Function to generate NPS
#Creating a vector equal to the 'Likelihood to Recommend' column
LTR <- df$LTR

#Creating a function of NPS that returns a number
NPS <- function(LTR) {
  promoters  <- (sum(LTR > 8))/length(LTR)
  detractors <- (sum(LTR < 7))/length(LTR)
  nps <- (promoters-detractors)*100
  return(nps)
}

#Checking the NPS value
NPS(LTR)



#Comparing NPS for the Purpose of Visit

LTR1 <- df$LTR[df$POV=="BUSINESS"]
LTR2 <- df$LTR[df$POV=="LEISURE"]

NPS(LTR1)
NPS(LTR2)

#Calculating the difference
NPS(LTR1) - NPS(LTR2)

## end your R code and logic 

####################################
##### write output file ############
# add your R code to write output file
####################################


