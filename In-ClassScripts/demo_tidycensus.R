## ------------------------------
## 
## Demo: Using the tidycensus package
##
## Purpose of script: To demonstrate how to use the tidycensus package 
## to access the Census Bureau's Census Data API.
## 
## Author: Reina Chano Murray
## 
## Date Created: 2021-02-12
##
## Requirements: 
##  tidycensus
##  tidyverse
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
## uncomment next 2 lines and install packages if needed

# install.packages("tidycensus")
# install.packages("tidyverse")

library(tidycensus)
library(tidyverse)


## set your API key

api_key = ""       # enter your API key 
?census_api_key    # documentation on function
census_api_key(api_key)

##
## ------------------------


## ------------------------
##
## DEMO 1
## 
## Step 1: Specify a Dataset. 
## The tidycensus package has the following datasets available:
#   acs5 - 5-year ACS
#   acs1 - 1-year ACS
#   sf1  - Decennial census


## Step 2: Specify a Year
#   For the decennial censuses, year will just be the year of the decennial census. 
#   The tidycensus package can access the 1990, 2000, and 2010 decennial censuses.
#   For ACS data, the year argument of tidycensus functions refers to the end-year of the sample period. 
#   For example, if you want to use a 5-year ACS that ended in 2017, set year = 2017. 
#   As of January 2020, tidycensus supports the end-years 2010 through 2017.


## Use these two components (dataset and year) to load all variables for a given dataset
acs17 <- load_variables(year = 2017, dataset = "acs5", cache = TRUE)
View(acs17)   # does this table look familiar?  :)   you can search this. Try searching "Units in Structure"

# note, I can also just view it in the console
acs17

# and I can filter by a specific variable, 
# but this requires knowing the exact wording of the value  you want
acs17 %>%
  filter(concept == "UNITS IN STRUCTURE" )


## once I find the variables I want, I can store their codes into a vector
vars_acs17 <- c( owner_occupied = "B25032_002", 
                 renter_occupied = "B25032_013")


## Step 3: Get Data
## Now that we've identified the variables and the dataset and the
## years we want to pull from, we can use get_acs() and get_decennial()
## to pull the data and save it into a dataframe. 

## Note: make sure to supply AT LEAST geography, variables, and year

df_acs <- get_acs( geography = "state", 
                   variables = vars_acs17, # variable defined earlier
                   year = 2017
)

df_acs
View(df_acs)

# a note about moe -- ACS data includes the estimate and the margin of error
# refer to the Census Bureau's documentation on ACS data for further info
##
## ------------------------


## ------------------------
##
## DEMO 2
## 
## We can add additional arguments to our query. 
## Let's look at another metric in the same acs dataset: 
## Median Home Value (in dollars). If you search the df_acs table for 
## "Median Home Value", you'll see that the variable name for this 
## metric is "B25077_001"

## change geography to county
## and add an additional argument: state
medval_md <- get_acs( geography = "county", 
                      variables = "B25077_001",   # specifying one variable
                      year = 2017,
                      state = "MD",               # specifying MD for state
                      survey = "acs5")
View(medval_md)


## you can drill further down and look specifically at Median Home Values
## for all census tracts within Prince George's County.
## change geography to tract
## keep the state argument
## and add another argument: county

medval_pgmd <- get_acs( geography = "tract", 
                        variables = "B25077_001",
                        year = 2017,
                        state = "MD", 
                        county = 033, 
                        survey = "acs5")
View(medval_pgmd)


## What if you want the full table for all metrics related to 
## median home value? (median status by mortgage value, median status
## by year structure built, etc). 
## Instead of including a variable argument for "B25077_001", use 
## a table argument for "B25077".  

pgmd_val <- get_acs( geography = "tract", 
                     table = "B25075",     # table argument, not variable
                     year = 2017,
                     state = "MD", 
                     county = 033, 
                     survey = "acs5")
View(pgmd_val)
