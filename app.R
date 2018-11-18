# Shinyfit
## Shiny front end for finalfit
## Ewen Harrison
## First version: Nov 2018

# Packages
library(shiny)
library(dplyr)
library(finalfit)
library(DT)

# Data must be prepared here first
source("0_prep.R")

# Define UI
ui <- fluidPage(
	
	# App title
	titlePanel("Shinyfit"),
	
	fluidRow(
		# Inputs: edit in this file:
		column(4,
					 source(file.path("ui", "ui_input1.R"),  local = TRUE)$value),
		
		# Outputs: edit in this file:
		column(8,
					 tabsetPanel(id = "tabs",
					 						source(file.path("ui", "ui_output1.R"),  local = TRUE)$value,
					 						source(file.path("ui", "ui_output2.R"),  local = TRUE)$value)
		)
	)
)

# Server
server <- function(input, output, session) {
	
	# UI updates and subsetting
	source(file.path("server", "server1_uiupdates.R"),  local = TRUE)$value
	
	# Fit model and main results table 
	## Condition: only run server-side funcs when viewing tab for speed
	observe({if(input$tabs == "table"){
		source(file.path("server", "server2_fit.R"),  local = TRUE)$value
		
		# Download
		source(file.path("server", "server3_download.R"),  local = TRUE)$value
	} else if (input$tabs == "plot"){
		# Plot
		source(file.path("server", "server4_plot.R"),  local = TRUE)$value		
	}
	})
	
	# Not yet used
	# source(file.path("server", "server2.R"),  local = TRUE)$value
	# source(file.path("server", "server3.R"),  local = TRUE)$value
	
}

# Run the application 
shinyApp(ui = ui, server = server)
