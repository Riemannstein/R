# Clean all variables and functions
rm(list=ls())

# Load libraries
library(uroot)
library(tseries)

# Read dat1.txt and store it in dat1
dat1 <- read.table("dat1.txt")

# Plot the time series data and save it to files
png("./dat1_plot.png")
plot(dat1$V1, xlab="Period", ylab="dat1", main="Plot of time series in dat1.txt")
dev.off()

# Plot the acf and save it to files
png("./dat1_acf.png")
plot(acf(dat1$V1),main="Sample ACF for dat1")
dev.off()

# Plot the pacf and save it to files
png("./dat1_pacf.png")
plot(pacf(dat1$V1),main="Sample PACF for dat1")
dev.off()

# Use AIC to determine the lag
ar(dat1$V1, aic = TRUE, order.max =NULL)

# ADF test with lag=24
adf.test(dat1$V1,alternative = "stationary", k =24)