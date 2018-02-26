#read the two data sets to objects X and Y. Labels to Xl y Yl

X<-read.fwf("./UCI HAR Dataset/test/X_test.txt",c(2,14,rep(c(1,15),560)))
Y<-read.fwf("./UCI HAR Dataset/train/X_train.txt",c(2,14,rep(c(1,15),560)))

# Activity_Labels are columns, go to Xl y Yl

Xl<-read.fwf("./UCI HAR Dataset/test/Y_test.txt",c(1))
Yl<-read.fwf("./UCI HAR Dataset/train/Y_train.txt",c(1))

#remove empty columns. Both data frames should have 292 columns

X<-X[,!apply(X, 2, function(x) all(gsub(" ", "", x)=="", na.rm=TRUE))]
Y<-Y[,!apply(Y, 2, function(x) all(gsub(" ", "", x)=="", na.rm=TRUE))]
X<-X[,-1]
Y<-Y[,-1]

#Merges the training and the test sets to create one data set

df<-rbind(X,Y)

# Uses descriptive activity names to name the activities in the data set
# features.txt contains the activity names. It was converted to CSV to be 
# read in R

n<-read.csv("features.csv")


# names in n are under the ActivityName header

colnames(df) <- n$ActivityName[1:292]

# Extracts only the measurements on the mean and standard deviation for each measurement.


mn<-grep("mean",names(df),value = FALSE,) # Gets the columns with mean
sn<-grep("std",names(df),value = FALSE,) # Gets the columns with std

mn<-as.vector(rbind(mn,sn)) # Creates a vector only with columns mean and std numbers

df<-df[,mn] # Extracts the mean and std columns

# Appropriately labels the data set with descriptive variable names.

# Read Activity and Subject names

a<-read.fwf("./UCI HAR Dataset/activity_labels.txt",c(1,1,18))
a<-a[,-2]
names(a)=c("id","activity")

# Assign descriptive activity name to labels from a

l<-rbind(Xl,Yl)
l[,2]<-as.character("NA")
names(l)=c("id","activity")

count = 1

for(i in l$id){ 
  aux1<- l[count,1]
  aux2<-as.character(a[aux1,2])
  l[count,2]<-aux2
  count=count+1}

# add names to df on 1st column, and add subject to the left

df<-cbind(l,df)
Xs<-rbind(Xs,Ys)
df<-cbind(Xs,df)
names(df)[1]<-"Subject"
names(df)[2]<-"ActivityId"


# From the df, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

# Create Means M data frame per Activity

M<-data.frame()


count1=1
count2=1

for(count in 1:6){
  str("activity")
  str(count1)
  dfaux<-df
  dfaux<- df[which(df$ActivityId==count1),]
  
  for (count2 in 1:9) {
    str("activity")
    str(count1)
    str("subject")
    str(count2)
    dfaux<- df[which(df$ActivityId==count1),]
    dfaux<- dfaux[which(dfaux$Subject==count2),]
    dfaux<-dfaux[,-c(1,2,3)]
    m<-colMeans(dfaux)
    M<-rbind(M,m)
    count2=count2+1
  }
 count1=count1+1
   
}

n<-names(dfaux)
colnames(M)<-n

# Asign descriptive names to M

b<-c(rep(c(1:9),6))
c<-c(c(rep.int(1,9)),c(rep.int(2,9)),c(rep.int(3,9)),c(rep.int(4,9)),c(rep.int(5,9)),c(rep.int(6,9)))
b<-rbind(b,c)
b<-t(b)
mode(b) = "numeric"
b<-data.frame(b)
names(b)=c("Subject","ActivityId")

count = 1

for(i in b$ActivityId){ 
  aux1<- b[count,2]
  aux2<-as.character(a[aux1,2])
  b[count,2]<-aux2
  count=count+1}

names(b)=c("Subject","Activity")

M<-cbind(b,M)

# Export M to txt file without row names.

write.table(M,"dataframe.txt",row.names = FALSE)




