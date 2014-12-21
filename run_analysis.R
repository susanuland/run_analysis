#run_analysis.r  (Project for Coursera Clean Data Course)
# combine the training and test data into one data set keeping only data values for variables containing mean() or std()
# Assume working directory is set to be folder above UCI HAR Dataset

# Read in Features

features=read.table("./UCI HAR Dataset/features.txt",header=FALSE)

# Read in Testing Data

xtstdat=read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)  #has 2947 rows, 561 columns
ytstlab=read.table("./UCI HAR Dataset/test/Y_test.txt", header=FALSE)
subtst=read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)

#Read in Training Data

xtraindat=read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE) #has 7352 rows, 561 columns
ytrainlab=read.table("./UCI HAR Dataset/train/Y_train.txt")
subtrain=read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)


#add column names to test data
for(i in 1:561){
  names(xtstdat)[i]<-as.character(features$V2[i])
}
subject=subtst$V1
activity=ytstlab$V1
#combine columns: subject, activity, and 561 test data columns
subActTstDat=cbind(subject,activity,xtstdat)

#add column names to train data
for(i in 1:561){
  names(xtraindat)[i]<-as.character(features$V2[i])
}
subject=subtrain$V1  #want to add subject column label 
activity=ytrainlab$V1 #want to add activity column label
#combine columns: subject, activity, and 561 training data columns
subActTrainDat=cbind(subject,activity,xtraindat)

#combine the test and training data
mergedDat=rbind(subActTstDat,subActTrainDat)

#Create Vector of feature indexes that contain mean() and std()
meanStdIndex=c(1,2,3,4,5,6,7,8,43,44,45,46,47,48,83,84,85,86,
               87,88,123,124,125,126,127,128,163,164,165,166,
               167,168,203,204,216,217,229,230,242,243,255,
               256,268,269,270,271,272,273,347,348,349,350,351,
               352,426,427,428,429,430,431,505,506,518,519,531,532,
               544,545)

#just keep the 66 out 561 training data columns that have mean() or std()
MeanStdDat=mergedDat[,meanStdIndex]


# use aggregate to calculate averages for all subject/activity/variable
# For example           Subject 1/STANDING/tBodyAcc-mean()-X  answer=0.278918
aggdata<-aggregate(MeanStdDat, by=list(MeanStdDat$subject,MeanStdDat$activity),FUN=mean)
newdata<-as.data.frame(aggdata[,3:68])

# sort the data by subject and activity
sortdata<-newdata[order(newdata$subject,newdata$activity),]

#put in descriptive labels for activity lables
sortdata$activity=factor(sortdata$activity,labels=c("WALKING", "WALK_UP_STAIR","WALK_DOWN_STAIR","SITTING","STANDING","LAYING"))

# write out tidy data file
write.table(sortdata,file="tidysmartphonedata.txt",row.name=FALSE)


