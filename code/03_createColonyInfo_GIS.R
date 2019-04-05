# get list of ID Numbers NOT in ColonyInfo_FLMAMerged2April2019
ColonyInfo_remainder <- ColonyInfo %>%
	filter(!(ColonyInfo$`ID NUM` %in% ColonyInfo_FLMAMerged2April2019$ID_NUM))
# find those in ColonyInfo_NWRMerged2April2019 and keep
ColonyInfo_NWRMerged2April2019_keep <- ColonyInfo_NWRMerged2April2019 %>%
	filter(ColonyInfo_NWRMerged2April2019$ID_NUM %in% ColonyInfo_remainder$`ID NUM`)

# get list of ID Numbers still missing
ColonyInfo_remainder %<>%
	filter(!(ColonyInfo_remainder$`ID NUM` %in% ColonyInfo_NWRMerged2April2019$ID_NUM))

# find those in ColonyInfo_WildlifeManagementAreasMerged2April2019
ColonyInfo_WMAMerged2April2019_keep <- ColonyInfo_WMAMerged2April2019 %>%
	filter(ColonyInfo_WMAMerged2April2019$ID_NUM %in% ColonyInfo_remainder$`ID NUM`)


# rbind GIS data
ColonyInfo_GIS <- ColonyInfo_FLMAMerged2April2019 %>%
	rbind.fill(ColonyInfo_NWRMerged2April2019_keep) %>%
	rbind.fill(ColonyInfo_WMAMerged2April2019_keep)

ColonyInfo_GIS$Lat %<>% round(6)
ColonyInfo_GIS$Long %<>% round(6)

# merge duplicates
ColonyInfo_GIS_duplicates_removed <- ColonyInfo_GIS %>% 
	as.data.frame %>% 
	arrange(Lat, Long, ID_NUM) %>% 
	.[duplicated(.[c("Lat","Long")]) | 
	  	duplicated(.[c("Lat","Long")], fromLast = TRUE), ] %>%
	dplyr::group_by(Lat, Long) %>%
	#rowwise() %>%
	dplyr::summarise(
		ColonyIDNumber = paste(ID_NUM, collapse="; "),
		ManagedAreaName = ManagedAreaName[1],
		ManagedAreaNameAbbr = ManagedAreaNameAbbr[1],
		ManagingAgency = ManagingAgency[1],
		Owner = Owner[1],
		CoOwners = CoOwners[1],
		OwnerTypes = OwnerTypes[1],
		TotalAcresManagedArea = TotalAcresManagedArea[1],
		ManagedAreaDescription1 = ManagedAreaDescription1[1],
		ManagedAreaDescription2 = ManagedAreaDescription2[1],
		ManagedAreaComments1 = ManagedAreaComments1[1],
		ManagedAreaComments2 = ManagedAreaComments2[1],
		Manager = Manager[1],
		ManagingInstitution = ManagingInstitution[1],
		ManagerCity = ManagerCity[1],
		ManagerPhone = ManagerPhone[1],
		ManagedAreaComments12 = ManagedAreaComments12[1]
	)




ColonyInfo_GIS_no_duplicates <- ColonyInfo_GIS %>% 
	as.data.frame %>% 
	arrange(Lat, Long) %>% 
	.[!(
		duplicated(.[c("Lat","Long")]) | 
			duplicated(.[c("Lat","Long")], 
					 fromLast = TRUE)
	), ]

ColonyInfo_GIS_duplicates_removed %<>% rbind.fill(ColonyInfo_GIS_no_duplicates)