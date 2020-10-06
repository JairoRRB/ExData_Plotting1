
# Read data ---------------------------------------------------------------
HPC <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";")

# Preparing data ----------------------------------------------------------
aux1 <- subset(HPC,HPC$Date=="1/2/2007")
aux2 <- subset(HPC,HPC$Date=="2/2/2007")
aux <- aux <- rbind(aux1, aux2)
rm(aux1)
rm(aux2)
aux$Global_active_power <- as.numeric(as.character(aux$Global_active_power))
str(aux)
summary(aux)

# Creating and exporting the plot -------------------------------------------------------
png(filename = "plot1.png", width = 480, height = 480)
hist(aux$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
rm(aux)
rm(HPC)