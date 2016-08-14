describes the variables, the data, and any transformations or work that you performed to clean up the data called 

Variables used in script
- features: dataframe which stores list of all features provided in 'features.txt' file.
- activitylabels: data frame which stores links between activity ids and activity lables loaded from 'activity_labels.txt' file.
- ytrain: data frame with train data set activity lables loaded from y_train.txt file
- ytest: data frame with train data set activity lables loaded from y_train.txt file
- xtrain: data frame with train data set from file X_train.txt
- xtest: data frame with test data set from file X_test.txt
- subjecttrain: data frame which describes subject who performed activity loaded from subject_train.txt file
- subjectest: data frame which describes subject who performed activity loaded from subject_test.txt file
- datasetTrain: data frame which stores ytrain data set extended with 'subjectid' and 'activitydescription'
- datasetTest: data frame which stores ytrain data set extended with 'subjectid' and 'activitydescription'
- outputDataSet: data frame which stores datasetTrain combined with datasetTest (UNION) for all standard deviation and mean measures
- aggr_data: data frame with outputDataSet grouped by activityid, subjectid and average value for all measures


Output datasets
- outputDataSet: data frame which holds all measures (std, mean) calculated for signals from accelerator and gyrometer  collected during experiment
- aggr_data: data frame with mean values of all measures in outputDataSet calculated for activity and subject dimension

Description of steps in script
1. Loading features and activitylables into memory
2. Loading activity lables for test and train data
3. Loading subject data for test and train data
4. Combining activity lables and subject data by row (column bind)
5. Adding names from features file into train and test data set
6. Combining data produced in 4th and 5th step by row (column bind) separately for train and test data set
7. Combining extended train and test data set from previous step  (union) -> outputDataSet 
8. Calculating average values for all measures in outputDataSet for data grouped by activity and subject -> aggr_data


