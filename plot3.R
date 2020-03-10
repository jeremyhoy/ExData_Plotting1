#Download and unzip data files

zipFile <- 'HPC.zip'
dataFile <- 'household_power_consumption.txt'

if (!file.exists(zipFile)){
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                  ,zipFile)
}

if(!file.exists(dataFile)){
    unzip(zipFile)
}

#Load file contents into data frame
householdPowerConsumption <- read.table(dataFile, header=TRUE, sep=";", na.strings = "?")

#Convert Date and Time variables
library(lubridate)

householdPowerConsumption$Date <- dmy(householdPowerConsumption$Date)
householdPowerConsumption$Time <- hms(householdPowerConsumption$Time)

#subset data set to the dates we're interested in
hpc <- subset(householdPowerConsumption, Date=='2007-02-01'|Date=='2007-02-02')

hpc$DateTime <- hpc$Date+hpc$Time

#Plot to display device
# with(hpc, plot(DateTime, Sub_metering_1, ylab="Energy sub metering", xlab="", type="n"))
# with(hpc, lines(DateTime, Sub_metering_1))
# with(hpc, lines(DateTime, Sub_metering_2, col="red"))
# with(hpc, lines(DateTime, Sub_metering_3, col="blue"))
# legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Plot to png device
png("plot3.png")
with(hpc, plot(DateTime, Sub_metering_1, ylab="Energy sub metering", xlab="", type="n"))
with(hpc, lines(DateTime, Sub_metering_1))
with(hpc, lines(DateTime, Sub_metering_2, col="red"))
with(hpc, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
