## ------------------------------
##
## Demo: rjsonio
##
## Purpose of script: To demonstrate the rjsonio package
## 
## Author: Reina Chano Murray
## 
## Date Created: 2021-02-12
##
## Requirements:
##  RJSONIO package -- for converting JSON into R objects
##  Census Data API Key (if hitting limits)
##  References creating queries in web browser from accompanying slide deck
## ------------------------------

## ------------------------
##
## Getting Started
##
## set your working directory 

wd_path = ""   # enter your working directory path
setwd(wd_path)

##
## ------------------------


## ------------------------
##
## Load packages
##
## load RJSONIO -- if you don't have the package installed, 
## uncomment the next line to install the package. 

# install.packages("RJSONIO")
library(RJSONIO)

##
## ------------------------


## ------------------------
##
## DEMO
## We'll use the same API query we ran in the browser:
## 2018 population or housing unit estimate of those reporting race as 
## "Asian alone or in combination" for all counties in the state of Maryland
## We can call that exact same API query and store it in a variable:

query <- "https://api.census.gov/data/2018/pep/charagegroups?get=POP,GEONAME,DATE_DESC&DATE_CODE=11&RACE=10&for=county:*&in=state:24"

## If you hit the limit and need to include your key, 
## uncomment this line and add your key

#queryKey <- "https://api.census.gov/data/2018/pep/charagegroups?get=POP,GEONAME,DATE_DESC&DATE_CODE=11&RACE=10&for=county:*&in=state:24&key=[yourkey]"


## if we call up this variable, we'll see that it's a vector with 1 element
query

## to parse this request, use the RJSONIO library to convert the JSON content
## in the query to R objects

?fromJSON # pulls up documentation on the fromJSON() function
ljson <- fromJSON(query)

# view the extracted data
head(ljson, 4)

# these are nested lists:
ljson[1]  # headers
ljson[2]  # first "row" of data, Allegany County
ljson[3]  # second "row" of data, Anne Arundel County

## we've successfully pulled data from the Census API, but this format
## isn't the greatest for further analysis. We can clean up/extract
## elements from the ljson variable and store them as R objects

ljson <- ljson[2:length(ljson)]  # remove headers from ljson

ljson.cou <- sapply(ljson, function(x) x[2]) # pull out county names
ljson.cou

ljson.tot <- sapply(ljson, function(x) x[1])  # extract total population value
ljson.tot

ljson.date <- sapply(ljson, function(x) x[3])  # extract date description
ljson.date

ljson.datecode <- sapply(ljson, function(x) x[4])  # extract date code
ljson.datecode

ljson.race <- sapply(ljson, function(x) x[5])  # extract race code
ljson.race

ljson.state <- sapply(ljson, function(x) x[6])  # extract state code
ljson.state

ljson.county <- sapply(ljson, function(x) x[7])  # extract county code
ljson.county

## note, if you call up the ljson variable, all the data is still in there
## in nested list form (except the headers, which we pulled out entirely)
ljson

## what we've done is extracted out specific columns and saved them as objects
ljson.cou
ljson.tot   ## note too that ljson.tot (total population) is formatted as a string


## take these individual r objects and create dataframe
df <- data.frame(ljson.cou, 
                 as.numeric(ljson.tot), # convert to numeric, structure currently string
                 ljson.date, 
                 ljson.datecode, 
                 ljson.race, 
                 ljson.state, 
                 ljson.county)

# create new column names
names(df) <- c("CountyName", 
               "Population", 
               "Date", 
               "DateCode", 
               "Race", 
               "StateFIPS", 
               "CountyCode")

df
View(df)  # another view

## we've now structured our data from the Census Data API as a dataframe 
## that we can work with further in R

