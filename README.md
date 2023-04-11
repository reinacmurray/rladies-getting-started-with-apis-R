# Getting Started with APIs in R
This repository contains webinar notes and materials used in the R-Ladies Baltimore & Irvine event, [Getting Started with APIs in R](https://www.meetup.com/rladies-baltimore/events/291493215/), presented on April 11, 2023. 

# What you'll need to follow along
If you are interested in following along the demonstration portion, I recommend cloning and/or downloading a copy of this repository to your own computer. This presentation goes over several R packages and tools:

## Installing R and RStudio
This talk's demonstration uses R and RStudio. To follow along, make sure you have access to R and RStudio by either downloading R and RStudio, or setting up a free account at [RStudio Cloud](https://rstudio.cloud/).

- Download links: 
	- R - https://cran.r-project.org/
	- RStudio - https://www.rstudio.com/products/rstudio/download/ (Download “RStudio Desktop”, not “RStudio Server”)
- If it’s been a while since you’ve used R or R Studio, no worries! But check your versions and consider updating if you’re several versions behind.

## R Packages to install
The demonstrations in this talk use the following R packages:
- [httr](https://cran.r-project.org/web/packages/httr/index.html)
- [jsonlite](https://cran.r-project.org/web/packages/jsonlite/index.html)
- [censusapi](https://cran.r-project.org/web/packages/censusapi/index.html)

## Getting a US Census API Key
To follow along during the workshop, you'll need an API key. From the [US Census Bureau's Developer site](https://www.census.gov/data/developers/data-sets.html), submit your [API key request](https://api.census.gov/data/key_signup.html).

# Description of Repository Files
- PresentationMaterials: this folder contains the powerpoint presentation used in today's talk, as well as a pdf version of the powerpoint. 
- Scripts: this folder contains R scripts demonstrated in today's talk
    - demo1_httr_jsonlite: R file for demonstration 1
    - demo2_censusapi: R file for demonstration 2
    - demo_rjsonio: R file demonstrating rjosnio (optional)
    - demo_tidycensus: R file demonstrating tidycensus (optional)


# License and Terms of Use
The presentation materials are licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License (CC BY-NC-SA 4.0)](https://creativecommons.org/licenses/by-nc-sa/4.0/), attributable to Reina Chano Murray. 