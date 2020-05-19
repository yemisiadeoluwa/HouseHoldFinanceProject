/*
Author: Yemisi Adeoluwa
Date: 11/05/2020
Title: Store procedure script to find the top 10 householdmember with the highest income
Description: finding the top 10 household member with the highest income 

*/
--this first query would show the fullname of the householdmember and the count of the income
SET ANSI_NULLS ON

GO

SET QUOTED_IDENTIFIER ON

GO

ALTER PROC TOP_10_HouseholdMember_Income
AS 
SELECT TOP 10
		    i.net_income [Net Income]
			,h.surname [Family Name]
		   ,h.forename + ' ' + h.surname [House Hold Member]
		   ,r.role_in_family [Family Member Role]
		   
FROM RoleInFamily r
LEFT JOIN HouseholdMember h
ON r.roleinfamily_id= h.householdmember_id
LEFT JOIN Income i
ON i.income_id = h.householdmember_id

GROUP BY i.income_id
		   ,i.net_income
		   ,h.forename + ' ' + h.surname
		   ,r.role_in_family
		   ,h.surname

ORDER BY COUNT(*)



