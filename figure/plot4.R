# Read data ---------------------------------------------------------------
HPC <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";")

# Preparing data ----------------------------------------------------------
aux1 <- subset(HPC,HPC$Date=="1/2/2007")
aux1$Date <- as.Date(aux1$Date, format="%d/%m/%Y")
aux1$Time <- strptime(aux1$Time, format="%H:%M:%S")
aux1[1:nrow(aux1),"Time"] <- format(aux1[1:nrow(aux1),"Time"],"2007-02-01 %H:%M:%S")

aux2 <- subset(HPC,HPC$Date=="2/2/2007")
aux2$Date <- as.Date(aux2$Date, format="%d/%m/%Y")
aux2$Time <- strptime(aux2$Time, format="%H:%M:%S")
aux2[1:nrow(aux2),"Time"] <- format(aux2[1:nrow(aux2),"Time"],"2007-02-02 %H:%M:%S")

aux <- rbind(aux1, aux2)
rm(aux1)
rm(aux2)
aux$Global_active_power <- as.numeric(as.character(aux$Global_active_power))
aux$Global_reactive_power <- as.numeric(as.character(aux$Global_reactive_power))
aux$Voltage <- as.numeric(as.character(aux$Voltage))
aux$Sub_metering_1 <- as.numeric(as.character(aux$Sub_metering_1))
aux$Sub_metering_2 <- as.numeric(as.character(aux$Sub_metering_2))
str(aux)
summary(aux)

# Creating and exporting the plot -------------------------------------------------------
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
plot(aux$Time, aux$Global_active_power, type = "l", xlab = " ", ylab = "Global Active Power")
plot(aux$Time, aux$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(aux$Time, aux$Sub_metering_1, type = "l", xlab = " ", ylab = "Energy sub metering")
lines(aux$Time, aux$Sub_metering_2, col = "red")
lines(aux$Time, aux$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub metering_1", "Sub metering_2", "Sub metering_3"))
plot(aux$Time, aux$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
rm(aux)
rm(HPC)