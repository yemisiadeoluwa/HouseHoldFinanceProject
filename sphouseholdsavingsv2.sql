/*
Author: Yemisi Adeoluwa
Date: 12/05/2020
Title: Savings for each household
Description: Store procedure for the household Savings
*/

SET ANSI_NULLS ON

GO

SET QUOTED_IDENTIFIER ON

GO


ALTER PROC sp_Household_Savings
 
AS

BEGIN

       SELECT DISTINCT  s.saving_id
						,h.householdmember_id
						,h.surname [Household]
					    ,s.amount
						,sc.savingcategory [Savings Category]
						,s.saving_date [Saving Date]
						,CONVERT(CHAR(8),s.saving_date,4) [Saving Date]
						--,DATENAME (DW, s.saving_date) [Day of Saving]
						--,DATENAME(DD,s.saving_date) [Saving Day]
						--,DATENAME(MM,s.saving_date) [Saving Month]
						,DATENAME(YY,s.saving_date) [Saving Year]

	FROM dbo.Saving s LEFT JOIN dbo.BankAccount ba
	ON s.bankaccount_id_fk = ba.bankaccount_id LEFT JOIN dbo.HouseholdMemberBankAccount hba
    ON hba.bankaccount_id_fk = ba.bankaccount_id LEFT JOIN dbo.HouseholdMember h
    ON h.householdmember_id = hba.householdmember_id_fk LEFT JOIN dbo.SavingCategory sc
    ON sc.savingcategory_id = s.savingcategory_id_fk 

	WHERE CONVERT(CHAR(8),s.saving_date,4) >= '2017-10-03 22:45:07.110 03.10.16'

    --WHERE h.surname = @surname AND s.saving_date = @saving_date
END


