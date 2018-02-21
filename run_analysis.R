#set the WD where X_test and X_train sets are located

setwd("~/JHU/DataScience/CleanObtainData/Week4/project")

#read the two data sets to objects X and Y

X<-read.fwf("X_test.txt",c(2,14,rep(c(1,15),290),1,9))
Y<-read.fwf("X_train.txt",c(2,14,rep(c(1,15),290),1,9))

#remove empty columns. Both data frames should have 292 columns

X<-X[,!apply(X, 2, function(x) all(gsub(" ", "", x)=="", na.rm=TRUE))]
Y<-Y[,!apply(Y, 2, function(x) all(gsub(" ", "", x)=="", na.rm=TRUE))]
X<-X[,-1]
Y<-Y[,-1]

#Merges the training and the test sets to create one data set

df<-rbind(X,Y)

# Extracts only the measurements on the mean and standard deviation for each measurement.

m<-colMeans(df)
sd<-apply(df, 2, sd)

# Uses descriptive activity names to name the activities in the data set
# features.txt contains the activity names. It was converted to CSV to be 
# read in R

n<-read.csv("features.csv")

# Appropriately labels the data set with descriptive variable names.
# names in n are under the ActivityName header

colnames(df) <- n$ActivityName[1:292]

# From the df, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

df2<-rbind(df,m)




