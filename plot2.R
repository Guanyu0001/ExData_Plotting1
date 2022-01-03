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

#plot
png(file  = "plot2.png", width = 480, height = 480)
plot(dat1$Global_active_power~dat1$datatime, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
