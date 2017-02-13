#Lab04 - for loops
#Kelly Carscadden, Feb  10, 2017

################################
##Part 1 - printing from loops##
################################

#Q1: print 'hi' to console 10 times
for (i in 1:10) {
  print("hi")
}


#Q2: track Tim's remaining funds over time (8 wks)
start <- 10 #Tim starts with $10
allowance <- 5  #weekly allowance of $5
packs <- 2 #Tim buys 2 packs of gum a week
cost <- 1.34 #cost per gum pack
nWeeks <- 8 #number of weeks for which we're tracking Tim's finances

#My approach: consider income & expenses & establish a new 'start' $ amount for the next week
for(i in 1:nWeeks) {
  start <- start + allowance - (packs * cost) 
  print(start)
  #print(paste(i,start, sep=". ")) #if you wanted output numbered 1:8, but wrapped in quotes
}


#Q3: Population shrinkage across 7 years
start <- 2000 #population begins with 2000 individuals
growth <- 0.95 #population expected to shrink by 5% each year
nYears <- 7 #tracking the population growth across 7 years

for(i in 1:nYears) {
  start <- start * growth
  print(start)
}


#Q4: Discrete-time logistic growth equation
#Find value of n[12], and print abundance at each step
N <- 2500 #initial population size
K <- 10000 #carrying capacity
r <- 0.8 #intrinsic population growth rate
timeStep <- 12 #total time steps, including present

for(i in 1:timeStep) {  #starting with print, so will also print timeStep 1 population (starting value)
  print(N)
  N <- N + (r * N * (K - N) / K)
}

#The population size in time step 12 is 9999.985




################################
##Part 2 - storing from loops###
################################

#Q1: Array indexing
len <- 18 #length of desired array
myVector <- rep(0, len)
myVector

for(i in seq(1,len)) {
  #store 3x the ith value, in the ith position in the vector
  myVector[i] <- 3 * i
}

myVector #output looks as expected

#make a new vector, and then make the first entry = 1
myVector2 <- rep(0, len)
myVector2[1] <- 1
myVector2

#starting with the second entry, make that entry = 1 + (2 * previous entry)
for(i in 2:len) {
  myVector2[i] <- 1 + (2 * myVector2[i-1])
}

myVector2 #output looks as expected


#Q2: Fibonacci sequence (each number is the sum of the two previous ones, starting with 1,1 or 0,1)
#create a loop that makes a vector of the 1st 20 Fibonacci numbers

len <- 20 #looking for 20 Fibonacci numbers
fibNumbers <- rep(NA, len) #create a vector to store the output
fibNumbers[1:2] <- c(0,1) #seed the vector with 2 starting values

for(i in 3:len) {
  fibNumbers[i] <- fibNumbers[i-2] + fibNumbers[i-1]
}

fibNumbers #output is as expected - matches beginning of sequence given in assignment Wikipedia blurb


#Q3: Redo Q4 from Part 1, but store the output
steps <- 12
time <- rep(NA, steps) #stores time steps 1:12
time[1] <- 1 #specify first time step as time = 1

abundance <- rep(NA, steps) #stores abundance predicted from discrete-time logistic equation
abundance[1] <- 2500 #fill in 1st time step with starting population size

K <- 10000 #carrying capacity
r <- 0.8 #intrinsic population growth rate  
  
  
for(i in 2:steps) {
  time[i] <- i  #counts the time steps
  abundance[i] <- abundance[i-1] + (r * abundance[i-1] * (K - abundance[i-1]) / K)
}

#check the output
time
abundance

#plot the results
plot(time, abundance, xlab="Time step", ylab="Abundance", main="Discrete-time logistic growth")


#Q4: Using data from the CO2 Information Analysis Centre
setwd("/Users/kellycarscadden/Documents/EBIOcourses/CompBioLabsAndHomework/Lab04")
dat <- read.csv("CO2_data_cut_paste.csv")
head(dat)
str(dat)

#for each variable other than year, calculate percent change from year i-1 to i across all years
#use nested for-loops and retain the original column names

CO2percentChange <- matrix(nrow = nrow(dat) - 1, ncol = ncol(dat), data = NA)
colnames(CO2percentChange) <- colnames(dat) #keep the same column names as original data
colnames(CO2percentChange)
CO2percentChange <- as.data.frame(CO2percentChange) #make this into a data frame

#fill in the Year column with the original data, minus the 1st yr
#percent change listed for a given year (j) will be from year (j-1) to (j)
CO2percentChange$Year <- dat$Year[-1] 

str(CO2percentChange) #looks as expected

#for each variable (column), after 'Year'
for(i in 2:ncol(dat)) {
  
  #pull out just that column
  tmp <- dat[,i]
  
  #calculate percent change across years, from j-1 to j
  #each row is a year, in the original data
  for (j in 2:length(tmp)) {
    CO2percentChange[j-1,i] <- ((tmp[j] - tmp[j-1]) / tmp[j-1]) * 100
  } #end of years loop
  
} #end of variables loop

write.csv(CO2percentChange, "YearlyPercentChangesInCO2.csv")  


#BONUS: For each year, calculate percent change from 1st year with non-zero data, write output
#won't be larger than previous output, so using those output dimensions
CO2percentChange2 <- matrix(nrow = nrow(dat) - 1, ncol = ncol(dat), data = NA)
colnames(CO2percentChange2) <- colnames(dat) #keep the same column names as original data
CO2percentChange2 <- as.data.frame(CO2percentChange2) #make this into a data frame

#fill in the Year column with the original data, minus the 1st yr
CO2percentChange2$Year <- dat$Year[-1] 


#For each variable (column), after 'Year'
for(i in 2:ncol(dat)) {
  
  #pull out just that column
  tmp <- dat[,i]
  
  #determine the first year with non-zero data, for this column
  #this will be the reference point from which percent change for each year is determined
  reference <- tmp[tmp>0][1]
  
  #calculate percent change from year j to reference year
  #each row is a year, in the original data
  
  #begin loop in year AFTER the 1st non-zero (reference) year
  startYear <- which(tmp>0)[2]
  
  for (j in startYear:length(tmp)) {
    CO2percentChange2[j-1,i] <- ((tmp[j] - reference) / reference) * 100
  } #end of years loop
  
} #end of variables loop

write.csv(CO2percentChange2, "YearlyPercentChangesInCO2_Bonus.csv")    
