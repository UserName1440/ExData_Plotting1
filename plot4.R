library(dplyr);library(lubridate);library(lattice)
## Set working directory
setwd("/Users/NoneUser1440/Desktop/Coursera/Data Science(JHU)/Exploratory Data Analysis/Week1/ExData_Plotting1")

#Download EC data files from the web, unzip them, and specify time/date settings
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
Files <- "Electric power consumption.zip"
if (!file.exists(Files)){
  download.file(URL, destfile = Files, mode="wb")
}
if (!file.exists("./household_power_consumption")){
  unzip(Files)
}
dateDownloaded <- date()
# Read table with specific separation and NA values
EPC <- read.table("./household_power_consumption.txt",sep = ";",header = T,
                  skipNul = T,na.strings = "?")
# Extract data for specific dates
twodays <- which(EPC$Date == "1/2/2007"|EPC$Date == "2/2/2007")
EPC <- EPC[twodays,] %>% mutate(NewT = dmy_hms(paste(Date,Time, sep = " ")))

#Plot 4
# Create PNG file with width = 480 and height = 480
png(filename = "./plot4.png",width = 480,height = 480)
# Create two rows and columns for 4 plots
par(mfrow = c(2,2))
plot(EPC$NewT,EPC$Global_active_power,
     main = NULL,xlab = "",ylab = X,type = "l" )
plot(EPC$NewT,EPC$Voltage,
     main = NULL,xlab = "datetime",ylab = "Voltage",type = "l" )
plot(EPC$NewT,EPC$Sub_metering_1, col = "black",type = "l",
     ylab = "Energy sub metering", xlab = "")

# Use lines function in add extra lines into the same plot
lines(EPC$NewT,EPC$Sub_metering_3, col = "blue")
lines(EPC$NewT,EPC$Sub_metering_2, col = "red")

# Set the text size prior to the plot to ensure proper text size in the legend
SetTextSize <- par(cex = 0.5)
legend("topright", 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),
       bty = "n",
       lty = 1)

# Reset the text size
SetTextSize <- par(cex = 0.8)
plot(EPC$NewT,EPC$Global_reactive_power,
     main = NULL,xlab = "datetime",ylab = "Global_reactive_power",type = "l" )
dev.off()