library(dplyr)

##Loading features names into 'features' data frame
  features <- read.csv("UCI HAR Dataset/features.txt", header = FALSE, sep="", col.names =  c("featureid", "featuredescription"))
  
##Loading activity lables into 'activitydicitonary' data frame
  activitylabels <- read.csv("UCI HAR Dataset/activity_labels.txt", header = FALSE, sep="", col.names = c("activityid", "activitydescription"))

##Loading y_train.txt into 'ytrain' data frame which identifies performed activity
  ytrain <- read.csv("UCI HAR Dataset/train/y_train.txt", header = FALSE, col.names = c("activityid"))
##Loading y_test.txt into 'ytest' data frame which identifies performed activity
  ytest <- read.csv("UCI HAR Dataset/test/y_test.txt", header = FALSE, col.names = c("activityid"))
##Loading subject_train.txt into 'subjecttrain' data frame which identifies subject who performed given activity
  subjecttrain <- read.csv("UCI HAR Dataset/train/subject_train.txt", header = FALSE, col.names = c("subjectid"))
##Loading subject_test.txt into 'subjectest' data frame which identifies subject who performed given activity
  subjectest <- read.csv("UCI HAR Dataset/test/subject_test.txt", header = FALSE, col.names = c("subjectid"))

##Loading X_train.txt  into xtrain data frame
  xtrain <- read.csv("UCI HAR Dataset/train/X_train.txt", header = FALSE, sep ="")
##Loading X_test.txt and X_test.txt into xtest data frame
  xtest <- read.csv("UCI HAR Dataset/test/X_test.txt", header = FALSE, sep ="")

##Adding column names and extending original xtrain dataset with subject and acitvity information
  #Adding activity description (left join) and initializing output data set
  datasetTrain <- merge(x=ytrain, y = activitylabels, by.x = "activityid", by.y = "activityid", all.x = TRUE, all.y = FALSE)
  datasetTest <- merge(x=ytest, y = activitylabels, by.x = "activityid", by.y = "activityid", all.x = TRUE, all.y = FALSE)
  #Combining ytrain and subjecttrain
  datasetTrain <- cbind(subjecttrain, datasetTrain)
  datasetTest <- cbind(subjectest, datasetTest)
  #Adding descriptive names 
  colnames(xtrain) <- as.vector(features$featuredescription)
  colnames(xtest) <- as.vector(features$featuredescription)
  #Adding xtrain into output data set
  datasetTrain <- cbind(datasetTrain, xtrain)
  datasetTest <- cbind(datasetTest, xtest)

  outputDataSet <- rbind(datasetTest, datasetTrain)
  
  outputDataSet <- outputDataSet[,grep("mean|subjectid|activity|std", colnames(outputDataSet))]
##Remove unsued objects from memory
  remove(list = c("activitylabels", "xtrain", "ytrain", "subjecttrain","features", "xtest", "ytest", "subjectest", "datasetTrain", "datasetTest"))

##Calculate average for all measures in outputDataSet
by_activity_subject <-  group_by(outputDataSet, activityid, subjectid, activitydescription)
aggr_data<-summarise_all(by_activity_subject, mean)

#Save output data into text file
write.table(aggr_data, "aggr_data.txt", row.names = FALSE)
