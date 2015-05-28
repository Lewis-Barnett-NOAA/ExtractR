#' Wrapper to make a query from a sql file and get the data from a database using RODBC
#' A TrawlR function for use with the FRAM trawl survey database.
#'
#' @details Calls \code{\link{make.query}} and then \code{\link{getData}}
#'
#' @author Andi Stephens
#' @author Allan Hicks
#'
#' @param queryFN   The filename and location of the sql query to read in and convert with \code{\link{make.query}}
#' @param db   The name of your databse connection
#' @param uid   your user ID
#' @param pw    The password for the database connection. If omitted,
#'              RODBC will prompt you for a password and will mask it.
#'              If entered, it will be visible and unsecure.
#' @param sp    The species scientific name to extract from the DB
#' @param start The start year
#' @param end   The end year
#' @param speciesTable   The end year
#' @param ais   Logical whether or not to convert columns as in \code{\link{read.table}}.
#'              See \code{\link{RODBC::sqlQuery}}
#'
#' @seealso \code{\link{make.query}, \link{queryDB}}, \code{\link{getData}}, \code{\link{RODBC::sqlQuery}}
#'
#' @export

getMultiSpeciesCatch <- function(queryFN,db,uid,pw="",sp,start,end,speciesTable=NULL,asis=F) {
    #if speciesTable not entered, get it from database
    if(is.null(speciesTable)) {
        stop("I need to code it in to get the species table.  For now do that first and pass the matrix")
        queryDB(....)
    }
    #get the particular species called for and make common name one string
    species <- speciesTable[match(sp,speciesTable$SCIENTIFIC_NAME),]
    species$SPECIES <- gsub(" ","_",species$SPECIES)

    #make the multi-species query
    qq <- make.query(queryFN, sp=sp, start=start, end=end)
    tmpIN <- paste(paste("'",species$SCIENTIFIC_NAME,"'",sep=""),species$SPECIES,sep=" AS ",collapse=", ")
    qq <- gsub("&msp",tmpIN,qq)

    #get data and return
    out <- getData(dsn=db,uid=uid,pw=pw,query=qq,ais=asis)
    return(out)
}

