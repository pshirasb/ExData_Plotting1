#-----------------------------------------------------------------
# Plot Number 1
#-----------------------------------------------------------------

data_filename = "household_power_consumption.txt"
data_url      = paste0("https://d396qusza40orc.cloudfront.net/",
                       "exdata%2Fdata%2Fhousehold_power_consumption.zip")

# Download and unzip the data if it does
# not exist already
if(!file.exists(data_filename)) {
    download.file( url    = data_url
                 , dest   = "data.zip"
                 , method = "curl" )
    unzip( zipfile = "data.zip" )
}

# Load and prepare the data for plotting
data = read.table( file       = data_filename
                 , header     = T
                 , sep        = ";"
                 , dec        = "."
                 , na.strings = "?"
                 , stringsAsFactors = F )

from_date = as.Date("2007/02/01")
to_date   = as.Date("2007/02/02")

data$Date = as.Date(data$Date, format = "%d/%m/%Y")
x = data[ data$Date == from_date | data$Date == to_date ,]


# Plot onto a png graphic device
png ( filename  = "plot1.png"
    , width     = 480
    , height    = 480
    , type      = "cairo")

hist( x    = x$Global_active_power
    , main = "Global Active Power"
    , xlab = "Global Active Power (kilowatts)"
    , ylab = "Frequency"
    , col  = "green" )

dev.off()
