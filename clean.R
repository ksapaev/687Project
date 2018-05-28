#####################################
##### Do NOT delete this block #####
setwd(Sys.getenv('PROJECT_HOME'))
####################################

####################################
## write code to read input csv into data frame
raw <- read.csv('raw_data.csv')
####################################

## start writing your R code from here

#Converting State abbrivations, room types, and cities as Characters
raw$STATE_R <- as.character(raw$STATE_R)
raw$ROOM_TYPE_CODE_R <- as.character(raw$ROOM_TYPE_CODE_R)
raw$City_PL <- as.character(raw$City_PL)

#Filtering by US states and saving the dataset as "df"
df <- raw[raw$STATE_R %in% state.abb,]

#Selecting necessary columns for the project under the dataset "project"
project <- data.frame(LTR = df$Likelihood_Recommend_H, Overall_Satisfaction = df$Overall_Sat_H, Hotel_Condition = df$Condition_Hotel_H, Staff_Cared = df$Staff_Cared_H,
                      Customer_Service = df$Customer_SVC_H, CheckIn = df$Check_In_H, Room_Satisfy = df$Guest_Room_H, NPS = df$NPS_Type, 
                      Reservation = df$RESERVATION_DATE_R, CheckInDate = df$CHECK_IN_DATE_C, CheckOutDate = df$CHECK_OUT_DATE_C, 
                      LengthStay = df$LENGTH_OF_STAY_C, RoomType = df$ROOM_TYPE_CODE_R, StateAbb = df$STATE_R, AgeRange = df$Age_Range_H, Gender = df$Gender_H,
                      GP_Tier = df$GP_Tier, POV = df$POV_CODE_C, Brand = df$Brand_PL, City = df$City_PL, 
                      Country = df$Country_PL, Region = df$Region_PL, Location = df$Location_PL, Longitude = df$Property.Longitude_PL, Latitude = df$Property.Latitude_PL, DomInt = df$Dom.Int.l_PL, Revenue = df$REVENUE_USD_R, 
                      Class = df$Class_PL , BookingChannel = df$Booking_Channel, Relationship = df$Relationship_PL, stringsAsFactors=FALSE)

#Dropping all rows with NAs
project <- project[complete.cases(project), ]

#Converting state abbrivations, room types, and cities as factors
project$StateAbb <- as.factor(project$StateAbb)
project$RoomType <- as.factor(project$RoomType)
project$City <- as.factor(project$City)

#Redefining levels of GP_Tier, grouping duplicate levels
levels(project$GP_Tier) <- c("None", "None", "Courtesy", "Diamond", "Diamond", "Gold", "Gold", "Lifetime Diamond", "Lifetime Diamond", "Platinium", "Platinium")

#Removing unknown Age Group
project <- project[project$AgeRange %in% levels(project$AgeRange)[-1],]

#Adding regions column to the dataset according to the states
project$StateRegion <- state.region[match(project$StateAbb, state.abb)]

#Counting row names from beginning
rownames(project) <- NULL

#str(project)
#str(project$GP_Tier)
#head(project,20)
#summary(project)
#summary(project$GP_Tier, maxsum = length(levels(project$GP_Tier)))



## end your R code and logic 

####################################
##### write output file ############
write.csv(project, file = 'data.csv')
####################################

