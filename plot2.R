# plot2.R
# Reads data on household power consumption and plots the global active power consumed over a time frame of 2 days.
# Please make sure that the file "household_power_consumption.txt" is in the working directory

# reads data from "household_power_consumption.txt" and stores data in power.cons.data
power.cons.data <- read.csv("household_power_consumption.txt", sep = ";", colClasses = "character", header = TRUE)

period.begin <- "01/02/2007" # beginning of period of interest
period.end <- "02/02/2007" # end of period of interest

# creates a logical vector keep that contains the indices of the data corresponding to the above period of interest
keep <- (as.Date(power.cons.data$Date, "%d/%m/%Y") >= as.Date(period.begin, "%d/%m/%Y")) & (as.Date(power.cons.data$Date, "%d/%m/%Y") <= as.Date(period.end, "%d/%m/%Y"))
power.cons.data.subset <- power.cons.data[keep,] # subset the original data using the logical vector keep

global.active.power <- as.numeric(power.cons.data.subset$Global_active_power) # get the global active power values
xlabel <- "" # define an x-axis label
ylabel <- "Glabal Active Power (kilowatts)" # define a y-axis label

date.time <- paste(power.cons.data.subset$Date, power.cons.data.subset$Time, sep = " ") # combine date and time together
time.plot <- unclass(as.POSIXct(strptime(date.time, "%d/%m/%Y %H:%M:%S"))) # change date and time into time in seconds

# define parameters for plot to modify x-axis
tick.ref <- time.plot[1] # beginning of data
step.size <- 24*60*60 # step size between consecutive ticks
tick.values <- c(tick.ref, tick.ref + (1*step.size), tick.ref + (2*step.size)) # a vector of ticks values
tick.labels <- c("Thu", "Fri", "Sat") # a vector of ticks labels 

png(file = "plot2.png", width = 480, height = 480, units = "px", pointsize = 12) # open png device and create "plot2.png"
plot(time.plot, global.active.power, xlab = xlabel, ylab = ylabel, type = "l", xaxt = "n") # plot data and supress x-axis
axis(1, at = tick.values, labels = tick.labels) # create custom x-axis with days 
dev.off() # turn off device