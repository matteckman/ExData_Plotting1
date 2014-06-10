## download and unzip the data file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp,method="curl")
unzip(temp) ## "household_power_consumption2.txt"
unlink(temp)

## read the data into memory
library(data.table)
data <- fread("./household_power_consumption.txt")

## clean up the data
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")
data$Global_active_power <- as.numeric(data$Global_active_power)

## subset the data to needed dates
data2 <- subset(data,data$Date > "2007-01-31" & data$Date < "2007-02-03")

## create the bar plot and save as png file
png(filename="plot1.png",width=480,height=480,units="px")
hist(data2$Global_active_power,col="red",main="Global Active Power", sub="", xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()