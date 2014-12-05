setwd("~/R/ExploratoryDataAnalysis/Project1")
packages <- c("data.table")
sapply(packages, require, character.only=TRUE, quietly=TRUE)

dataPath <- file.path(getwd(), "data")
dataFile = file.path(dataPath, "household_power_consumption.txt")

dtDataComplete <- data.table(read.csv(dataFile, sep=";", header=TRUE,  na.strings="?", stringsAsFactors=FALSE))

#cast the date
dtDataComplete$Date <- as.Date(dtDataComplete$Date, format="%d/%m/%Y")

#subset only the "2007-02-01 and 2007-02-02" data
dtData <- dtDataComplete[Date >= "2007-02-01" & Date <= "2007-02-02"]
rm(dtDataComplete)

#create a date and time column
datetime <- paste(dtData$Date, dtData$Time, sep=" ")
dtData$datetime <- as.POSIXct(datetime)

#Plot the plot2 graph
plot(dtData$Global_active_power~dtData$datetime, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")


#Save the graph to file as plot2.png
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
