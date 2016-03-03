---
title: "Code Book"
author: "Sue Gilbert Evans"
date: "March 1, 2016"
output: html_document
---
# Code Book
### Getting and Cleaning Data - Coursera Data Science Specialization: Course Project

## Objective of this project:
To access an online dataset from the University of California Irvine Machine Learning website and create an R script that will process the dataset according to the specifications outlined in the Course Project instructions.

## Source of the Data:
The data were downloaded from the following site:  
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


The source data files are stored in the following branch of the working directory: "UCI HAR Dataset".  

Before running the script, you should ensure the data files on your local machine are either stored in a directory matching this name, or alter the code to point to the location of the files on your computer. 


## Data Collection
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

### For each record it is provided:

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.


### The dataset downloaded from the UCI website includes the following files:

* 'README.txt':
    + Information on the data provided by the original experimentors.

* 'features_info.txt': 
    + Shows information about the variables used on the feature vector.
    
* 'features.txt': 
    + List of all features.
    + This is the complete list of variable names for the 561 variables. 
    
* 'activity_labels.txt': 
    + Links the class labels with their activity name.
    
* 'train/X_train.txt': 
    + Training data set.
    + 7352 observations, 561 variables
    
* 'train/y_train.txt': 
    + Training activity code labels.
    + 7352 observations on one variable
    
* 'train/subject_train.txt': 
    + Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
    + 7352 observations on one variable

* 'test/X_test.txt': 
    + Test data set.
    + 2947 observations, 561 variables
    
* 'test/y_test.txt': 
    + Test activity code labels.
    + 2947 observations on one variable
    
* 'test/subject_test.txt': 
    + Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
    + 2947 observations on one variable    

**Note:** The following files are included with the data but are not utilized in this project.

* 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
* 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
* 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.



## Pre-processing steps and approach to merging the data

The script for processing the data are found in the R file `'run_analysis.R'`.  

Described here are steps to create the final independent tidy data set with the average of each variable for each activity and each subject.  

### Step 1: Create TEST and TRAIN Datasets  

Working first on the test data, create one dataset as follows:

* label the test data (`'X_test.txt'`) with meaningful variable names (from `'features.txt'`)
* add the appropriate subject identifiers (from `'subject_test.txt'`)
* add the numeric activity codes (from `'y_test.txt'`)

This is accomplished using the `cbind` function.  The new dataset will follow this format:

Column 1  | Column 2  | Columns 3 - 563
----------|-----------|---------------------
subject   | activity  | "Features" variables 


This process is repeated for the test data using data from `'X_train.txt'`, `'subject_train.txt'`, and `'y_train.txt'`.  


### Step 2:  Merge TEST and TRAIN Datasets into one dataset

Merge the training and test datasets created in Step 1, into one dataset using the `rbind` function.


### Step 3: Replace numeric activity codes with text labels 

Replace the numeric activity codes with their corresponding descriptive text labels (found in `'activity_labels.txt'`).  For example, "1" is replaced with "WALKING". The activity codes and matching text labels are as follows:
  * 1:  WALKING
  * 2:  WALKING_UPSTAIRS
  * 3:  WALKING_DOWNSTAIRS
  * 4:  SITTING
  * 5:  STANDING
  * 6:  LAYING


### Step 4:  Extract only the mean() and std() vars

Search for the variables that measure either mean ("mean") or standard deviation ("std") for each measure, using `grep` with regular expressions.  Extract this subset of variables and tidy the variable names to produce the dataset ready for Step 5.

NOTE:  Only "mean" and "std" variables were selected.  "meanFreq" variables were not considered to fit the desired specifications and were excluded.  


### Step 5:  Create a separate, independent tidy dataset with the average of each variable for each activity and each subject.  

This is accomplished with the `dplyr` package, using the `group_by` and `summarize` functions.



## Description of the Tidy Dataset 'tidydata.txt'

The final dataset is stored in the file `'tidydata.txt'`.  This is a `data.frame` of 180 observations and 68 variables.  Each observation represents a measurement on one subject and one activity.

Here is a description of the variables:

* 1)  subject  - Factor w/ 30 levels ("1", "2", ..., "30").  Identifies the subject performing the task(s)
    
* 2)  activity -  Factor w/ 6 levels ("laying", "sitting", "standing", "walking",   "walkingdownstairs", "walkingupstairs").  Labels the activities with meaningful text labels

        
**Notes on Variables 3 through 68:**  These variables represent the average of the mean (mean) and standard devation (std) signals for the accelerometer and gyroscope measurements ("features").  

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix **'t'** to denote time; variables 2 through 42) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. 

Similarly, the acceleration signal was then separated into body and gravity 
acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass 
Butterworth filter with a corner frequency of 0.3 Hz.  

Subsequently, the body linear acceleration and angular velocity were derived in time to 
obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, 
tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Fast Fourier Transform (FFT) was applied to some of these signals 
producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, 
fBodyGyroMag, fBodyGyroJerkMag. (Note the **'f'** to indicate frequency domain signals; variables 43 through 68).  As with the above time domain signals, these frequency domain signal measures represent the mean (mean) or standard deviation (std) in each axis (X, Y or Z). 

Features are normalized and bounded within [-1,1]. 
The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/sec^2^).  The gyroscope units are radians/second.

*  3)  tbodyaccmeanx  (num)
*  4)  tbodyaccmeany  (num)
*  5)  tbodyaccmeanz  (num)
*  6)  tbodyaccstdx  (num)
*  7)  tbodyaccstdy  (num)
*  8)  tbodyaccstdz  (num)

*  9)  tgravityaccmeanx  (num)
* 10)  tgravityaccmeany  (num)
* 11)  tgravityaccmeanz  (num)
* 12)  tgravityaccstdx  (num)
* 13)  tgravityaccstdy  (num)
* 14)  tgravityaccstdz  (num)

* 15)  tbodyaccjerkmeanx  (num)
* 16)  tbodyaccjerkmeany  (num)
* 17)  tbodyaccjerkmeanz  (num)
* 18)  tbodyaccjerkstdx  (num)
* 19)  tbodyaccjerkstdy  (num)
* 20)  tbodyaccjerkstdz  (num)

* 21)  tbodygyromeanx  (num)
* 22)  tbodygyromeany  (num)
* 23)  tbodygyromeanz  (num)
* 24)  tbodygyrostdx  (num)
* 25)  tbodygyrostdy  (num)
* 26)  tbodygyrostdz  (num)

* 27)  tbodygyrojerkmeanx  (num)
* 28)  tbodygyrojerkmeany  (num)
* 29)  tbodygyrojerkmeanz  (num)
* 30)  tbodygyrojerkstdx  (num)
* 31)  tbodygyrojerkstdy  (num)
* 32)  tbodygyrojerkstdz  (num)

* 33)  tbodyaccmagmean  (num)
* 34)  tbodyaccmagstd  (num)

* 35)  tgravityaccmagmean  (num)
* 36)  tgravityaccmagstd  (num)

* 37)  tbodyaccjerkmagmean  (num)
* 38)  tbodyaccjerkmagstd  (num)

* 39)  tbodygyromagmean  (num)
* 40)  tbodygyromagstd  (num)

* 41)  tbodygyrojerkmagmean  (num)
* 42)  tbodygyrojerkmagstd  (num)

* 43)  fbodyaccmeanx  (num)
* 44)  fbodyaccmeany  (num)
* 45)  fbodyaccmeanz  (num)
* 46)  fbodyaccstdx  (num)
* 47)  fbodyaccstdy  (num)
* 48)  fbodyaccstdz  (num)

* 49)  fbodyaccjerkmeanx  (num)
* 50)  fbodyaccjerkmeany  (num)
* 51)  fbodyaccjerkmeanz  (num)
* 52)  fbodyaccjerkstdx  (num)
* 53)  fbodyaccjerkstdy  (num)
* 54)  fbodyaccjerkstdz  (num)

* 55)  fbodygyromeanx  (num)
* 56)  fbodygyromeany  (num)
* 57)  fbodygyromeanz  (num)
* 58)  fbodygyrostdx  (num)
* 59)  fbodygyrostdy  (num)
* 60)  fbodygyrostdz  (num)

* 61)  fbodyaccmagmean  (num)
* 62)  fbodyaccmagstd  (num)

* 63)  fbodybodyaccjerkmagmean  (num)
* 64)  fbodybodyaccjerkmagstd  (num)

* 65)  fbodybodygyromagmean  (num)
* 66)  fbodybodygyromagstd  (num)

* 67)  fbodybodygyrojerkmagmean  (num)
* 68)  fbodybodygyrojerkmagstd  (num)



## License:

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.














