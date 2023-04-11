## ------------------------------
## 
## Demo 2: Using the censusapi package
##
## Purpose of script: To demonstrate how to use the censusapi package 
## to access the Census Bureau's Census Data API.
## 
## Author: Reina Chano Murray
## 
## Date Created: 2023-04-01
##
## Requirements: 
##  censusapi
##  Census Data API Key (if hitting limits)
##
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
## uncomment next line and install package if needed
# install.packages("censusapi")

# load libraries
library(censusapi)


## make a variable for your key
api_key_source = source('api-keys.R')  # load up API key
api_key = api_key_source$value

print(api_key)

##
## ------------------------


## ------------------------
##
## DEMO 1
##
## Start by viewing the list of census data accessible through this package

apis <- listCensusApis()
View(apis)

## there's a lot of datasets you can access!
## let's look at the Small Area Health Insurance Estimates API
## in the apis variable, search for this dataset

View(apis)   # use search function to search for "Small Area Health Insurance Estimates"

## the name of the dataset is "timeseries/healthins/sahie"
## to determine which variables to explore in this dataset, 
## use the listCensusMetadata function

## specify the type argument = variables to see the variables available
sahie_vars <- listCensusMetadata( name = "timeseries/healthins/sahie", 
                                  type = "variables")
head(sahie_vars)
View(sahie_vars)

# see what geographies are available
sahie_geo <- listCensusMetadata( name = "timeseries/healthins/sahie", 
                                 type = "geography")
head(sahie_geo)


## use getCensus to return a data frame of results from a census api 
# always include:
#   name: name of the api
#   vintage: dataset year
#   vars: list of variables to get
#   region: geography level to return

# see documentation
?getCensus

# get uninsured rate by income group at the national level for 2018.
sahie_national <- getCensus( name = "timeseries/healthins/sahie",
                             vars = c("NAME", "IPRCAT", "IPR_DESC", "PCTUI_PT"), 
                             region = "us:*", 
                             time = 2018, 
                             key = api_key)
View(sahie_national)


# change region to state to get state level data
sahie_states <- getCensus( name = "timeseries/healthins/sahie",
                           vars = c("NAME", "IPRCAT", "IPR_DESC", "PCTUI_PT"), 
                           region = "state:*", 
                           time = 2018, 
                           key = api_key)
View(sahie_states)

# get county-level data with region. Query for just Maryland with regionin
sahie_counties_MD <- getCensus(name = "timeseries/healthins/sahie",
                               vars = c("NAME", "IPRCAT", "IPR_DESC", "PCTUI_PT"), 
                               region = "county:*", 
                               regionin = "state:24", 
                               time = 2018, 
                               key = api_key)
head(sahie_counties_MD)



# this dataset is also a timeseries data (as we saw from the metadata)
# use the time argument 
# percent uninsured in MD from 2016 to 2018
sahie_years_MD <- getCensus( name = "timeseries/healthins/sahie",
                             vars = c("NAME", "PCTUI_PT"),
                             region = "state:24",
                             time = "from 2006 to 2018", 
                             key = api_key)
View(sahie_years_MD)
