# Reading the data from the dates 2007-02-01 and 2007-02-02

hpc <- read.table("household_power_consumption.txt",
                  header=TRUE, sep=";", na.strings = "?", 
                  colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))


hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")                                        # Format date to Type Date
hpc <- subset(hpc,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))     # Filter data set from 2007-02-01 to 2007-02-02
hpc <- hpc[complete.cases(hpc),]                                                 # Remove incomplete observation

dateTime <- paste(hpc$Date, hpc$Time)                           # Combine Date and Time column
dateTime <- setNames(dateTime, "DateTime")                      # Name the vector
hpc <- hpc[ ,!(names(hpc) %in% c("Date","Time"))]               # Remove Date and Time column
hpc <- cbind(dateTime, hpc)                                     # Add DateTime column
hpc$dateTime <- as.POSIXct(dateTime)                            # Format dateTime Column


#Making plot 3
with(hpc, {
        plot(Sub_metering_1~dateTime, type="l", ylab="Global Active Power", xlab="")
        lines(Sub_metering_2~dateTime, col = "red")
        lines(Sub_metering_3~dateTime, col = "blue")
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Saving file plot3.png and close device
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()