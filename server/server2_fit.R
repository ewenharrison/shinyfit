library(shiny)

# Fit
fit = reactive({
	finalfit::finalfit(subdata(), dependent = dependent(), explanatory = input$explanatory1,
										 explanatory_multi = input$explanatory2,
										 random_effect = input$random_effects1,
										 confint_type = input$confint_type, keep_models=!input$keep_models,
										 metrics=input$metrics, condense=!input$condense)
})

# Main table
results_table = reactive({
	if(!input$metrics){
		return(fit())
	}else{
		return(fit()[[1]])
	}
})

# Column number to allow reactive justification
fit_column_n = reactive(dim(results_table())[2])

output$results = renderDataTable({
	DT::datatable(results_table(),
								rownames=FALSE, extensions = "FixedColumns", 
								options = list(dom = 't', 
															 scrollX = TRUE, 
															 paging=FALSE,
															 fixedColumns = list(leftColumns = 1, rightColumns = 0),
															 searching = FALSE,
															 columnDefs = list(list(className = 'dt-right', targets = 2:fit_column_n()-1))))
})

# Metrics table
metrics_table = reactive({
	if(input$metrics){
		return(fit()[[2]])
	}
})

output$metrics = renderTable({
	metrics_table()}, 
	colnames=FALSE
)
