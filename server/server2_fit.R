library(shiny)

# Fit
df.out = reactive({
	finalfit::finalfit(subdata(), dependent = input$outcome, explanatory = input$explanatory1,
										 explanatory_multi = input$explanatory2,
										 random_effect = input$random_effects1,
										 confint_type = input$confint_type, keep_models=!input$keep_models,
										 metrics=input$metrics, condense=!input$condense)
})

# Main table
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

# Metrics table
metrics_table = reactive({
	if(input$metrics){
		return(df.out()[[2]])
	}
})

output$metrics = renderTable({
	metrics_table()}, 
	colnames=FALSE
)
