tabPanel("Crosstabs", value = "crosstabs",
				 DT::dataTableOutput("crosstabs"),
				 downloadButton('download_crosstabs_csv',"Download table: csv"),
				 downloadButton('download_crosstabs_doc',"Download table: doc")
)
