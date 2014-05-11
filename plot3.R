#Set the working directory
setwd("C:/Users/saneppal/Source/Repos/ExData_Plotting1")
#Download the file to current directory
file<-"./household_power_consumption.zip"
if(!file.exists(file))
{
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="household_power_consumption.zip")
}
#Read the file
unzip("./household_power_consumption.zip")
data<-read.table("./household_power_consumption.txt",header=TRUE,stringsAsFactors=FALSE, sep=";")

#Subset the file to only 01/02/2007 and 02/02/2007
data_sub<-data[(data$Date=="1/2/2007"|data$Date=="2/2/2007"),]

#Create a datetime column combining the 'Date' and 'Time' columns
consumption<-cbind(data_sub,Datetime=strptime(paste(data_sub$Date,data_sub$Time), "%d/%m/%Y %H:%M:%S"))


#Create a histogram using the base plotting system
## Create and annotate the plot to screen device
color<-c("black","red","blue")
plottedColumns<-c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
j<-1
with(consumption,plot(Datetime,Sub_metering_1,type="n"))
for(i in plottedColumns)
  {
  lines(consumption[,"Datetime"],consumption[,i],col=color[j])
  j<-j+1
  }
par(font=2)
legend("topright",col=color,legend=plottedColumns,pch='--')
##Copy the plot to png file
dev.copy(png, file="plot3.png", width=480, height=480)
## Turn off the device
dev.off()