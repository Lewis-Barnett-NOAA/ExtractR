#' Download sql file from GitHub and save as an object in R
#'
#' @details Reads an sql (text) file from GitHub or any folder for use in ExtractR
#'
#' @author Allan Hicks
#'
#' @param sqlName  The name of your sql file. This can be just the name, or a specific path and name on your computer. See Details.
#' @param folder   The folder your sql file is in. "GitHub" refers to the specific GitHub site (nwfsc-data)
#' @param database An additional folder specifying the database that the sql file is associated with. Can be a vector and it
#'                   will search through these folders until it finds the sql file (if present)
#'
#' @details The default is to search the GitHub site for the sql file when the user enters just the name of the sql file.
#'          If you want to use an sql file local on your computer, you can either 1) enter the name of the file and specific the folder it is in
#'          using the folder argument, or 2) enter in the entire path with the sql file name in the sqlName argument.  For both of these cases,
#'          the \code{database} argument should be blank
#'
#' @seealso \code{\link{make.query}, \link{queryDB}}, \code{\link{getMultiSpeciesCatch}}, \code{\link{RODBC::sqlQuery}}
#'
#' @examples
#' getSQL("HaulCharacteristics.sql") #gets the sql from GitHub by default
#'
#' getSQL(sqlName = "HaulCharacteristics.sql",
#'	   folder = "C:/NOAA2015/SurveyDatabase/sql",
#'	   database = "")
#'
#' getSQL("C:/NOAA2015/SurveyDatabase/sql/HaulCharacteristics.sql")
#'
#' @export

getSQL <- function(sqlName, folder="GitHub", database=if(folder=="GitHub"){c("trawl","observer")}else{""},verbose=TRUE) {
	#use if statement in database (and not ifelse) because ifelse would only return first element
    database #this needs to be here to set database. Without calling it first, the if statements don't set it for some reason

	if(folder=="GitHub") {  #get from GitHub Site
		folder <- "https://raw.githubusercontent.com/nwfsc-data/sql/master"
	}
	loc <- file.path(folder,database,sqlName)
	if(substring(sqlName,2,2)==":") { #A specific path
		folder <- ""
		loc <- sqlName
	}
	if(verbose) cat("Getting sql script from",loc,"\n",sep="\n")

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
	return(sql)
}
