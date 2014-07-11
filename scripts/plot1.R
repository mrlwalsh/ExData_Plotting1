# Read power data and create plot 1
# plot1.R  20140711

setwd("C:/Users/Michael/Google Drive/Coursera/Exploratory Data Analysis/Projects")

if (!file.exists("data")) {
  dir.create("data")
}

if (!file.exists("figures")) {
  dir.create("figures")
}

# Download data file

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "./data/powerarchive.zip")

powerdat <- read.table(unz("./data/powerarchive.zip","household_power_consumption.txt"), header=TRUE, sep=";", colClasses = "character")
showConnections()
closeAllConnections()


dir()
powerdat <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", colClasses = "character")
str(powerdat)
head(powerdat)

# Create datetime variable and convert Date to date class

powerdat$dt <- as.POSIXct(paste(powerdat$Date, powerdat$Time), format="%d/%m/%Y %H:%M:%S")

powerdat$Date <- as.Date(powerdat$Date, format = "%d/%m/%Y")
head(powerdat)


# subset to just 2007-02-01 and 2007-02-02

powersamp <- powerdat[powerdat$Date == "2007-02-01" | 
                       powerdat$Date == "2007-02-02",]

# Convert character variables to numeric 

powersamp$Global_active_power <- as.numeric(powersamp$Global_active_power)
powersamp$Global_reactive_power <- as.numeric(powersamp$Global_reactive_power)
powersamp$Voltage <- as.numeric(powersamp$Voltage)
powersamp$Global_intensity <- as.numeric(powersamp$Global_intensity)
powersamp$Sub_metering_1 <- as.numeric(powersamp$Sub_metering_1)
powersamp$Sub_metering_2 <- as.numeric(powersamp$Sub_metering_2)
powersamp$Sub_metering_3 <- as.numeric(powersamp$Sub_metering_3)


str(powersamp)
summary(powersamp)

# Save plot to png file

#plot 1

png(file = "./figures/plot1.png")

hist(powersamp$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col = "Red")

dev.off()
