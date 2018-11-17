wellPanel(h4('Main input parameters:'),
					selectInput("outcome",
											label    = "Outcome/dependent variable:",
											selected = alldata_names_list$Outcome[1],
											choices  = alldata_names_list,
											selectize = FALSE),
					selectInput("explanatory1",
											label    = "Explanatory variable(s), full model:",
											selected = alldata_names_list_explanatory$Explanatory[1],
											choices  = alldata_names_list_explanatory,
											multiple = TRUE),
					selectInput("explanatory2",
											label = "Explanatory variable(s), reduced model:",
											choices = alldata_names_list_explanatory$Explanatory[1],
											multiple = TRUE),
					selectInput("random_effects1",
											label    = "Random effects",
											selected = NULL,
											choices  = alldata_names_list_explanatory[2],
											multiple = TRUE),
					
					# textOutput("tmpout"),
					# textOutput("tmpout2"),
					# textOutput("tmpout3"),
					# 
					checkboxInput("subset",
												label = "Subset dataset",
												value = FALSE),
					conditionalPanel(condition = 'input.subset == true',
													 selectInput("subset_variable",
													 						label    = "Variable to subset by:",
													 						selected = alldata_factors_names_list$Explanatory[1],
													 						choices  = alldata_factors_names_list,
													 						selectize = FALSE),
													 selectInput("subset_levels",
													 						label    = "Keep:",
													 						selected = alldata %>% 
													 							pull(alldata_factors_names_list$Explanatory[1]) %>% 
													 							levels(),
													 						choices  = alldata %>% 
													 							pull(alldata_factors_names_list$Explanatory[1])%>%
													 							levels(),
													 						multiple = TRUE)

					),
					checkboxInput("keep_models",
												label = "Show only final model",
												value = FALSE),
					checkboxInput("metrics",
												label = "Include model metrics",
												value = FALSE),
					checkboxInput("condense",
												label = "Do not condense output",
												value = FALSE)
					
					
					
)
