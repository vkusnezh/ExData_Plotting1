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



# Making plot 2
plot(hpc$Global_active_power~hpc$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

#Saving file plot2.png and close device
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()