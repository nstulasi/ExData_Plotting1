#Reset the number of cols for displaying the plot
par(mfcol=c(1,1))
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


#******Line plot using the base plotting system*****

## Initialize the loop variables
color<-c("black","red","blue")
plottedColumns<-c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
j<-1
## Create an empty plot i.e. type= "n" onto which the lines will be plotted
with(consumption,plot(Datetime,Sub_metering_1,ylab="Energy sub metering",type="n",family="sans",ps=12))

## Iterate through the 3 metrics to draw the lines
for(i in plottedColumns)
  {
  lines(consumption[,"Datetime"],consumption[,i],col=color[j])
  j<-j+1
  }
## Add legend
legend("topright",col=color,legend=plottedColumns,lty=1,y.intersp=0.7,cex=0.8,text.width = max(sapply(text, strwidth)))
#Copy the plot to png file
dev.copy(png, file="plot3.png", width=480, height=480)
## Turn off the device
dev.off()