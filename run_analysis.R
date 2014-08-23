##importing data
xTest<-read.table("./ProjectData/test/X_test.txt", header=TRUE)
yTest<-read.table("./ProjectData/test/y_test.txt", header=TRUE)
subjectTest<-read.table("./ProjectData/test/subject_test.txt", header=TRUE)

xTrain<-read.table("./ProjectData/train/X_train.txt", header=TRUE)
yTrain<-read.table("./ProjectData/train/y_train.txt", header=TRUE)
subjectTrain<-read.table("./ProjectData/train/subject_train.txt", header=TRUE)

##setting the names equal so i can use rbind
names(xTest)<-names(xTrain)
##binding test data and training data
completeData<-rbind(xTest,xTrain)

##assigning variable names to the columns
variableNamesData<-read.table("./ProjectData/features.txt")
names(completeData)<-variableNamesData$V2

##selecting columns having mean or std
columnsToSelect<-grep("mean()|std()", names(completeData))
completeData<-completeData[,columnsToSelect]

##creating a new column for Activity Names in Test Data
for(i in 1:length(yTest$X5)){
  if(yTest$X5[i]==1)
    yTest$ActivityNames[i]= "Walking"
  if(yTest$X5[i]==2)
    yTest$ActivityNames[i]= "Walking_Upstairs"
  if(yTest$X5[i]==3)
    yTest$ActivityNames[i]= "Walking_Downstairs"
  if(yTest$X5[i]==4)
    yTest$ActivityNames[i]= "Sitting"
  if(yTest$X5[i]==5)
    yTest$ActivityNames[i]= "Standing"
  if(yTest$X5[i]==6)
    yTest$ActivityNames[i]= "Laying"         
}

##creating a new column for Activity Names in Training Data
for(i in 1:length(yTrain$X5)){
  if(yTrain$X5[i]==1)
    yTrain$ActivityNames[i]= "Walking"
  if(yTrain$X5[i]==2)
    yTrain$ActivityNames[i]= "Walking_Upstairs"
  if(yTrain$X5[i]==3)
    yTrain$ActivityNames[i]= "Walking_Downstairs"
  if(yTrain$X5[i]==4)
    yTrain$ActivityNames[i]= "Sitting"
  if(yTrain$X5[i]==5)
    yTrain$ActivityNames[i]= "Standing"
  if(yTrain$X5[i]==6)
    yTrain$ActivityNames[i]= "Laying"         
}

activityNamesData<-rbind(yTest,yTrain)

##adding the Activity Name column as the 1st column in completeData
completeData<-cbind(activityNamesData$ActivityNames,completeData)

##adding subject data in completeData
names(subjectTest)<-names(subjectTrain)
subjectsData<-rbind(subjectTest,subjectTrain)
names(subjectsData)<-c("Subject")
completeData<-cbind(subjectsData$Subject,completeData)

##saving the data frame as a txt file
write.table(completeData, file="./CleanData.txt", row.name=FALSE)


##################################
## creating 2nd dataset
secondCompleteData<-rbind(xTest,xTrain)
names(secondCompleteData)<-variableNamesData$V2
secondCompleteData<-cbind(activityNamesData$ActivityNames,secondCompleteData)
secondCompleteData<-cbind(subjectsData$Subject,secondCompleteData)

## running aggregate function to get means
answer<-aggregate(secondCompleteData[,3:ncol(secondCompleteData)], list(subject=secondCompleteData[,1], Activity=secondCompleteData[,2]),mean)
write.table(answer, file="./AggregatedData.txt", row.name=FALSE)