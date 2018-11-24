library(shiny)

# Crosstabs
crosstabs = reactive({
	finalfit::summary_factorlist(subdata(), dependent = input$column_var, explanatory = input$explanatory3,
															 p = input$p, na_include = input$na_include, column = input$column_prop, 
															 total_col = input$total_col, orderbytotal = input$orderbytotal,
															 dependent_label_prefix = "", 
															 add_dependent_label = TRUE)
})

# Column number to allow reactive justification
crosstabs_column_n = reactive(dim(crosstabs())[2])

output$crosstabs = renderDataTable({
	DT::datatable(crosstabs(),
								rownames=FALSE, extensions = "FixedColumns", 
								options = list(dom = 't', 
															 scrollX = TRUE, 
															 paging=FALSE,
															 fixedColumns = list(leftColumns = 1, rightColumns = 0),
															 searching = FALSE,
															 columnDefs = list(list(className = 'dt-right', targets = 2:crosstabs_column_n()-1))
								)
	)
})
