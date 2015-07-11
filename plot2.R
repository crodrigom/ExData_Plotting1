
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
par(bg="white")
plot(data_full$DateTime, data_full$Global_active_power, type = "l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file= "./plot2.png", height=480, width=480) 
dev.off()