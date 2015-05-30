#' Download sql file from GitHub and save as an object in R
#'
#' @details Reads an sql (text) file from GitHub for use in ExtractR
#'
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
#' @examples
#' getSQL(loc="https://raw.githubusercontent.com/nwfsc-data/sql/master/trawl/HaulCharacteristics.sql")
#' loc <- "C:/NOAA205/SurveyDatabase/sql/HaulCharacteristics.sql"
#'
#' @export

sqlName <- "HaulCharacteristics.sql"
folder <- "GitHub"
database <- c("trawl","observer")

getSQL <- function(sqlName,folder="GitHub",database=c("trawl","observer")) {

	if(folder=="GitHub") {
		folder <- "https://raw.githubusercontent.com/nwfsc-data/sql/master"
	}
	loc <- file.path(folder,database,sqlName)

	if(substring(folder,1,4)=="http") {
		sqlExists <- NULL
		for(i in 1:length(loc)) sqlExists <- c(sqlExists,RCurl::url.exists(loc[i],.opts = list(ssl.verifypeer = FALSE)))
		if(!any(sqlExists)) {
			stop("The sqls specified,\n",paste(loc,collapse="\n"),"\ndo not exist\n")
		}
		loc <- loc[sqlExists]
		sql <- RCurl::getURL(loc,.opts = list(ssl.verifypeer = FALSE))
		sql <- readLines(textConnection(sql))
	} else {
	    if (!file.exists(loc)) {
	        stop("The file specified, ", loc,", does not exist\n")
	    }
	    sql <- readLines(loc)
	}
}
