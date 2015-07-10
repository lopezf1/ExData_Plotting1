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

# Convert Sub_metering to numeric.  Paste date and time and then
# convert to POSIXlt for graphing.

df2$Sub_metering_1 <- as.numeric(df2$Sub_metering_1)
df2$Sub_metering_2 <- as.numeric(df2$Sub_metering_2)
df2$DateTime <- paste(df2$Date, df2$Time, sep=" ")
df2$DateTime <- strptime(df2$DateTime, "%d/%m/%Y %H:%M:%S")

# Create plot and copy plot to PNG device.  Did not send to screen 
# devise because dev.copy "cut off" part of the legend.

png("plot3.png", width=480, height=480)
par(mfrow=c(1,1))
with(df2, plot(DateTime, Sub_metering_1, ylab="Energy sub metering",
               xlab="", type="l"))
with(df2, lines(DateTime, Sub_metering_2, type="l", col="red"))
with(df2, lines(DateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", lty=1, lwd=1, col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

