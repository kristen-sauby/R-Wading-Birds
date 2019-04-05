ManagementAreaInfo <- ColonyInfo %>%
	group_by(
		ManagedAreaName,
		ManagedAreaNameAbbr,
		ManagingAgency,
		Owner,
		CoOwners,
		OwnerTypes,
		TotalAcresManagedArea,
		ManagedAreaDescription1,
		ManagedAreaDescription2,
		ManagedAreaComments1,
		ManagedAreaComments2,
		Manager,
		ManagingInstitution,
		ManagerCity,
		ManagerPhone,
		ManagedAreaComments12
	) %>% summarise()


ManagementAreaInfo %>% write.csv("ManagementAreaInfo.csv")