setwd("C:/Users/jpeng11/coursera/Getting and Cleaning Data/Project")

library(dplyr); library(tidyr)


fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "dataset.zip", mod = "wb")
unzip(zipfile = "dataset.zip", list = T)
unzip(zipfile = "dataset.zip", exdir = ".", unzip = "internal")

list.files(); list.dirs(full.name = T)

setwd("./UCI HAR Dataset")

list.files(all.files = T); list.dirs(full.names = T)
list.files("./train"); list.files("./test")


# read subject data for training set
train_subject <- read.table("./train/subject_train.txt")
# read all X for train data
X_train <- read.table("./train/X_train.txt")
# read y for all train data
y_train <- read.table("./train/y_train.txt")

train <- cbind(X_train, y_train, train_subject)

# read subject data for test set
test_subject <- read.table("./test/subject_test.txt")
# read all X for test data
X_test <- read.table("./test/X_test.txt")
# read y for all test data
y_test <- read.table("./test/y_test.txt")

# combine test set
test <- cbind(X_test, y_test, test_subject)


# combind train and test set

combined_set <- rbind(train, test)

# read features.txt, which is a data frame with 2 column, V2 is the corresponding names for each X 
features <- read.table("features.txt")
# find index for features$V2 which contain "mean"
mean_ind <- grep("mean",features$V2)
# find value for features$V2 which contain "mean"
mean_col <- grep("mean",features$V2, value = T)
# find index for features$V2 which contain "std"
std_ind <- grep("std",features$V2)
# find value for features$V2 which contain "sd"
std_col <- grep("std", features$V2, value = T)


# combine mean_index and sd_index
all_ind <- c(mean_ind, std_ind, 562, 563)
# subset X_train containing "mean" and "std"

Combined <- combined_set[, c(all_ind)]
dim(Combined)

names(Combined) <- c(mean_col, std_col, "Activity", "Subject")

Combined <- Combined %>% 
    mutate(Source = c(rep("train", dim(train)[1]), rep("test", dim(test)[1])))
           
dim(Combined)

Activity <- read.table("activity_labels.txt")
Activity
names(Activity) <- c("Activity", "Activity_Description")

Combined <- Combined %>%
    merge(Activity, by = "Activity") %>%
    select(-Activity)
names(Combined) <- gsub("()", "", names(Combined))

Final <- Combined %>% gather(key = "Measure_Type", value = "Measurement",
                             -c(Subject, Source, Activity_Description))
Final_Average <- Final %>%
    group_by(Subject, Measure_Type, Activity_Description) %>%
    summarise(Average= mean(Measurement, na.rm = T))

write.table(Final_Average, file = "Final_Average.txt", row.names = F)
write.table(Final, file = "Final.txt", row.names= F)
