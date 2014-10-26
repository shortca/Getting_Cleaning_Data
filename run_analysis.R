run_analysis <- function() {
        
        library(data.table)
### CHECK IF WEARABLE DATA FILE EXISTS IN DIRECTORY. IF NOT, DOWNLOAD, UNZIP, COMBINE TEST & TRAIN SETS
        
        if(file.exists("wearable.txt") == FALSE) {download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="zip_file.zip")
                unzip("./zip_file.zip")
                data_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
                subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
                activity_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
                data_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
                subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
                activity_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
                
                ##ADD COLs FOR SUBJECT AND ACTIVITY TO TEST AND TRAIN SETS THEN COMBINE
                
                test_set <- cbind("SUBJECT"=subject_test,"ACTIVITY"=activity_test,"OBS"=data_test)
                train_set <- cbind("SUBJECT"=subject_train,"ACTIVITY"=activity_train,"OBS"=data_train)
                data_join <- rbind(test_set,train_set)
                write.table(data_join, file="data.txt")
        }
        
##EXTRACT MEAN AND STDEV FOR EACH MEASUREMENT
        
        data <- read.table("data.txt")
        meas_means <- apply(data[3:563],1,mean)
        meas_std <- apply(data[3:563],1,sd)
        subject <- data[1]
        activity <- data[2]
##CHANGE ACTIVITY INT TO DESCRIPTIVE VALUES OF ACTIVITIES
        activity[activity=="1"] <- "WALKING"
        activity[activity=="2"] <- "WALKING_UPSTAIRS"
        activity[activity=="3"] <- "WALKING_DOWNSTAIRS"
        activity[activity=="4"] <- "SITTING"
        activity[activity=="5"] <- "STANDING"
        activity[activity=="6"] <- "LAYING"
##BUILD TABLE OF SUBJECT, ACTIVITY, MEASUREMENT MEAN, MEASUREMENT SD
        summ_table <- data.table(cbind("SUBJECT"=subject,"ACTIVITY"=activity,MEAN=meas_means,STDEV=meas_std))
        setnames(summ_table,1:4,c("Subject","Activity","Average Mean","Average Standard Deviation"))
        

##CREATE SECONDARY DATASET WITH TIDY DATA TABLE OF AVGS OF BOTH VARIABLES FOR EACH SUBJECT AND ACTIVITY
        library(dplyr)
        
        summ_table <- tbl_df(summ_table)  #convert Summary Table into data frame table object
        
        
        final_table <- summ_table %>%
                group_by(Subject, Activity) %>%
                summarise_each(funs(mean))
                

        write.table(final_table,"Course_Project_Result.txt",row.name=FALSE)
        
}
