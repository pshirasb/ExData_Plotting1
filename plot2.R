#-----------------------------------------------------------------
# Plot Number 2
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
png ( filename  = "plot2.png"
    , width     = 480
    , height    = 480
    , type      = "cairo")

plot( x    = x$Global_active_power
    , type = "l"
    , xlab = ""
    , ylab = "Global Active Power (kilowatts)"
    , col  = "blue"
    , axes = FALSE )

day_ticks = c( min(which(x$Date == from_date))
             , min(which(x$Date == to_date  ))
             , max(which(x$Date == to_date  )) + 1)

day_labels = weekdays( c(from_date, to_date, to_date + 1)
                     , abbreviate = TRUE )

axis( side   = 1
    , at     = day_ticks
    , labels = day_labels )
                
axis( side   = 2
    , labels = TRUE )

box()

dev.off()
