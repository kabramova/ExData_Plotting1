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
png("plot4.png", width = 480, height = 480)
# Create a 2-by-2 main plot
par(mfrow=c(2,2))
# Plot all 4 little plots
plot(hpc$DateTime, hpc$Global_active_power, type='l', xlab = "", 
     ylab="Global Active Power")
plot(hpc$DateTime, hpc$Voltage, type='l', xlab = "datetime", ylab="Voltage")
yrange<-range(c(hpc$Sub_metering_1,hpc$Sub_metering_2,hpc$Sub_metering_3))
plot(hpc$DateTime,hpc$Sub_metering_1,type="l",ylim=yrange, xlab="",
     ylab="Energy sub metering")
lines(hpc$DateTime, hpc$Sub_metering_2,type="l",col='red')
lines(hpc$DateTime, hpc$Sub_metering_3,type="l",col='blue')
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lwd=c(1,1,1),col=c("black", "red", "blue"), bty="n")
plot(hpc$DateTime, hpc$Global_reactive_power, type='l', xlab = "datetime", 
     ylab="Global_reactive_power")
dev.off()