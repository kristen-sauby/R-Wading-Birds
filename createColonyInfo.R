# get list of ID Numbers NOT in ColonyInfo_FLMAMerged2April2019
ColonyInfo_remainder <- ColonyInfo %>%
	filter(!(ColonyInfo$`ID NUM` %in% ColonyInfo_FLMAMerged2April2019$ID_NUM))
# find those in ColonyInfo_NWRMerged2April2019
ColonyInfo_NWRMerged2April2019_keep <- ColonyInfo_remainder %>%
	filter(ColonyInfo_remainder$`ID NUM` %in% ColonyInfo_NWRMerged2April2019$ID_NUM)

# get list of ID Numbers still missing
ColonyInfo_remainder %<>%
	filter(!(ColonyInfo_remainder$`ID NUM` %in% ColonyInfo_NWRMerged2April2019$ID_NUM))

# find those in ColonyInfo_WildlifeManagementAreasMerged2April2019

# get list of ID Numbers still missing

# add those from original ColonyInfo file
