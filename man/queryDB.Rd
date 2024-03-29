% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/queryDB.R
\name{queryDB}
\alias{queryDB}
\title{Wrapper to make a query from a sql file and get the data from a database using RODBC}
\usage{
queryDB(queryFilename, db, uid, pw = "", sp = " ", start = " ",
  end = " ", asis = FALSE)
}
\arguments{
\item{queryFilename}{The filename of the sql query to read in and convert with \code{\link{make.query}}}

\item{db}{The name of your database connection}

\item{uid}{your user ID}

\item{pw}{The password for the database connection. If omitted,
RODBC will prompt you for a password and will mask it.
If entered, it will be visible and unsecure.}

\item{sp}{The species scientific name to extract from the DB}

\item{start}{The start year}

\item{end}{The end year}

\item{ais}{Logical whether or not to convert columns as in \code{\link{read.table}}.
             See \code{\link{RODBC::sqlQuery}}}
}
\description{
Wrapper to make a query from a sql file and get the data from a database using RODBC
}
\details{
Calls \code{\link{make.query}} and then \code{\link{getData}}
}
\author{
Andi Stephens

Allan Hicks
}
\seealso{
\code{\link{make.query}}, \code{\link{RODBC::sqlQuery}}
}

