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
png("plot4.png", width = 480, height = 480)

#fill the plots row-wise, with 2 rows and 2 columns
par(mfrow = c(2,2))

#plot 1
plot(powerDT[,dateTime], powerDT[,Global_active_power], type = "l", xlab = "", ylab = "Global Active Power")
#plot 2
plot(powerDT[,dateTime], powerDT[,Voltage], type="l", xlab = "", ylab = "Voltage")

#plot 3
plot(powerDT[,dateTime], powerDT[, Sub_metering_1], type = "l", xlab ="", ylab = "Energy sub metering")
lines(powerDT[,dateTime], powerDT[, Sub_metering_2], col="red")
lines(powerDT[,dateTime], powerDT[, Sub_metering_3], col="blue")
legend("topright", col=c("black","red", "blue")
              , lty = c(1,1)
              , bty = "n"
              , cex = 0.5
              , legend = c("Sub_metering_1 ", "Sub_metering_2 ", "Sub_metering_3 "))

#plot 4
plot(powerDT[,dateTime], powerDT[,Global_reactive_power], type = "l", xlab = "datetime", ylab = "Global_reactive_power")

#close the file connection
dev.off()