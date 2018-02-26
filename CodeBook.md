CODE BOOK
SCRIPT DESCRIPTION

1st It reads the two data sets X_test and X_train to objects X and Y. Labels are obtained from Y_test and Y_train to objects Xl y Yl

2nd Merges the data sets and creates a unique data frame df

3rd Assigns  names to columns based on features file

4th Extract column names with mean or std. there are 23 mean and 23 std columns for a total of 46 variables

5th Assign descriptive row names based on activity names and subject number

6th Gets means by subject and by activity. Constructs data frame M with the means. There are 9 subject instances and 6 activities, therefore 
M has 54 rows and 46 variables.

7th Assign descriptive row names to M: Subject and descriptive activity name for 48 columns total.
