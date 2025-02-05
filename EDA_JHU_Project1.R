# Uploading required packages
library(readr)
library(ggplot2)
library(lubridate)

# Creating the plot1
power <- read_delim("C:/Users/Downloads/exdata_data_household_power_consumption/household_power_consumption.txt", delim = ";", escape_double = FALSE, trim_ws = TRUE)
power <- power %>% mutate(Date = as.Date(Date, format = '%d/%m/%Y'))
power <- filter(power, Date >= '2007-02-01' & Date < '2007-02-03')
power$Global_active_power <- as.numeric(power$Global_active_power)
png("plot1.png", width=480, height=480)
hist(power$Global_active_power, main = 'Global Active Power', xlab = 'Global Active Power (kW)', ylab = 'Frequency', col = 'red')
dev.off()

# Creating the plot2
png("plot2.png", width=480, height=480)
power$DateTime <- as.POSIXct(paste(power$Date, power$Time), format = '%Y-%m-%d %H:%M:%S')
ggplot(power, aes(DateTime, Global_active_power)) + geom_line() + labs(x = 'Date', y = 'Global Active Power (kW)')
dev.off()

# Creating the plot3
power$Sub_metering_1 <- as.numeric(power$Sub_metering_1)
power$Sub_metering_2 <- as.numeric(power$Sub_metering_2)
power$Sub_metering_3 <- as.numeric(power$Sub_metering_3)
png("plot3.png", width=480, height=480)
plot(power$DateTime, power$Sub_metering_1, type="l", xlab="", ylab="Energy Sub Metering")
lines(power$DateTime, power$Sub_metering_2, col="red")
lines(power$DateTime, power$Sub_metering_3, col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "), lty=c(1,1), lwd=c(1,1))
dev.off()

# Creating the plot4
power$Global_reactive_power <-as.numeric(power$Global_reactive_power)
power$Voltage <- as.numeric(power$Voltage)
power$Global_intensity <- as.numeric(power$Global_intensity)
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
plot(power$DateTime, power$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(power$DateTime, power$Voltage, type = "l", xlab = "Datetime", ylab = "Voltage")
plot(power$DateTime, power$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(power$DateTime, power$Sub_metering_2, col="red")
lines(power$DateTime, power$Sub_metering_3, col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "), lty=c(1,1), bty="n", cex=.5)
plot(power$DateTime, power$Global_reactive_power, type = "l", xlab = "DateTime", ylab = "Global Reactive Power")
dev.off()
