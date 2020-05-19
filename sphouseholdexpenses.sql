/*
Author: Yemisi Adeoluwa
Date: 11/05/2020
Title: Expenses for each household
Description: Store procedure for the household expenses
*/

SET ANSI_NULLS ON

GO

SET QUOTED_IDENTIFIER ON

GO


ALTER PROC sp_Household_Expenses
AS

SELECT  e.expense_id
       ,h.householdmember_id
       ,h.surname [Household]
	   ,e.amount 
	   ,e.expense_date
	   ,ec.category
	   ,CONVERT(CHAR(8),e.expense_date,4) [Expense Date]
	   ,DATENAME (DW, e.expense_date) [Day of Expense]
	   ,DATENAME(DD,e.expense_date) [Expense Day]
	   ,DATENAME(MM,e.expense_date) [Expense Month]
	   ,DATENAME(YY,e.expense_date) [Expense Year]

FROM dbo.Expense e LEFT JOIN dbo.HouseholdMemberExpense he
ON e.expense_id = he.expense_id_fk LEFT JOIN dbo.HouseholdMember h
ON h.householdmember_id = he.householdmember_id_fk LEFT JOIN ExpenseDescription ed
ON ed.expensedescription_id = e.expensedescription_id_fk LEFT JOIN dbo.ExpenseCategory ec
ON ec.expensecategory_id = ed.expensecategory_id_fk

WHERE e.expense_date >= '2016-06-15 08:56:27.600'
--WHERE h.surname = 'Gordon'


