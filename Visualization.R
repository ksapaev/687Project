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
library(reshape2)

# Creating a box plot
myboxPlot <- ggplot(df, aes(x=Overall_Satisfaction, y=LTR)) + geom_boxplot(fill="yellow", col="black")
myboxPlot <- myboxPlot + scale_x_continuous( breaks = 1:10)+ scale_y_continuous( breaks = 1:10)

#Creating the png file of the boxplot.
png(filename="boxplot_LTR_Satisfaction.png", width=600, height=600)
myboxPlot
dev.off()



#Creating a plot for Revenue compared Age Range
myPlotAgeRev <- ggplot(df, aes(x= AgeRange, y= Revenue))+ geom_col( fill="black") + ggtitle("Revenue compared to Age Range" )

png(filename="RevenueAge.png", width=800, height=600)
myPlotAgeRev
dev.off()


#Creating a plot for Revenue compared Length of Stay
myPlotStayRev <- ggplot(df, aes(x= LengthStay, y= Revenue))+ geom_col( fill="darkred") + ggtitle("Revenue compared to Length of Stay" )

png(filename="RevenueStay.png", width=800, height=600)
myPlotStayRev
dev.off()

##################################

#Promoter/Detractor by Purpose of Visit
promoters <- df[df$NPS=="Promoter",]
detractors <- df[df$NPS=="Detractor",]

proPOV <- tapply(promoters$NPS, promoters$POV, length)
detPOV <- tapply(detractors$NPS, detractors$POV, length)

POV <- data.frame(pov=names(proPOV), promoters=as.numeric(proPOV), detractors=as.numeric(detPOV))
rownames(POV) <- NULL

POV <- melt(POV)

barchart <- ggplot(POV, aes(x= pov, y= value, fill=variable)) + geom_bar(stat="identity", width=0.8, position = "dodge")
barchart <- barchart + xlab("") + ylab("Number of Promoter/Detractor") +  theme_minimal() + ggtitle("Promoter/Detractor by Purpose of Visit")
barchart <- barchart + theme(legend.position="bottom") + theme(legend.title=element_blank())
barchart <- barchart + scale_fill_manual(POV$variable,values=c("#5A7247","#B76BA3")) 

png(filename="POV.png", width=800, height=600)
barchart
dev.off()

#Promoter/Detractor by Region

proRegion <- tapply(promoters$NPS, promoters$StateRegion, length)
detRegion <- tapply(detractors$NPS, detractors$StateRegion, length)

Region <- data.frame(region=names(proRegion), promoters=as.numeric(proRegion), detractors=as.numeric(detRegion))
rownames(Region) <- NULL

Region <- melt(Region)

barchart2 <- ggplot(Region, aes(x= region, y= value, fill=variable)) + geom_bar(stat="identity", width=0.8, position = "dodge")
barchart2 <- barchart2 + xlab("") + ylab("Number of Promoter/Detractor") +  theme_minimal() + ggtitle("Promoter/Detractor by Regions")
barchart2 <- barchart2 + theme(legend.position="bottom") + theme(legend.title=element_blank())
barchart2 <- barchart2 + scale_fill_manual(Region$variable,values=c("#5A7247","#B76BA3")) 

png(filename="Region.png", width=800, height=600)
barchart2
dev.off()




#Generating a heatmap where we take x for hotel condition, y for room satisfaction.
#Colors range from white to blue depending on fil value of LTR.
myPlotHeat <- ggplot(df, aes(x=Hotel_Condition, y=Room_Satisfy, fill=LTR)) + geom_tile(color = "white") 
myPlotHeat <- myPlotHeat + scale_fill_gradient(low="white", high="darkblue", space = "Lab", name="LTR") + xlab("Hotel condition") + ylab("Guest Room satisfaction")
myPlotHeat <- myPlotHeat + coord_fixed() + theme_minimal() + scale_x_continuous( breaks = 1:10)+ scale_y_continuous( breaks = 1:10)

#Creating the png file of the heatmap
png(filename="heat_hc_rs.png")
myPlotHeat
dev.off()


#Generating a heatmap where we take x for customer service, y for check in.
#Colors range from white to blue depending on fil value of LTR.
myPlotHeat2 <- ggplot(df, aes(x=Customer_Service, y=CheckIn, fill=LTR)) + geom_tile(color = "white") 
myPlotHeat2 <- myPlotHeat2 + scale_fill_gradient(low="white", high="darkred", space = "Lab", name="LTR") + xlab("Customer Service") + ylab("Check In")
myPlotHeat2 <- myPlotHeat2 + coord_fixed() + theme_minimal() + scale_x_continuous( breaks = 1:10)+ scale_y_continuous( breaks = 1:10)

#Creating the png file of the heatmap
png(filename="heat_cs_ch.png")
myPlotHeat2
dev.off()

#########################################################################

#Calculating mean LTR/Number of Detractors for each state
LTRmean <- tapply(df$LTR, df$StateAbb, mean)
Detractor <- tapply(df$NPS, df$StateAbb, length)

#Creating a dataframe of 50 states and mean NPS/Number of Detractors
LTRmeans <- data.frame(abb=(names(LTRmean)), LTR=LTRmean)
Detractors <- data.frame(abb=(names(Detractor)), Detractor=Detractor)

#Adding 'state name' in lowercase format to the dataframes LTR/Detractors
LTRmeans <- LTRmeans %>% mutate(state=tolower(state.name[match(LTRmeans$abb,state.abb)]))
Detractors <- Detractors %>% mutate(state=tolower(state.name[match(Detractors$abb,state.abb)]))

#Getting the US map
data("fifty_states")


#List of Latitudes and Longitudes for Every State
point.state <- c("alabama", "alaska", "arizona", "arkansas", "california", "colorado", "connecticut", "delaware", "florida", "georgia",
                 "hawaii", "idaho", "illinois", "indiana", "iowa", "kansas", "kentucky", "louisiana", "maine", "maryland",
                 "massachusetts", "michigan", "minnesota", "mississippi", "missouri", "montana", "nebraska", "nevada", "new hampshire", "new jersey",
                 "new mexico", "new york", "north carolina", "north dakota", "ohio", "oklahoma", "oregon", "pennsylvania", "rhode island", "south carolina",
                 "south dakota", "tennessee", "texas", "utah", "vermont", "virginia", "washington", "west virginia", "wisconsin", "wyoming")
point.lat <- c(32.806671, 61.370716, 33.729759, 34.969704, 36.116203, 39.059811, 41.597782, 39.318523, 27.766279, 33.040619,
               21.094318, 44.240459, 40.349457, 39.849426, 42.011539, 38.526600, 37.668140, 31.169546, 44.693947, 39.063946,
               42.230171, 43.326618, 45.694454, 32.741646, 38.456085, 46.921925, 41.125370, 38.313515, 43.452492, 40.298904,
               34.840515, 42.165726, 35.630066, 47.528912, 40.388783, 35.565342, 44.572021, 40.590752, 41.680893, 33.856892,
               44.299782, 35.747845, 31.054487, 40.150032, 44.045876, 37.769337, 47.400902, 38.491226, 44.268543, 42.755966)
point.lon <- c(-86.791130, -152.404419, -111.431221, -92.373123, -119.681564, -105.311104, -72.755371, -75.507141, -81.686783, -83.643074,
               -157.498337, -114.478828, -88.986137, -86.258278, -93.210526, -96.726486, -84.670067, -91.867805, -69.381927, -76.802101,
               -71.530106, -84.536095, -93.900192, -89.678696, -92.288368, -110.454353, -98.268082, -117.055374, -71.563896, -74.521011,
               -106.248482, -74.948051, -79.806419, -99.784012, -82.764915, -96.928917, -122.070938, -77.209755, -71.511780, -80.945007,
               -99.438828, -86.692345, -97.563461, -111.862434, -72.710686, -78.169968, -121.490494, -80.954453, -89.616508, -107.302490)

point <- data.frame(state=point.state, lon=point.lon, lat=point.lat)


#Adding geopoints to the dataframes LTR/Detractors
LTRmeans <- LTRmeans %>% mutate(lat=point$lat[match(state,point$state)], lon=point$lon[match(state,point$state)])
Detractors <- Detractors %>% mutate(lat=point$lat[match(state,point$state)], lon=point$lon[match(state,point$state)])


#Reappointing latitude and longitude for Alaska
LTRmeans$lon <- ifelse(LTRmeans$state == "alaska", -117.404419, LTRmeans$lon)
LTRmeans$lat <- ifelse(LTRmeans$state == "alaska", 28.370716, LTRmeans$lat)
Detractors$lon <- ifelse(Detractors$state == "alaska", -117.404419, Detractors$lon)
Detractors$lat <- ifelse(Detractors$state == "alaska", 28.370716, Detractors$lat)

#Reappointing latitude and longitude for Hawaii
LTRmeans$lon <- ifelse(LTRmeans$state == "hawaii", -104.498337, LTRmeans$lon)
LTRmeans$lat <- ifelse(LTRmeans$state == "hawaii", 24.094318, LTRmeans$lat)
Detractors$lon <- ifelse(Detractors$state == "hawaii", -104.498337, Detractors$lon)
Detractors$lat <- ifelse(Detractors$state == "hawaii", 24.094318, Detractors$lat)

#Drawing a graph of LTR on US map, adding layers
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


#Drawing a graph of Detractors on US map, adding layers
USmapDet <- ggplot(Detractors, aes(map_id = state)) + geom_map(map = fifty_states, aes(fill=Detractor), color="black") 
USmapDet <- USmapDet + expand_limits(x = fifty_states$long, y = fifty_states$lat)
USmapDet <- USmapDet + coord_map() + ggtitle("Map of the USA filled by number of Detractors")
USmapDet <- USmapDet + fifty_states_inset_boxes() 
USmapDet <- USmapDet + scale_fill_gradient(low = "lightblue",high = "darkblue")

#Adding a layer with points
USmapDet <- USmapDet + geom_point(data=Detractors, aes(x=lon, y=lat, color=Detractor, size=Detractor)) + scale_colour_gradient(low = 'yellow', high='red')

#Scaling points by radius
#USmapDet <- USmapDet + scale_radius(aes(size=Detractors$Detractor))

# Creating png for the map.
png(filename="map_usa_Detractor.png", width=800, height=600)
USmapDet
dev.off()


#LTRmeans[order(LTRmeans$LTR),]
#Detractors[order(Detractors$Detractor),]


## end your R code and logic 

####################################
##### write output file ############
# add your R code to write heat_hc_rs.png
####################################


		





