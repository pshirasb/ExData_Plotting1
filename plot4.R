#-----------------------------------------------------------------
# Plot Number 4
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


# Setup the plot device
png ( filename  = "plot4.png"
    , width     = 480
    , height    = 480
    , type      = "cairo")

par(mfrow = c(2,2))
day_ticks = c( min(which(x$Date == from_date))
             , min(which(x$Date == to_date  ))
             , max(which(x$Date == to_date  )) + 1)

day_labels = weekdays( c(from_date, to_date, to_date + 1)
                     , abbreviate = TRUE )


# Plot Global Active Power
plot( x    = x$Global_active_power
    , type = "l"
    , xlab = ""
    , ylab = "Global Active Power"
    , col  = "black"
    , xaxt = "n" )

axis( side   = 1
    , at     = day_ticks
    , labels = day_labels )

# Plot Voltage
plot( x    = x$Voltage
    , type = "l"
    , xlab = "datetime"
    , ylab = "Voltage"
    , col  = "black"
    , xaxt = "n" )

axis( side   = 1
    , at     = day_ticks
    , labels = day_labels )



# Plot Energy Sub Metering
plot( x    = x$Sub_metering_1
    , type = "l"
    , xlab = ""
    , ylab = "Energy Sub Metering"
    , col  = "purple"
    , xaxt = "n" )

lines( x    = x$Sub_metering_2
     , type = "l"
     , col  = "red")

lines( x    = x$Sub_metering_3
     , type = "l"
     , col  = "blue")

legend( x      = "topright"
      , lty    = "solid"
      , bty    = "n"
      , legend = c( "Sub_metering_1"
                  , "Sub_metering_2"
                  , "Sub_metering_3" )
      , col    = c( "purple"
                  , "red"
                  , "blue" ))

axis( side   = 1
    , at     = day_ticks
    , labels = day_labels )
               
# Plot Global Reactive Power
plot( x    = x$Global_reactive_power
    , type = "l"
    , xlab = "datetime"
    , ylab = "Global Reactive Power"
    , col  = "black"
    , xaxt = "n" )

axis( side   = 1
    , at     = day_ticks
    , labels = day_labels )

dev.off()
