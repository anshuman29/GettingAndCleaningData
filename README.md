There is just one script "run_analysis.R" which does all the cleaning up, transformation and aggregation. 
It creates 2 datasets:
a) CleanData - clean data with columns for mean and std only
b) AggregatedData: aggregated data with mean values of each variable for each activity and each subject.

------------------------------------------------------------
Steps I followed:

I first read the following data:
1. X_test
2. Y_test
3. subject_test
4. X_train
5. Y_train
6. subject_train

Then i made the column names of xTest and xTrain the same by assigning the column names of xTrain to xTest. 
The sole purpose of this was so I could use rbind to combine the data.

Then I read the file features.txt into variableNamesData and then assigned this to names(completeData)

Then I used the grep command to find the indices of the columns which have mean() or std() in their name.
Using these indices, I subsetted completeData, to include only these columns.

Next,I ran a for loop to add a new column value for every ActivityName corresponding to its number.
I did it first for Test Data and then for Training Data.

Then I simply used rbind to bind yTest and yTrain (which now had the activity names)
Next, I used cbind to add the new ActivityName column to the completeData.

Then, I used rbind to bind the subjects data. After which, I again used cbind to add this column to completeData.

I saved this dataset as CleanData.txt 


Now, I again created the secondCompleteData pretty much the same way as above but did not subset based on columns.
Then I ran the aggregate function to get the mean of each variable for each activity and each subject.

I saved this dataset as AggregatedData.txt

---------------------------------------------------------------

NOTE::: I understand the project asked me to submit 1 dataset but I am submitting 2 datasets.
The reason is I just feel this was a more descriptive solution as I have the dataset for  both:
a) Cleaning the data = CleanData.txt
b) Aggregating the data = AggregatedData.txt

