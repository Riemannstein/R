# Clean all variables and functions
rm(list=ls())

# Load libraries
library(uroot)
library(tseries)

# Read dat1.txt and store it in dat1
dat2 <- read.table("dat2.txt")

# Plot the time series data and save it to files
png("./dat2_plot_V1.png")
plot(dat2$V1, xlab="Period", ylab="dat2 V1", main="Plot of time series of the 1st column in dat2.txt")
dev.off()

# Plot the time series data and save it to files
png("./dat2_plot_V2.png")
plot(dat2$V2, xlab="Period", ylab="dat2 V2", main="Plot of time series of the 2nd column in dat2.txt")
dev.off()

# Plot the time series data and save it to files
png("./dat2_plot_V3.png")
plot(dat2$V3, xlab="Period", ylab="dat3", main="Plot of time series of the 3rd column in dat2.txt")
dev.off()

# # Plot the acf and save it to files
# png("./dat1_acf.png")
# plot(acf(dat1$V1),main="Sample ACF for dat1")
# dev.off()
# 
# # Plot the pacf and save it to files
# png("./dat1_pacf.png")
# plot(pacf(dat1$V1),main="Sample PACF for dat1")
# dev.off()
# 
# # Use AIC to determine the lag
# ar(dat1$V1, aic = TRUE, order.max =NULL)
# 
# # ADF test with lag=24
# adf.test(dat1$V1,alternative = "stationary", k =24)