###############################################################################
# plot2.R:
# 1. loads data from "household_power_consumption.txt"
# 2. generates required subset based on specified dates
# 3. creates a scatterplot 
# 4. writes this scatterplot to png file: plot2.png
###############################################################################

# cleanup the environment
rm(list=ls(all=TRUE)) 

# set working directory where the data file has been downloaded and unzipped to
setwd("~/ExData_Plotting1/")

# load library that deals with date, time manipulations
library(lubridate)

# read full data set into the data frame
df <- read.table("household_power_consumption.txt", header = TRUE, sep = ';',stringsAsFactors=FALSE, na.strings="?", dec = ".")

# select subset of the data for 2 days as required by the assignment
a <- df[df$Date %in% c("1/2/2007","2/2/2007"),]

# check data types: as expected
# > str(a)
# 'data.frame':        2880 obs. of  9 variables:
#$ Date                 : chr  "1/2/2007" "1/2/2007" "1/2/2007" "1/2/2007" ...
#$ Time                 : chr  "00:00:00" "00:01:00" "00:02:00" "00:03:00" ...
#$ Global_active_power  : num  0.326 0.326 0.324 0.324 0.322 0.32 0.32 0.32 0.32 0.236 ...
#$ Global_reactive_power: num  0.128 0.13 0.132 0.134 0.13 0.126 0.126 0.126 0.128 0 ...
#$ Voltage              : num  243 243 244 244 243 ...
#$ Global_intensity     : num  1.4 1.4 1.4 1.4 1.4 1.4 1.4 1.4 1.4 1 ...
#$ Sub_metering_1       : num  0 0 0 0 0 0 0 0 0 0 ...
#$ Sub_metering_2       : num  0 0 0 0 0 0 0 0 0 0 ...
#$ Sub_metering_3       : num  0 0 0 0 0 0 0 0 0 0 ...

# convert Date to a Date object
a$Date <- as.Date(strptime(a$Date, "%d/%m/%Y"))

# add new column and set to a string that concat Date and Time 
a$DateTime <- do.call(paste, as.data.frame(a[,1:2], stringsAsFactors=FALSE))

# convert DateTime to POSIXct
a$DateTime <- ymd_hms(a$DateTime)

# check data type: as expected
#> class(a$DateTime)
#[1] "POSIXct" "POSIXt" 

# create the requested scatterplot and write it to png file
png(file="plot2.png", width=480, height=480, bg = "transparent")
plot(a$DateTime, a$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
dev.off()

