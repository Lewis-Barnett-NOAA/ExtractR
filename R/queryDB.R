#' Wrapper to make a query from a sql file and get the data from a database using RODBC
#'
#' @details Calls \code{\link{make.query}} and then \code{\link{getData}}
#'
#' @author Andi Stephens
#' @author Allan Hicks
#'
#' @param queryFilename   The filename of the sql query to read in and convert with \code{\link{make.query}}
#' @param db   The name of your database connection
#' @param uid   your user ID
#' @param pw    The password for the database connection. If omitted,
#'              RODBC will prompt you for a password and will mask it.
#'              If entered, it will be visible and unsecure.
#' @param sp    The species scientific name to extract from the DB
#' @param start The start year
#' @param end   The end year
#' @param ais   Logical whether or not to convert columns as in \code{\link{read.table}}.
#'              See \code{\link{RODBC::sqlQuery}}
#'
#' @seealso \code{\link{make.query}}, \code{\link{RODBC::sqlQuery}}
#'
#' @export

queryDB <- function(queryFilename,db,uid,pw="",sp=" ", start=" ", end=" ", asis=FALSE) {

    #make the query as a character string from the file in the sql directory
    query <- make.query(queryFilename,sp=sp,start=start,end=end)

    #get data from the database
    out <- getData(dsn=db,uid=uid,pw=pw,query=query,ais=asis)

    return(out)
}
