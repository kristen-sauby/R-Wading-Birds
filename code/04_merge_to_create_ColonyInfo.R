
# get lat/long to be the same across records
ColonyInfo_GIS_duplicates_removed$Lat %<>% round(4)
ColonyInfo_GIS_duplicates_removed$Long %<>% round(4)

ColonyInfo$Lat %<>% round(4)
ColonyInfo$Long %<>% round(4)


# then merge and keep all ColonyInfo
ColonyInfo %<>% merge(
	ColonyInfo_GIS_duplicates_removed,
	by.x =c("Lat", "Long", "ColonyIDNumber"),
	by.y =c("Lat", "Long", "ColonyIDNumber"),
	all=T
)

ColonyInfo %>% write.csv("ColonyInfo_merged.csv")