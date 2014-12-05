packages <- c("data.table")
sapply(packages, require, character.only=TRUE, quietly=TRUE)

dataPath <- file.path(getwd(), "data")
dataFile = file.path(dataPath, "household_power_consumption.txt")

dtDataComplete <- data.table(read.csv(dataFile, sep=";", header=TRUE,  na.strings="?", stringsAsFactors=FALSE))

#cast the date
dtDataComplete$Date <- as.Date(dtDataComplete$Date, format="%d/%m/%Y")

#get the data for 2007-02-01 and 2007-02-02
dtData <- dtDataComplete[Date >= "2007-02-01" & Date <= "2007-02-02"]
rm(dtDataComplete)

#Create date and time column
datetime <- paste(dtData$Date, dtData$Time, sep=" ")
dtData$datetime <- as.POSIXct(datetime)

#Plot the plot4 graph
plotthegraph <- function() {
        with(dtData, {
                plot(Global_active_power~datetime, type="l", ylab="Global Active Power", xlab="")
                plot(Voltage~datetime, type="l", ylab="Voltage")
                plot(Sub_metering_1~datetime, type="l", ylab="Energy sub metering", xlab="")
                lines(Sub_metering_2~datetime, col='Red')
                lines(Sub_metering_3~datetime, col='Blue')
                legend("topright", col=c("black", "red", "blue"), bty = "n", lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
                plot(Global_reactive_power~datetime, type="l")
        })
}

#plot the graph to screen
par(mfrow=c(2,2))
plotthegraph()

#dev.copy(png, file="plot4.png", height=480, width=480)
#Copying the graph to plot3.png files using dev.copy is not copying the legend probably
#therefore I am plotting the graph to PNG file
png(file="plot4.png")

par(mfrow=c(2,2))
plotthegraph()

dev.off()
