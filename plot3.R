# plot3.R
# Reads data on household power consumption and plots the readings of three energy meters over a time frame of 2 days.
# Please make sure that the file "household_power_consumption.txt" is in the working directory

# reads data from "household_power_consumption.txt" and stores data in power.cons.data
power.cons.data <- read.csv("household_power_consumption.txt", sep = ";", colClasses = "character", header = TRUE)

period.begin <- "01/02/2007" # beginning of period of interest
period.end <- "02/02/2007" # end of period of interest

# creates a logical vector keep that contains the indices of the data corresponding to the above period of interest
keep <- (as.Date(power.cons.data$Date, "%d/%m/%Y") >= as.Date(period.begin, "%d/%m/%Y")) & (as.Date(power.cons.data$Date, "%d/%m/%Y") <= as.Date(period.end, "%d/%m/%Y"))
power.cons.data.subset <- power.cons.data[keep,] # subset the original data using the logical vector keep

meter.1 <- as.numeric(power.cons.data.subset$Sub_metering_1) # get the readings of the first meter
meter.2 <- as.numeric(power.cons.data.subset$Sub_metering_2) # get the readings of the second meter
meter.3 <- as.numeric(power.cons.data.subset$Sub_metering_3) # get the readings of the third meter
xlabel <- "" # define an x-axis label
ylabel <- "Energy sub metering" # define a y-axis label

date.time <- paste(power.cons.data.subset$Date, power.cons.data.subset$Time, sep = " ") # combine date and time together
time.plot <- unclass(as.POSIXct(strptime(date.time, "%d/%m/%Y %H:%M:%S"))) # change date and time into time in seconds

# define parameters for plot to modify x-axis
tick.ref <- time.plot[1] # beginning of data
step.size <- 24*60*60 # step size between consecutive ticks
tick.values <- c(tick.ref, tick.ref + (1*step.size), tick.ref + (2*step.size)) # a vector of ticks values
tick.labels <- c("Thu", "Fri", "Sat") # a vector of ticks labels 

png(file = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12) # open png device and create "plot3.png"
plot(time.plot, meter.1, xlab = xlabel, ylab = ylabel, type = "n", xaxt = "n")
axis(1, at = tick.values, labels = tick.labels) # create custom x-axis

lines(time.plot, meter.1) # plot meter 1 data
lines(time.plot, meter.2, col = "red") # plot meter 2 data
lines(time.plot, meter.3, col = "blue") # plot meter 3 data

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), lwd = c(2,2,2), col = c("black", "red", "blue")) # create a legend
dev.off() # turn off device