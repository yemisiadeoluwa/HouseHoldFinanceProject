/*
Author: Yemisi Adeoluwa
Date: 14/05/2020
Title: Income of each household
Description: Store procedure for the household Income
*/

SET ANSI_NULLS ON    
GO

SET QUOTED_IDENTIFIER ON

GO


ALTER PROC sp_Household_Income
 
AS

BEGIN

       SELECT DISTINCT   i.income_id
	                    ,i.net_income
						,h.forename [Household Member]
						,hh.family_name [Family Name]
						,i.income_date [Income Date]
						,ic.category [Income Category]
						,w.country_name [UK Countries]
						,w.city_name [Region]

	FROM dbo.Income i LEFT JOIN dbo.IncomeDescription d
	ON i.incomedescription_id_fk = d.incomedescription_id LEFT JOIN dbo.IncomeCategory ic
	ON ic.incomecategory_id = d.incomecategory_id_fk LEFT JOIN dbo.BankAccount ba
	ON ba.bankaccount_id = i.bankaccount_id_fk LEFT JOIN dbo.HouseholdMemberBankAccount hba
    ON hba.bankaccount_id_fk = ba.bankaccount_id LEFT JOIN dbo.HouseholdMember h
    ON h.householdmember_id = hba.householdmember_id_fk LEFT JOIN dbo.Household  hh
	ON hh.household_id = h.household_id_fk LEFT JOIN dbo.Household HhFM
	ON HhFM.household_id = hh.household_id LEFT JOIN dbo.WorldGeography w
	ON w.worldgeography_id = hh.worldgeography_id_fk
	
	WHERE h.forename IS NOT NULL AND hh.family_name IS NOT NULL

	ORDER BY hh.family_name ASC
	--WHERE i.income_date >= '2017-10-03'

    --WHERE h.surname = @surname AND s.saving_date = @saving_date
END


