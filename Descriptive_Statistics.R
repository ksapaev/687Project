#####################################
##### Do NOT delete this block #####
setwd(Sys.getenv('PROJECT_HOME'))
####################################

####################################
## write code to read input csv into data frame
df <- read.csv('data.csv')
####################################

## start writing your R code from here

library(modeest)


#Statistics for LTR

summary(df$LTR)
sd(df$LTR)
mfv(df$LTR)
quantile(df$LTR, probs=c(0.01, 0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 0.95, 0.99))



#Statistics for Overall Satisfaction

summary(df$Overall_Satisfaction)
sd(df$Overall_Satisfaction)
mfv(df$Overall_Satisfaction)
quantile(df$Overall_Satisfaction, probs=c(0.01, 0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 0.95, 0.99))



#Statistics for Hotel Condition

summary(df$Hotel_Condition)
sd(df$Hotel_Condition)
mfv(df$Hotel_Condition)
quantile(df$Hotel_Condition, probs=c(0.01, 0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 0.95, 0.99))



#Statistics for Staff Cared

summary(df$Staff_Cared)
sd(df$Staff_Cared)
mfv(df$Staff_Cared)
quantile(df$Staff_Cared, probs=c(0.01, 0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 0.95, 0.99))



#Statistics for Customer Service

summary(df$Customer_Service)
sd(df$Customer_Service)
mfv(df$Customer_Service)
quantile(df$Customer_Service, probs=c(0.01, 0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 0.95, 0.99))



#Statistics for Check In

summary(df$CheckIn)
sd(df$CheckIn)
mfv(df$CheckIn)
quantile(df$CheckIn, probs=c(0.01, 0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 0.95, 0.99))



#Statistics for Guest Room Satisfaction

summary(df$Room_Satisfy)
sd(df$Room_Satisfy)
mfv(df$Room_Satisfy)
quantile(df$Room_Satisfy, probs=c(0.01, 0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 0.95, 0.99))



#Statistics for Length of Stay

summary(df$LengthStay)
sd(df$LengthStay)
mfv(df$LengthStay)
quantile(df$LengthStay, probs=c(0.01, 0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 0.95, 0.99))

hist(rnorm(length(df$LengthStay), mean = mean(df$LengthStay), sd = sd(df$LengthStay)), main = "Normal Distribution",
    xlab = "Distribution of Length of Stay")



#Statistics for Revenue

summary(df$Revenue)
sd(df$Revenue)
mfv(df$Revenue)
quantile(df$Revenue, probs=c(0.01, 0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 0.95, 0.99))

hist(rnorm(length(df$Revenue), mean = mean(df$Revenue), sd = sd(df$Revenue)), main = "Normal Distribution",
     xlab = "Distribution of Revenue")



#Histograms
png(filename="LTR.png", width=800, height=600)
HistogramLTR <- hist(df$LTR, main="Histogram for Likelihood to recommend", xlab= "Likelihood to Recommend", border="blue", col="orange",
                     xlim=c(0,10), las=1, breaks=15)
dev.off()

png(filename="RoomSatisfaction.png", width=800, height=600)
HistogramRoomSat <- hist(data$Room_Satisfy, main="Histogram for Room Satisfaction", xlab= "Room Satisfaction", border="blue", col="green",
                         xlim=c(0,10), las=1, breaks=15)
dev.off()

png(filename="CheckIn.png", width=800, height=600)
HistogramCheckIn <- hist(data$CheckIn, main="Histogram for Check in", xlab= "Check In", border="blue", col="yellow",
                         xlim=c(0,10), las=1, breaks=15)
dev.off()


HistogramHotelC <- hist(data$Hotel_Condition, 
                        main="Histogram for Hotel Condition", 
                        xlab= "Hotel Condition", 
                        border="blue", 
                        col="purple",
                        xlim=c(0,10),
                        las=1, 
                        breaks=15)

HistogramCustServ <- hist(data$Customer_Service, 
                          main="Histogram for Customer Service", 
                          xlab= "Customer Service", 
                          border="blue", 
                          col="red",
                          xlim=c(0,10),
                          las=1, 
                          breaks=15)

HistogramStaffCared <- hist(data$Staff_Cared, 
                            main="Histogram for Staff Cared", 
                            xlab= "Staff Care", 
                            border="blue", 
                            col="grey",
                            xlim=c(0,10),
                            las=1, 
                            breaks=15)
#Create PNG file







png(filename="HistogramHotelC.png", width=800, height=600)
plot(HistogramHotelC)
dev.off()

png(filename="HistogramCustServ.png", width=800, height=600)
plot(HistogramCustServ)
dev.off()

png(filename="HistogramStaffCared.png", width=800, height=600)
plot(HistogramStaffCared)
dev.off()


## end your R code and logic 

####################################
##### write output file ############
# add your R code to write RoomSatisfaction.png
####################################



