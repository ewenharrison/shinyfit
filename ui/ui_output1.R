tabPanel("Fit", value = "fit",
				 DT::dataTableOutput("results"),
				 tableOutput("metrics"),
				 downloadButton('download_fit_csv',"Download table: csv"),
				 downloadButton('download_fit_doc',"Download table: doc")
)