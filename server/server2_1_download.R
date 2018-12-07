# Download buttons
## Todo: write in option to name files

## .csv
output$download_fit_csv <- downloadHandler(
	filename = function(){"fit_results.csv"}, 
	content = function(filename){
		write.csv(results_table(), filename, row.names = FALSE)
	}
)

## .doc
output$download_fit_doc <- downloadHandler(
	filename = function(){"fit_results.doc"},
	content = function(filename) {
		# Copy the report file to a temporary directory before processing it, in
		# case we don't have write permissions to the current working dir (which
		# can happen when deployed).
		tempReport <- file.path(tempdir(), "fit_output.Rmd")
		file.copy("fit_output.Rmd", tempReport, overwrite = TRUE)
		
		# Set up parameters to pass to Rmd document
		params <- list(results = results_table(),
									 metrics = metrics_table(),
									 h1 = input$h1)
		
		# Knit the document, passing in the `params` list, and eval it in a
		# child of the global environment (this isolates the code in the document
		# from the code in this app).
		rmarkdown::render(tempReport, output_file = filename,
											params = params,
											envir = new.env(parent = globalenv())
		)
	})
