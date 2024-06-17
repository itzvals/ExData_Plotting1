#  using the “Individual household electric power consumption Data Set” 


#clean data
rm(list = ls())

#load packages
Epower <-read.csv("household_power_consumption.txt",  header=TRUE, sep=';', 
                  na.strings="?", check.names=F, stringsAsFactors=FALSE,
                  comment.char="", quote='\"')

#convert date from df to day/month/year format
Epower$Date <- as.Date(Epower$Date, format="%d/%m/%Y")
#subset the dates 2007-02-01 and 2007-02-02. 
Epower_subset <- subset(Epower, Date >= "2007-02-01" & Date <= "2007-02-02")

#Our overall goal here is simply to examine how household energy usage 
# varies over a 2-day period in February, 2007.

# Your task is to reconstruct plots
# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
#plot2
DTime <- paste(as.Date(Epower_subset$Date), Epower_subset$Time)
Epower_subset$Datetime <- as.POSIXct(DTime)

Epower_subset <- na.omit(Epower_subset)

png(filename = "plot2.png", width = 480, height = 480)
plot(Epower_subset$Global_active_power ~ Epower_subset$Datetime, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "",  xaxt = "n")
axis.POSIXct(1, at = seq(min(Epower_subset$Datetime), max(Epower_subset$Datetime), by = "days"), 
             format = "%a")
dev.off()

