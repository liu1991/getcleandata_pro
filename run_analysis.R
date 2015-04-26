dat_train <- read.table("UCI HAR Dataset/train/X_train.txt")
dat_test <- read.table("UCI HAR Dataset/test/X_test.txt")
dat0 <- rbind(dat_train,dat_test)
#Merges the training and the test sets to create one data set

features <- read.table("UCI HAR Dataset/features.txt")
col_mean <- features[grep("mean",features$V2),]$V1
col_std <- features[grep("std",features$V2),]$V1
dat <- dat0[,c(col_mean,col_std)]
#Extracts the measurements on the mean and standard deviation for each measurement 

labs_train <- read.table("UCI HAR Dataset/train/y_train.txt")
labs_test <- read.table("UCI HAR Dataset/test/y_test.txt")
labs <- rbind(labs_train,labs_test)
labs <- factor(labs$V1)
levels(labs)<- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
dat <- cbind(activities=labs,dat)
#Uses descriptive activity names to name the activities in the data set

varnames <- c(as.character(features[col_mean,2]),as.character(features[col_std,2]))
colnames(dat) <- c("activities",varnames)
#Appropriately labels the data set with descriptive variable names


subs_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subs_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subs <- rbind(subs_train,subs_test)
dat <- cbind(subjects=subs$V1,dat)
dat2 <- aggregate(. ~ subjects+activities, data = dat, mean)
#Creates a second, independent tidy data set with the average 
#of each variable for each activity and each subject
