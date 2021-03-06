% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/my_trace.R
\name{mytrace}
\alias{mytrace}
\title{Posterior Traceplots}
\usage{
mytrace(x, pars, lang, ...)
}
\arguments{
\item{x}{model output, or a data.table result from the output of \code{\link{get_iters}}}

\item{pars}{names of parameters to be plotted. Uses \code{get_iters} defaults for getting parameters.}

\item{lang}{model language (of \code{x})}

\item{...}{arguments passed to plot}
}
\description{
Generate traceplots from either JAGS or Stan output
}
\details{
Easier to handle than other traceplots (if, e.g., wanted to add trace plot from multiple models to same figure, hard to do w/ Stan function). Works for JAGS or Stan output (via R2jags and rstan).
}

