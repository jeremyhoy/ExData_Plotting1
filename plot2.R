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

#Plot line chart to display device
#with(hpc, plot(DateTime, Global_active_power, type='l', ylab="Global Active Power (kilowatts)", xlab=""))

#Plot line chart to png file device
png("plot2.png")
with(hpc, plot(DateTime, Global_active_power, type='l', ylab="Global Active Power (kilowatts)", xlab=""))
dev.off()