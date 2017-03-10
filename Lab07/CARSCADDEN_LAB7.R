#User-defined functions

#################################
##Problem 1: Fibonacci sequence##
#################################

###Write a function that returns a vector of Fibonacci numbers, length n, where n >= 3
#Arguments: length of output vector desired (n), starting value (0 or 1)

fibFunc <- function (n, start) { 
  
  #pre-allocate, allowing user-specified start, filling in 2nd value that will always be 1
  fib <- c(start, 1, rep(NA, n-2))

  for(i in 3:n){
    fib[i] <- fib[i-2] + fib[i-1] #each number is the sum of the two previous
  }#end of for loop
  
  return(fib) #output the vector of results
  
}# end of function

#Testing the function
fibFunc(10, 0)


###Bonus 1a - have this work for any length n (including n < 3)
fibFunc <- function (n, start) { 
  
  #pre-allocate space, enter user-defined starting value
  fib <- c(start, rep(NA, n-1))
  
  if (n > 1) {
    fib[2] <- 1 #enter 1, which is always the second value, if desired output >1 long
  }#end of if
  
  if (n > 2) {
    for(i in 3:n) {
      fib[i] <- fib[i-2] + fib[i-1] #each number is the sum of the two previous
    }#end of if
  }#end of for loop
  
  return(fib) #output the vector of results
  
}# end of function

#Testing the function
fibFunc(10, 0)
fibFunc(1, 0)
fibFunc(2, 1) #seems good

###Bonus 1b - check user input
#My additional check - check start is either 0 or 1

fibFunc <- function (n, start) { 
  
  #Print message if user enters a negative number
  if(n < 0 | start < 0) {
    cat("Warning - negative value given as an argument. Both n and start must be non-negative integers\n")
  }
  
  #Print message if user enters a non-integer
  if(identical(as.integer(n), n) | identical(as.integer(start), start) == "FALSE") {
     cat("Warning - non-integer given as an argument. Both n and start must be non-negative integers\n")
  }
  
  #Print message if user enters a starting value beyond 0 or 1
  if(start != 0 | start != 1) {
    cat("Warning - invalid starting value given. Fibonacci sequence should begin with 0 or 1\n")
  }
  
  #pre-allocate space, enter user-defined starting value
  fib <- c(start,rep(NA, n-1))
  
  if (n > 1) {
    fib[2] <- 1 #enter 1, which is always the second value, if desired output >1 long
  }#end of if
  
  if (n > 2) {
    for(i in 3:n) {
      fib[i] <- fib[i-2] + fib[i-1] #each number is the sum of the two previous
    }#end of if
  }#end of for loop
  
  return(fib) #output the vector of results
  
}# end of function


#Testing these warnings
fibFunc(2, -0.5)


####################################
##Problem 2: Logistic growth model##
####################################

###Write a function of the logistic growth model (with default arguments) that plots and returns the results

#key to parameters
# start = initial population size (aka, n[1])
# timeSteps = total number generations
# r = intrinsic population growth rt
# K = carrying capacity

#Create function with default values
logGrowthFunc <- function(start = 10, timeSteps = 100, r = 0.8, K = 1000) {
  
  n <- c(start, rep(NA, timeSteps-1)) #pre-allocate, and load in starting population size
  
  for(t in 2:timeSteps) {
    n[t] <- n[t-1] + (r * n[t-1] * (K - n[t-1]) / K) #Calculate logistic growth
  }#end for loop
  
  #create data frame with time and abund
  abundDat <- data.frame("Generation" = 1:timeSteps, "Abundance" = n)

  #plot the data
  plot(abundDat$Generation, abundDat$Abundance, type = "l", col = "blue",
       xlab = "Generation", ylab = "Population Abundance", main = "Logistic population growth")
  
  #output the data and exit the function
  return(abundDat) 
  
}#end function

#Checking the function
abundDat <- logGrowthFunc()
abundDat


##############################
##Problem 3: Social networks##
##############################

###Write a function that turns a square matrix into a pairwise table
setwd("/Users/kellycarscadden/Documents/EBIOcourses/CompBioLabsAndHomework/Lab07")
networkMatrix <- read.csv("LargeAdjacencyMatrix.csv")

#Target (pairwise table) has 3 columns: row (sp1), column (sp2), value (interaction)
#Target only includes non-zero interactions
#Note - interactions are symmetric in association table to start with
#Self-self interactions are noted with 0s (i.e., not counted)

pairwiseTableFunc <- function(mat) {
  
  #pre-allocate space
  #start by determining the number of interactions present (to get # rows of pairwise table)
  #because self-self interactions are not counted, can count total # 1s / 2 
  #(since 1-2 and 2-1 are presently in the matrix)
  totInteractions <- length(which(mat == 1)) / 2
  
  #now pre-allocate
  pairTable <- matrix(data = NA, nrow = totInteractions, ncol = 3)
  colnames(pairTable) <- c("Row", "Column", "Value")
  
  #create a counter
  k <- 0
  
  #because I do not want to include duplicates (i.e., I synonymize 1-2 and 2-1),
  #extract only elements below the diagonal in the association matrix
  mat[!lower.tri(mat)] <- 0 #replace all but the lower triangular matrix with 0
  
  #use nested for-loops to extract row & column indices (IDs of the interacting species)
  #for each row
  for(i in 1:nrow(mat)) {
    
    #search across each column for 1s
    for(j in 1:ncol(mat)) {
      if(mat[i,j] == 1) {
        #count that we found an interaction to record
        k <- k+1
        
        #use the counter to track which row of our target pairwise table takes the data
        #enter the row and column numbers of the original association matrix, and '1' for an association
        pairTable[k, ] <- c(i, j, 1) 
        
        }#end of if statement
    }#end of column loop
  }#end of row loop
  
  return(pairTable) #output the data and exit the function
  
}#end of function

#Test the function
pairTableCheck <- pairwiseTableFunc(networkMatrix)
pairTableCheck


###Bonus - write a function that turns a pairwise table into a square matrix

assocMatrixFunc <- function(pairwiseTable) {
  
  #pre-allocate space
  #start by determining the size of the square matrix, 
  #where nrow and ncol both = total number species present
  totSp <- max(pairwiseTable[,1])
  assocMatrix <- matrix(data = 0, nrow = totSp, ncol = totSp)
  rownames(assocMatrix) <- 1:totSp
  colnames(assocMatrix) <- c(paste("V",1:totSp, sep="")) #make col labels consistent with original networkMatrix
  
  #for each row of the pairwise table
  for(i in 1:nrow(pairwiseTable)) {
    #record an interaction
    assocMatrix[pairwiseTable[i, 1], pairwiseTable[i, 2]] <- 1
    
    #record the duplicate interaction (i.e., switch row & column)
    assocMatrix[pairwiseTable[i, 2], pairwiseTable[i, 1]] <- 1
    
  }#end of row loop
  
  return(assocMatrix) #return data and exit the function
  
}#end of function

#Checking the function
assocMatrixCheck <- assocMatrixFunc(pairTableCheck)
assocMatrixCheck

#Compare to the original association matrix
identical(dim(networkMatrix), dim(assocMatrixCheck)) #TRUE - same sizes

#spot check
#'identical' command doesn't work comparing data.frame of integers (networkMatrix) and matrix of numeric values (assocMatrixCheck)
all(c(networkMatrix[5,] == assocMatrixCheck[5,]) == TRUE) #do all values of this haphazardly chosen row match between matrices?
all(c(networkMatrix[,80] == assocMatrixCheck[,80]) == TRUE) #haphazardly checking a column
#seems good
