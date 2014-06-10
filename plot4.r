## download and unzip the data file
#temp <- tempfile()
#download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp,method="curl")
#unzip(temp) ## "household_power_consumption2.txt"
#unlink(temp)

## read the data into memory
library(data.table)
data <- fread("./household_power_consumption.txt")

## clean up the data, part 1
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")
print('finished converting Date column to Date format...')

## subset the data to needed dates
data2 <- subset(data,data$Date > "2007-01-31" & data$Date < "2007-02-03")
print('finished subsetting data...')

## clean up the data, part 2
data2$Global_active_power <- as.numeric(data2$Global_active_power)
data2$Sub_metering_1 <- as.numeric(data2$Sub_metering_1)
print('finished converting data column to numeric...')
data2$DateTime <- paste(data2$Date,data2$Time)
print('finished creating DateTime column...')
data2$DateTime <- as.POSIXct(data2$DateTime,format="%Y-%m-%d %H:%M:%S")
print('finished converting DateTime column to POSIXct...')

## create the bar plot and save as png file
print('about to create png...')
png(filename="plot4.png",width=480,height=480,units="px")

## multiple plots, c(rows,columns)
## note: plots are filled in by rows, left to right
par(mfrow = c(2,2))

## create Plot1
plot(data2$DateTime,data2$Global_active_power,type="n",main="", sub="", xlab="", ylab="Global Active Power (kilowatts)")
  lines(data2$DateTime,data2$Global_active_power)

## create Plot 2
plot(data2$DateTime,data2$Voltage,type="n",main="", sub="", xlab="datetime", ylab="Voltage")
  lines(data2$DateTime,data2$Voltage)

## create Plot 3
plot(data2$DateTime,data2$Sub_metering_1,type="n",main="", sub="", xlab="", ylab="Energy sub metering")
  lines(data2$DateTime,data2$Sub_metering_1,col="black")
  lines(data2$DateTime,data2$Sub_metering_2,col="red")
  lines(data2$DateTime,data2$Sub_metering_3,col="blue")
  ## add legend
  legend("topright",'',c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=.8,bty="n",lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black","red","blue"))

## create Plot 4
plot(data2$DateTime,data2$Global_reactive_power,type="n",main="", sub="", xlab="datetime", ylab="Global_reactive_power")
  lines(data2$DateTime,data2$Global_reactive_power)

## close png file
dev.off()