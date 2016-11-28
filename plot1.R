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

## create a histogram plotting Global Active Power
hist(powerSubset$Global_active_power, 
     main = "Global Active Power", 
     col = "red",  
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency")

## save as png
dev.copy(png, file = "plot1.png", height = 480, width = 480, units = "px")

dev.off()
