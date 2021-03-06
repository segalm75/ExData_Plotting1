## plot 2

# read data

filename <- "data/household_power_consumption.txt"

# only need data from: 2007-02-01 and 2007-02-02.

## subsetting

powerdat  <- read.table(filename, sep = ";", na.strings="?", skip=grep("1/2/2007", readLines(filename)),nrows=2879,
                        col.names = colnames(read.table(filename, sep=";",nrow = 1, header = TRUE)))
# convert Date column to R data class

# convert date and time columns to R time classes

power.dates<-as.character(powerdat$Date)
power.times<-as.character(powerdat$Time)
power.x    <- paste(power.dates, power.times)
power.z    <- strptime(power.x, "%d/%m/%Y %H:%M:%S")

# add date/time column to data frame
powerdat   <- cbind(powerdat,DateTime=power.z) 

# convert time to day of week

powerdat$dayOfweek <- weekdays(as.Date(powerdat$DateTime),abbreviate = TRUE)

# plot global active power vs. dayOfWeek

plot(powerdat$DateTime,powerdat$Global_active_power,xaxt="n", xlab = "",
     ylab="Global Active Power (kilowatts)",type = "l") #don't plot the x axis

#figure out the lowest and highest months
daterange=c(as.POSIXlt(min(powerdat$DateTime)),as.POSIXlt(max(powerdat$DateTime))) 
axis.POSIXct(1, at=seq(daterange[1], daterange[2], by="days"), 
             format="%a") #label the x axis by Days of week

# copy active window to png file
dev.copy(png,file = "plot2.png",width=480, height=480, units="px")
dev.off()