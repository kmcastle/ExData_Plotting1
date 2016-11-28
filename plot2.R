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

## plot variable global_active_power
with(powerSubset, 
     plot(Global_active_power, 
          type = "l", 
          xaxt = "n", 
          xlab = "", 
          ylab = "Global Active Power (kilowatts)"))


## label x-axis with abbreviated days of the week
axis(1, 
     at = c(0, 1500, 2900), 
     labels = c("Thu", "Fri", "Sat"))

## save as png
dev.copy(png, file = "plot2.png", height = 480, width = 480, units = "px")

dev.off()