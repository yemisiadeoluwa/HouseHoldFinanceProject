
USE master
GO

/* =============================================
*	Author:				Lanre Adeoluwa
*	Project Name:		OurMicroFinanceDB OLTP Database
*	File Name:			create-database.sql
*	Current Version:	v1.0.3-BETA
*	Create date:		24/11/2018
*	Description: 
						Create OurMicroFinanceDB database if it does not exist.
						But switched to OurMicroFinanceDB database, if it does exist.

*	Change History:
						v1.0.3-BETA: 02/05/2019 Lanre Adeoluwa: Began project collaboration with Yemisi
						v1.0.2-BETA: 02/05/2019 Lanre Adeoluwa: Changed HomeFinanceDB to OurMicroFinance
						v1.0.1-BETA: 04/02/2019 Lanre Adeoluwa: Changed HomeFinance to HomeFinanceDB
						v1.0.0-BETA: 30/11/2018 Lanre Adeoluwa: Created initial database.

-- =============================================*/

IF NOT EXISTS
(
	SELECT name
	FROM master.sys.databases
	WHERE name = N'OurMicroFinanceDB_v_1_0_3_BETA'
)
BEGIN
	CREATE DATABASE OurMicroFinanceDB_v_1_0_3_BETA
	PRINT 'Successfully created OurMicroFinanceDB_v_1_0_3_BETA database'
END

