
# 1. download and unzip data
if(!file.exists("./data/household_power_consumption.txt")){
    temp = tempfile()
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, temp, method = "curl")
    if(!file.exists("data")){ dir.create("./data") }
    unzip(temp, exdir = "./data")
}

# 2. read the data into R and convert $Date and $Time variables to correct format
data_full <- read.csv("./data/household_power_consumption.txt", header=TRUE, sep=';', na.strings="?", nrows =  10 )
data_full <- read.csv("./data/household_power_consumption.txt", header=TRUE, sep=';', na.strings="?", 
                      skip = 66636, nrows =  (1440*2), col.names = colnames(data_full))

data_full$Date <- as.Date(data_full$Date, "%d/%m/%Y")
data_full$DateTime <- strptime(paste(data_full$Date, data_full$Time), format = "%Y-%m-%d %H:%M:%S")

# 3. Plotting and saving


par(mfrow = c(2,2), bg="white")#, mar=par('mar')+c(2,2,2,1))#, oma = c(0.5, 0.2, 0.2, 0.2))#, mar=c(2, 0.2, 0.2, 0.2))
with(data_full,{
        plot(DateTime, Global_active_power, type = "l", ylab="Global Active Power", xlab="")
        
        plot(DateTime,Voltage, type = "l", ylab="Voltage", xlab="datetime")
        
        plot (DateTime, Sub_metering_1, type = "l", ylab="Energy sub metering", xlab="")
        lines(DateTime, Sub_metering_2, type = "l", col = "red")
        lines(DateTime, Sub_metering_3, type = "l", col = "blue")
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
               col=c("black", "red", "blue"), lty = c(1,1,1), bty = "n")
        
        plot(DateTime, Global_reactive_power, type = "l", xlab="datetime")     
})


dev.copy(png, file= "./plot4.png", height=480, width=480)
dev.off()


