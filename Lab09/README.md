###README for Lab 09

####Basic Information
Author: Kelly Carscadden
Date: Mar 24, 2017
Source file for lab: [on Sam Flaxman's Github](https://github.com/flaxmans/CompBio_on_git/tree/master/Labs/Lab09)
Attribution for camera trap data: Cusack et al. 2013

Overview: The lab objective was to parse date-time data from the Cusack et al. 2013 paper and create functions to do basic calculations on that date-time data. A personal goal was to explore POSIX formats and how to work with the list data created when data-time strings are converted to POSIXct format. After playing with POSIXct data, I'm sure there must be a more straightforward way to parse date-time data for the lab goal - possibly even by hand.

####Camera trap data components

1. Reference - a unique identifying integer
2. Placement - location of trap (Random or Trail)
3. Season - time of sampling (Wet or Dry season)
4. Station - numeric or alphanumeric station ID
5. Species - common name of species imaged
6. DateTime - date and time of image (in one of two general formats):
* dd/mm/yyyy hh:mm (day/mo/4-digit yr hr:min)
* dd/mm/yy hh:mm (day/mo/yr without century hr:min)

####Main script components
The script:
1. Standardizes the DateTime format (all using 4-digit year)
2. Converts DateTime into POSIXct format
3. Creates a function (calcTimeDiff) that calculates the time difference, in days, between any two input times
4. Creates a function (timeDiffByGroup) that returns a vector of time differences, in days, between each consecutive time point for a particular sampling unit (i.e., for a given Placement, Season, and Station)