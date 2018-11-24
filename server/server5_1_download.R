# Download buttons
## Todo: write in option to name files

## .csv
output$download_crosstabs_csv <- downloadHandler(
	filename = function(){"crosstabs.csv"}, 
	content = function(filename){
		write.csv(crosstabs(), filename)
	}
)

## .doc
output$download_crosstabs_doc <- downloadHandler(
	filename = function(){"crosstabs.doc"},
	content = function(filename) {
		# Copy the report file to a temporary directory before processing it, in
		# case we don't have write permissions to the current working dir (which
		# can happen when deployed).
		tempReport <- file.path(tempdir(), "crosstabs_output.Rmd")
		file.copy("output.Rmd", tempReport, overwrite = TRUE)
		
		# Set up parameters to pass to Rmd document
		params <- list(results = crosstabs(),
									 h1 = input$h1)
		
		# Knit the document, passing in the `params` list, and eval it in a
		# child of the global environment (this isolates the code in the document
		# from the code in this app).
		rmarkdown::render(tempReport, output_file = filename,
											params = params,
											envir = new.env(parent = globalenv())
		)
	})