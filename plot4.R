#COMMON: Fetching, loading and preparing file for graphics
#-----------------------------------------------
zlclfile <- "household_power_consumption.zip"
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = zlclfile,
              method = "auto",
              mode = "wb");
unzip(zipfile = zlclfile, overwrite = TRUE)
              
rawpowerdata <- read.table(file = "household_power_consumption.txt", 
                           colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
                           stringsAsFactors = FALSE,
                           sep = ";",
                           header = TRUE,
                           na.strings = "?"
                           )

#Converting input date to R Date class & setting up a smaller filtered dataset
rawpowerdata$RDate <- as.Date(rawpowerdata$Date, format = "%d/%m/%Y")
rawpowerdata$RDateTime <- as.POSIXct(paste(rawpowerdata$Date, rawpowerdata$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")
filterdata <- subset(rawpowerdata, RDate == as.Date("2007-02-01") | RDate == as.Date("2007-02-02"))

#plot4
#set parameters for multi-plot
par(mfrow=c(2,2), mar=c(5,4,2,1))
#use with to cut down on typing
with(filterdata, {
  #(1,1)
  plot(RDateTime,  Global_active_power, type = "l", xlab = "", ylab = "Global Acitve Power (kilowatts)")
  #(2,1)
  plot(RDateTime,  Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  #(1,2)
  plot(RDateTime,  Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
  points(RDateTime, Sub_metering_2, col = "red", type ="l")
  points(RDateTime, Sub_metering_3, col = "blue" , type ="l")
  legend("topright",  lwd=1, lty=1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  #(2,2)
  plot(RDateTime,  Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
  })


#copy to png device with proper size
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
