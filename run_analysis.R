setwd("C:/Users/CRP/Dropbox/DataScience/CleaningData/UCI HAR Dataset/")

#first loading in all data

file<-"activity_labels.txt"
activities<-read.table(file,header=FALSE,sep=" ")

file<-"features.txt"
features<-read.table(file,header=FALSE,sep=" ")

file<-"test/y_test.txt"
y_test<-read.table(file,header=FALSE,sep=" ")

file<-"test/X_test.txt"
X_test<-read.table(file,header=FALSE,sep="")

file<-"test/subject_test.txt"
subject_test<-read.table(file,header=FALSE,sep="")

file<-"train/y_train.txt"
y_train<-read.table(file,header=FALSE,sep=" ")

file<-"train/X_train.txt"
X_train<-read.table(file,header=FALSE,sep="")

file<-"train/subject_train.txt"
subject_train<-read.table(file,header=FALSE,sep="")

#Checking for number of rows that should converge
#Equivalent for train not shown here
nrow(y_test)
nrow(X_test)
nrow(subject_test)

#combining the different data_sets first separately

d_test<-cbind(subject_test,y_test,X_test)
d_train<-cbind(subject_train,y_train,X_train)

#it can be seen that there are 9 subjects in test and 21 in train
unique(d_test[,1])
unique(d_train[,1])

#Thus merging now both together is nothing else than rbind
d_all<-rbind(d_test,d_train)

#I will first start with tasks 3. and 4. in order to get first all the
#labeling in order before extracting mean and sd
#I think this is a tidier way to do

#First I'm gonna label all the variable names
#First var is "subject_id" followed by "activity" and then come all the features
#that can be found in the features file. Thus I build a vector:

label_vector<-c("subject_id","activity",as.character(features[,2]))

colnames(d_all) <- label_vector

#you can check that all the columns are correctly labeled:
names(d_all)

#Now come the activity names that have to become readable 
#For this I convert the activity-column into a factor corresponding to activities

d_all$activity <- factor(d_all$activity, labels = as.character(activities[,2]))

is.factor(d_all$activity)
#gives out TRUE

#you can check this by the following
head(d_all$activity)

#OK, now that everything is tidy I will go to task2
#"Extracts only the measurements on the mean and standard deviation 
#for each measurement. 

#let's do this in a clever way and find all the mean() and std() in the colnames
#I assume that I only want mean() and std() and want to get rid of meanFreq()
#and also the angle-calculations in the end on means

string<-names(d_all)
i <- grep("meanFreq", string,ignore.case=F) 
string<-string[-i]
i <- grep("mean()|std()", string,ignore.case=F) 
string[i]

d_small<-d_all[,c("subject_id","activity",string[i])]

#you can check it with this:
names(d_small)

#So now we have cleaned up the data-set by only having the mean() and std()
#labeled all the col names, and the activities are given out in names

#Now comes the last task: "From the data set in step 4, creates a second, 
#independent tidy data set with the average of each variable for each activity 
#and each subject".

#library plyr will be useful
library(plyr)

#The following ddply will do the trick. It takes the data.frame d_small
#and applies mean column wise (colwise) for all subgroups of subject_id and activity
new_tidy_data<-ddply(d_small, .(subject_id,activity), colwise(mean))

#Thus in this new data.frame new_tiny_data you have one observation per subject_id
#depending on its activity and then the mean of every measurement
#It can be seen by this:
head(new_tidy_data)


write.table(new_tidy_data,file="output.txt",row.name=FALSE)