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

# Convert Global_active_power to numeric.  Paste date and time and then
# convert to POSIXlt for graphing.

df2$Global_active_power <- as.numeric(df2$Global_active_power)
df2$DateTime <- paste(df2$Date, df2$Time, sep=" ")
df2$DateTime <- strptime(df2$DateTime, "%d/%m/%Y %H:%M:%S")

# Create plot and copy plot to PNG device.

with(df2, plot(DateTime, Global_active_power, type="l", xlab="", 
               ylab="Global Active Power (kilowatts"))
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
