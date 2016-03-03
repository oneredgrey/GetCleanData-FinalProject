## Filename is run_analysis.R
## Assignment: Getting and Cleaning Data Course Project


## In preparation, load the necessary packages/libraries (if not already loaded).
install.packages("dplyr")
library("dplyr")




## _____ Step 1: Create TEST and TRAIN Datasets _____  

##  >>>---> Read the 561 variable names contained in the file "features.txt"

features <- read.table("./UCI HAR Dataset/features.txt")  ## read the file
varlabels <- features$V2  ## extract the text labels for naming the variables.


##  >>>---> Create TEST Dataset:

##  Read the test data and add variable names from "varlabels" (above)
testdata <- read.table("./UCI HAR Dataset/test/X_test.txt")
names(testdata) <- varlabels

## Read the test subject IDs and add variable name "subject"
testsubject.id <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(testsubject.id) <- "subject"

## Read the test data activity labels and add variable name "activity"
testlabels <- read.table("./UCI HAR Dataset/test/y_test.txt") 
names(testlabels) <- "activity"

## Merge these three test data frames to create one test dataset
test.df <- cbind(testsubject.id, testlabels, testdata)


##  >>>---> Create TRAIN Dataset:

##  Read the train data and add variable names from "varlabels" (above)
traindata <- read.table("./UCI HAR Dataset/train/X_train.txt")
names(traindata) <- varlabels 

## Read the train data subject IDs and add variable name "subject"
trainsubject.id <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(trainsubject.id) <- "subject"

## Read the train data activity labels and add variable name "activity"
trainlabels <- read.table("./UCI HAR Dataset/train/y_train.txt")  ## Train labels
names(trainlabels) <- "activity"

## Merge the three training data frames to create one dataset
train.df <- cbind(trainsubject.id, trainlabels, traindata)



## _____ Step 2: Merge TEST and TRAIN Datasets _____

alldata <- rbind(test.df, train.df) ## bind the test & train datasets on rows (rbind)



## _____ Step 3: Replace numeric activity codes with text labels _____  

activities <- read.table("./UCI HAR Dataset/activity_labels.txt") ## read the label file

## prepare tidy vector of new activity labels by selecting column 2 of the
## "activities" dataframe, cleaning up the text labels, changing to 
## lower case, and setting this as a factor variable.
newlabels <- as.factor(gsub("_","",tolower(activities[,2])))  

## prepare temporary vector of old (numeric) activity codes from the dataset
oldlabels <- sort(unique(alldata[, 2]))

## replace the old numeric codes with the new activity labels using "match" function.
alldata$activity <- newlabels[match(alldata$activity, oldlabels)]



## _____ Step 4: Extract only the mean() and std() vars; tidy up labels _____ 

## Use grep + regex to search for varnames with "mean" or "std" (NOT meanFreq())
meanstd <- grep(("mean[^F]()|std()"),names(alldata), value = TRUE)


## temporarily subset only the mean & std data variables from alldata,
## in preparation for tidying.
alldatasub <- subset(alldata, select = c(meanstd))  


## tidy up the variable labels: all lower case, no symbols.
names(alldatasub) <- gsub("-","", tolower(names(alldatasub))) ## remove "-"
names(alldatasub) <- gsub("\\(\\)","", (names(alldatasub))) ## remove "()"

## Re-join the tidied data variables with subject & activity.
newdata <- cbind(alldata[, 1:2], alldatasub)

## Further tidying by converting "subject" to factor variable.
newdata$subject <- as.factor(newdata$subject) 



## _____ Step 5: Create new tidy dataset with average of each variable  
##               for each activity and each subject _____                     

## Use dplyr (group_by) and (summarize_each) to list means by activity and subject.
tidydata <- newdata %>% 
  group_by (activity, subject) %>%    ## group by activity and subjectid
  summarize_each(funs(mean))          ## find the mean of each of the variables.
View(tidydata)                        ## Open the data in an easy-to-read table window.

## write the dataset to txt file
write.table(tidydata, file = "./UCI HAR Dataset/tidydata.txt") 

