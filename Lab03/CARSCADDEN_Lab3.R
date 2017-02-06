#Carscadden Lab 3 (R intro) work for Computational Biology

#########################
#Part 1. Basic operations
#########################

##Tracking chip supplies at a movie-watching party

#lab step #3: Save initial inventory (# bags chips) and number of guests (not including me)
chips <- 5 
guests <- 8 

#lab step #5: Save expected amount of chip consumption per guest (proportion of bag)
avgEat <- 0.4

#lab step #7: Calculate the expected amount of chips leftover, assuming I also eat 0.4 bags
chips - ((guests + 1) * avgEat)   #Ans: 1.4 bags of chips will remain




############################
#Part 2. Objects & functions
############################

##Looking at film rankings by guests

#lab step #8: Make a vector of each person's StarWars film rankings
Self <- c(7, 6, 5, 1, 2, 3, 4)
Penny <- c(5, 7, 6, 3, 1, 2, 4)
Jenny <- c(4, 3, 2, 7, 6, 5, 1)
Lenny <- c(1, 7, 3, 4, 6, 5, 2)
Stewie <- c(6, 7, 5, 4, 3, 1, 2)

#lab step #9: Retrieve Penny's and Lenny's Ep.IV rankings, and store these in new variables
PennyIV <- Penny[4]
LennyIV <- Lenny[4]

#lab step #10: Concatenate rankings into a matrix
rankings <- cbind(Self, Penny, Jenny, Lenny, Stewie)

#lab step #11: Explore structure of variables, vectors, and matrices created
str(PennyIV)  #numeric vector of length 1 (containing value '3')
str(Penny)  #numeric vector of length 7
str(rankings)  #matrix with 7 rows and 5 cols of numeric data, 
#with a vector of column names (guests) and no row names (films) provided

#lab step #12: Make a data frame (two ways) from the 5 ranking vectors
rankingsDf <- data.frame(Self, Penny, Jenny, Lenny, Stewie)
rankingsDf2 <- as.data.frame(cbind(Self, Penny, Jenny, Lenny, Stewie))
#data.frame will bind the given vectors into a data frame
#whereas as.data.frame takes a single object (e.g., a matrix) as the first argument

#lab step #13: Compare matrices and data frames created
class(rankings) #a matrix
class(rankingsDf) #a data.frame

str(rankings) #matrix with 7 rows and 5 cols of numeric data, 
#with a vector of column names (guests) and no row names (films) provided

str(rankingsDf) #data frame with 7 observations (rows) for 5 variables (cols)
#each column is a numeric vector, labelled with guest names

dim(rankings) #7, 5 (7 rows and 5 cols)
dim(rankingsDf) #7, 5 (7 rows and 5 cols).
#The matrix and data frame have the same dimensions

all(rankings == rankingsDf) #True
#The contents of the matrix and data frame are the same

typeof(rankings) #matrices store data as "double" (vectors of real values)
typeof(rankingsDf) #data frames store data as lists
#see, for types of R objects: 
#https://cran.r-project.org/doc/manuals/R-lang.html#Objects

#matrices and data frames differ in how they store data in memory


#lab step #14: Making row labels by creating a character vector of StarWars episodes
filmNames <- c("I", "II", "III", "IV", "V", "VI", "VII")

#lab step #15: Adding row labels into ranking matrix and data frames
row.names(rankings) <- filmNames
rankings #yes, the matrix rows are now labelled by episode

row.names(rankingsDf) <- filmNames
rankingsDf

row.names(rankingsDf2) <- filmNames
rankingsDf2
#yes, both rankings data frames now have episodes as row names

#lab step #16: Indexing - access 3rd row of rankings matrix
rankings[3,]

#lab step #17: Indexing - access 4th col of rankings data frame
rankingsDf[,4]

#lab step #18: Indexing - access my ranking for Ep.V
rankingsDf[5,1]

#lab step #19: Indexing - access Penny's ranking for Ep.II
rankingsDf[2,2]

#lab step #20: Indexing - access all rankings for Ep. IV-VI
rankingsDf[4:6,]

#lab step #21: Indexing - access all rankings for Ep. II, V, and VII
rankingsDf[c(2,5,7),]

#lab step #22: Indexing - access Penny, Jenny, & Stewie rankings for Ep. IV, VI
rankingsDf[c(4,6),c(2,3,5)]

#lab step #23: Switch Lenny's rankings for Ep. II and Ep. V
#hint - use 3 lines code & 1 new variable, so you don't overwrite needed values
LennyEp2 <- rankingsDf[2,4]  #save Lenny's original Ep. II ranking
rankingsDf[2,4] <- rankingsDf[5,4] #replace Lenny's Ep. II ranking with his Ep. V ranking
rankingsDf[5,4] <- LennyEp2 #replace Lenny's Ep. V ranking with his original Ep. II rank

rankingsDf[,4] #double check it worked by outputting all Lenny's rankings

#lab step #24: Subsetting with names instead of indexing

#with a matrix
rankings["III", "Penny"]  #Ans: 6

#with a data frame
rankingsDf["III", "Penny"]  #Ans: 6


#lab step #25: Use this approach to reverse the 'swap' in step 23
LennyEp2 <- rankingsDf["II","Lenny"]  #save Lenny's Ep. II ranking
rankingsDf["II","Lenny"] <- rankingsDf["V","Lenny"] #replace Lenny's Ep. II ranking with his Ep. V ranking
rankingsDf["V","Lenny"] <- LennyEp2

rankingsDf[,"Lenny"] #check it worked

#lab step #26: Using $ to redo the 'swap' done in step 23
LennyEp2 <- rankingsDf$Lenny[2]  #save Lenny's Ep. II ranking
rankingsDf$Lenny[2] <- rankingsDf$Lenny[5] #replace Lenny's Ep. II ranking with his Ep. V ranking
rankingsDf$Lenny[5] <- LennyEp2

rankingsDf$Lenny #check it worked


