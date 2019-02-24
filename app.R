# Shinyfit
## Shiny front end for finalfit
## Ewen Harrison
## First version: Nov 2018

# Packages
library(shiny)
library(dplyr)
library(finalfit)
library(DT)


# Data
source(file.path("server", "server0_data.R"),  local = TRUE)$value

# Define UI
ui <- fluidPage(
	
	# App title
	titlePanel("Shinyfit"),
	
	fluidRow(
		# Inputs: edit in this file:
		column(4,
					 source(file.path("ui", "ui_input1.R"),  local = TRUE)$value),
		
		# Outputs: edit in these files:
		column(8,
					 tabsetPanel(id = "tabs",
					 						source(file.path("ui", "ui_output1.R"),  local = TRUE)$value,
					 						source(file.path("ui", "ui_output2.R"),  local = TRUE)$value,
					 						source(file.path("ui", "ui_output3.R"),  local = TRUE)$value,
					 						source(file.path("ui", "ui_output4.R"),  local = TRUE)$value)
		)
	)
)

# Server
server <- function(input, output, session) {
	
	# UI updates and subsetting
	source(file.path("server", "server1_ui_updates.R"),  local = TRUE)$value
	
	# Output
	## Condition: only run server-side functions when a given tab is open for efficiency
	#observe({if(input$tabs == "fit"){
		
		# Fit table
		source(file.path("server", "server2_fit.R"),  local = TRUE)$value
		## Download
		source(file.path("server", "server2_1_download.R"),  local = TRUE)$value
	#} else if (input$tabs == "plot"){
		
		# Plot
		source(file.path("server", "server3_plot.R"),  local = TRUE)$value		
	#} else if (input$tabs == "crosstabs"){
		
		# Crosstabs
		source(file.path("server", "server4_crosstabs.R"),  local = TRUE)$value	
		## Download
		source(file.path("server", "server4_1_download.R"),  local = TRUE)$value
	#} else if (input$tabs == "glimpse"){	
		# Glimpse
		source(file.path("server", "server5_glimpse.R"),  local = TRUE)$value	
	#}
	#})
}

# Run application 
shinyApp(ui = ui, server = server)
