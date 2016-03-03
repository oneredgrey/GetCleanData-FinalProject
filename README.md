# GetCleanData-FinalProject
**Course Project submission for Coursera "Getting and Cleaning Data" project.**

This repo contains the files to satisfy the requirements for the final course project.  

The original data were downloaded from:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]
(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)



===========
The purpose of the project was to process several data contained in the University of California Irvine (UCI) Human Activity Recognition (HAR) datasets specified above, into one new, tidy dataset which contains only the average of each variable for each activity and each subject.

The relevant files in this repo are as follows:
 1. ReadMe.md - (this file) - basic description of the project parameters.
 2. tidydata.txt - the final tidy dataset
 3. codebook.md - details on the process and the data variables in the tidy dataset
 4. run_analysis.R - the script to process the original data into the final tidy dataset "tidydata.txt"

The basic processing steps involved: 
* Merging the training and the test sets to create one data set.
* Extracting only the measurements on the mean and standard deviation for each measurement.
* Applying descriptive activity names to name the activities in the data set
* Appropriately labelling the data set with descriptive variable names.
* Creating a second, independent tidy data set with the average of each variable for each activity and each subject.

=============

## Description of the pre-processed data

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

## For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

##The pre-processed dataset includes the following files:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

The following files from the original data set were not used in the data processing:
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

## Processing of cleaning up the data into the final tidy dataset:

The concept of "Tidy Data" as described by Hadley Wickham (http://vita.had.co.nz/papers/tidy-data.pdf) is that:
* each variable forms a column
* each observation forms a row
* each table/file stores data about one kind of observation

Some other features of tidy data include:
* use descriptive variable names
* avoid symbols such as "." and "_" in variable names
* don't duplicate variable names


**NOTE:** Before performing the data processing steps in `'run_analysis.R'`, it is assumed that the data have been downloaded from the above link and reside in a subfolder of the working directory called "UCI HAR Dataset".  

To initiate the data processing, run the file `'run_analysis.R'`.  The output of this script is a text file (`'tidydata.txt'`). The script will also open a data frame in R Studio.

The resulting tidy dataset is a 180 x 68 data frame.  The variables represent the average of the mean and standard deviation signals for each subject and each activity.



============================
with credit to:

**Human Activity Recognition Using Smartphones Dataset Version 1.0** 

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
[www.smartlab.ws](www.smartlab.ws)

