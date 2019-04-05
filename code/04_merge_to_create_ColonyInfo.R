
# get lat/long to be the same across records
ColonyInfo_GIS_duplicates_removed$Lat %<>% round(6)
ColonyInfo_GIS_duplicates_removed$Long %<>% round(6)

ColonyInfo$Lat %<>% round(6)
ColonyInfo$Long %<>% round(6)


# then merge and keep all ColonyInfo
ColonyInfo %<>% merge(
	ColonyInfo_GIS_duplicates_removed,
	by.x =c("Lat", "Long", "ColonyIDNumber"),
	by.y =c("Lat", "Long", "ColonyIDNumber"),
	all=T
)

# get list of ID Numbers still missing
ColonyInfo_remainder <- ColonyInfo %>%
	filter(!(ColonyInfo$`ID NUM` %in% ColonyInfo_GIS$ID_NUM))

# rbind with GIS data
ColonyInfo_GIS %<>% rbind.fill(ColonyInfo_remainder)




ColonyInfo_GIS %>% write.csv("ColonyInfo_merged.csv")