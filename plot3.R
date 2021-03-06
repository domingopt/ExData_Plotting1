# plot1.R:  Reads data from the "Individual household electric power consumption 
#           Data Set" and produces a hostogram plot.

# ------------------------------------------------------------------------------
# Data munging
# ------------------------------------------------------------------------------
# Read the data from the txt file
fileName <- "/Volumes/Data/coursera/Data Science/exdata/ExData_Plotting1/household_power_consumption.txt"
baseData <- read.csv(fileName, sep=";", stringsAsFactors = F)
# Filter based on the required dates
subsetData <- subset(baseData, Date == "1/2/2007" | Date == "2/2/2007")
# Convert the first 2 columns into Dates and Times
subsetData$Datetime <- strptime(paste(subsetData$Date, 
                                      subsetData$Time),
                                format = "%d/%m/%Y %H:%M:%S")
# Convert the rest of columns into numeric
cols = c(2:9)
subsetData[,cols] = apply(subsetData[,cols], 2, function(x) as.numeric(as.character(x)))

# ------------------------------------------------------------------------------
# Building the plot
# ------------------------------------------------------------------------------
png(filename = 'plot3.png', width = 480, height = 480, units = 'px')
with(subsetData, plot(Datetime, Sub_metering_1, type = 'l', 
                      col = 'black', ylab = 'Energy sub metering',
                      xlab = ''))
with(subsetData, lines(Datetime, Sub_metering_2, col = 'red'))
with(subsetData, lines(Datetime, Sub_metering_3, col = 'blue'))
legend("topright", col = c('black', 'blue', 'red'), 
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
dev.off()