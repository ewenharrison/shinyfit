library(shiny)

# Crosstabs
## Split name to relabel column
split_names_lookup = reactive({
	alldata_names_lookup %>% 
		filter(vname %in% input$split)
})

crosstabs = reactive({
	df.out = subdata() %>% 
		group_by(!!! syms(input$split)) %>%  
		do(
			finalfit::summary_factorlist(., dependent = input$column_var, explanatory = input$explanatory3,
																	 p = input$p, na_include = input$na_include, column = input$column_prop, 
																	 total_col = input$total_col, orderbytotal = input$orderbytotal,
																	 add_dependent_label = FALSE)
		) %>% 
		ungroup() %>% 
		rename(!!! syms(with(split_names_lookup(), setNames(vname, vfill)))) %>% 
		dependent_label(subdata(), dependent = input$column_var, prefix = "")
})

# Column number to allow reactive justification
crosstabs_column_right = reactive({seq(from = 1 + length(input$split), 
																			 to = dim(crosstabs())[2] - 1, 
																			 by = 1)
})

output$crosstabs = renderDataTable({
	DT::datatable(crosstabs(),
								rownames=FALSE, extensions = "FixedColumns", 
								options = list(dom = 't', 
															 scrollX = TRUE, 
															 paging = FALSE,
															 fixedColumns = list(leftColumns = 1, rightColumns = 0),
															 searching = FALSE,
															 columnDefs = list(list(className = 'dt-right', 
															 											 targets = crosstabs_column_right()))
								)
	)
})
