#This code is a solution to the first course project in the Coursera
#Exploratory Data Analysis class.

#Setup: 
##Load necessary libraries
library(data.table)
##Set the script's directory to the working directory
setwd(dirname(sys.frame(1)$ofile))

#Logic
##Read the file
df <- read.csv(file = "household_power_consumption.txt",
               header = FALSE,
               col.names = c("Date_DMY",
                             "Time_HMS",
                             "Global_active_power",
                             "Global_reactive_power",
                             "Voltage",
                             "Global_intensity",
                             "Sub_metering_1",
                             "Sub_metering_2",
                             "Sub_metering_3"),
               na.strings = "?",
               sep = ";",
               colClasses = c("character",
                              "character",
                              "numeric",
                              "numeric",
                              "numeric",
                              "numeric",
                              "numeric",
                              "numeric",
                              "numeric"),
               skip = 66637,
               nrows = 2880)
##Transform the date format
df[ , "Date_DMY"] <- as.Date(x = df[ , "Date_DMY"],
                             format = "%d/%m/%Y")
##Create a variable that can be used by the to_posix()
##function if needed
df[ , "Timestamp"] <- paste(df[ , "Date_DMY"],
                            df[ , "Time_HMS"],
                            sep = " ")

char_to_posix <- function(char_timestamp) {
  # Converts a character timestamp to posix, from:
  # "%Y-%m-%d %H:%M:%S" and as GMT
  return (strptime(char_timestamp,
                   format = "%Y-%m-%d %H:%M:%S",
                   tz = "GMT"))
}

#Plot
png(filename = "plot1.png",
    width = 480,
    height = 480,
    units = "px",
    bg = "transparent")
hist(df$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")
dev.off()