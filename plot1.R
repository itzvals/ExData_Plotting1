#  using the “Individual household electric power consumption Data Set” 


#clean data
rm(list = ls())

#load packages
Epower <-read.csv("household_power_consumption.txt",  header=TRUE, sep=';', na.strings="?")

#convert date from df to day/month/year format
Epower$Date <- as.Date(Epower$Date, format="%d/%m/%Y")
#subset the dates 2007-02-01 and 2007-02-02. 
Epower_subset <- subset(Epower, Date >= "2007-02-01" & Date <= "2007-02-02")

#Our overall goal here is simply to examine how household energy usage 
# varies over a 2-day period in February, 2007.

# Your task is to reconstruct plots
# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
#plot1

png(filename="plot1.png", width = 480, height = 480)
hist(Epower_subset$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()