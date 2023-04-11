## ------------------------------
##
## Demo 1: Using httr and jsonlite
##
## Purpose of script: To demonstrate how to use the httr and jsonlite
## packages in R. 
## 
## Author: Reina Chano Murray
## 
## Date Created: 2023-04-01
##
## Requirements:
##  httr 
##  jsonlite
##  Census Data API Key (if hitting limits)
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
## load httr and jsonlite -- if you don't have the packages installed, 
## uncomment the next line to install the package. 

#install.packages(c("httr", "jsonlite"))
library(httr)
library(jsonlite)

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


# Create a GET response to call the API
census_data <- httr::GET(query)


# View the API GET response result
str(census_data)    # check the status code -- 200 means good to go


# convert raw content to text (a JSON string)
census_content <- httr::content(census_data, as ="text")

str(census_content)
print(census_content)


# use jsonlite to convert this string to a dataframe and view data in a table
census_json <- jsonlite::fromJSON(census_content)

View(census_json)


# you can now use this data in R to run your analysis!