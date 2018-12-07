# Functions
## To expand data object list to global environment objects
list2objects = function(.list){
	for (i in 1:length(.list)){
		assign(
			names(.list)[i], .list[[i]],
			envir = .GlobalEnv
		)
	}
}

# Load dataset
## Future option for multiple datasets
load("data/alldata.rda") %>% 
	length() -> "dataset_n"

# Expand shinyfit data object
list2objects(alldata_list)
