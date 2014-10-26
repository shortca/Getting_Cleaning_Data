Getting_Cleaning_Data
=====================

Run Analysis Project (Coursera) Repo

1. Check if extracted/combined data file "data.txt" already exists in working directory.
	-If yes: Skip this step to save time.
	-If no: 
		- Download and unzip train and test files
		- Read each test file into subject, activity, and data variables
		- Combine columns for test subject, activity and data variables
		- Read each train file into subject, activity, and data variables
		- Combine columns for train subject, activity, and data variables
		- Combine all train and test rows into one comprehensive data set including subject, activity and data
		- Write this data table to "data.txt" file
		
2. Read data from "data.txt" and extract mean and standard deviation for each measurement (vars = meas_means, meas_std)
3. Transform Activity column values from integers (1:6) into alphanumeric activity descriptions (walking, sitting, standing, etc.)
4. Build and label table with columns: Subject #, Activity Description, Average Mean, Average Standard Deviation.
5. Create Secondary, tidy data set to show each subject's average mean and standard deviation for each activity.
6. Write this tidy data set to file "Course_Project_Result.txt"



TO READ RESULT TABLE INTO R:

1. Set working directory to "Course_Project_Result.txt" file path.
2. Use View(read.table("Course_Project_Result.txt")) to view result.
