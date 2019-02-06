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

