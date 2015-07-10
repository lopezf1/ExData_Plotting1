# Download files using CRAN library "downloader".  Unzip and place in folder titled,
# "ExData_Plotting1", which is the working directory.

library(downloader)
setwd("~/Coursera/Exploratory/ExData_Plotting1")
download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
         dest="dataset.zip", mode="wb")
unzip("dataset.zip", exdir="./")

# Read in dataset using read.table function.  Subset according 1/2/2007 and 2/2/2007.

df1 <- read.table("./household_power_consumption.txt", sep=";",header=TRUE, 
                  stringsAsFactors=FALSE)
df2 <- df1[df1$Date %in% c("1/2/2007", "2/2/2007"), ]
rm(df1)

# Paste date and time and then convert to POSIXlt for graphing.  
# Convert all other values to numeric.  

df2$DateTime <- paste(df2$Date, df2$Time, sep=" ")
df2$DateTime <- strptime(df2$DateTime, "%d/%m/%Y %H:%M:%S")

df2$Global_active_power <- as.numeric(df2$Global_active_power)
df2$Global_reactive_power <- as.numeric(df2$Global_reactive_power)
df2$Voltage <- as.numeric(df2$Voltage)
df2$Sub_metering_1 <- as.numeric(df2$Sub_metering_1)
df2$Sub_metering_2 <- as.numeric(df2$Sub_metering_2)

# Create plot and copy plot to PNG device.  Did not send to screen 
# devise because dev.copy "cut off" part of the legend.

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,4,2,1))
with(df2, {
    plot(DateTime, Global_active_power, type="l", xlab="", 
               ylab="Global Active Power")
    plot(DateTime, Voltage, type="l", xlab="datetime")
    plot(DateTime, Sub_metering_1, ylab="Energy sub metering",
         xlab="", type="l")
    lines(DateTime, Sub_metering_2, type="l", col="red")
    lines(DateTime, Sub_metering_3, type="l", col="blue")
    legend("topright", lty=1, lwd=1, col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(DateTime, Global_reactive_power, type="l", xlab="datetime")
})
dev.off()