

tmp = alldata
str(tmp)

levels(tmp$gender.factor)
str(tmp$gender.factor)

forcats::fct_drop(tmp$gender.factor) %>% 
	str()


colon_s %>% 
	select(mort_5yr) %>% 
	str()
	levels()
?forcats

	
	data.frame(
		var1 = factor(c(1,2,3)),
		var2 = factor(c(2,3,4))) %>% 
		dplyr::select(var1) %>% 
		levels()
	
	data.frame(
		var1 = factor(c(1,2,3)),
		var2 = factor(c(2,3,4))) %>% 
		dplyr::pull(var1) %>% 
		levels()
	
	alldata %>% 
		filter(UQ(sym("hdi_tertile")) %in% c("High")) %>% 
		dim()
	