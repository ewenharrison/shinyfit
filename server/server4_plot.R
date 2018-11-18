library(shiny)

# Use reduced model for plot when specified
explanatory = reactive({
	if(is.null(input$explanatory2)){
		input$explanatory1
	}else{
		input$explanatory2
	}
})

output$plot = renderPlot({
	finalfit::ff_plot(subdata(), dependent = input$outcome, explanatory = explanatory(),
										random_effect = input$random_effects1,
										confint_type = input$confint_type)
})