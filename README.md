The Run_analysis.R script reads in 7 files that are assumed to be DOWNLOADED from the following website:
 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and EXTRACTED into the working directory.
(Note: The script assumes the working directory is currently set to be directly above the extracted folder UCI HAR Dataset
List of Files Read In
1. features.txt (contains the column labels for the training and test data values)
2. X_test.txt (contains the testing data values 30% of total data)
3. Y_test.txt  (really could have been a column added to X_test since it tells which activity was being performed for X_test data row)
4. subject_test.txt (also could have a column added to X_test since it tells which subject produced the data values in X_test)
5. X_train.txt (contains the training data values, 70% of total data)
6. Y_train.txt  (same explanation as # 3 above except for X_train data)
7. subject_train.txt (same explanation as #4 above except for X_train data)
**More detailed explanations of the downloaded data can be found at website 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
or in the README file for the downloaded data

After all above files are read in, all 7 data files are manipulated into one data set. Any data values that do not have mean()
or std() in their "feature" column labels are removed from this dataset, (Reduces 561 columns to 66 columns). The intermediate data set  
now has subject, activity, and 66 column headings which contain mean() or std()

This intermediate data set is analyzed using the R function aggregate to produce the means of the "featured" data values
for a particular subject and activity.  For example, Subject #1 with an Activity of STANDING(numeric 5) had an average of 
0.2789 for the feature tBodyAcc-mean()-X.  

The final data set which contains only the averages of the features is written to a file named tidydata.txt in the working directory.
The final data set has 180 rows of data (30 Subjects x 6 activities) and 66 columns of averaged data.  The first and second columns list the
subject and activity and the remaining 66 columns contain the average feature values such as tBodyAcc-mean()-X being feature.
