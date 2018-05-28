#####################################
##### Do NOT delete this block #####
setwd(Sys.getenv('PROJECT_HOME'))
####################################

####################################
## write code to read input csv into data frame
NewDF <- read.csv('rules_data.csv')
####################################

## start writing your R code from here


##RIGHT HAND SIDE as NPS types (Detractor, Passive, or Promoter)

#Creating a transaction from the dataset
trans <- as(NewDF, "transactions")
summary(trans)
itemLabels(trans)

#################
#Frequency of support parameter
png(filename="Frequency.png", width=800, height=600)
itemFrequencyPlot(trans, support=0.05, cex.names=0.9)
dev.off()

################
#Creating rules with RHS for DETRACTOR
NPSrulesDet <- apriori(trans, parameter = list(support = 0.01, confidence = 0.1, minlen = 2, target="rules"), 
                       appearance = list(rhs = "NPS=Detractor", default="lhs"))

summary(NPSrulesDet)

#Sorting rules by support and confidence    
top.support.det <- sort(NPSrulesDet, decreasing = TRUE, na.last = NA, by = "support")
top.confidence.det <- sort(NPSrulesDet, decreasing = TRUE, na.last = NA, by = "confidence")


#Plotting the rules
inspect(head(top.support.det,10))
inspect(head(top.confidence.det,10))

png(filename="DetSupport.png", width=800, height=600)
plot(top.support.det)
dev.off()

png(filename="DetConfidence.png", width=800, height=600)
plot(top.confidence.det)
dev.off()


###############
#Creating rules with RHS for Promoter
NPSrulesPro <- apriori(trans, parameter = list(support = 0.1, confidence = 0.5, minlen = 2, target="rules"), 
                       appearance = list(rhs = "NPS=Promoter", default="lhs"))

summary(NPSrulesPro)

#Sorting rules by support and confidence    
top.support.pro <- sort(NPSrulesPro, decreasing = TRUE, na.last = NA, by = "support")
top.confidence.pro <- sort(NPSrulesPro, decreasing = TRUE, na.last = NA, by = "confidence")


#Plotting the rules
inspect(head(top.support.pro, 10))
inspect(head(top.confidence.pro, 10))

png(filename="ProSupport.png", width=800, height=600)
plot(top.support.pro)
dev.off()

png(filename="ProConfidence.png", width=800, height=600)
plot(top.confidence.pro)
dev.off()


##############
#Creating good rules for detractors
goodrulesetdet <- NPSrulesDet[quality(NPSrulesDet)$lift>1.12]
inspect(goodrulesetdet)

#Creating good rules for promoters
goodrulesetpro <- NPSrulesPro[quality(NPSrulesPro)$lift>1.045]
inspect(goodrulesetpro)

#Plotting the rules
png(filename="GoodRulesDetractor.png", width=800, height=600)
plot(goodrulesetdet)
dev.off()

png(filename="GoodRulesPromoter.png", width=800, height=600)
plot(goodrulesetpro)
dev.off()


## end your R code and logic 

####################################
##### write output file ############
# add your R code to write ProConfidence.png
####################################






