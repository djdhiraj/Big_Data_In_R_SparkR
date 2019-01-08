install.packages("sparklyr")
library(sparklyr)
sparklyr::spark_install()
sc<-spark_connect(master = "local") #Connected with the name of sc 
sc <- spark_connect(master = "local", version = "2.0.0", hadoop_version="2.7")
conf <- spark_config()
conf
install.packages("nycflights13")
library(nycflights13)
flights <- copy_to(sc, flights, "flights") #Copy data flights with the name of flights copied into spark 
flights_tbl <- spark_read_parquet(sc, "flights", "datainputs/nycflights13-parquet/flights")
library(dplyr) 
library(sparklyr)
library(ggplot2)
flights <- copy_to(sc, flights, "flights")
View(flights)
airlines <- copy_to(sc, airlines, "airlines")
View(airlines)
src_tbls(sc)
select(flights, year:day, arr_delay, dep_delay)
filter(flights, dep_delay > 1000)
arrange(flights, desc(dep_delay))
summarise(flights, mean_dep_delay = mean(dep_delay))
mutate(flights, speed = distance / air_time * 60)
c1 <- filter(flights, day == 17, month == 5, carrier %in% c('UA', 'WN', 'AA', 'DL'))
c2 <- select(c1, year, month, day, carrier, dep_delay, air_time, distance)
c3 <- arrange(c2, year, month, day, carrier)
c4 <- mutate(c3, air_time_hours = air_time / 60)
c4 <- flights %>%
  filter(month == 5, day == 17, carrier %in% c('UA', 'WN', 'AA', 'DL')) %>%
  select(carrier, dep_delay, air_time, distance) %>%
  arrange(carrier) %>%
  mutate(air_time_hours = air_time / 60)
c4 %>%
  group_by(carrier) %>%
  summarize(count = n(), mean_dep_delay = mean(dep_delay))
carrierhours <- collect(c4)
with(carrierhours, pairwise.t.test(air_time, carrier))
