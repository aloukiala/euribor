## All the files are here
setwd("/home/antti/Desktop/Euribor")

## Files loaded from 
## http://www.emmi-benchmarks.eu/euribor-org/euribor-rates.html
## in xls format
## All xls files are saved in libreoffice to csv format

## Header names
hnames <- c("Date","X1.Week","X1.Month","X3.Month","X6.Month","X12.Month")
euribors <- data.frame(names=hnames)
rm(df)
df <- data.frame(Date=as.Date(character()),
                 Week=numeric(),
                 Month=numeric(),
                 Month3=numeric(),
                 Month6=numeric(),
                 Month12=numeric(),
                 stringsAsFactors=FALSE) 
for(i in 1999:2002) {
  filename <- paste("hist_EURIBOR_", i, ".csv", sep="")
  data <- read.csv(filename, header=T, sep=";", dec=",")
  data <- data[hnames]
  
  df <- rbind(df, data)
  print(filename)
}
for(i in 2003:2005) {
  filename <- paste("hist_EURIBOR_", i, ".csv", sep="")
  data <- read.csv(filename, header=T, sep=";", dec=",")
  data <- data[toupper(hnames)]
  names(data) <- hnames
  df <- rbind(df, data)
  print(filename)
}
## Read 2006 with different headers
data <- read.csv("hist_EURIBOR_2006.csv", header=T, sep=";", dec=",")
data <- data[c("Date","X1W","X1M","X3M","X6M", "X12M")]
names(data) <- hnames
df <- rbind(df, data)

## 2007 need to pivot
data07 <- read.csv("hist_EURIBOR_2007.csv", header=T, sep=";", dec=",")

## Headers
## data07[,1]
t <- cbind(t(data07[1,-1]), t(data07[4,-1]), t(data07[6,-1]), t(data07[9,-1]), t(data07[15,-1]))
Date <- row.names(t)
row.names(t) <- NULL
tdf <- as.data.frame(t)
tdf <- cbind(Date, tdf)
names(tdf) <- hnames
df <- rbind(df, tdf)

## TODO 09-14 files -> most likely same as 07

ind <- 1:nrow(df)
df <- (cbind(df,ind))