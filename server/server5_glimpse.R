library(shiny)

# Glimpse
glimpse.out = reactive(finalfit::ff_glimpse(subdata()))

# Column number to allow reactive justification
glimpse1_column_n = reactive(dim(glimpse.out()[[1]])[2])
glimpse2_column_n = reactive(dim(glimpse.out()[[2]])[2])

output$glimpse1 = renderDataTable({
	DT::datatable(glimpse.out()[[1]],
								rownames=FALSE, extensions = "FixedColumns",
								# Hard coded column names. Don't imagine ff_glimpse() changing
								colnames = c("", "N", "Missing N", "Missing %", "Mean", "SD", "Min", "25% quartile", "Median", "75% quartile", "Max"),
								options = list(dom = 't', 
															 scrollX = TRUE, 
															 paging=FALSE,
															 fixedColumns = list(leftColumns = 1, rightColumns = 0),
															 searching = FALSE,
															 columnDefs = list(list(className = 'dt-right', targets = 2:glimpse1_column_n()-1))
								)
	)
})

output$glimpse2 = renderDataTable({
	DT::datatable(glimpse.out()[[2]],
								rownames=FALSE, extensions = "FixedColumns", 
								colnames = c("", "N", "Missing N", "Missing %", "Levels N", "Levels", "Levels Count", "Levels %"),
								options = list(dom = 't', 
															 scrollX = TRUE, 
															 paging=FALSE,
															 fixedColumns = list(leftColumns = 1, rightColumns = 0),
															 searching = FALSE,
															 columnDefs = list(list(className = 'dt-right', targets = 2:glimpse2_column_n()-1))
								)
	)
})
