PRINT GETDATE () ;
SELECT
	  COUNT (*) 
   FROM [view_EDW_HealthAssesmentALL]
   WHERE [CHANGED_FLG] IS NOT NULL;

/******************************
03.23.2015 P3 / 31:39 / 32 rows
*/

PRINT GETDATE () ;
PRINT GETDATE () ;
SELECT
	  COUNT (*) 
   FROM [view_EDW_HealthAssesmentALL]
   WHERE [CHANGED_FLG] IS NULL;

/***********************************
03.23.2015 P3 / 31:55 / 5697805 rows
*/

PRINT GETDATE () ;
PRINT GETDATE () ;
SELECT
	  COUNT (*) 
   FROM [view_EDW_HealthAssesmentALL];

/***********************************
03.23.2015 P3 / 22:48 / 5697837 rows
*/

PRINT GETDATE () ;
IF EXISTS (SELECT
			   [name]
		    FROM [tempdb].[dbo].[sysobjects]
		    WHERE [id] = OBJECT_ID (N'tempdb..#temp_EDW_HA_changedData')) 
    BEGIN
	   PRINT 'Dropping #temp_EDW_HA_changedData';
	   DROP TABLE
		   [#temp_EDW_HA_changedData];

    END;

SELECT
	  *
INTO
	[#temp_EDW_HA_changedData]
   FROM [view_EDW_HealthAssesmentALL]
   WHERE [CHANGED_FLG] IS NOT NULL; 
PRINT GETDATE () ;
select * from [#temp_EDW_HA_changedData];
PRINT GETDATE () ;

