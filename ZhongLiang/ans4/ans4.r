# Code for Problem 4

# Clean data and variables
rm(list=ls())

# Read data into file
sh_index <- read.csv("sh_index.CSV")
# Store the closing price data
closing_price <- sh_index$closing_price

# Print the first 10 data frame
head(sh_index, n=10)

# Plot the closing price
plot(sh_index$closing_price, xlab = "Period", ylab = "Closing price")

# Compute the number of sub-intervals
M <- floor(log(length(closing_price), 2))



# Set the number of observations we examine by taking the largest interger which is an exponent of 2 
# and smaller than the number of observation
N <- 2**M # Total number of observation that will be used

# Set the whole series to be the latest N observations
closing_price <- head(closing_price, N)

# Initialize a vector of length M to store the log(R/S) for each time scale
logRS <- numeric(M-1)


# Create the vector that stores the number of subintervals for each partition
intervals <- c(1:M)
intervals <- 2**intervals

# Loop over each partition
for (i in 1:(M-1)){
  # Create a matrix that store the data for each sub-interval
  nr <- intervals[i] # nr equals the number of sub-intervals for each partition
  closing <- matrix(nrow = nr, ncol = N/nr) 
  for (k in 0:(nr-1)){
    closing[k+1,] <- closing_price[(k*(N/(2**i))+1):((k+1)*(N/nr))]
  }
  
  # Calculate the mean of the closing price for partition i 
  m <- rowMeans(closing)
  head(m)
  
  # Calculate mean adjusted series Y
  Y <- matrix(nrow = nr, ncol = N/nr)
  for(k in 1:nr){
    Y[k,] <- closing[k,] - m[[k]]
  } 
  
  # Calculate cumulative deviate series Z
  Z <- matrix(nrow = nr, ncol = N/nr)
  for(k in 1:nr){
    Z[k,] <- cumsum(Y[k,])
  }
  
  # Calculate range series R
  r <- numeric(nr)
  for (k in 1:nr){
    r[k] = max(Z[k,]) - min(Z[k,])
  }
  
  
  # # Calculate range series R : Algorithm 2
  # R <- matrix(nrow = nr, ncol = N/nr)
  # for (k in 1:nr){
  #   for (l in 1:N/nr){
  #     R[k,l] = max(Z[k,1:l]) - min(Z[k,1:l])
  #   }
  # }
  
  # Calculate standard deviation series S
  s <- numeric(nr)
  for (k in 1:nr){
    s[k] <- sd(closing[k,])
  }
  
  # Compute the log(R/s) for each interval and take the average
  logRS[i] <- log(mean(m/s),2)
  
}

# Plot log(R/S)
png("./logRS.png")
plot(logRS, xlab = "Partition log(n)", ylab = "log(R(n)/S(n))")
dev.off()

# OLS estimate and significance test 
fit <- lm( logRS ~c(1:(M-1)) )
summary(fit)

# Compute z value for null hypothesis "H = 0.5" and compute p value
zvalue <- (fit$coefficients[2]-0.5)/coef(summary(fit))[2,"Std. Error"]
pvalue = 2*(1-pnorm(zvalue))


