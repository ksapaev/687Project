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
library(ggplot2)
library(ggmap)

# Creating a box plot
myboxPlot <- ggplot(df, aes(x=Overall_Satisfaction, y=LTR)) + geom_boxplot(fill="yellow", col="black")
myboxPlot <- myboxPlot + scale_x_continuous( breaks = 1:10)+ scale_y_continuous( breaks = 1:10)

#Creating the png file of the boxplot.
png(filename="boxplot_LTR_Satisfaction.png")
myboxPlot
dev.off()

## end your R code and logic 

####################################
##### write output file ############
# add your R code to write map_usa_LTR.png
####################################




