/*
Author: Yemisi Adeoluwa
Date: 16/05/2020
Title: Household information
Description: Store procedure for the household details
*/

SET ANSI_NULLS ON

GO

SET QUOTED_IDENTIFIER ON

GO


CREATE PROC sp_Household_Details
 
AS

BEGIN

       SELECT DISTINCT 	 h.forename [Household Member]
						,hh.family_name [Family Name]
						,w.country_name [UK Countries]
						,w.city_name [Region]

	FROM dbo.HouseholdMember h LEFT JOIN dbo.Household  hh
	ON h.household_id_fk =  hh.household_id LEFT JOIN dbo.Household HhFM
	ON HhFM.household_id = hh.household_id LEFT JOIN dbo.WorldGeography w
	ON w.worldgeography_id = hh.worldgeography_id_fk
	
	WHERE h.forename IS NOT NULL AND hh.family_name IS NOT NULL

	ORDER BY hh.family_name ASC
	--WHERE i.income_date >= '2017-10-03'

    --WHERE h.surname = @surname AND s.saving_date = @saving_date
END


