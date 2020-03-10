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

hpc$datetime <- hpc$Date+hpc$Time

png("plot4.png")

#Setup 2x2 layout
par(mfcol = c(2,2))

#plot2 - top left
with(hpc, plot(datetime, Global_active_power, type='l', ylab="Global Active Power", xlab=""))

#plot3 - bottom left
with(hpc, plot(datetime, Sub_metering_1, ylab="Energy sub metering", xlab="", type="n"))
with(hpc, lines(datetime, Sub_metering_1))
with(hpc, lines(datetime, Sub_metering_2, col="red"))
with(hpc, lines(datetime, Sub_metering_3, col="blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), box.lwd = 0, inset=0.005)

#line plot Voltage over time
with(hpc, plot(datetime, Voltage, type='l'))

#line plot Global_reactive_power over time
with(hpc, plot(datetime, Global_reactive_power, type='l'))

dev.off()

