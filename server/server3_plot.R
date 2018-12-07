library(shiny)

# Use reduced model for plot when specified
explanatory = reactive({
	if(is.null(input$explanatory2)){
		input$explanatory1
	}else{
		input$explanatory2
	}
})

output$plot.out = renderPlot({
	finalfit::ff_plot(subdata(), dependent = dependent(), explanatory = explanatory(),
										random_effect = input$random_effects1,
										confint_type = input$confint_type)
})

output$plot.ui <- renderUI({
	plotOutput("plot.out", width = paste0(input$width, "%"), height = input$height)
})