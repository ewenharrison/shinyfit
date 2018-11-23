# Preamble to do. 

# Dataset 1 ------------------------------
# Provide data to app
library(finalfit)

# colon_s example
# Read data to "alldata"
alldata = finalfit::colon_s

# Display variable names
names(alldata)

# Select subset of variables to keep
alldata = alldata %>% 
	dplyr::select(15:29, 32, 8)

# Add variable labels if wish
## e.g. 
alldata$nodes %<>% ff_label("Lymph node number")

# View dataset
ff_glimpse(alldata)

# Extract variable names and labels. 
alldata_names = names(alldata) 
names(alldata_names) = extract_variable_label(alldata)

# Arrange variable names for purposes of dropdown display
matrix(alldata_names)

# Choose how to arrange the above list:
alldata_names_list = list(Outcomes = alldata_names[c(15, 14, 10)],
													Explanatory = alldata_names[c(11,1,3,4,5,6,7,8,9,13,2, 17)],
													Groups = alldata_names[16]
)

# Remove outcomes from explanatory list
alldata_names_list_explanatory = alldata_names_list[-1]

# Create lookup table of names (required)
alldata_names_lookup = extract_labels(alldata)

# Create list for subsetting data, this is limited to factors
alldata %>% 
	dplyr::select_if(is.factor) -> alldata_subset

alldata_subset_names = names(alldata_subset) 
names(alldata_subset_names) = extract_variable_label(alldata_subset)
rm(alldata_subset)

# Arrange variable names for SUBSET dropdown list
matrix(alldata_subset_names)

# Choose how to arrange the above list:
alldata_subset_names_list = list(Outcomes = alldata_subset_names[c(13)],
																	Explanatory = alldata_subset_names[c(11,1,3,4,5,6,7,8,9)],
																	Groups = alldata_subset_names[14]
)
rm(alldata_subset_names)

# Name project
shinyfit_name = "Colon dataset"
dataset_label = "colon_s"

# Make final list for app
alldata_list = list(alldata=alldata,
								alldata_names = alldata_names,
								alldata_names_list=alldata_names_list,
								alldata_names_list_explanatory=alldata_names_list_explanatory,
								alldata_names_lookup=alldata_names_lookup,
								alldata_subset_names_list=alldata_subset_names_list,
								shinyfit_name=shinyfit_name,
								dataset_label=dataset_label)
class(alldata_list) = "shinyfit"

save(alldata_list, file="data/alldata.rda")	

# Clear workspace prior to assembling second dataset
rm(list=ls())
















# Dataset 2-------------------------------
# Provide data to app
library(finalfit)
library(dplyr)
library(forcats)

# colon_s example
# Read data to "alldata"
alldata = boot::melanoma

# Display variable names
names(alldata)

# Select subset of variables to keep
alldata = alldata %>% 
	dplyr::select(1:7)

# Recode factor levels if necessary
alldata %<>% 
	mutate(
		sex = factor(sex) %>% 
			fct_recode(Male = "1",
								 Female = "0"),
		ulcer = factor(ulcer) %>% 
			fct_recode(Yes = "1",
								 No = "0")
	)

# Add variable labels if wish
alldata$time %<>% ff_label("Time since operation (days)")
alldata$status %<>% ff_label("Status")
alldata$sex %<>% ff_label("Sex")
alldata$age %<>% ff_label("Age (years)")
alldata$year %<>% ff_label("Year of operation")
alldata$thickness %<>% ff_label("Thickness (mm)")
alldata$ulcer %<>% ff_label("Ulcer")


# View dataset
ff_glimpse(alldata)

# Extract variable names and labels. 
alldata_names = names(alldata) 
names(alldata_names) = extract_variable_label(alldata)

# Arrange variable names for purposes of dropdown display
matrix(alldata_names)

# Choose how to arrange the above list:
alldata_names_list = list(Outcomes = alldata_names[c(1, 2)],
													Explanatory = alldata_names[c(3:7)],
													Groups = ""
)

# Remove outcomes from explanatory list
alldata_names_list_explanatory = alldata_names_list[-1]

# Create lookup table of names (required)
alldata_names_lookup = extract_labels(alldata)

# Create list for subsetting data, this is limited to factors
alldata %>% 
	dplyr::select_if(is.factor) -> alldata_subset

alldata_subset_names = names(alldata_subset) 
names(alldata_subset_names) = extract_variable_label(alldata_subset)
rm(alldata_subset)

# Arrange variable names for SUBSET dropdown list
matrix(alldata_subset_names)

# Choose how to arrange the above list:
alldata_subset_names_list = list(#Outcomes = "",
																 Explanatory = alldata_subset_names[c(1,2)]#,
																 #Groups = ""
)
rm(alldata_subset_names)

# Name project
shinyfit_name = "Melanoma dataset"
dataset_label = "melanoma"

# Make final list for app
alldata_list = list(alldata=alldata,
								alldata_names = alldata_names,
								alldata_names_list=alldata_names_list,
								alldata_names_list_explanatory=alldata_names_list_explanatory,
								alldata_names_lookup=alldata_names_lookup,
								alldata_subset_names_list=alldata_subset_names_list,
								shinyfit_name=shinyfit_name,
								dataset_label=dataset_label)
class(alldata_list) = "shinyfit"
save(alldata_list, file="data/alldata.rda")	

# Clear workspace prior to assembling second dataset
rm(list=ls())





































# GS2 example	
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
	
	# Make all missing but add ?forcats::fct_explicit_na
							 
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
	alldata_names_lookup = extract_labels(alldata)
	
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
	
save(list=ls(), file="data/alldata2.rda")	
