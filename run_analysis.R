library(data.table)
library(reshape2)
# download and unzip dataset
if(!file.exits("./data")){dir.create("./data")}
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile= "./data/data.zip")
unzip("data.zip",exdir="./data")

#reading files
#reading training tables
X_train<-read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("./data/UCI HAR Dataset/train/subject_train.txt")
#reading test tables
X_test<-read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("./data/UCI HAR Dataset/test/subject_test.txt")
#reading feature vector:
features<-read.table("./data/UCI HAR Dataset/features.txt")
#reading activity labels:
activitylabels<-read.table("./data/UCI HAR Dataset/activity_labels.txt")

#assign columns names
colnames(X_train)<-features[,2]
colnames(y_train)<-"activityID"
colnames(subject_train)<-"subjectID"
colnames(X_test)<-features[,2]
colnames(y_test)<-"activityID"
colnames(subject_test)<-"subjectID"
colnames(activitylabels)<-c("activityID","activityname")
#merging datas
trainmerge<-cbind(y_train,subject_train,X_train)
testmerge<-cbind(y_test,subject_test,X_test)
alldata<-rbind(trainmerge,testmerge)

#extract only the measurements on the mean and standard deviation for each measurement
#reading columns names
colNames<-colnames(alldata)
meanstd<-c(grepl("activityID",colNames)|
             grepl("subjectID",colNames)|
             grepl("mean..",colNames)|
            grepl("std..",colNames))
meanstddata<-alldata[,meanstd==TRUE]

#Uses descriptive activity names to name the activities in the data set
# labels the data set with descriptive variable names
descrinames<-merge(activitylabels,meanstddata,by="activityID",all=TRUE)
datamelt<-melt(descrinames,id=c("activityID","activityname","subjectID"))

#create a tidy,independent dataset accoding to average of each variable for each activity and each subject.
meandata<-dcast(datamelt,activityID+activityname+subjectID~variable,mean)
write.table(meandata,"./tidydata.txt")
