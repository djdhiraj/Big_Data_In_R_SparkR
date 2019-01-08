#Machine Learning
#You can orchestrate machine learning algorithms in a Spark cluster via the machine learning functions within sparklyr.
#These functions connect to a set of high-level APIs built on top of DataFrames that help you create and tune machine learning workflows.


#Here’s an example where we use ml_linear_regression to fit a linear regression model. 
#We’ll use the built-in mtcars dataset, and see if we can predict a car’s fuel consumption (mpg) based on its weight (wt), 
#and the number of cylinders the engine contains (cyl). We’ll assume in each case that the
#relationship between mpg and each of our features is linear.

# copy mtcars into spark
mtcars_tbl <- copy_to(sc, mtcars)

# transform our data set, and then partition into 'training', 'test'
partitions <- mtcars_tbl %>%
  filter(hp >= 100) %>%
  mutate(cyl8 = cyl == 8) %>%
  sdf_partition(training = 0.5, test = 0.5, seed = 1099)

# fit a linear model to the training dataset
fit <- partitions$training %>%
  ml_linear_regression(response = "mpg", features = c("wt", "cyl"))
fit
summary(fit)
