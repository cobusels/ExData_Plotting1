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

#plot2
plot(filterdata$RDateTime,  filterdata$Global_active_power, type = "l", xlab = "", ylab = "Global Acitve Power (kilowatts)")
#copy to png device with proper size
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()
