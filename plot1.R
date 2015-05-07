# Load the library required for reading the data
library(sqldf)

# Read the data from file (present in the same directory)
f <- file("household_power_consumption.txt")
hpc <- sqldf('select * from f where "Date" = "1/2/2007" or "Date" = "2/2/2007"', 
             file.format=list(sep=";", row.names=FALSE))
close(f)

# Combine Date and Time variables into one
dateTime <- paste(hpc$Date,hpc$Time)
# Add a column to the data frame that contains date and time in date format
hpc$DateTime <- strptime(dateTime, format="%d/%m/%Y %H:%M:%S")

# Open a png device, make the plot and close the device
png("plot1.png", width = 480, height = 480)
# Plot the histogram
hist(hpc$Global_active_power, col='red', main="Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab="Frequency")
dev.off()
