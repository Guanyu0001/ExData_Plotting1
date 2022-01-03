library(lubridate)
# read data
dat <- read.csv("household_power_consumption.txt", sep = ";")

# clean data
datatime <- paste(dat$Date, dat$Time)
dat$datatime <- dmy_hms(datatime)

interval1<- interval(ymd("2007-02-01"), ymd_hms("2007-02-02 24:00:00"))
dat1 <- dat[dat$datatime %within% interval1,]

dat1$Global_active_power <- as.numeric(dat1$Global_active_power)
dat1$Global_reactive_power <- as.numeric(dat1$Global_reactive_power)
dat1$Sub_metering_1 <- as.numeric(dat1$Sub_metering_1)
dat1$Sub_metering_2 <- as.numeric(dat1$Sub_metering_2)
dat1$Sub_metering_3 <- as.numeric(dat1$Sub_metering_3)

# plot

png(file  = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
plot(dat1$Global_active_power~dat1$datatime, type= "l", ylab = "Global Active Power", xlab="")

plot(dat1$Voltage~dat1$datatime, type= "l", ylab = "Voltage", xlab="datetime")

plot(dat1$Sub_metering_1~dat1$datatime, type="l", xlab = "", ylab = "Energy sub metering")
lines(dat1$Sub_metering_2~dat1$datatime, col="red")
lines(dat1$Sub_metering_3~dat1$datatime, col="blue")
legend("topright",col = c("black","red","blue"), lty=1, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

plot(dat1$Global_reactive_power~dat1$datatime, type= "l", xlab="datetime")
dev.off()
