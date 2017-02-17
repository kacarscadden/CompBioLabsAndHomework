#Lab on Looping & Conditional Statements

#Set working directory
setwd("/Users/kellycarscadden/Documents/EBIOcourses/CompBioLabsAndHomework/Lab05")

##############################
#Part 1 - Simple Conditionals#
##############################

#Q1: Check if a value is larger than 5 and print a message
x <- 7 #Choose a starting value

#Use an if-else statement to check if x > 5
if(x > 5) {
  cat(paste("The value of x is > 5"))
} else {
  cat(paste("The value of x is < or = 5"))
}


#Q2:Data munging
myVec <- read.csv("Vector1.csv")
str(myVec)  #This reads in as a data frame. I want a vector instead
myVec <- unname(unlist(myVec))  #Also remove meaningless names (x1, x2, ...)
str(myVec)  #Is a numeric vector, now

#Check through data & replace negative values with NA using a for loop
for(i in 1:length(myVec)) {
  if(myVec[i] < 0){
    #replace negative numbers with NA
    myVec[i] <- NA
  }  #end if loop
}  #end for loop

#Check it worked by looking for negative values
min(myVec, na.rm=T)  #Is now a positive number


#Use 'which' to replace NAs with 0s
myVec[which(is.na(myVec))] <- 0

#Check it worked by looking at first several values
myVec[1:20]  #NAs are replaced by 0s


#Create a new vector including values from myVec that fall between 50 and 100
myVecSubset <- myVec[which(myVec >= 50 & myVec <= 100)]
range(myVecSubset)  #Check I don't see values outside what I expected


#Q3: Munging using 'which' and indexing
CO2 <- read.csv("CO2_data_cut_paste.csv")  #read in CO2 data from last week (now in Lab05 folder)
names(CO2)  #Output column names

#In which year were Gas emissions first non-zero?
nonZeroYrs <- which(CO2[,3] != 0)
CO2[nonZeroYrs[1],1]  #Output the Year value corresponding to the first non-zero gas value seen
#1885 was the first year in which Gas output was non-zero

#In which years were Total emissions between 200-300 million metric tons?
#See how Total is coded
summary(CO2[,3])  #min 0, max 1806. Presumably 200 would indicate 200 million.

#Store which elements of CO2$Total fit our criteria
yrsWithinRange <- which(CO2[,2] >= 200 & CO2[,2] <= 300) 
CO2[yrsWithinRange,1]  #Output the years that correspond to this range of Total emissions
#In the following years, Total CO2 emissions were between 200-300 million:
#1879 1880 1881 1882 1883 1884 1885 1886 1887



#######################################
#Part 2 - Loops & Conditions & Biology#
#######################################

#Lotka Volterra predator-prey Model
#Calculate abundances of predators and prey over time, using this model

#Set up parameters
totalGenerations <- 1000 #Will model abundance over 1000 generations
initPrey <- 100  #Initial prey abundance
initPred <- 10  #Initial predator abundance
a <- 0.01	 #Attack rate
r <- 0.2  #Growth rate of prey
m <- 0.05  #Mortality rate of predators
k <- 0.1 	#Conversion constant of prey into predators

#Create vectors to track time and store output
#Create a vector of generations
time <- 1:totalGenerations

#Space for prey abundance, starting with initial abundance
n <- c(initPrey, rep(NA, totalGenerations-1)) 

#Space for predator abundance, starting with initial abundance
p <- c(initPred, rep(NA, totalGenerations-1))


#Write a loop that calculates abundances over time
#Include checks for biological realism - since this is a discrete-time model,
#prey abundance may dip to negative numbers. Check this and make any negatives 0 instead.

for(t in 2:totalGenerations) {
  
  #calculate prey abundance via L-V model
  n[t] <- n[t-1] + (r * n[t-1]) - (a * n[t-1] * p[t-1])
  
  #check for any negative prey abundances and set those to 0
  if(n[t] < 0) {
    n[t] <- 0
  } #end of if statement
  
  #calculate predator abundance via L-V model
  p[t] <- p[t-1] + (k * a * n[t-1] * p[t-1]) - (m * p[t-1])
  
} #end of for loop


#Check output makes sense by plotting

#Plot the prey first
plot(time, n, xlab="Generation", ylab="Abundance", 
     main="Predator and Prey Abundance\n with the Lotka - Volterra Model",
     type="l", col="blue")

#Layer on the predators
lines(time, p, lty=2, col="red")

#Add a legend
legend("topright", c("Prey", "Predators"), pch=c(NA,NA), lty=c(1,2), col=c("blue", "red"))


