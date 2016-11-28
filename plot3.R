library(lubridate)
library(dplyr)

## read in data
householdPower <- read.table(
  file = "household_power_consumption.txt", 
  sep = ";", 
  na.strings = "?", 
  header = TRUE)

## convert the variables "Date" and "Time" to date-time objects
householdPower$Date <- dmy(householdPower$Date)
householdPower$Time <- hms(householdPower$Time)

## subset data for the dates 2002-02-01 and 2002-02-02
powerSubset <- filter(householdPower, Date == "2007-02-01" | Date == "2007-02-02")

## plot variables sub_metering_1, sub_metering_2, and sub_metering_3
with(powerSubset, 
     plot(Sub_metering_1, 
          type = "l", 
          col = "black", 
          xaxt = "n", 
          xlab = "", 
          ylab = "Energy sub metering"))
with(powerSubset, 
     lines(Sub_metering_2, 
           col = "red"))
with(powerSubset, 
     lines(Sub_metering_3, 
           col = "blue"))

## label x-axis with abbreviated days of the week
axis(1, 
     at = c(0, 1500, 2900), 
     labels = c("Thu", "Fri", "Sat"))

## create legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))

## save as png
dev.copy(png, file = "plot3.png", height = 480, width = 480, units = "px")

dev.off()