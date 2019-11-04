library(shiny)
library(shinyjs)
library(finalfit)

# UI updates
## Project name from alldata, this is used in document download
observe({
	updateTextInput(session, "h1", value = shinyfit_name)
})

## Explanatory_multi (explanatory2) must only include variables from explanatory (explanatory1)
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
		vlabels = alldata %>% extract_variable_label()
		subdata = alldata %>%
			# Passing a quoted character to `filter()` is a total pain 
			dplyr::filter(UQ(sym(input$subset_variable)) %in% input$subset_levels) %>% 
			mutate_if(is.factor, forcats::fct_drop) %>% 
			ff_relabel(vlabels)
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

# Order by total workaround
observe({
	if(input$orderbytotal)
		updateCheckboxInput(session, "total_col", value = TRUE
	)
})	
