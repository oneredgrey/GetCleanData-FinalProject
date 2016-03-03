# GetCleanData-FinalProject
**Course Project submission for Coursera "Getting and Cleaning Data" project.**

This repo contains the files to satisfy the requirements for the final course project.  
 
The original data were downloaded from:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]
(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

with credit to:

**Human Activity Recognition Using Smartphones Dataset
Version 1.0** 

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
[www.smartlab.ws](www.smartlab.ws)

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






