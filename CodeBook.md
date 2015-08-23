#This is the CodeBook for the project#

#Description of the Data#

First of all I loaded all the 8 necessary files into R. 
I thus first created the data.frames:
d_test which contains all the subject information, activity information and all the measurement informations.
d_train is the exact same object but for the training data.

Then I merged both of these objects into one big object: d_all

What I did then is first do all the labeling excercises (which corresponds to step 4 in the project).
Thus I gave the columns the following names: 
"subject_id" for the subjects (previously data under the "subject_" file), 
"activity" for the activity (previously data under the "y_" file),
and then all the names that can be found in the file features.txt for all the other variables.

What I did then is to label the activity according to the labels in activities.txt (which corresponds to step 3 in the project).

Which this nicely labeled data now extracted all the mean() and std().
A new data.frame is created called d_small which contains "subject_id", "activity" and all the measurements with either
mean() or std().

(Note: I have on purpose deleted the meanFrequency() and the ones with the angles in the end. As I understood
the excercises, they are not part of the columns that are supposed to be kept)

The last part was the trickiest one. a new tidy data.frame new_tidy_data is created with as observations subject_id and activity. 
Thus id=1, activity=walking
id=1, activity=standing
....
id=2, activity=walking" etc.

in the columns you then have the averages for that subgroup of all the measurements (of means and stds).


