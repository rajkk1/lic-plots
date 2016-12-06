# Filename: licensPlots.R
# --------------------
# Plots licenses used in matlab and mathematica each month for the last
# 12 months
###############################################################################

#load required librarlies
require(lubridate)
require(ggplot2)
require(gridExtra)
require(zoo)

#Location of license stat files
path="[dataPath]"
matlabFile <- paste(path,"MatlabLicStat.txt", sep="")
mathFile <- paste(path,"MathematicaLicStat.txt", sep="")

# Function: createLicDF
# Usage: licDF <- CreateLicDF(filename)
# -------------------------------------
# Turns the license file txt file into a dataframe with headers and correct data 
# types
createLicDF <- function(filename) {
    licDF=read.csv(filename, header = FALSE, sep = ",")
    names(licDF)<-c("date","time","number")
    licDF$date <-as.Date(licDF$date,format = "%m/%d/%y")
    licDF$time <-strptime(licDF$time,format = "%H:%M:%S")  #convert time to POSIxct
    licDF$time <-strftime(licDF$time,format = "%H:%M:%S")  #retain just time
    return(licDF)
}

# Function: createMaxTable
# Usage: maxTable <- createMaxTable(licDF)
# ----------------------------------------
# Takes in a license file text and outputs a table with number of max license
# files used per month in the last 12 months
createMaxTable <- function(filename) {
    licDF <- createLicDF(filename) #convert file to dataframe
    maxTable <- aggregate(number~month(date)+year(date),data=licDF,max) #find maximum for every month
    maxTable$date <- paste(maxTable$"year(date)", maxTable$"month(date)",sep="-") #combine month + year into new variable
    maxTable$date <- as.yearmon(maxTable$date) #change to "date" variable to get them in correct order when plotting
    return(tail(maxTable,n=12)) #return the last 12 months
}

### Main sequence
## With boxplots

#Create data sets
matlabData <- createLicDF(matlabFile)
mathData <- createLicDF(mathFile)
#Keep only last 12 months of data
cutoffDate <- as.yearmon(Sys.Date()-365) #Year & month of 1 year ago
matlabData <- matlabData[as.yearmon(matlabData$date) >= cutoffDate,]
mathData <- mathData[as.yearmon(mathData$date) >= cutoffDate,]

#Create boxplots
matlabPlot <- ggplot(aes(x=factor(month.abb[month(date)],levels=month.abb),y=number),data=matlabData) +
  geom_boxplot() +
  theme(axis.title=element_text(size=18),axis.text=element_text(size=12))+
  labs(x="Month", y="Matlab Licenses used")
mathPlot <- ggplot(aes(x=factor(month.abb[month(date)],levels=month.abb),y=number),data=mathData) +
  geom_boxplot() +
  theme(axis.title=element_text(size=18),axis.text=element_text(size=12))+
  labs(x="Month", y="Mathematica Licenses used")
png("/[dataPath]/lic-usage-plot.png", height=600, width = 600) #Save to file
grid.arrange(matlabPlot, mathPlot, nrow=2) #arrange plots one on top of each other
dev.off() #close save file

#Old sequence with just line plots
#Create tables of max licenses used for Matlab and Mathematica licenses
#matlabMax <- createMaxTable(matlabFile)
#mathMax <- createMaxTable(mathFile)
# Create plots
#matlabPlot <- ggplot(data=matlabMax,aes(x=as.factor(date),y=number,group=1)) +
#    geom_point() +
#    geom_line() +
#    labs(x="Date (month/year)", y="Max Matlab Licenses used") + 
#    theme(axis.title=element_text(size=18),axis.text=element_text(size=12))  
#mathPlot <- ggplot(data=mathMax,aes(x=as.factor(date),y=number,group=1)) +
#    geom_point() +
#    geom_line() +
#    labs(x="Date (month/year)",y="Max Mathematica Licenses used") + 
#    theme(axis.title=element_text(size=18),axis.text=element_text(size=12))
#png("/home/lmguru/licenseStats/lic-usage-plot.png", height=600, width = 600) #Save to file
#grid.arrange(matlabPlot, mathPlot, nrow=2) #arrange plots one on top of each other
#dev.off() #close save file
