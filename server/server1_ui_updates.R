library(shiny)
library(shinyjs)
library(finalfit)

# UI updates
## Project name from alldata
observe({
	updateTextInput(session, "h1", value = shinyfit_name)
})

## Add optional dataset selector if more than one dataset provided
# if(dataset_n >1){
# 	insertUI(
# 		selector = '#placeholder',
# 		ui = radioButtons("dataset",
# 											label = "Select:",
# 											#choices = c(1,2),
# 											choiceNames = list("Dataset 1", "Dataset 2"),
# 											choiceValues = list(1, 2),
# 											selected = 1, 
# 											inline=TRUE)
# 	)}

# Select dataset
# observe({
# 	if(!is.null(input$dataset)){
# 		if(input$dataset == 1){
# 			list2objects(alldata1)
# 			js$reset()
# 		}else if (input$dataset == 2){
# 			list2objects(alldata2)
# 			js$reset()
# 		}
# 	}
# })

## Explanatory_multi (explanatory2) to only include variables from explanatory (explanatory1)
explanatory2_update = reactive({
	alldata_names[alldata_names %in% input$explanatory1]
})

observe({
	updateSelectInput(session, "explanatory2", choices = explanatory2_update())
})

## Subset level updates from subset_variable
subset_levels_update = reactive({
	alldata %>% dplyr::pull(input$subset_variable) %>% levels()
})

observe({
	updateSelectInput(session, "subset_levels",
										choices = subset_levels_update(),
										selected = subset_levels_update()
	)
})	

# Subset data
subdata = reactive({
	
	## Subset 
	if(!input$subset){
		subdata = alldata
	}else{
		subdata = alldata %>%
			# Passing a quoted character to `filter()` is a total pain 
			dplyr::filter(UQ(sym(input$subset_variable)) %in% input$subset_levels) %>% 
			mutate_if(is.factor, forcats::fct_drop)
	}
	
	## Make missing explicit
	if(input$missing){
		subdata %<>%
			# This seems awkward, but open to suggestions of multiple mutate_if contitions
			# in a single move
			mutate_if(names(.) %in% unlist(alldata_names_list_explanatory) & 
									sapply(., is.factor),
								forcats::fct_explicit_na
			)
	}
	return(subdata)
})

# Define outcome
## Define dependent variable if survival object
dependent = reactive({
	if(!input$survival){
		input$outcome
	}else if(input$survival){
		paste0("Surv(", input$outcome, ",", input$status, ")")	
	}
})