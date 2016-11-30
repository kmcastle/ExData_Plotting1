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

## create a histogram plotting Global Active Power
png(file = "plot1.png", height = 480, width = 480, units = "px")

hist(powerSubset$Global_active_power, 
     main = "Global Active Power", 
     col = "red",  
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency")

dev.off()
