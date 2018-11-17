# Provide data to app

# For demo comment out to leave one
#dataset = "colon_s"
dataset = "gs2"

# colon_s example
if(dataset == "colon_s"){
	
	# Read data to "alldata"
	alldata = finalfit::colon_s
	
	# Variable names
	names(alldata)
	
	# Select variables to keep
	alldata = alldata %>% 
		dplyr::select(15:29, 32, 8)
	
	# Extract variable names and labels. 
	alldata_names = names(alldata) 
	names(alldata_names) = extract_variable_label(alldata)
	
	# Subset variable names for purposes of dropdown display
	matrix(alldata_names)
	
	alldata_names_list = list(Outcomes = alldata_names[c(15, 14, 10)],
														Explanatory = alldata_names[c(11, 1,3,4,5,6,7,8,9,13,2, 17)],
														Groups = alldata_names[16]
	)
	
	# Remove outcomes from explanatory list (optional)
	alldata_names_list_explanatory = alldata_names_list[-1]
	
	# Create lookup table of names (required)
	alldata_names_lookup = extract_labels(colon_s)
	
	# Name project
	shinyfit_name = "Example: colon_s"
	
# GS2 example	
}else if(dataset == "gs2"){
	# Read data to "alldata"
	load("shinydata.rda")
	alldata = shinydata
	rm(shinydata)
	
	# Variable names
	names(alldata)
	
	# Select variables to keep
	alldata = alldata %>% 
		dplyr::select(1, 3:25)
	
	# For now, and just for this example, filter unknown and missing
	alldata = alldata %>%
		filter_all(all_vars(. != "Unknown")) %>%
		filter_all(all_vars(. != "Missing")) %>% 
		mutate_all(funs(forcats::fct_drop))
							 
	# Extract variable names and labels. 
	alldata_names = names(alldata) 
	names(alldata_names) = extract_variable_label(alldata)
	
	# Subset variable names for purposes of dropdown display
	matrix(alldata_names)
	
	alldata_names_list = list(Outcomes = alldata_names[c(19:24)],
														Explanatory = alldata_names[c(1:18)],
														Groups = alldata_names[1]
	)
	
	# Remove outcomes from explanatory list (optional)
	alldata_names_list_explanatory = alldata_names_list[-1]
	
	# Create lookup table of names (required)
	alldata_names_lookup = extract_labels(colon_s)
	
	# Create list of factors for subsetting
	alldata %>% 
		select_if(is.factor) -> alldata_factors
	
	alldata_factors_names = names(alldata_factors) 
	names(alldata_factors_names) = extract_variable_label(alldata_factors)
	
	matrix(alldata_factors_names)
	
	alldata_factors_names_list = list(Outcomes = alldata_names[c(19:24)],
														Explanatory = alldata_names[c(1:18)],
														Groups = alldata_names[1]
	)
	
	# Name project
	shinyfit_name = "GlobalSurg2: SSI"
	
	
	
}
