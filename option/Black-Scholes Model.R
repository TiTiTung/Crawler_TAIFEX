BlackScholes <- function(S, K, r, T, sig, type){
  
  if(type=="C"){
    d1 <- (log(S/K) + (r + sig^2/2)*T) / (sig*sqrt(T))
    d2 <- d1 - sig*sqrt(T)
    
    value <- S*pnorm(d1) - K*exp(-r*T)*pnorm(d2)
    return(value)}
  
  if(type=="P"){
    d1 <- (log(S/K) + (r + sig^2/2)*T) / (sig*sqrt(T))
    d2 <- d1 - sig*sqrt(T)
    
    value <-  (K*exp(-r*T)*pnorm(-d2) - S*pnorm(-d1))
    return(value)}
}


call <- BlackScholes(110,100,0.04,1,0.2,"C")
put <- BlackScholes(110,100,0.04,1,0.2,"P")


# Get the Close column(4) from the WIKI dataset from Quandl of the APPL stock 
library(Quandl)
library(tidyverse)
data <- Quandl("WIKI/AAPL.4")

# Retrieve the first 50 values

recent_data <- data[1:50,]

# Use the arrange function from dplyr package to get old values at top. This would guarantee that the calculations are performed with the oldest values of the series at first.

recent_data <- arrange(recent_data, -row_number())

# Add a new column with the returns of prices. Input NA to the first value of the column in order to fit the column in the recent_data data frame.

recent_data$returns <- c('NA',round(diff(log(recent_data$Close)),3))
recent_data= recent_data[-1,]
# Convert the column to numeric

recent_data$returns <- as.numeric(recent_data$returns)

# Calculate the standard deviation of the log returns

standard_deviation <- sd(recent_data$returns,na.rm=TRUE)


annual_sigma <- standard_deviation * sqrt(250)






S = 110
K = 100
r = 0.04
Time = 180/252
sigma = 0.2

# The variable CallValueperSigma would store all the option prices that are 
# calculated with the different values of sigma along the sigma vector. 


CallValueperSigma <- BlackScholes(S,K,r,Time,sigma,"C") 


# The variable CallValueperSigma would store all the option prices that are 
# calculated with the different values of sigma along the sigma vector. 

CallValueperSigma <- BlackScholes(S,K,r,Time,sigma) 








## Black-Scholes Function
BS <-
  function(S, K, T, r, sig, type="C"){
    d1 <- (log(S/K) + (r + sig^2/2)*T) / (sig*sqrt(T))
    d2 <- d1 - sig*sqrt(T)
    if(type=="C"){
      value <- S*pnorm(d1) - K*exp(-r*T)*pnorm(d2)
    }
    if(type=="P"){
      value <- K*exp(-r*T)*pnorm(-d2) - S*pnorm(-d1)
    }
    return(value)
  }


## Function to find BS Implied Vol using Bisection Method
implied.vol <-
  function(S, K, T, r, market, type){
    sig <- 0.20
    sig.up <- 1
    sig.down <- 0.001
    count <- 0
    err <- BS(S, K, T, r, sig, type) - market 
    
    ## repeat until error is sufficiently small or counter hits 1000
    while(abs(err) > 0.00001 && count<10000){
      if(err < 0){
        sig.down <- sig
        sig <- (sig.up + sig)/2
      }else{
        sig.up <- sig
        sig <- (sig.down + sig)/2
      }
      err <- BS(S, K, T, r, sig, type) - market
      count <- count + 1
    }
    
    ## return NA if counter hit 1000
    if(count==1000){
      return(NA)
    }else{
      return(sig)
    }
  }



{
  S = 12784
  K = 12850
  r = 0.01
  T = 2/260
  sigma = 1
  market = 37}

implied.vol(S, K, T, r, market,"C")

(110,100,0.04,1,0.2,"C")
