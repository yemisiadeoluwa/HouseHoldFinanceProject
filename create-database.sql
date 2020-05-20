
USE master
GO

/* =============================================
*	Author:				Yemisi Adeoluwa
*	Project Name:		OurMicroFinanceDB OLTP Database
*	File Name:			create-database.sql
*	Current Version:	v1.0.3-BETA
*	Create date:		24/11/2018
*	Description: 
						Create OurMicroFinanceDB database if it does not exist.
						But switched to OurMicroFinanceDB database, if it does exist.

*	

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

