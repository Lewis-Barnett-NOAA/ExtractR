# TrawlR

## Allan Hicks, Todd Hay, Beth Horness, John Wallace, Andi Stephens

###R code to access FRAM databases using specific sql scripts

A set of functions to query FRAM databases from R

The goal of this project is to allow for easier access to 
FRAM data. We are still developing these functions and discussing 
the issues related to using these extractions for general research.

The R code does the following:

1. Reads in the sql text file
2. Inserts the species and years to extract and makes a query
3. Calls the database using RODBC
4. Returns a dataframe with the extraction

To install this as a package from GitHub
```S
install.packages("devtools")
devtools::install_github("nwfsc-data/ExtractR")
```

Future work

* Keep developing the code as a package
* Add functions for simple analyses
* Make it simple to perform extractions needed for assessment exploration
* Provide informative warnings related to
    * incorrect specification for sql
    * correct use of data
   
