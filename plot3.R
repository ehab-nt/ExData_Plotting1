library("data.table")
powerDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?")
#Prevents printing in scientific notation, convert the variable to numeric
powerDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

#Convert date column type
powerDT[, dateTime := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("dateTime")]

#Filter the dates
powerDT <- powerDT[(dateTime >= "2007-02-01") & (dateTime <= "2007-02-03")]

#Create png file and open connection to it
png("plot3.png", width = 480, height = 480)

#Create the plot. type = "l" for normal line plot
plot(powerDT[, dateTime], powerDT[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")

#add the lines to existing plot
lines(powerDT[, dateTime], powerDT[, Sub_metering_2],col="red")
lines(powerDT[, dateTime], powerDT[, Sub_metering_3],col="blue")

#add the legend, mention its color, line type & width, labels, position
legend("topright"
       , col=c("black","red","blue")
       , legend = c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))


#close the file connection
dev.off()