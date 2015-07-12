## read file

filename <- "data/household_power_consumption.txt"

# only need data from: 2007-02-01 and 2007-02-02.

## subsetting

powerdat  <- read.table(filename, sep = ";", na.strings="?", skip=grep("1/2/2007", readLines(filename)),nrows=2879,
                        col.names = colnames(read.table(filename, sep=";",nrow = 1, header = TRUE)))


## plot 1

hist(powerdat$Global_active_power,
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency",
     main="Global Active Power", col = "red")

# copy active window to png file
dev.copy(png,file = "plot1.png",width=480, height=480, units="px")
dev.off()
