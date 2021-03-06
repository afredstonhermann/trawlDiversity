#' Plot Map of Bottom Temperature
#' 
#' Give the processed MSOM, plot a map of bottom temperature in each year for the region
#' 
#' @param prn the p object (processed msom; output from \code{process_msomStatic})
#' @param Figures option list to which the figure and its information should be added
#' @param FUN graphical device function
#' @param ... arguments passed to plot_device
#' 
#' @details
#' The function uses \code{unpack_p} to get much of the information it needs. The \code{Figures} object is a list whose first level is intended to be the region. The second level is specific to each figure. The third level has 3 elements: 'figure', 'name', and 'dim'. The 'figure' element is the result of using \code{\link{recordPlot}} on what is plotted. The name of the figure is, e.g., what the saved figure would be called. The dim is the width and height (in that order) in inches.
#' 
#' @return
#' Returns the Figure object
#' 
#' @seealso 
#' There are several functions that are run through the process_msom_figures script. Richness and temperature plots are \code{\link{plot_btemp_map}}, \code{\link{plot_rich_bt_scatter}}, and \code{\link{plot_rich_bt_ts}}. Figures for colonization, extinction, and the species and places associated with those processes are \code{\link{plot_ce_wrap}}, \code{\link{plot_col_vs_unobsSpp}}, \code{\link{plot_colExt_perStrat}}, and \code{\link{plot_rank_temp}}. Figures for diagnostics are \code{\link{plot_traceplot}} and \code{\link{plot_post_corr}}.
#' 
#' @export
plot_btemp_map <- function(prn, Figures, FUN="dev.new", ...){
	requireNamespace("maps", quietly=TRUE)
	pup <- unpack_p(prn)
mapply(x=names(pup), value=pup, function(x, value){assign(x, value, envir=parent.frame(n=2));invisible(NULL)})(prn)
	
	if(missing(Figures)){
		Figures <- list()
	}
	
	fig_num <- "Figure3"
	
	fig3_name <- paste0("btempMap_", reg, ".png")
	f3_mfrow <- auto.mfrow(n_yrs)
	f3_height <- 6
	f3_width <- f3_mfrow[2]*f3_height/f3_mfrow[1]
	fig3_dim <- c(f3_width, f3_height)
	
	Figures[[reg]][[fig_num]][["figure"]] <- list()
	Figures[[reg]][[fig_num]][["name"]] <- fig3_name
	Figures[[reg]][[fig_num]][["dim"]] <- fig3_dim
	
	Figures[[reg]][[fig_num]] <- plot_device(Figures[[reg]][[fig_num]], FUN, ...)
	
	par(mfrow=f3_mfrow, oma=c(0.1,0.1, 1,0.1), mar=c(1,1,0.1,0.1), mgp=c(0.75,0.1,0), tcl=-0.15, cex=1, ps=8)
	
	yrs2loop <- bt[,sort(una(year))]
	for(y in 1:length(yrs2loop)){
		t_lon <- bt[year==yrs2loop[y],lon]
		t_lat <- bt[year==yrs2loop[y],lat]
		t_bt_col <- bt[year==yrs2loop[y],bt_col]
		plot(t_lon, t_lat, type="n")
		maps::map(add=TRUE)
		points(t_lon, t_lat, col=t_bt_col, pch=20)
		mtext(yrs2loop[y], side=3, adj=0.1, line=-0.75, font=2)
	}
	# bt[,j={
# 		plot(lon, lat, type="n")
# 		map(add=TRUE)
# 		points(lon, lat, col=bt_col, pch=20)
# 		mtext(unique(year), side=3, adj=0.1, line=-0.75, font=2)
# 	}, by="year"]
	mtext(paste(reg, "Bottom Temperature"), outer=TRUE, side=3, line=0.25, font=2)
	
	if(is.null(Figures[[reg]][[fig_num]][["fig_loc"]])){
		Figures[[reg]][[fig_num]][["figure"]] <- recordPlot()
	}else{
		Figures[[reg]][[fig_num]][["figure"]] <- NULL
		dev.off()
	}
	

	
	return(Figures)
}