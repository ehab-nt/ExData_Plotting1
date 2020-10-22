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
png("plot1.png", width = 480, height = 480)

#create the histogram
hist(powerDT[, Global_active_power], main = "Global Active Power", xlab = "", ylab = "Frequency", col = "Red")

#close the file connection
dev.off()