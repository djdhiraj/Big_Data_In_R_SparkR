# To import airlines file from H2O’s package:
library(h2o)
h2o.init()
irisPath <- "https://s3.amazonaws.com/h2o-airlines-unpacked/allyears2k.csv"
iris.hex <- h2o.importFile(path = irisPath, destination_frame = "iris.hex")

# To import from S3:
library(h2o)
h2o.init()
airlinesURL <- "https://s3.amazonaws.com/h2o-airlines-unpacked/allyears2k.csv"
airlines.hex <- h2o.importFile(path = airlinesURL, destination_frame = "airlines.hex")
flightsByMonth <- h2o.group_by(data = airlines.hex,
                               by = "Month",
                               nrow("Month"),
                               gb.control=list(na.methods="rm"))   #Group by Month data frame in h2o
flightsByMonth.R <- as.data.frame(flightsByMonth) # Convert h2o data frame to R data frame 
class(flightsByMonth.R)      
# Find the number of flights in a given month based on the origin
cols <- c("Origin","Month")
flightsByOriginMonth <- h2o.group_by(data=airlines.hex,
                                     by=cols,
                                     nrow("Month"),
                                     gb.control=list(na.methods="rm"))
flightsByOriginMonth.R <- as.data.frame(flightsByOriginMonth)
flightsByOriginMonth.R
which(colnames(airlines.hex)=="Cancelled")
cancellationsByMonth <- h2o.group_by(data = airlines.hex,
                                     by = "Month",
                                     sum("Cancelled"),
                                     gb.control=list(na.methods="rm"))
cancellation_rate <- cancellationsByMonth$sum_Cancelled/flightsByMonth$nrow
rates_table <- h2o.cbind(flightsByMonth$Month,cancellation_rate)
rates_table.R <- as.data.frame(rates_table)
rates_table.R


cols <- c("Dest", "IsArrDelayed", "IsDepDelayed")
originFlights <- h2o.group_by(data = airlines.hex[c("Origin",cols)],
                              by = "Origin",
                              sum(cols),
                              gb.control = list(na.methods = "ignore", col.names = NULL))

# Note a warning because col.names null
res <- h2o.cbind(lapply(cols, function(x){h2o.group_by(airlines.hex,by="Origin",sum(x))}))[,c(1,2,4,6)]
res
summary(airlines.hex)


# View quantiles and histograms
#high_na_columns = h2o.ignoreColumns(data = airlines.hex)
quantile(x = airlines.hex$ArrDelay, na.rm = TRUE)
h2o.hist(airlines.hex$ArrDelay)

airlines.split = h2o.splitFrame(data = airlines.hex,
                                ratios = 0.85) # Split data into test and train 
airlines.train = airlines.split[[1]]  # train data set
airlines.test = airlines.split[[2]]  # test data set
h2o.table(airlines.train$Cancelled)  # View table data set 
h2o.table(airlines.test$Cancelled)   # View table data set

