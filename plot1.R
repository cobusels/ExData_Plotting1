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
filterdata <- subset(rawpowerdata, RDate == as.Date("2007-02-01") | RDate == as.Date("2007-02-02"))


#plot1
hist(filterdata$Global_active_power, col = "Red", main = "Global Active Power", xlab = "Global Acitve Power (kilowatts)")
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
