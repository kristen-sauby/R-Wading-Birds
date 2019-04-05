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

# get lat/long to be the same across records
ColonyInfo_GIS$Lat %<>% round(4)
ColonyInfo_GIS$Long %<>% round(4)

ColonyInfo$Lat %<>% round(4)
ColonyInfo$Long %<>% round(4)

# get list of ID Numbers still missing
ColonyInfo_remainder <- ColonyInfo %>%
	filter(!(ColonyInfo$`ID NUM` %in% ColonyInfo_GIS$ID_NUM))

# rbind with GIS data
ColonyInfo_GIS %<>% rbind.fill(ColonyInfo_remainder)




ColonyInfo_GIS %>% write.csv("ColonyInfo_merged.csv")