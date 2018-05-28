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

#LTR - CheckIn
LinModLTR <- lm(formula=LTR ~ CheckIn, data=df)
summary(LinModLTR)

plot <- ggplot(df, aes(x=CheckIn, y=LTR)) +geom_count()+ stat_smooth(method = "lm", formula = y ~ x, se = FALSE, col = "red") 
plot <- plot + labs(x = "Check In", y = "Likelihood to Recommend")
plot <- plot  + coord_fixed() + theme_minimal() + scale_x_continuous( breaks = 1:10)+ scale_y_continuous( breaks = 1:10)

png(filename="LTR_CheckIn.png", width=800, height=600)
plot
dev.off()

#LTR - HotelCondition
LinModLTR <- lm(formula=LTR ~ Hotel_Condition, data=df)
summary(LinModLTR)

plot <- ggplot(df, aes(x=Hotel_Condition, y=LTR)) +geom_count()+ stat_smooth(method = "lm", formula = y ~ x, se = FALSE, col = "red") 
plot <- plot + labs(x = "Hotel Condition", y = "Likelihood to Recommend")
plot <- plot  + coord_fixed() + theme_minimal() + scale_x_continuous( breaks = 1:10)+ scale_y_continuous( breaks = 1:10)

png(filename="LTR_HC.png", width=800, height=600)
plot
dev.off()


#LTR - CheckIn + HotelCondition
LinModLTR <- lm(formula=LTR ~ Hotel_Condition + CheckIn, data=df)
summary(LinModLTR)

plot <- ggplot(df, aes(x=Hotel_Condition+CheckIn, y=LTR)) +geom_count()+ stat_smooth(method = "lm", formula = y ~ x, se = FALSE, col = "red") 
plot <- plot + labs(x = "Hotel Condition and Check In", y = "Likelihood to Recommend")
plot <- plot  + theme_minimal() + scale_y_continuous( breaks = 1:10)

png(filename="LTR_CheckIn_HC.png", width=800, height=600)
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


