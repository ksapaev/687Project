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


#List of Latitudes and Longitudes for Every State
point$state <- c("Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia",
                 "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland",
                 "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey",
                 "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina",
                 "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming")
point$lat <- c(32.806671, 61.370716, 33.729759, 34.969704, 36.116203, 39.059811, 41.597782, 39.318523, 27.766279, 33.040619,
               21.094318, 44.240459, 40.349457, 39.849426, 42.011539, 38.526600, 37.668140, 31.169546, 44.693947, 39.063946,
               42.230171, 43.326618, 45.694454, 32.741646, 38.456085, 46.921925, 41.125370, 38.313515, 43.452492, 40.298904,
               34.840515, 42.165726, 35.630066, 47.528912, 40.388783, 35.565342, 44.572021, 40.590752, 41.680893, 33.856892,
               44.299782, 35.747845, 31.054487, 40.150032, 44.045876, 37.769337, 47.400902, 38.491226, 44.268543, 42.755966)
point$lon <- c(-86.791130, -152.404419, -111.431221, -92.373123, -119.681564, -105.311104, -72.755371, -75.507141, -81.686783, -83.643074,
               -157.498337, -114.478828, -88.986137, -86.258278, -93.210526, -96.726486, -84.670067, -91.867805, -69.381927, -76.802101,
               -71.530106, -84.536095, -93.900192, -89.678696, -92.288368, -110.454353, -98.268082, -117.055374, -71.563896, -74.521011,
               -106.248482, -74.948051, -79.806419, -99.784012, -82.764915, -96.928917, -122.070938, -77.209755, -71.511780, -80.945007,
               -99.438828, -86.692345, -97.563461, -111.862434, -72.710686, -78.169968, -121.490494, -80.954453, -89.616508, -107.302490)


#Adding geopoints to the dataframe
LTRmeans <- LTRmeans %>% mutate(lat=point$lat[match(tolower(point$state),state)], lon=point$lon[match(tolower(point$state),state)])


#Reappointing latitude and longitude for Alaska
LTRmeans$lon <- ifelse(LTRmeans$state == "alaska", -117.404419, LTRmeans$lon)
LTRmeans$lat <- ifelse(LTRmeans$state == "alaska", 28.370716, LTRmeans$lat)

#Reappointing latitude and longitude for Hawaii
LTRmeans$lon <- ifelse(LTRmeans$state == "hawaii", -104.498337, LTRmeans$lon)
LTRmeans$lat <- ifelse(LTRmeans$state == "hawaii", 24.094318, LTRmeans$lat)

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


		
		
		
		
		
