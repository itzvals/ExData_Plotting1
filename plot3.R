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

# Plot 3: Time series plot of Sub_metering_1, Sub_metering_2, and Sub_metering_3 with custom x-axis labels
png(filename = "plot3.png", width = 480, height = 480)
with(Epower_subset, {
  plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy Sub Metering", xlab = "", xaxt = "n")
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
})

# Add custom x-axis labels
axis.POSIXct(1, at = seq(start_date, end_date, by = "days"), format = "%a", labels = c("Thu", "Fri", "Sat"))

dev.off()
