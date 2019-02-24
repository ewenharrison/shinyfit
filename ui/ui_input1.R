wellPanel(
	# Heading
	h4('Dataset'),
	textInput("h1", "Project name", value = ""),
	
	# Crosstabs
	conditionalPanel(condition = "input.tabs == 'crosstabs'",
									 selectInput("column_var",
									 						label    = "Variable of interest (column)",
									 						selected = alldata_names_list$Explanatory[1],
									 						choices  = alldata_names_list,
									 						selectize = FALSE),
									 selectInput("explanatory3",
									 						label    = "Explanatory variables (rows)",
									 						selected = alldata_names_list_explanatory$Explanatory[2],
									 						choices  = alldata_names_list,
									 						multiple = TRUE),
									 selectInput("split",
									 						label    = "Split",
									 						choices  = alldata_names_list_explanatory,
									 						multiple = TRUE),
									 checkboxInput("column_prop",
									 							label = "Column proportions",
									 							value = TRUE),
									 checkboxInput("p",
									 							label = "Include p-value",
									 							value = TRUE),
									 checkboxInput("total_col",
									 							label = "Include total column",
									 							value = FALSE),
									 checkboxInput("orderbytotal",
									 							label = "Order by total (only with one explanatory)",
									 							value = FALSE)
									 ),
	
	# Fit / plot
	conditionalPanel(condition = "input.tabs == 'fit' | input.tabs == 'plot'",
									 h4('Model parameters'),
									 checkboxInput("survival",
									 							label = "Survival object",
									 							value = FALSE),
									 selectInput("outcome",
									 						label    = "Outcome/dependent/time variable:",
									 						selected = alldata_names_list$Outcome[1],
									 						choices  = alldata_names_list,
									 						selectize = FALSE),
									 conditionalPanel(condition = 'input.survival == true',
									 								 selectInput("status",
									 								 						label    = "Survival status:",
									 								 						choices  = alldata_names_list,
									 								 						selectize = FALSE)
									 ),
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
									 						choices  = alldata_names_list_explanatory$Groups,
									 						multiple = TRUE),
									 h4('Model options'),
									 checkboxInput("keep_models",
									 							label = "Show only final model",
									 							value = FALSE),
									 checkboxInput("metrics",
									 							label = "Include model metrics",
									 							value = FALSE),
									 checkboxInput("condense",
									 							label = "Do not condense output",
									 							value = FALSE),
									 radioButtons("confint_type",
									 						 label = "Confidence interval type ('profile' much slower, more accurate)",
									 						 choices = c("default", "profile"),
									 						 selected = "default", inline = TRUE)
	),
	h4('Subset data'),
	checkboxInput("subset",
								label = "Subset dataset",
								value = FALSE),
	conditionalPanel(condition = 'input.subset == true',
									 selectInput("subset_variable",
									 						label    = "Variable to subset by:",
									 						selected = alldata_subset_names_list$Explanatory[1],
									 						choices  = alldata_subset_names_list,
									 						selectize = FALSE),
									 selectInput("subset_levels",
									 						label    = "Keep:",
									 						selected = alldata %>% 
									 							pull(alldata_subset_names_list$Explanatory[1]) %>% 
									 							levels(),
									 						choices  = alldata %>% 
									 							pull(alldata_subset_names_list$Explanatory[1])%>%
									 							levels(),
									 						multiple = TRUE)
	),

	conditionalPanel(condition = "input.tabs == 'fit' | input.tabs == 'plot' | input.tabs == 'crosstabs'",
									 h4('Missing data'),
									 # Two ways of handling missing
									 # First is forcats::fct_explicit_na for fit()
									 # Second is na_include for finalfit::summary_factorlist()
									 checkboxInput("missing",
									 							label = "Missing values explicit",
									 							value = FALSE)
	),
	conditionalPanel(condition = "input.tabs == 'crosstabs'",
									 checkboxInput("na_include",
									 							label = "Missing values explicit (explanatory only)",
									 							value = FALSE)
	),
	
	
	# Plot only
	conditionalPanel(condition = "input.tabs == 'plot'",
									 sliderInput("width",  "Plot Width (%)", min = 20, max = 100, value = 80, step=10),
									 sliderInput("height", "Plot Height (px)", min = 200, max = 1000, value = 400, step=50)
	)
)
