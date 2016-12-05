getwd()
setwd("C:/Users/Matthew/Documents/school/coursera/GettingAndCleaning/project/UCI HAR Dataset/All Files")
list.files()#I put all files into one working directory, including un-necessary intertial files.

#require some useful packages
library(dplyr)
library(tidyr)
library(reshape)

#first find the lables for the "x" component of the data
features <- read.table(file.choose())
#View(features)
features <- features[,2]
features <- as.vector(features)




activities <- read.table(file.choose(), sep=" " )
#View(activities)
activities <- (activities[,2])
activities <- as.vector(activities)
#activities

#read in test--should be 2947 obs. 
ts.sub <-read.table(file.choose())
ts.x <-read.table(file.choose())


ts.y <-read.table(file.choose())
ts.df <- cbind(ts.sub, ts.x, ts.y)
names(ts.df) = c("subject", features, "activity")


#read in training -- should be 7352-obs
tr.sub <-read.table(file.choose())
#reading in train "x" takes some time
tr.x <-read.table(file.choose())
tr.y <- read.table(file.choose())
tr.df<- (cbind(tr.sub, tr.x, tr.y))
names(tr.df)<-c("subject", features, "activity")
#View(tr.df)
#merge ts.df and tr.df sets, then call it tr.td 
tr.td <- rbind(tr.df, ts.df) 
#View(tr.td)

#Let's change the activities column to rational names 
#tr.td$activity 
#activities
tr.td$activity <- as.factor(tr.td$activity)

tmp <-tr.td$activity
#activities
levels(tmp)<- c("WALKING", "WALKING_UPSTAIRS","WALKING_DOWNSTAIRS",
                 "SITTING", "STANDING" ,"LAYING")
#tmp
#head(tr.td$activity,25)
#head(tmp,25)

tr.td$activity <- tmp 

#remove extraneous columns 
extract<- grep( "mean\\(\\)|std\\(\\)",features, value = FALSE)
#extract
#features[extract]

tmp3 <- tr.td
extract <- (extract+1) #the first column index is subject
#extract
sub.td <- tmp3 
sub.td <- cbind(sub.td$subject,sub.td[extract],sub.td$activity)
sub.td
#replace tBody<-TotalBody, Acc<-Acceleration, Mag<-Magnitude, fBody<-FourierTransformed, 
#Gyro<-_Gyroscope. I chose to do this manually so as to avoid errors, but using regex would be possible too
names(sub.td)<-c  ("Subject", "TotalBodyAcceleration-mean()-X","TotalBodyAcceleration-mean()-Y" ,      
  "TotalBodyAcceleration-mean()-Z",           "TotalBodyAcceleration-std()-X",            "TotalBodyAcceleration-std()-Y",           
  "TotalBodyAcceleration-std()-Z",            "TotalGravityAcceleration-mean()-X",        "TotalGravityAcceleration-mean()-Y",       
 "TotalGravityAcceleration-mean()-Z" ,       "TotalGravityAcceleration-std()-X",         "TotalGravityAcceleration-std()-Y",        
 "TotalGravityAcceleration-std()-Z",         "TotalBodyAccelerationJerk-mean()-X",       "TotalBodyAccelerationJerk-mean()-Y",      
 "TotalBodyAccelerationJerk-mean()-Z",       "TotalBodyAccelerationJerk-std()-X",        "TotalBodyAccelerationJerk-std()-Y",       
 "TotalBodyAccelerationJerk-std()-Z",        "TotalBody_Gyroscope-mean()-X",          "TotalBody_Gyroscope-mean()-Y",         
 "TotalBody_Gyroscope-mean()-Z",          "TotalBody_Gyroscope-std()-X",           "TotalBody_Gyroscope-std()-Y",          
 "TotalBody_Gyroscope-std()-Z",           "TotalBody_GyroscopeJerk-mean()-X",      "TotalBody_GyroscopeJerk-mean()-Y",     
 "TotalBody_GyroscopeJerk-mean()-Z" ,     "TotalBody_GyroscopeJerk-std()-X",       "TotalBody_GyroscopeJerk-std()-Y",      
 "TotalBody_GyroscopeJerk-std()-Z",       "TotalBodyAccelerationMagnitude-mean()",          "TotalBodyAccelerationMagnitude-std()",          
 "TotalGravityAccelerationMagnitude-mean()",       "TotalGravityAccelerationMagnitude-std()",        "TotalBodyAccelerationJerkMagnitude-mean()",     
 "TotalBodyAccelerationJerkMagnitude-std()",       "TotalBody_GyroscopeMagnitude-mean()",         "TotalBody_GyroscopeMagnitude-std()",         
 "TotalBody_GyroscopeJerkMagnitude-mean()",     "TotalBody_GyroscopeJerkMagnitude-std()",      "FourierTransformBodyAcceleration-mean()-X",          
 "FourierTransformBodyAcceleration-mean()-Y",           "FourierTransformBodyAcceleration-mean()-Z" ,          "FourierTransformBodyAcceleration-std()-X",           
 "FourierTransformBodyAcceleration-std()-Y",            "FourierTransformBodyAcceleration-std()-Z",            "FourierTransformBodyAccelerationJerk-mean()-X",      
"FourierTransformBodyAccelerationJerk-mean()-Y",       "FourierTransformBodyAccelerationJerk-mean()-Z",       "FourierTransformBodyAccelerationJerk-std()-X",       
"FourierTransformBodyAccelerationJerk-std()-Y",        "FourierTransformBodyAccelerationJerk-std()-Z",        "FourierTransformBody_Gyroscope-mean()-X",        
 "FourierTransformBody_Gyroscope-mean()-Y",          "FourierTransformBody_Gyroscope-mean()-Z",          "FourierTransformBody_Gyroscope-std()-X",          
 "FourierTransformBody_Gyroscope-std()-Y",           "FourierTransformBody_Gyroscope-std()-Z",          "FourierTransformBodyAccelerationMagnitude-mean()",         
"FourierTransformBodyAccelerationMagnitude-std()",          "FourierTransformBodyBodyAccelerationJerkMagnitude-mean()",  "FourierTransformBodyBodyAccelerationJerkMagnitude-std()",  
 "FourierTransformBodyBody_GyroscopeMagnitude-mean()",     "FourierTransformBodyBody_GyroscopeMagnitude-std()",      "FourierTransformBodyBody_GyroscopeJerkMagnitude-mean()",
 "FourierTransformBodyBody_GyroscopeJerkMagnitude-std()",  "Activity") 

#produce tidydataset of mean by activity and mean by subject. It goes to the home directory 
output <- melt(sub.td,id=c("Subject", "Activity"))
output2 <- cast(output, Subject + Activity ~ variable, mean)
output2
write.table(output2, file="tidyoutput.txt", sep= ",", row.name = FALSE)
