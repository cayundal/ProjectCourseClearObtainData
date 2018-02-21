# ProjectCourseClearObtainData

To run the code, please paste on the working directory the Samsung Data along with the files contained in the repository.

The script:
Reads the files on Samsung Data X_test and X_train and puts them as separate data frames.

Eliminate the empty rows in both data frames.

Bind the two data frames.

Calculates mean and standard deviation for each column creating two verctors: m and sd.

Reads the column names from the features file. This file was previously converted to csv in order to avoid mistakes since it is not a fwf file.

Asigns the column names to the merged data frame.

Binds the merged data frame with m.

Exports the resulting data frame as df2.txt.


