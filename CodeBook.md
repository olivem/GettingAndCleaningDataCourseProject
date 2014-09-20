CodeBook

Variables
df: is the output of the merged x train and x test datasets that is used to extract the mean and standard deviation and descriptive activity names.
x, y, subject: is the output of the merged datasets used for the fLabel function for binding Labels to the dataset.

Transformations
Each data set is extracted.
Data sets are merged into 3 seperate datasets: x, y and subject.
Mean and Standard Deviation is extracted from the x dataset.
Descriptive names are referecned from the y dataset.
Labels are created with the combined x, y and subject datasets.
TidyDataSet txt is created.
