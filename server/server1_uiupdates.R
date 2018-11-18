library(shiny)

# UI updates
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
	if(!input$subset){
		return(alldata)
	}else{
		alldata %>%
			# Passing a quoted character to `filter()` is a total pain 
			dplyr::filter(UQ(sym(input$subset_variable)) %in% c(input$subset_levels)) %>% 
			mutate_all(funs(forcats::fct_drop(.)))
	}
})