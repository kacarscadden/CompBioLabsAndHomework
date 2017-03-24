#Lab09: Novel Problem Solving

#set working directory
setwd("/Users/kellycarscadden/Documents/EBIOcourses/CompBioLabsAndHomework/Lab09")

#read in camera trap data (Cusack et al. 2013)
trapData <- read.csv("Cusack_et_al_random_versus_trail_camera_trap_data_Ruaha_2013_14.csv")
head(trapData)

##################################################################################
##Parse the DateTime column so we can calculate differences among time intervals##
##################################################################################

#Convert the data into a time format

#Notes to self about 2 time formats: 
#1. POSIXct recommended (= seconds after UNIX epoch). 
#2. POSIXlt is created by strptime and is handy because it's a list of day/month/etc... and therefore data elements are more readily extractable

#references for comments on time formats: 
#http://www.noamross.net/blog/2014/2/10/using-times-and-dates-in-r---presentation-code.html
#http://stackoverflow.com/questions/10699511/difference-between-as-posixct-as-posixlt-and-strptime-for-converting-character-v

trapData$datePos <- lapply(trapData$DateTime, 
                           function(x){
                             as.POSIXct(strptime(x, format="%d/%m/%Y %H:%M"))
                             })
#strptime gives a POSIXlt format, which I convert into POSIXct format
#from ?strptime:
#%d   Day of the month as decimal number (01–31).
#%m   Month as decimal number (01–12).
#%Y   Year with century
#%H   Hours as decimal number (00–23)
#%M   Minute as decimal number (00–59).

#check a few elements, to see if the output is logical
trapData$datePos[c(1, 200, 500, 1000, 5000, length(trapData$datePos))]

#Is not recording '2013' correctly in times interpreted as LMT instead of MDT, like others
#Inspecting original data reveals years not all entered consistently (e.g., 13 vs. 2013, month or day 1 vs. 01)
trapData$DateTime[c(1, 200, 500, 1000, 5000, length(trapData$datePos))]

#Testing whether it matters that days, months, hours are 2-digit or not (using 9 as an example)

identical(as.POSIXct(strptime(09, format="%d")), as.POSIXct(strptime(9, format="%d"))) 
identical(as.POSIXct(strptime(09, format="%m")), as.POSIXct(strptime(9, format="%m")))
identical(as.POSIXct(strptime(09, format="%H")), as.POSIXct(strptime(9, format="%H")))
#Yes - either of these forms are identical.

#The year is definitely an issue (%Y expects 2013, 2014, not 13 or 14)
#Parsing strings to make dates consistent. 4-digit years are more interpretable, so choosing that format

#Year separated from day & month by '\' and from time by ' ', so need to use multiple delimiters
#trial run:
i <- 1
strsplit(as.character(trapData$DateTime[i]), "\\/| ")
#yes - this separates each date, time element

#this isolates year (the 3rd element in the date-time string)
sapply(strsplit(as.character(trapData$DateTime[i]), "\\/| "), '[',3)

#putting this together in a way that checks for 2-digit years & fills in the century

#Make date no longer a factor w/ many levels (in a new column)
trapData$DateFixed <- as.character(trapData$DateTime)

for(i in 1:length(trapData$DateFixed)) {
  timeTmp <- trapData$DateFixed[i]
  #extract year
  rawYr <- sapply(strsplit(timeTmp, "\\/| "), '[',3) 
  
  #determine if it lacks century (do nothing if it contains century, paste in '20' if lacking)
  if(rawYr == "2013" | rawYr == "2014") 
    { NA
  } else {
    rawYr <- as.numeric(paste(20, rawYr, sep=""))

    #re-assemble a fixed date-time string
    day <- as.numeric(sapply(strsplit(timeTmp, "\\/| "), '[',1))
    mo <- as.numeric(sapply(strsplit(timeTmp, "\\/| "), '[',2))
    dateString <- paste(day, mo, rawYr, sep="/")
    timeString <- sapply(strsplit(timeTmp, "\\/| "), '[',4)
    
    trapData$DateFixed[i] <- paste(dateString, timeString, sep=" ")
    }#end of else 
}#end of for loop        
         

###re-converting to POSTIXct format, now that year is fixed
trapData$datePos <- lapply(trapData$DateFixed, 
                           function(x){
                             as.POSIXct(strptime(x, format="%d/%m/%Y %H:%M"))
                           })
#re-checking format
trapData$datePos[c(1, 200, 500, 1000, 5000, length(trapData$datePos))]
#year looks good. There are still different timezones, but using 'tz = EAT' within strptime does not allow me to select East Africa Time


############################
##Calculate time intervals##
############################
#ref: https://stat.ethz.ch/R-manual/R-devel/library/base/html/difftime.html

#Try out an example: date 2 minus date 1
#datePos is a *list* of POSIXct values, so need double bracket indexing
difftime(trapData$datePos[[2]], trapData$datePos[[1]], units = "days")

###################################################
##Create a function to calculate time differences##
###################################################
calcTimeDiff <- function(time1, time2) {
  return(difftime(time2, time1, units = "days"))
}

#Test drive the function
calcTimeDiff(trapData$datePos[[1]], trapData$datePos[[2]])
#yes, this agrees with my above example output


##################################################################
##Create a function to calculate time differences, within groups##
##################################################################

#Prompt from assignment: 
#For a given Placement, Season, and Station, the function should return a vector of time intervals betweeen consecutive camera trappings.  
#Hint: You may be able to make life slightly easier on yourself by having this function repeatedly call the function you wrote for the previous problem.

#Arguments:
#1. the full data set, 
#2. Placement, 
#3. Season, 
#4. Station

timeDiffByGroup <- function(data, Placement, Season, Station) {
  #Subset the data according to the specified placement, season, station
  #can't work in the usual way, since datePos is a list (and can't be specified as a column, here)
  placemSub <- which(data$Placement == Placement)
  seasonSub <- which(data$Season == Season)
  stationSub <- which(data$Station == Station)
  
  #find rows that satisfy the multiple criteria
  temp <- intersect(placemSub, seasonSub)
  rowsNeeded <- intersect(temp, stationSub)
  
  #create space - should return a vector of differences, for the specified groupings
  timeDiffsDays <- rep(NA, length(rowsNeeded)-1)
  
  #use the indices created above to extract time elements from the list of POSIXct dates
  for(i in 1:(length(rowsNeeded)-1)) {
    
  timeDiffsDays[i] <- calcTimeDiff(data$datePos[[rowsNeeded[i]]], data$datePos[[rowsNeeded[i+1]]])[[1]] #[[1]] extracts the numbers from the text result
  }#end for loop
  
  return(timeDiffsDays)
}#end function

#Test drive the function
timeDiffByGroup(data = trapData, Placement = "Random", Season = "D", Station = 1)
