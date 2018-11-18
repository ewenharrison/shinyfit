tabPanel("Table", value = "table",
				 DT::dataTableOutput("results"),
				 tableOutput("metrics"),
				 downloadButton('download_csv',"Download table: csv"),
				 downloadButton('download_doc',"Download table: doc")
)