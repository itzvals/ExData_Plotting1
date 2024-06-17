#  using the “Individual household electric power consumption Data Set” 


#clean data
rm(list = ls())

# Load packages
Epower <- read.csv("household_power_consumption.txt", header = TRUE, sep = ';', 
                   na.strings = "?", check.names = FALSE, stringsAsFactors = FALSE,
                   comment.char = "", quote = '\"')

# Convert date from df to day/month/year format
Epower$Date <- as.Date(Epower$Date, format = "%d/%m/%Y")

# Subset the dates 2007-02-01 and 2007-02-02
Epower_subset <- subset(Epower, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Create Datetime column
DTime <- paste(as.Date(Epower_subset$Date), Epower_subset$Time)
Epower_subset$Datetime <- as.POSIXct(DTime)

# Remove rows with NA values in relevant columns
Epower_subset <- na.omit(Epower_subset)

# Determine the start and end points for the labels
start_date <- as.POSIXct("2007-02-01")
end_date <- as.POSIXct("2007-02-03")

png(filename = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

# Plot Global Active Power
with(Epower_subset, {
  plot(Global_active_power ~ Datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "", xaxt = "n")
  axis.POSIXct(1, at = seq(start_date, end_date, by = "days"), format = "%a", labels = c("Thu", "Fri", "Sat"))
})

# Plot Voltage
with(Epower_subset, {
  plot(Voltage ~ Datetime, type = "l", ylab = "Voltage (volt)", xlab = "", xaxt = "n")
  axis.POSIXct(1, at = seq(start_date, end_date, by = "days"), format = "%a", labels = c("Thu", "Fri", "Sat"))
})

# Plot Sub Metering
with(Epower_subset, {
  plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy Sub Metering", xlab = "", xaxt = "n")
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
  axis.POSIXct(1, at = seq(start_date, end_date, by = "days"), format = "%a", labels = c("Thu", "Fri", "Sat"))
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

# Plot Global Reactive Power
with(Epower_subset, {
  plot(Global_reactive_power ~ Datetime, type = "l", ylab = "Global Reactive Power (kilowatts)", xlab = "", xaxt = "n")
  axis.POSIXct(1, at = seq(start_date, end_date, by = "days"), format = "%a", labels = c("Thu", "Fri", "Sat"))
})
dev.off()