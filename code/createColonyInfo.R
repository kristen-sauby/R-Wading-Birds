# get list of ID Numbers NOT in ColonyInfo_FLMAMerged2April2019
ColonyInfo_remainder <- ColonyInfo %>%
	filter(!(ColonyInfo$`ID NUM` %in% ColonyInfo_FLMAMerged2April2019$ID_NUM))
# find those in ColonyInfo_NWRMerged2April2019
ColonyInfo_NWRMerged2April2019_keep <- ColonyInfo_NWRMerged2April2019 %>%
	filter(ColonyInfo_NWRMerged2April2019$ID_NUM %in% ColonyInfo_remainder$`ID NUM`)

# get list of ID Numbers still missing
ColonyInfo_remainder %<>%
	filter(!(ColonyInfo_remainder$`ID NUM` %in% ColonyInfo_NWRMerged2April2019$ID_NUM))

# find those in ColonyInfo_WildlifeManagementAreasMerged2April2019
ColonyInfo_WMAMerged2April2019_keep <- ColonyInfo_WMAMerged2April2019 %>%
	filter(ColonyInfo_WMAMerged2April2019$ID_NUM %in% ColonyInfo_remainder$`ID NUM`)

# get list of ID Numbers still missing
ColonyInfo_remainder %<>%
	filter(!(ColonyInfo_remainder$`ID NUM` %in% ColonyInfo_WMAMerged2April2019$ID_NUM))

write.csv(ColonyInfo_remainder, "ColonyInfo_remainder.csv")
# add those from original ColonyInfo file


ColonyInfo_FLMAMerged2April2019 %>%
	rbind.fill(ColonyInfo_NWRMerged2April2019_keep) %>%
	rbind.fill(ColonyInfo_WMAMerged2April2019_keep) %>% write.csv("ColonyInfo_w_GIS_data.csv")
