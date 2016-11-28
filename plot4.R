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

## set up graphics device for 4 graphs
par(mfrow = c(2, 2))

## graph 1: global_active_power
with(powerSubset, 
     plot(Global_active_power, 
          type = "l", 
          xaxt = "n", 
          xlab = "", 
          ylab = "Global Active Power"))
  ## label x-axis with abbreviated days of the week
  axis(1, 
     at = c(0, 1500, 2900), 
     labels = c("Thu", "Fri", "Sat"))

## graph 2: voltage
with(powerSubset, plot(Voltage,
                       type = "l",
                       xaxt = "n",
                       xlab = "datetime",
                       ylab = "Voltage"))  
  ## label x-axis with abbreviated days of the week
  axis(1, 
     at = c(0, 1500, 2900), 
     labels = c("Thu", "Fri", "Sat"))
  
## graph 3: energy sub metering
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

## graph 4: global reactive power
with(powerSubset,
     plot(Global_reactive_power,
          type = "l",
          xaxt = "n",
          xlab = "datetime",
          ylab = "Global_reactive_power"))
  ## label x-axis with abbreviated days of the week
  axis(1, 
     at = c(0, 1500, 2900), 
     labels = c("Thu", "Fri", "Sat"))

## save as png
dev.copy(png, file = "plot4.png", height = 480, width = 480, units = "px")
  
dev.off()