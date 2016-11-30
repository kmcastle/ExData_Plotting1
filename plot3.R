library(dplyr)

## read in data
householdPower <- read.table(
  file = "household_power_consumption.txt", 
  sep = ";", 
  na.strings = "?", 
  header = TRUE)

## convert the variables "Date" and "Time" to date-time objects
householdPower$Date <- as.POSIXct(dmy_hms(as.character(paste(householdPower$Date, householdPower$Time))))

## subset data for the dates 2002-02-01 and 2002-02-02
powerSubset <- filter(householdPower, date(Date) == "2007-02-01" | date(Date) == "2007-02-02")

## plot variables sub_metering_1, sub_metering_2, and sub_metering_3

png(file = "plot3.png", height = 480, width = 480, units = "px")

with(powerSubset, 
     plot(Date, Sub_metering_1, 
          type = "l", 
          col = "black",
          xlab = "", 
          ylab = "Energy sub metering"))
with(powerSubset, 
     lines(Date, Sub_metering_2, 
           col = "red"))
with(powerSubset, 
     lines(Date, Sub_metering_3, 
           col = "blue"))

## create legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))

dev.off()