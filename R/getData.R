#' Create an ODBC connection and get data from database
#'
#' @details Open an ODBC connection and using an sql, extract data from the database.
#'
#' @author Andi Stephens
#' @author Allan Hicks
#'
#' @param dsn   The name of your databse connection
#' @param uid   Your user ID
#' @param query The sql query as an R object
#' @param pw    The password for the database connection. If omitted,
#'              RODBC will prompt you for a password and will mask it.
#'              If entered, it will be visible and unsecure.
#' @param ais   Logical whether or not to convert columns as in \code{\link{read.table}}.
#'              See \code{\link{RODBC::sqlQuery}}
#'
#' @seealso \code{\link{make.query}, \link{queryDB}}, \code{\link{getMultiSpeciesCatch}}, \code{\link{RODBC::sqlQuery}}
#'
#' @export

getData <- function(dsn,uid,query,pw="",ais=asis) {
    ############################################################################
    # Function to extract from a database given a query
    ############################################################################

    require(RODBC)
    db <- RODBC::odbcConnect(dsn=dsn,uid=uid,pw=pw)
    out <- RODBC::sqlQuery(db, query,as.is=ais)
    RODBC::odbcClose(db)

    return(out)
}
