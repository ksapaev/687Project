#####################################
##### Do NOT delete this block #####
setwd(Sys.getenv('PROJECT_HOME'))
####################################

####################################
## write code to read input csv into data frame
df <- read.csv('data.csv')
####################################

## start writing your R code from here


library(ggplot2)

#Linear model for Likelihood to Recommend

#LTR - StaffCared
LinModLTR <- lm(formula=LTR ~ Staff_Cared, data=df)
summary(LinModLTR)

plot <- ggplot(df, aes(x=Staff_Cared, y=LTR)) +geom_count()+ stat_smooth(method = "lm", formula = y ~ x, se = FALSE, col = "red") 
plot <- plot + labs(x = "Staff Cared", y = "Likelihood to Recommend")
plot <- plot  + coord_fixed() + theme_minimal() + scale_x_continuous( breaks = 1:10)+ scale_y_continuous( breaks = 1:10)

png(filename="LTR_StaffCared.png", width=800, height=600)
plot
dev.off()

#LTR - RoomSatisfy
LinModLTR <- lm(formula=LTR ~ Room_Satisfy, data=df)
summary(LinModLTR)

plot <- ggplot(df, aes(x=Room_Satisfy, y=LTR)) +geom_count()+ stat_smooth(method = "lm", formula = y ~ x, se = FALSE, col = "red") 
plot <- plot + labs(x = "Room Satisfied", y = "Likelihood to Recommend")
plot <- plot  + coord_fixed() + theme_minimal() + scale_x_continuous( breaks = 1:10)+ scale_y_continuous( breaks = 1:10)

png(filename="LTR_RoomSatisfied.png", width=800, height=600)
plot
dev.off()

#LTR - CustomerService
LinModLTR <- lm(formula=LTR ~ Customer_Service, data=df)
summary(LinModLTR)

plot <- ggplot(df, aes(x=Customer_Service, y=LTR)) +geom_count()+ stat_smooth(method = "lm", formula = y ~ x, se = FALSE, col = "red") 
plot <- plot + labs(x = "Customer Service", y = "Likelihood to Recommend")
plot <- plot  + coord_fixed() + theme_minimal() + scale_x_continuous( breaks = 1:10)+ scale_y_continuous( breaks = 1:10)

png(filename="LTR_CustomerService.png", width=800, height=600)
plot
dev.off()


#LTR - StaffCared + RoomSatisfy + CustomerService + LengthOfStay
#Length of Stay is statically not significant at 5% level
LinModLTR <- lm(formula=LTR ~ Customer_Service + Staff_Cared + Room_Satisfy + LengthStay, data=df)
summary(LinModLTR)


#LTR - StaffCared + RoomSatisfy + CustomerService
LinModLTR <- lm(formula=LTR ~ Customer_Service + Staff_Cared + Room_Satisfy, data=df)
summary(LinModLTR)

plot <- ggplot(df, aes(x=Customer_Service + Staff_Cared + Room_Satisfy, y=LTR)) +geom_count()+ stat_smooth(method = "lm", formula = y ~ x, se = FALSE, col = "red") 
plot <- plot + labs(x = "Customer Service, Staff Cared, and Room Satisfied", y = "Likelihood to Recommend")
plot <- plot  + theme_minimal() + scale_y_continuous( breaks = 1:10)

png(filename="LTR_All.png", width=800, height=600)
plot
dev.off()

#############


#Create dataframe of sample 10 elements
test <- df[sample(df$LTR, 10, replace=FALSE),]

#Test/predict the dataframe with 10 elements
LTRtest <- predict(LinModLTR, test, type="response")
ifelse(LTRtest<7, "Detractor", "Not Detractor")


test$LTR
LTRtest



## end your R code and logic 

####################################
##### write output file ############
# add your R code to write output file
####################################


