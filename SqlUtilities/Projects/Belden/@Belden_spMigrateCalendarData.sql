
--UPDATE_DTTM
/*
1 - Create a MIRROR table, DM_F_SALES_SUMMARY, in Smart.
2 - Modify SSIS package to use UPDATE_DTTM and not rebuild, but update DM_F_SALES_SUMMARY
	based on the last update timestamp.
3 - Write an SSIS package to pull data from table DM_F_SALES_SUMMARY in SMART_GLOBAL_DW
	and either ADD or update the data in SMART
4 - In the case of update, we will need to add a GUID to DM_F_SALES_SUMMARY
	and use it in tandem with the UPDATE_DTTM column
5 - Apply the same approach as above to DM_D_CALENDAR
6 - Create Both tables within SMART and pull the data on a schedule based on the MAX(UPDATE_DTTM)
	in SMART.DM_F_SALES_SUMMARY and SMART.DM_D_CALENDAR
7 - Apply SSIS lookup logic and insert or update as needed.	
*/

/*
ALTER TABLE DM_D_CALENDAR
ADD RowGuid uniqueidentifier
CONSTRAINT DM_D_CALENDAR_RowGuid DEFAULT NewId() NOT NULL
*/

--3,434,080,000 Bytes
/*
ALTER TABLE DM_F_SALES_SUMMARY
ADD RowGuid uniqueidentifier
CONSTRAINT DM_F_SALES_SUMMARY_RowGuid DEFAULT NewId() NOT NULL
*/

--select count(*) from dbo.DM_D_CALENDAR

create Procedure spMigrateCalendarData
as
begin
	ALTER TABLE dbo.DM_L_RAW_MAT_PRICE DROP CONSTRAINT [R_18] ;

	truncate TABLE DBO.DM_D_CALENDAR ;

	INSERT INTO DBO.DM_D_CALENDAR
	SELECT *
	FROM SMART_GLOBAL_DW.dbo.DM_D_CALENDAR ;

	ALTER TABLE [dbo].[DM_L_RAW_MAT_PRICE]  WITH CHECK ADD  CONSTRAINT [R_18] FOREIGN KEY([TIME_KEY])
	REFERENCES [dbo].[DM_D_CALENDAR] ([TIME_KEY]);

	ALTER TABLE [dbo].[DM_L_RAW_MAT_PRICE] CHECK CONSTRAINT [R_18] ;

end
--select * From DBO.DM_D_CALENDAR
--exec spMigrateCalendarData

/*
ALTER TABLE DM_F_SALES_SUMMARY
ADD RowGuid uniqueidentifier
CONSTRAINT DM_F_SALES_SUMMARY_RowGuid DEFAULT NewId() NOT NULL
GO

CREATE NONCLUSTERED INDEX [PI01_DM_F_SALES_SUMMARY] ON [dbo].[DM_F_SALES_SUMMARY] 
(
	[RowGuid] ASC,
	[UPDATE_DTTM] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
*/