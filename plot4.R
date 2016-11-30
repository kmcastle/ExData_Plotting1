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

## set up graphics device for 4 graphs
png(file = "plot4.png", height = 480, width = 480, units = "px")

par(mfrow = c(2, 2))

## graph 1: global_active_power
with(powerSubset, 
     plot(Date, Global_active_power, 
          type = "l", 
          xlab = "", 
          ylab = "Global Active Power"))

## graph 2: voltage
with(powerSubset, plot(Date, Voltage,
                       type = "l",
                       xlab = "datetime",
                       ylab = "Voltage"))  
  
## graph 3: energy sub metering
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

## graph 4: global reactive power
with(powerSubset,
     plot(Date, Global_reactive_power,
          type = "l",
          xlab = "datetime",
          ylab = "Global_reactive_power"))
  
dev.off()