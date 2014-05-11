readData <- function() {
  dataFile <- "data.csv"
  if(file.exists(dataFile)) {
    table <- read.csv(dataFile)
    table$DateTime <- strptime(table$DateTime, "%Y-%m-%d %H:%M:%S")
  } else {
    if(!file.exists("household_power_consumption.zip")) {
      fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      fileName <- download.file(fileUrl, destfile="household_power_consumption.zip")
    } else {
      fileName <- "household_power_consumption.zip"
    }
    tf <- unz(fileName, "household_power_consumption.txt")
    table <- read.table(tf, header=TRUE, sep=';', na.strings="?", colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
    table <- table[(table$Date == "1/2/2007") | (table$Date == "2/2/2007"),]
    table$DateTime <- strptime(paste(table$Date, table$Time), "%d/%m/%Y %H:%M:%S")
    write.csv(table, dataFile)
  }
  return(table)
}