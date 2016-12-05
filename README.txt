This is a script which performs the following tasks:

1. Reads in test and training data as well as variable names and column names from an untidy dataset. 
The script uses file.choose() instead of assigning the directory for convenience in avoiding replacing Windows escape characters. 

2.Assigns rational, meaningful names to variables (features), and activities.
	Activities receives text string names based on physical activity words in English versus numerical factor levels
	features.txt uses somewhat cryptic names as the columns for the variables, but it is better than no labels
	after gathering the useful variables, the names are replaced by expanding on abbreviations--giving a more natural English column name. 

3. Seperates meaningful variables (means and standard deviations) from less meaningful variables.

4. Provides average values for the variables via an output file. 

The user will need to assign their own working directory, and if using file.choose() must be careful to choose correctly the files from the dataset. 
"ts" is used as shorthand for the "test" files x, sub and y. Correspondingly, "tr" for the training counterparts. features.txt goes into features and Activities 
receives activities.txt.  



Further information about the laboratory and data can be found here http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data is found here https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

And this is part of the November 2016 coursework in Getting and Cleaning Data provided by Coursera and John's Hopkins University. 