
USE OurMicroFinanceDB_v_1_0_3_BETA
GO

/* =============================================
*	Author:				Yemisi Adeoluwa
*	Project Name:		OurMicroFinanceDB OLTP Database
*	File Name:			create-tables.sql
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

create table Gender --done (custom data)
(
		gender_id								tinyint			identity(1,1)
	,	gender									nchar(10)		not null			-- Male, Female, Unknown
	,	constraint pk_gender_id primary key (gender_id)
)
go

create table Frequency  --done (custom data)
(
		frequency_id							tinyint			identity(1,1)
	,	frequency								nvarchar(15)	not null			-- Daily, Weekly, Monthly, Quarterly, Half-Yearly, Yearly, random, one-off
	,	constraint pk_frequency_id primary key (frequency_id)
)
go

create table Occupation  --done (custom data)
(
		occupation_id							smallint		identity(1,1)
	,	occupation_name							nvarchar(50)	not null			-- Student, Developer, Doctor Others etc
	,	constraint pk_occupation_id primary key (occupation_id)
)
go

create table WorldGeography --done  (redgate data generator)

(
		worldgeography_id							int				identity(1,1)
	,	country_name								nvarchar(100)	not null
	,	city_name									nvarchar(100)	not null
	,	country_code								nchar(6)		null
	,	city_code									nchar(6)		null
	,	constraint pk_worldgeography_id primary key (worldgeography_id)
)
go

create table Household  --done  (redgate data generator)
(
		household_id							int				identity(1,1)
	,	family_name								nvarchar(200)	not null
	,	worldgeography_id_fk					int								
	,	constraint pk_household_id primary key (household_id)
	,	constraint fk_household_worldgeography_id_fk foreign key (worldgeography_id_fk) references worldgeography (worldgeography_id)
)
go

create table RoleInFamily  --done
(
		roleinfamily_id							tinyint			identity(1,1)
	,	role_in_family							nvarchar(50)	not null		--Husband, Wife, Son, Spinter, Bachelor etc
	,	constraint  pk_roleinfamily_id primary key (roleinfamily_id)
)

create table HouseholdMember  --done  (redgate data generator)
(
		householdmember_id						int				identity(1,1)
   ,	forename								nvarchar(100)	not null
   ,	surname									nvarchar(100)	not null
   ,	date_of_birth							date			not null
   ,	occupation_id_fk						smallint		not null
   ,	gender_id_fk							tinyint			not null
   ,	roleinfamily_id_fk						tinyint			not null		
   ,	household_id_fk							int				not null	
   ,	constraint pk_householdmember_id primary key (householdmember_id)
   ,	constraint fk_householdmember_occupation_id_fk foreign key(occupation_id_fk) references occupation (occupation_id)
   ,	constraint fk_householdmember_gender_id_fk foreign key(gender_id_fk) references gender(gender_id)
   ,	constraint fk_householdmember_roleinfamily_id_fk foreign key (roleinfamily_id_fk) references roleinfamily (roleinfamily_id)
   ,	constraint fk_householdmember_household_id_fk foreign key (household_id_fk) references household (household_id)
)
go

create table AccountType   --done
(
		accounttype_id							tinyint			identity(1,1)
	,	account_type_name						nvarchar(35)	not null				-- Current, ISA, Savings, Fixed Deposit, Joint Current, Joint Savings etc
	,	constraint pk_accounttype_id primary key (accounttype_id)
)
go

create table BankAccount  --done  (redgate data generator)
(
		bankaccount_id							tinyint			identity(1,1)
	,   bank_name								nvarchar(50)	not null
	,	is_internet_service						bit				not null
	,	is_mobile_banking						bit				not null
	,	is_phone_banking						bit				not null
	,   accounttype_id_fk						tinyint			not null			
	,   constraint pk_bankaccount_id primary key (bankaccount_id)
	,   constraint fk_bankaccount_accounttype_id_fk foreign key(accounttype_id_fk) references accounttype (accounttype_id)
)
go

create table HouseholdMemberBankAccount  --done (Redgate)  -pk?
(
		householdmember_id_fk					int					not null
	,	bankaccount_id_fk						tinyint				not null
	,	constraint pk_householdmemberbankaccount_id primary key (householdmember_id_fk, bankaccount_id_fk)
	,	constraint fk_householdmemberbankaccount_householdmember_id_fk foreign key (householdmember_id_fk) references householdmember (householdmember_id)
	,	constraint fk_householdmemberbankaccount_bankaccount_id_fk foreign key (bankaccount_id_fk) references bankaccount (bankaccount_id) 
)
go

create table Company   --done
(
		company_id							int				identity(1,1)
	,	company_name						nvarchar(350)	not null		/* i.e.  Council, T-Mobile, Scottish Power etc */
	,	constraint pk_company_id primary key(company_id)
)
go

/*	know the date
	know where its setup (BankAccount)
	know if active
	know which company
*/
create table DirectDebits  --done
(
		directdebits_id							int				identity(1,1)
	,	directdebit_payment_date				datetime		not null	
	,	bankaccount_id_fk						tinyint			not null
	,	company_id_fk							int				not null
	,	is_active								bit				not null
	,	constraint pk_directdebits_id primary key (directdebits_id)
	,	constraint fk_directdebits_bankaccount_id_fk foreign key (bankaccount_id_fk) references bankaccount (bankaccount_id)
	,	constraint fk_directdebits_company_id_fk foreign key (company_id_fk) references company (company_id)
)
go

create table Costing  --done
(		
		costing_id								nvarchar(1)			--E or A or I
	,	costing									nvarchar(15)		--Estimate or Actual or Initial Balance
	,	constraint pk_costing_id	primary key (costing_id)
)
go

create table BillType   --done
(
		billtype_id								int				identity(1,1)
	,	bill_type								nvarchar(350)	not null		--whether mobile phone, gas, council etc

	,	constraint pk_billtype_id primary key(billtype_id)
)
go

/*Bill owner is important */
create table Bill         --done (Redgate)
(
		bill_id									int				identity(1,1)
	,   bill_due_date							datetime		not null
	,   company_id_fk							int				not null								
	,   bill_amount								numeric(10,2)	not null
	,	billtype_id_fk							int				not null			--whether mobile phone, gas, council etc
	,	frequency_id_fk							tinyint				not null
	,	is_dd_setup								bit				
	,	dd_date									datetime	
	,	costing_id_fk							nvarchar(1)
	,	directdebits_id_fk						int										
	,   constraint pk_bill_id primary key (bill_id)
	,	constraint fk_bill_company_id_fk foreign key (company_id_fk) references company (company_id)
	,   constraint fk_bill_billtype_id_fk foreign key (billtype_id_fk) references billtype (billtype_id)
	,	constraint fk_bill_frequency_id_fk foreign key (frequency_id_fk) references frequency (frequency_id)
	,	constraint fk_bill_costing_id_fk	foreign key (costing_id_fk) references costing (costing_id)
	,	constraint fk_bill_directdebits_id_fk foreign key (directdebits_id_fk) references directdebits (directdebits_id)
	,	constraint uk_bill_directdebits_id_fk unique (directdebits_id_fk)
)
go

create table HouseholdMemberBill   --done (Redgate)
(
		householdmember_id_fk					int				not null
	,	bill_id_fk								int				not null
	,	constraint pk_householdmemberbill_id primary key (householdmember_id_fk, bill_id_fk)
	,	constraint fk_householdmemberbill_householdmember_id_fk foreign key(householdmember_id_fk) references householdmember (householdmember_id)
	,	constraint fk_householdmemberbill_bill_id_fk foreign key(bill_id_fk) references Bill (bill_id)
)
go

create table DebtPaymentTypeAllowed       --done
(
		debtpaymenttypeallowed_id				nvarchar(1)		not null
	,	debt_Payment_allowed					nvarchar(15)		not null				--instalmental, lump-sum, both
	,	constraint pk_debtpaymenttypeallowed_id primary key (debtpaymenttypeallowed_id)
)
go

--create table DebtRepaymentStatus		--- not started, not active, active

/*	know total value
	date last updated
	is it estimate or actual (button on the app calculates estimate
	know the interest rate (know long to pay off via app)
	company the debt is owed to 
	isFullyPaid bit field
	owner of debt*/
create table Debt   --done (Redgate)
(	
		debt_id									smallint				identity(1,1)
	,	debt_total_value						numeric(10,2)			null
	,	date_debt_taken_out						datetime				not null
	,	debt_term_in_month						int						null				-- 60-month, 30-month, 12-month etc
	,	mandatory_due_debt_payment_date			datetime				null				--Mandatory final due date to pay back all the debt
	,	mandatory_due_debt_set_by				nvarchar(20)			null				-- company or brower or others
	,	is_finished_debt_payment				bit						not null			--checks whether the full debt has been paid back
	,	finished_paid_date						datetime				null				-- date the debt was fully paid back
	,	is_active_debt_repayment				bit						not null			
	,	has_interest_rate						bit						not null
	,	debt_interest_rate						numeric(5,3)			null
	,	company_id_fk							int						null
	,	debtpaymenttypeallowed_id_fk			nvarchar(1)				not null
	,	constraint pk_debt_id primary key (debt_id)
	,	constraint fk_debt_company_id_fk	foreign key (company_id_fk) references company(company_id)
	,	constraint fk_debt_debtpaymenttypeallowed_id_fk foreign key (debtpaymenttypeallowed_id_fk) references debtpaymenttypeallowed (debtpaymenttypeallowed_id)
)
go

create table DebtServicing    --done (Redgate)
(
		debtservicing_id					int						identity(1,1)
	,	debtservice_amount					numeric(10,2)			not null
	,	is_direct_debt_payment				bit						not null
	,	debt_id_fk							smallint				not null
	,	directdebits_id_fk					int						null
	,	constraint pk_debtservicing_id primary key (debtservicing_id)
	,	constraint fk_debtservicing_debt_id_fk foreign key (debt_id_fk) references debt (debt_id)
	,	constraint fk_debtservicing_directdebits_id_fk foreign key (directdebits_id_fk) references directdebits(directdebits_id)
	,	constraint uk_debtservicing_directdebits_id_fk unique (directdebits_id_fk)
)
go

create table DebtBalance   --done (Redgate)
(
		debtbalance_id						int						identity(1,1)
	,	debt_balance_date					datetime				not null
	,	debt_balance_amount					numeric(10,2)			not null
	,	is_fully_paid						bit						null
	,	costing_id_fk						nvarchar(1)				null
	,	debt_id_fk							smallint				not null
	,	constraint pk_debtbalance_id primary key (debtbalance_id)
	,	constraint fk_debtbalance_debt_id_fk foreign key (debt_id_fk) references debt (debt_id)
	,	constraint fk_debtbalance_costing_id_fk	foreign key (costing_id_fk) references costing(costing_id)
)
go

/*
	Bills
	Debt Servicing
	Giving  --tithe, donations, evangelism outreach materials, support evangelism, offering etc
	PersonalDevelopment  ---books, tutorial videos subscriptions
	Entertainment   -- travel, take aways etc
	CarAndHomeMaintainence   -- MOT, Service, car repairs, home maintenance
	Feeding    --
	Transport  --
	Miscellaneous --
*/
create table ExpenseCategory  --  done   --to confirm            --utitlity, insurances, property taxes, vehicle taxes, childcare,  accomodation, debt repayment plan, vehicle maintenance, 
(
		expensecategory_id					smallint				identity(1,1)
	,	category							nvarchar(100)			not null
	,	constraint pk_expensecategory_id primary key (expensecategory_id)
)
go

/*	Saving withdrawals
	*/
create table ExpenseDescription   --done (Redgate) 
(
		expensedescription_id				int						identity(1,1)
	,	expense_description					nvarchar(100)			not null
	,	expensecategory_id_fk				smallint				not null
	,	constraint pk_expensedescription_id primary key (expensedescription_id)
	,	constraint fk_expensedescription_expensecategory_id_fk foreign key (expensecategory_id_fk) references expensecategory (expensecategory_id)
)
go

create table Expense   --done (Redgate) 
(
		expense_id							int						identity(1,1)
	,	expense_date						datetime
	,	costing_id_fk						nvarchar(1)
	,	amount								numeric(10,2)
	,	expensedescription_id_fk			int
	,	note								nvarchar(100)				null
	,	constraint pk_expense_id primary key (expense_id)
	,	constraint fk_expense_costing_id_fk foreign key (costing_id_fk) references costing(costing_id)
	,	constraint fk_expense_expensedescription_id_fk foreign key (expensedescription_id_fk) references expensedescription(expensedescription_id)
)
go

create table IncomePaymentMethod   --done
(
		incomepaymentmethod_id					int				identity(1,1)
	,	income_method							nvarchar(200)	not null
	,	constraint pk_incomepaymentmethod_id primary key (incomepaymentmethod_id)
)
go

/*
	SALARY
	BUSINESS
	OTHER
*/
create table IncomeCategory  --done (Redgate) 
(
		incomecategory_id					smallint				identity(1,1)
	,	category							nvarchar(100)			not null
	,	constraint pk_incomecategory_id primary key (incomecategory_id)
)
go

/*	
	Yoga Tablet sale
*/
create table IncomeDescription  --done (Redgate) 
(
		incomedescription_id				smallint						identity(1,1)
	,	income_description					nvarchar(100)			not null
	,	incomecategory_id_fk				smallint				not null
	,	constraint pk_incomedescription_id primary key (incomedescription_id)
	,	constraint fk_incomedescription_incomecategory_id_fk foreign key (incomecategory_id_fk) references incomecategory (incomecategory_id)
)
go

create table Income --done (Redgate) 
(
		income_id								int				identity(1,1)
	,   income_date								date			not null
	,   net_income								numeric(10,2)	not null
	,	bankaccount_id_fk						tinyint				null
	,	incomedescription_id_fk					smallint		not null
	,   frequency_id_fk							tinyint			not null			--whether daily, weekly, one off etc
	,   incomepaymentmethod_id_fk				int				not null			--whether, cash, bacs, cheque etc
	,	note									nvarchar(100)		null
	,	constraint pk_income_id primary key (income_id)
	,	constraint fk_income_bankaccount_id_fk foreign key (bankaccount_id_fk) references bankaccount(bankaccount_id)
	,	constraint fk_income_incomedescription_id_fk foreign key (incomedescription_id_fk) references incomedescription (incomedescription_id)
	,	constraint fk_income_frequency_id_fk foreign key (frequency_id_fk) references frequency (frequency_id)
	,	constraint fk_income_incomepaymentmethod_id_fk foreign key (incomepaymentmethod_id_fk) references incomepaymentmethod (incomepaymentmethod_id)
)
go

create table SavingCategory  --done (Redgate) 
(
		savingcategory_id						tinyint			identity(1,1)
	,	savingcategory							nvarchar(50)	not null
	,	constraint pk_savingcategory_id primary key (savingcategory_id)
)
go

create table Saving  --done (Redgate)
(
		saving_id								int				identity(1,1)
	,	saving_date								datetime
	,	bankaccount_id_fk						tinyint
	,	costing_id_fk							nvarchar(1)
	,	savingcategory_id_fk					tinyint
	,	amount									numeric(10,2)
	,	note									nvarchar(100)	null
	,	constraint pk_saving_id	primary key (saving_id)
	,	constraint fk_saving_bankaccount_id_fk	foreign key (bankaccount_id_fk) references bankaccount (bankaccount_id)
	,	constraint fk_saving_costing_id_fk foreign key (costing_id_fk) references costing (costing_id)
	,	constraint fk_saving_savingcategory_id foreign key (savingcategory_id_fk) references savingcategory (savingcategory_id)
)
go

create table HouseholdMemberIncome  --done (Redgate)
(
		householdmember_id_fk					int				not null
	,	income_id_fk							int				not null
	,	constraint pk_householdmemberincome_id primary key (householdmember_id_fk, income_id_fk)
	,	constraint fk_householdmemberincome_householdmember_id_fk foreign key(householdmember_id_fk) references householdmember (householdmember_id)
	,	constraint fk_householdmemberincome_income_id_fk foreign key(income_id_fk) references income (income_id)
)
go

create table HouseholdMemberExpense  --done (Redgate)
(
		householdmember_id_fk					int				not null
	,	expense_id_fk							int				not null
	,	constraint pk_householdmemberexpense_id primary key (householdmember_id_fk, expense_id_fk)
	,	constraint fk_householdmemberexpense_householdmember_id_fk foreign key(householdmember_id_fk) references householdmember (householdmember_id)
	,	constraint fk_householdmemberexpense_expense_id_fk foreign key(expense_id_fk) references expense (expense_id)
)
go

create table HouseholdMemberDebt   --done (Redgate)
(
		householdmember_id_fk					int				not null
	,	debt_id_fk								smallint		not null
	,	constraint pk_householdmemberdebt_id primary key (householdmember_id_fk, debt_id_fk)
	,	constraint fk_householdmemberdebt_householdmember_id_fk foreign key(householdmember_id_fk) references householdmember (householdmember_id)
	,	constraint fk_householdmemberdebt_debt_id_fk foreign key(debt_id_fk) references debt (debt_id)
)
go
 