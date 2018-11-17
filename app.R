# Shinyfit
## Shiny front end for finalfit
## Ewen Harrison
## First version: Nov 2018

# Packages
library(shiny)
library(dplyr)
library(finalfit)
library(DT)

# Data preparation is here
source("0_prep.R")

# Define UI
ui <- fluidPage(
	
	# Application title
	titlePanel("Shinyfit"),
	
	fluidRow(
		# Inputs
		column(4,
					 source(file.path("ui", "ui_input1.R"),  local = TRUE)$value),
		# Outputs
		column(8,
					 textInput("h1", "Project", value = shinyfit_name),
					 DT::dataTableOutput("results"),
					 tableOutput("metrics"),
					 downloadButton('download_csv',"Download table: csv"),
					 downloadButton('download_doc',"Download table: doc")
		)
	)
)

# Server
server <- function(input, output, session) {
	
	# Update explanatory_multi (explanatory2)
	# to only include variables from explanatory (explanatory1)
	explanatory2_update = reactive({
		alldata_names[alldata_names %in% input$explanatory1]
	})
	
	observe({
		updateSelectInput(session, "explanatory2", choices = explanatory2_update())
	})
	
	# Subset
	subset_levels_update = reactive({
		alldata %>% dplyr::pull(input$subset_variable) %>% levels()
	})
	
	observe({
		updateSelectInput(session, "subset_levels",
											choices = subset_levels_update(),
											selected = subset_levels_update()
		)
	})	
	
	subdata = reactive({
		if(!input$subset){
			return(alldata)
		}else{
			alldata %>%
				# Passing a quoted character to `filter()` is a total pain 
				dplyr::filter(UQ(sym(input$subset_variable)) %in% c(input$subset_levels)) %>% 
				mutate_all(funs(forcats::fct_drop(.)))
		}
	})
	
	output$tmpout = renderText({
		subdata() %>% 
			dim()
	})
	
	output$tmpout2 = renderText({
		input$subset_variable
	})
	output$tmpout3 = renderText({
		input$subset_levels
	})
	

	# alldata %>%
	# 	dplyr::filter(hdi_tertile %in% c("Low", "Middle")) %>%
	# 	dim()



	# Fit
	df.out = reactive({
		finalfit::finalfit(subdata(), dependent = input$outcome, explanatory = input$explanatory1,
											 explanatory_multi = input$explanatory2,
											 random_effect = input$random_effects1,
											 confint_type = "default", keep_models=!input$keep_models,
											 metrics=input$metrics, condense=!input$condense)
	})
	
	## Main table
	results_table = reactive({
		if(!input$metrics){
			return(df.out())
		}else{
			return(df.out()[[1]])
		}
	})
	
	output$results = renderDataTable({
		DT::datatable(results_table(),
									
									rownames=FALSE, extensions = "FixedColumns", 
									options = list(dom = 't', 
										scrollX = TRUE, 
										paging=FALSE,
										fixedColumns = list(leftColumns = 1, rightColumns = 0),
										searching = FALSE))
	})
	
	## Metrics table
	metrics_table = reactive({
		if(input$metrics){
			return(df.out()[[2]])
		}
	})
	
	output$metrics = renderTable({
		metrics_table()}, 
		colnames=FALSE
	)
	
	# Download buttons
	## .csv
	output$download_csv <- downloadHandler(
		filename = function(){"shinyfit.csv"}, 
		content = function(filename){
			write.csv(results_table(), filename)
		}
	)
	
	## .doc
	output$download_doc <- downloadHandler(
		filename = function(){"shinyfit.doc"},
		content = function(filename) {
			# Copy the report file to a temporary directory before processing it, in
			# case we don't have write permissions to the current working dir (which
			# can happen when deployed).
			tempReport <- file.path(tempdir(), "output.Rmd")
			file.copy("output.Rmd", tempReport, overwrite = TRUE)
			
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
	
	# source(file.path("server", "server1.R"),  local = TRUE)$value
	# source(file.path("server", "server2.R"),  local = TRUE)$value
	# source(file.path("server", "server3.R"),  local = TRUE)$value
	# source(file.path("server", "server4.R"),  local = TRUE)$value
}

# Run the application 
shinyApp(ui = ui, server = server)
