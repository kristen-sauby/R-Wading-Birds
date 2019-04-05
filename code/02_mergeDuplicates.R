ColonyInfo <- ColonyInfo5Apr2019 %>% 
	as.data.frame %>% 
	arrange(Lat, Long, `ID NUM`) %>% 
	.[duplicated(.[c("Lat","Long")]) | 
	  	duplicated(.[c("Lat","Long")], fromLast = TRUE), ] %>%
	dplyr::group_by(Lat, Long) %>%
	#rowwise() %>%
	dplyr::summarise(
		ColonyIDNumber = paste(`ID NUM`, collapse="; "),
		ColonyName = paste(unique(`Colony name`), collapse="; "),
		#Latitude = Lat[1],
		#Longitude = Long[1],
		AtlasNumber = paste(unique(`Atlas# (red cells are duplicates)`), collapse="; "),
		Origin = paste(unique(Origin), collapse="; "),
		OwnershipManagement = paste(`ownership/management`, collapse="; "),
		Comments = paste(unique(comments), collapse="; ")
	)

ColonyInfo_wo_Duplicates <- ColonyInfo5Apr2019 %>% 
	as.data.frame %>% 
	arrange(Lat, Long) %>% 
	.[!(
		duplicated(.[c("Lat","Long")]) | 
			duplicated(.[c("Lat","Long")], 
					 fromLast = TRUE)
	), ]

ColonyInfo %<>% rbind.fill(ColonyInfo_wo_Duplicates) %>% dplyr::select(-`...9`)

ColonyInfo %>% write.csv("ColonyInfo_duplicates_removed5April2019.csv")