# Functions
## To expand list to global environment objects
list2objects = function(.list){
	for (i in 1:length(.list)){
		assign(
			names(.list)[i], .list[[i]],
			envir = .GlobalEnv
		)
	}
}

#jsResetCode <- "shinyjs.reset = function() {history.go(0)}"

# Load dataset(s)
load("data/alldata.rda") %>% 
	length() -> "dataset_n"

list2objects(alldata_list)

# alldata <- reactive({
# 	alldata1
# })
