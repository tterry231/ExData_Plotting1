## TAT - Exploratory Data Analysis Week 1 Assignment
## 
## Source Data - UCI Machine Learning Database for Household Power Consumption
##
## Data for plotting - February 1,2 - 2007
##
## Library required - "lubridate"

library(lubridate)

##
## Download dataset for processing and unzip
##

fileUrl <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"

dir.create("UCIHouseholdPower")

download.file(fileUrl, destfile="UCIHouseholdPower/UCIHouseholdPower.zip")

unzip("UCIHouseholdPower/UCIHouseholdPower.zip")

##
## Read first 5 rows to get "classes" information to improve speed of "read.table"
##

hh_power_5rows <- read.table("household_power_consumption.txt", header = TRUE, check.names = TRUE, sep = ";", nrows = 5)

classes <- sapply(hh_power_5rows, class)

##
## load "hh_power" with data - checking column names, using "classes", and ";" separator
##

hh_power <- read.table("household_power_consumption.txt", header = TRUE, check.names = TRUE, sep = ";", na.strings = "?", colClasses = classes)

##
## Create new column "$date_time" for combined, converted timestamp from "$Date" and "$Time
##
## Use the local timezone of the system processing data to adjust tz in $date_time
## 

local_tz <- Sys.timezone()

hh_power$date_time = dmy_hms(paste(hh_power$Date, hh_power$Time), tz = local_tz)

##
## Subset the data frame for the needed dates - Feb. 1, 2007 and Feb. 2, 2007
##

hh_power_sub_1 <- subset(hh_power, hh_power$date_time >= "2007-02-01 00:00:00" & hh_power$date_time < "2007-02-03 00:00:00")

##
## Remove original data frame to free up memory along with temp data frame used for "classes"
##

rm(hh_power)
rm(hh_power_5rows)

##
## Create Plot 3 - line plot for "$Sub_metering[1:3]" over "time"
##

with(hh_power_sub_1, plot(Sub_metering_1 ~ date_time, ylab = "Energy sub metering", xlab = "", type = "l"))
with(hh_power_sub_1, points(Sub_metering_2 ~ date_time, col= "red", type = "l"))
with(hh_power_sub_1, points(Sub_metering_3 ~ date_time, col= "blue", type = "l"))
legend("topright", col = c("black", "red", "blue"), lty = c(1,1,1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##
## Copy the plot to .png and close the device
##

dev.copy(png,"plot3.png", width = 480, height = 480)
dev.off()








