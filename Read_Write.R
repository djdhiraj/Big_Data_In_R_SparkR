#Reading and Writing Data

#You can read and write data in CSV, JSON, and Parquet formats. Data can be stored in HDFS, S3, 
#or on the lcoal filesystem of cluster nodes.


temp_csv <- tempfile(fileext = ".csv")
temp_parquet <- tempfile(fileext = ".parquet")
temp_json <- tempfile(fileext = ".json")

spark_write_csv(iris_tbl, temp_csv)
iris_csv_tbl <- spark_read_csv(sc, "iris_csv", temp_csv)

spark_write_parquet(iris_tbl, temp_parquet)
iris_parquet_tbl <- spark_read_parquet(sc, "iris_parquet", temp_parquet)

spark_write_json(iris_tbl, temp_json)
iris_json_tbl <- spark_read_json(sc, "iris_json", temp_json)

src_tbls(sc)

#Extensions
#The facilities used internally by sparklyr for its dplyr and machine learning interfaces are available to extension packages.
#Since Spark is a general purpose cluster computing system there are many potential applications for extensions 
#(e.g. interfaces to custom machine learning pipelines, interfaces to 3rd party Spark packages, etc.).

#Here’s a simple example that wraps a Spark text file line counting function with an R function:

# write a CSV 
tempfile <- tempfile(fileext = ".csv")
write.csv(nycflights13::flights, tempfile, row.names = FALSE, na = "")

# define an R interface to Spark line counting
count_lines <- function(sc, path) {
  spark_context(sc) %>% 
    invoke("textFile", path, 1L) %>% 
      invoke("count")
}

# call spark to count the lines of the CSV
count_lines(sc, tempfile)



#Table Utilities
#You can cache a table into memory with:
tbl_cache(sc, "batting") #where batting is a file name 
#and unload from memory using:

tbl_uncache(sc, "batting") #where batting is a file name 

#Connection Utilities
#You can view the Spark web console using the spark_web function:
spark_web(sc)
#You can show the log using the spark_log function:
spark_log(sc, n = 10)

spark_disconnect(sc) # disconnect connection
