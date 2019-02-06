# Big_Data_In_R_SparkR
What is SparkR
An R package distributed with Apache Spark:
Provides R fronted to Spark
Convenient interperability between R and Spark DataFrams
SparkR is the sum of distributed/ robust processing, data sources, off memory data structures and 
Dynamic environment, interactive, packages, visualization


Overview of SparkR API 
# IO
* read.df
* write.df
* createDataFrame
* collect 

# Caching 
* cache
* persist 
* unpersist
* cacheTable
* uncacheTable

# Utility Functons 
* dim/ head/ take
* rand/ sample

# MLLib 
* glm/ predict

# DataFrameAPI
 * select
 * subset
 *groupBy 
 * head
 * showDF 
 * unionAll 
 * agg
 * avg
 * column
 
# SQL
* sql
* table
* saveAsTable
* registerTamTable
* tables

# Transformation in Apache Spark

* map
* flatmap
* filter
* distict
* sample
* union 
* intersection
* subtract 
* cartesian

# Actions in Apache spark
* collect()
* count()
* take()
* takeOrdered(num)(ordering)
* reduce(function)
* aggregate(zeroValue)(seqOp, combOp)
* foreach(function)

# Machine Learning Model in H2O

* Deep Leaning                          * Naive Bayes          
* Linear Regression                     * Principal Components Analysis (PCA) 
* K Means                               * Stacked Ensembles  
* Generalised Linear Model              * Gradient Boosting Machine 
* Generalized Low Rank Model            * Distributed Random Forest
* Word2vec




