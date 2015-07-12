## plot 4

# read data
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


# create 4 subplot figure

par(mfcol=c(2,2),mar = c(4,4,1,1), oma = c(0,0,1,0))

# subplot (1,1)

# plot global active power vs. dayOfWeek

plot(powerdat$DateTime,powerdat$Global_active_power,xaxt="n", xlab = "",
     ylab="Global Active Power (kilowatts)",type = "l") #don't plot the x axis

#figure out the lowest and highest months
daterange=c(as.POSIXlt(min(powerdat$DateTime)),as.POSIXlt(max(powerdat$DateTime))) 
axis.POSIXct(1, at=seq(daterange[1], daterange[2], by="days"), 
             format="%a") #label the x axis by Days of week

# subplot(2,1)

plot(powerdat$DateTime,powerdat$Sub_metering_1,xaxt="n", xlab = "",
     ylab="Energy sub metering",type="n") #don't plot the x axis
with(powerdat,lines(DateTime,Sub_metering_1,xaxt="n", xlab = "",
                    ylab="",type = "l", col = "black"))
with(powerdat,lines(DateTime,Sub_metering_2,xaxt="n", xlab = "",
                    ylab="",type = "l", col = "red"))
with(powerdat,lines(DateTime,Sub_metering_3,xaxt="n", xlab = "",
                    ylab="",type = "l", col = "blue"))
legend("topright", lwd = 1, col = c("black","red","blue"), legend = colnames(powerdat)[7:9])

#figure out the lowest and highest months
daterange=c(as.POSIXlt(min(powerdat$DateTime)),as.POSIXlt(max(powerdat$DateTime))) 
axis.POSIXct(1, at=seq(daterange[1], daterange[2], by="days"), 
             format="%a") #label the x axis by Days of week

# subplot(1,2)

# plot voltage vs. dayOfWeek

plot(powerdat$DateTime,powerdat$Voltage,xaxt="n", xlab = "datetime",
     ylab="Voltage",type = "l") #don't plot the x axis

#figure out the lowest and highest months
daterange=c(as.POSIXlt(min(powerdat$DateTime)),as.POSIXlt(max(powerdat$DateTime))) 
axis.POSIXct(1, at=seq(daterange[1], daterange[2], by="days"), 
             format="%a") #label the x axis by Days of week

# subplot(2,2)

# plot Globar reactive power vs. dayOfWeek

plot(powerdat$DateTime,powerdat$Global_reactive_power,xaxt="n", xlab = "datetime",
     ylab = "Global_reactive_power",type = "l") #don't plot the x axis

#figure out the lowest and highest months
daterange=c(as.POSIXlt(min(powerdat$DateTime)),as.POSIXlt(max(powerdat$DateTime))) 
axis.POSIXct(1, at=seq(daterange[1], daterange[2], by="days"), 
             format="%a") #label the x axis by Days of week

# copy active window to png file
dev.copy(png,file = "plot4.png",width=480, height=480, units="px")
dev.off()
