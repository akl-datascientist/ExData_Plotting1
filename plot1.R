# plot1.R
# Reads data on household power consumption and plots a histrogram of the distribution of the global active power consumed.
# Please make sure that the file "household_power_consumption.txt" is in the working directory

# reads data from "household_power_consumption.txt" and stores data in power.cons.data
power.cons.data <- read.csv("household_power_consumption.txt", sep = ";", colClasses = "character", header = TRUE)

period.begin <- "01/02/2007" # beginning of period of interest
period.end <- "02/02/2007" # end of period of interest

# creates a logical vector keep that contains the indices of the data corresponding to the above period of interest
keep <- (as.Date(power.cons.data$Date, "%d/%m/%Y") >= as.Date(period.begin, "%d/%m/%Y")) & (as.Date(power.cons.data$Date, "%d/%m/%Y") <= as.Date(period.end, "%d/%m/%Y"))
power.cons.data.subset <- power.cons.data[keep,] # subset the original data using the logical vector keep

global.active.power <- as.numeric(power.cons.data.subset$Global_active_power) # get the global active power values
xlabel <- "Global Active Power (kilowatts)" # define an x-axis label
ylabel <- "Frequency" # define a y-axis label

png(file = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12) # open png device and create "plot1.png"
hist(global.active.power, xlab = xlabel, ylab = ylabel, main = "Global Active Power", col = 'red') # plot histogram
dev.off() # turn off device