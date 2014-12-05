packages <- c("data.table")
sapply(packages, require, character.only=TRUE, quietly=TRUE)

dataPath <- file.path(getwd(), "data")
dataFile = file.path(dataPath, "household_power_consumption.txt")

dtDataComplete <- data.table(read.csv(dataFile, sep=";", header=TRUE,  na.strings="?", stringsAsFactors=FALSE))

#Cast the date
dtDataComplete$Date <- as.Date(dtDataComplete$Date, format="%d/%m/%Y")

#get two days of data
dtData <- dtDataComplete[Date >= "2007-02-01" & Date <= "2007-02-02"]
rm(dtDataComplete)

#Create date and time column
datetime <- paste(dtData$Date, dtData$Time, sep=" ")
dtData$datetime <- as.POSIXct(datetime)

#plot the hist graph
hist(dtData$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

#copy the graph to plot1.png
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
