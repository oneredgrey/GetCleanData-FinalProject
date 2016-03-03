---
title: "Code Book"
author: "Sue Evans"
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

* 'README.txt'
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

The following files are included with the data but are not utilized in this project.

* 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
* 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
* 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.



## Pre-processing steps and approach to merging the data

The script for processing the data are found in the R file "run_analysis.R".  

Described here are steps to create the final independent tidy data set with the average of each variable for each activity and each subject.  

### Step 1: Create TEST and TRAIN Datasets  

Working first on the test data, create one dataset as follows:

* label the test data ('X_test.txt') with meaningful variable names (from 'features.txt')
* add the appropriate subject identifiers (from 'subject_test.txt')
* add the numeric activity codes (from 'y_test.txt')

This is accomplished using the `cbind` function.  The new dataset will follow this format:

Column 1  | Column 2  | Columns 3 - 563
----------|-----------|---------------------
subject   | activity  | "Features" variables 


This process is repeated for the test data using data from 'X_train.txt', 'subject_train.txt', and 'y_train.txt'.  


### Step 2:  Merge TEST and TRAIN Datasets into one dataset

Merge the training and test datasets created in Step 1, into one dataset using the `rbind` function.


### Step 3: Replace numeric activity codes with text labels 

Replace the numeric activity codes with their corresponding descriptive text labels (found in 'activity_labels.txt').  For example, "1" is replaced with "WALKING". The activity codes and matching text labels are as follows:
  * 1:  WALKING
  * 2:  WALKING_UPSTAIRS
  * 3:  WALKING_DOWNSTAIRS
  * 4:  SITTING
  * 5:  STANDING
  * 6:  LAYING


### Step 4:  Extract only the mean() and std() vars

Search for the variables that measure either mean ("mean") or standard deviation ("std") for each measure, using `gsub` with regular expressions.  Extract this subset of variables to produce the dataset ready for Step 5.

NOTE:  Only "mean" and "std" variables were selected.  "meanFreq" variables were not considered to fit the desired specifications and were excluded.  


### Step 5:  Create a separate, independent tidy dataset with the average of each variable for each activity and each subject.  

This is accomplished with the dplyr package, using the "group_by" and "summarize" functions.

The resulting tidy dataset is stored in the file "tidydata.txt".  It is a data.frame of 180 obs. of  68 variables.


## Variables in the Tidy Dataset

1.  subject  - Factor w/ 30 levels ("1", "2", ..., "30")
    * Identifies the subject performing the task(s)
    
2.  activity
    Factor w/ 6 levels ("laying", "sitting", "standing", "walking",   "walkingdownstairs", "walkingupstairs")
    * Labels the activities with meaningful text labels

        
Variables 3 through 68 represent the average of the mean and standard devation signals for the accelerometer and gyroscope measurements ("features").  

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. 

Similarly, the acceleration signal was then separated into body and gravity 
acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass 
Butterworth filter with a corner frequency of 0.3 Hz.  Features are normalized and bounded within [-1,1]. The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/seg2).  The gyroscope units are radians/second.


3.  tbodyaccmeanx - (numeric)
4.  tbodyaccmeany - (numeric) 
5.  tbodyaccmeanz - (numeric)
6.  tbodyaccstdx - (numeric)
7.  tbodyaccstdy - (numeric)
8.  tbodyaccstdz - (numeric) 
* Time domain signals: average of the mean (mean) or standard deviation (std) body acceleration signal (unit of measure - g) on each axis (X, Y, Z) for each subject and each activity. 


9.  tgravityaccmeanx - (numeric)    
10. tgravityaccmeany - (numeric)
11. tgravityaccmeanz - (numeric)
12. tgravityaccstdx - (numeric)  
13. tgravityaccstdy - (numeric)  
14. tgravityaccstdz - (numeric)  
* Time domain signals: average of the mean (mean) or standard deviation (std) gravity acceleration signal (unit of measure - g) on each axis (X, Y, Z) for each subject and each activity. 


15. tbodyaccjerkmeanx - (numeric)      
16. tbodyaccjerkmeany - (numeric)  
17. tbodyaccjerkmeanz - (numeric)  
18. tbodyaccjerkstdx - (numeric)   
19. tbodyaccjerkstdy - (numeric)  
20. tbodyaccjerkstdz - (numeric)  
* Time domain signals: average of the mean (mean) or standard deviation (std) body linear acceleration jerk signal on each axis (X, Y, Z) for each subject and each activity.



21. tbodygyromeanx - (numeric)  
22. tbodygyromeany - (numeric)  
23. tbodygyromeanz - (numeric)  
24. tbodygyrostdx  - (numeric)   
25. tbodygyrostdy - (numeric)  
26. tbodygyrostdz - (numeric)  
* Time domain signals: average of the mean (meand) or standard deviation (std) body angular velocity signal (unit of measure - rad/sec) on each axis (X, Y, Z) for each subject and each activity.



27. tbodygyrojerkmeanx - (numeric)  
28. tbodygyrojerkmeany - (numeric)  
29. tbodygyrojerkmeanz - (numeric)  
30. tbodygyrojerkstdx - (numeric)  
31. tbodygyrojerkstdy - (numeric)  
32. tbodygyrojerkstdz - (numeric)  
* Time domain signals: average of the mean (mean) or standard deviation (std) body angular velocity jerk signal on each axis (X, Y, Z) for each subject and each activity.


33. tbodyaccmagmean - (numeric)  
34. tbodyaccmagstd - (numeric)  

35. tgravityaccmagmean - (numeric)  
36. tgravityaccmagstd - (numeric)  

37. tbodyaccjerkmagmean - (numeric)  
38. tbodyaccjerkmagstd - (numeric)  

39. tbodygyromagmean - (numeric)  
40. tbodygyromagstd - (numeric)  

41. tbodygyrojerkmagmean - (numeric)  
42. tbodygyrojerkmagstd - (numeric)  
* average of the mean (mean) or standard deviation (std) magnitude of three-dimensional signals (calculated using the Euclidean norm) for each subject and each activity.
  
  
Fast Fourier Transform (FFT) was applied to some of these signals 
producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, 
fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).  As with the above time domain signals, these frequency domain signal measures represent the mean (mean) or standard deviation (std) in each axis (X, Y or Z) 

43. fbodyaccmeanx - (numeric)  
44. fbodyaccmeany - (numeric)  
45. fbodyaccmeanz - (numeric)            
46. fbodyaccstdx - (numeric)  
47. fbodyaccstdy - (numeric)  
48. fbodyaccstdz - (numeric)            

49. fbodyaccjerkmeanx - (numeric)  
50. fbodyaccjerkmeany - (numeric)  
51. fbodyaccjerkmeanz - (numeric)  
52. fbodyaccjerkstdx - (numeric)  
53. fbodyaccjerkstdy - (numeric)  
54. fbodyaccjerkstdz - (numeric)  

55. fbodygyromeanx - (numeric)  
56. fbodygyromeany - (numeric)  
57. fbodygyromeanz - (numeric)    
58. fbodygyrostdx - (numeric)  
59. fbodygyrostdy - (numeric)  
60. fbodygyrostdz - (numeric)            

61. fbodyaccmagmean - (numeric)  
62. fbodyaccmagstd - (numeric)  

63. fbodybodyaccjerkmagmean - (numeric)  
64. fbodybodyaccjerkmagstd - (numeric)  

65. fbodybodygyromagmean - (numeric)  
66. fbodybodygyromagstd - (numeric)    

67. fbodybodygyrojerkmagmean - (numeric)  
68. fbodybodygyrojerkmagstd - (numeric)  

















