#################################################################################################
# So this is the R script file for project 1 of Week 1 of the coursera MOOC "Exploratory data
# analysis": plot2
# by Carina M Gsottbauer
# 8th March 2015
#################################################################################################

# Set the working directory
setwd("C:/Users/Beowulf/Desktop/Expl_data_analysis")
# Check that setting the working directory worked
getwd()

# Load the data (data file is massive, so will take a bit of time to load everything)
power <- read.table("household_power_consumption.txt", sep=";", header = TRUE)
#check the data
str(power)
#check the data
head(power)

# SO this is a lot of data but I only need the data for 2 dates: 01/02/2007 and 02/02/2007
# so let's subset it accordingly
power2 <- subset(power, Date == "1/2/2007" | Date == "2/2/2007", header = TRUE)
#check the data
str(power2)
# rerun Date as a factor to remove the old number of levels showing
power2$Date <- as.factor(power2$Date)
#check the data
str(power2)

# for some reason R thinks this is a factor with levels
# so this code transform it into a numeric without losing the decimals
power2$Global_active_power <-as.numeric(as.character(power2$Global_active_power))
#check the data
str(power2)


### So I want to combine date and time so that I then can plot Global_active_power against it
# both Date and Time need to be characters for this to work
power2$timestamp <- as.POSIXct(paste(power2$Date, power2$Time, sep = " "),
                               format = "%d/%m/%Y %H:%M:%S")
head(power2)


# Now lets plot the date on the x-axis and the Global_active_power on the y axis
png(filename="plot2.png",  width=480, height=480) # width&height not necessary, as 480x480 = default
plot(power2$timestamp, power2$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
dev.off()
# type="l" means that R plots lines btw. data points
# xlab = "" removes the x-axis label