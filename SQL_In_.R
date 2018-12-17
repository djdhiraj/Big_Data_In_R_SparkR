install.packages("sqldf")
library(sqldf)
library(CARS)
head(mtcars)
head(mtcars,3)
df<-sqldf("SELECT mpg FROM mtcars")
df1<-sqldf("SELECT mpg,cyl,disp FROM mtcars ")
print(df1)
# In R we can use SQL with the sqldf function. It works exactly the same as in 
#a database 

# The data.frame (in this case mtcars) represents the table we are querying and goes in the FROM statement  

# We can also compute new variables in the select statement using the syntax: 

df2<-sqldf("SELECT mpg-cyl AS difference FROM mtcars")
print(df2)

#New column addded successfully

### GROUP BY    

## Calculating avg 

df3<-sqldf("SELECT AVG(mpg) AS mpg_avg FROM mtcars GROUP BY cyl")
print(df3)

# Other aggregations 

df4<-sqldf("SELECT MAX(mpg),MIN(cyl) FROM mtcars")
print(df4)

#We could be also interested in knowing how many observations each carrier has 

df5<-sqldf("SELECT cyl, COUNT(*) AS count FROM mtcars GROUP BY cyl")
print(df5)

# Let’s create two tables: A and B to demonstrate joins.
A = data.frame(c1 = 1:4, c2 = letters[1:4]) 
B = data.frame(c1 = c(2,4,5,6), c2 = letters[c(2:5)])  
print(A)
print(B)


### INNER JOIN 
# This means to match the observations of the column we would join the tables by.   
df_inner<-sqldf("SELECT A.c1, B.c2 FROM A INNER JOIN B ON A.c1 = B.c1")
print(df_inner)  
  

  
  
  
