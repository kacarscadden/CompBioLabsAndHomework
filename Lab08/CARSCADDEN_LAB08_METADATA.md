###Metadata for Lab 08

####Basic Information
Author: Kelly Carscadden
Date: Mar 17, 2017
Source file for lab: [on Sam Flaxman's Github](https://github.com/flaxmans/CompBio_on_git/tree/master/Labs/Lab08)
Attribution for mySafeWriteCSV function: Samuel Flaxman
Overview: The script specifies a function that runs a discrete-time logistic growth model on some default parameter values (described below). The script outputs a data frame of population abundance across generations, creates a plot, and writes the data frame to a .csv file, while ensuring the .csv file does not overwrite any existing files. It includes a meta-script to make a source-able file of parameter values used in the model.

####Model
>n[t] = n[t-1] + ( r * n[t-1] * (K - n[t-1]) / K )

####Parameters
1. Definitions
Four parameters are specified for this model:
 * start = initial population size, aka, n[1]  
 * timeSteps = total number of generations  
 * r = intrinsic population growth rate, aka per capita rate of growth
* K = carrying capacity

2. Default values
Default values are hard-coded as part of the function and are also recorded in the supplementary Parameters.R file.
 * start = 10 individuals 
 * timeSteps = 100 generations  
 * r = 0.8  
* K = 1000 individuals

####Outputs

 1. Data frame with two columns (generations, abundance) and timeSteps rows (by default, 100)
 * This is written to a .csv file
 2. Plot of abundance over generations, showing the logistic growth curve. An example, created using default parameters:
 ![Sample plot produced](https://github.com/kacarscadden/CompBioLabsAndHomework/blob/master/Lab08/logisticGrowth.png?raw=true)
 

