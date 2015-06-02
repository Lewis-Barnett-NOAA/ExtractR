#' Make a query from an sql file that can be used by RODBC
#'
#' @details Read in the lines of an sql file, remove the comments, substitute in stuff,
#'   and then return the query as a character string.
#'
#' @author Andi Stephens
#' @author Allan Hicks
#'
#' @param query The sql file.
#' @param sp    The species scientific name to extract from the DB (certain sql scripts)
#' @param start The start year (certain sql scripts)
#' @param end   The end year (certain sql scripts)
#' @param ...   Named arguments to pass to \code{\link{getSQL}}. See examples.
#'
#' @seealso \code{\link{getData}, \link{queryDB}}, \code{\link{getMultiSpeciesCatch}}
#'
#' @examples
#' make.query("HaulCharacteristics.sql", start=1998, end=2014) #gets the sql from GitHub by default
#'
#' make.query("SingleSpecies.sql", sp="Sebastes entomelas", start=1998, end=2014) #gets the sql from GitHub by default
#'
#' make.query("HaulCharacteristics.sql", start=1998, end=2014,
#'     folder = "C:/NOAA2015/SurveyDatabase/sql",
#'     database = "")
#'
#' make.query("C:/NOAA2015/SurveyDatabase/sql/HaulCharacteristics.sql", start=1998, end=2014)
#'
#' @export

make.query = function(query, sp=" ", start=" ", end=" ",...) {
    #############################################################################
    #
    # Function make.query creates an SqlPlus query from a file.
    # Reads in query text and removes comment lines
    # Returns the query as one statement (list of characters) to pass to sqlQuery
    #
    # Originally written by Andi Stephens in June 2010
    # reformatted and modified by Allan Hicks for ExtractR in 2015
    #
    #############################################################################
    removeComments <- function(x,comment) {
        lines <- grep(comment,x)
        x[lines] <- unlist(lapply(strsplit(x[lines],comment),function(xx){xx[1]}))
        return(x)
    }

    pars <- list(...)
    folder <- if(is.null(pars$folder)) {formals(getSQL)$folder}else{pars$folder}
    database <- if(is.null(pars$database)) {eval(formals(getSQL)$database)}else{pars$database}
    verbose <- if(is.null(pars$verbose)) {formals(getSQL)$verbose}else{pars$verbose}

    qq <- getSQL(query, folder=folder, database=database, verbose=verbose)

    #Remove comment lines
    if(length(grep("REM",qq))>0) {
        qq <- removeComments(qq,"REM")
    }
    if(length(grep("--",qq))>0) {
        qq <- removeComments(qq,"--")
    }
    #if(length(grep("/* ",qq))>0) stop("Sorry, does not handle multi-line comments\n") WORK out how to slelct for /* specifically

    # Make appropriate substitutions
    sp <- paste("'",paste(sp,collapse="','"),"'",sep="")
    qq <- gsub("&sp", sp, qq)
    qq <- gsub("&beginyr", start, qq)
    qq <- gsub("&endyr", end, qq)

    #Return query to be performed
    return(paste(qq,collapse=" "))
}

