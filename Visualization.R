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
library(fiftystater)

# Creating a box plot
myboxPlot <- ggplot(df, aes(x=Overall_Satisfaction, y=LTR)) + geom_boxplot(fill="yellow", col="black")
myboxPlot <- myboxPlot + scale_x_continuous( breaks = 1:10)+ scale_y_continuous( breaks = 1:10)

#Creating the png file of the boxplot.
png(filename="boxplot_LTR_Satisfaction.png", width=600, height=600)
myboxPlot
dev.off()















#Calculating mean LTR for each state
LTRmean <- tapply(df$LTR, df$StateAbb, mean)


#Creating a dataframe of 50 states and mean NPS
LTRmeans <- data.frame(abb=(names(LTRmean)), LTR=LTRmean)

#Adding 'state name' in lowercase format to the dataframe
LTRmeans <- LTRmeans %>% mutate(state=tolower(state.name[match(LTRmeans$abb,state.abb)]))


#Getting the US map
data("fifty_states")

#Getting the geopoints
point <- geocode(LTRmeans$state)
LTRmeans$lon <- point[,1]
LTRmeans$lat <- point[,2]

#Reappointing latitude and longitude for Alaska
LTRmeans$lon <- ifelse(LTRmeans$state == "alaska", -117.5, LTRmeans$lon)
LTRmeans$lat <- ifelse(LTRmeans$state == "alaska", 28.5, LTRmeans$lat)

#Reappointing latitude and longitude for Hawaii
LTRmeans$lon <- ifelse(LTRmeans$state == "hawaii", -104.5, LTRmeans$lon)
LTRmeans$lat <- ifelse(LTRmeans$state == "hawaii", 24.5, LTRmeans$lat)

#Drawing a graph on US map, adding layers
USmap <- ggplot(LTRmeans, aes(map_id = state)) + geom_map(map = fifty_states, aes(fill=LTR), color="black") 
USmap <- USmap + expand_limits(x = fifty_states$long, y = fifty_states$lat)
USmap <- USmap + coord_map() + ggtitle("Map of the USA filled by mean LTR")
USmap <- USmap + fifty_states_inset_boxes() 
USmap <- USmap + scale_fill_gradient(low = "lightblue",high = "darkblue", breaks=c(8.1,8.5,9,9.4))

#Adding a layer with points
USmap <- USmap + geom_point(data=LTRmeans, aes(x=lon, y=lat, color=LTR)) + scale_colour_gradient(low = 'yellow', high='red')

#Scaling points by radius
USmap <- USmap + scale_radius(aes(size=LTRmeans$LTR))

# Creating png for the map.
png(filename="map_usa_LTR.png", width=800, height=600)
USmap
dev.off()


## end your R code and logic 

####################################
##### write output file ############
# add your R code to write boxplot_LTR_Satisfaction.png
####################################



