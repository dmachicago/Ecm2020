
--Test Cases
--exec IVP_DataValidation 'view_EDW_RewardUserDetail' ;
--exec IVP_DataValidation 'view_EDW_SmallStepResponses' 
--exec IVP_DataValidation 'view_EDW_Coaches';
--go

GO
PRINT 'Executing C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\IVP_Views.sql ';
GO
PRINT 'Creating procedure IVP_DataValidation';
GO
IF EXISTS (SELECT
				  name
			 FROM sys.procedures
			 WHERE name = 'IVP_DataValidation') 
	BEGIN
		DROP PROCEDURE
			 IVP_DataValidation;
	END;
GO
CREATE PROCEDURE IVP_DataValidation @vname AS nvarchar (250) 
AS

	 --02.23.2015 (WDM) - Started development if the IVP procedure.
	 --02.24.2015 (WDM) - Completed and generated the procedure in the different environments.

	 BEGIN
		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_II')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_II;
			 END;
		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_III')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_III;
			 END;
		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_IV')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_IV;
			 END;
		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_V')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_V;
			 END;
		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_IV')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_IV;
			 END;
		 IF NOT EXISTS (SELECT
							   name
						  FROM sys.views
						  WHERE name = @vname) 
			 BEGIN
				 PRINT '<><><><><><><><><><><><><><><><><><><><><><><><><>';
				 PRINT 'ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ';
				 PRINT '<><><><><><><><><><><><><><><><><><><><><><><><><>';
				 PRINT ' ';
				 PRINT 'ERROR: ' + @vname + ' is missing.';
				 PRINT '<><><><><><><><><><><><><><><><><><><><><><><><><>';
				 RETURN;
			 END;
		 DECLARE @iTotal AS int = 0;
		 DECLARE @mysql AS nvarchar (2000) = '';
		 DECLARE @ProcStartTime AS datetime = GETDATE () ;
		 DECLARE @StartTime AS datetime = GETDATE () ;
		 DECLARE @EndTime AS datetime = GETDATE () ;
		 DECLARE @ETime AS nvarchar (200) = '';
		 DECLARE @CurrSvr nvarchar (250) = (SELECT
												   @@servername) ;
		 DECLARE @CurrDB nvarchar (250) = (SELECT
												  DB_NAME ()) ;
		 SET NOCOUNT ON;

		 --select count(*) as cnt into IVP_Temp_II from view_EDW_SmallStepResponses

		 PRINT '**************************************************************************************';
		 PRINT 'Veryfying Data From: ' + @vname + ' on server ' + @CurrSvr + ' within DB: ' + @CurrDB;
		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_II')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_II;
			 END;

		 --select count(*) as cnt into IVP_Temp_II from view_EDW_Coaches;		

		 SET @mysql = 'select count(*) as cnt into IVP_Temp_II from ' + @vname;
		 EXEC (@mysql) ;
		 DECLARE @rowcount int = (SELECT TOP (1) 
										 cnt
									FROM IVP_Temp_II) ;
		 SET @EndTime = GETDATE () ;

		 --hours over 24, minutes,  seconds, milliseconds

		 SET @ETime = (SELECT
							  CAST (CAST (CAST (@EndTime AS float) - CAST (@StartTime AS float) AS int) * 24 + DATEPART (hh, @EndTime - @StartTime) AS varchar (10)) + ':' + RIGHT ('0' + CAST (DATEPART (mi, @EndTime - @StartTime) AS varchar (2)) , 2) + ':' + RIGHT ('0' + CAST (DATEPART (ss, @EndTime - @StartTime) AS varchar (2)) , 2) + '.' + RIGHT ('0' + CAST (DATEPART (ms, @EndTime - @StartTime) AS varchar (2)) , 2)) ;
		 PRINT 'TOTAL Records in ' + @vname + ': ' + CAST (@rowcount AS nvarchar (50)) + '.';
		 PRINT 'Execution Time: ' + @ETime;

		 --********************************************

		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_III')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_III;
			 END;
		 SET @StartTime = GETDATE () ;
		 SET @mysql = 'select top 100 * into IVP_Temp_III from ' + @vname;
		 EXEC (@mysql) ;
		 SET @EndTime = GETDATE () ;

		 --hours over 24, minutes,  seconds, milliseconds

		 SET @ETime = (SELECT
							  CAST (CAST (CAST (@EndTime AS float) - CAST (@StartTime AS float) AS int) * 24 + DATEPART (hh, @EndTime - @StartTime) AS varchar (10)) + ':' + RIGHT ('0' + CAST (DATEPART (mi, @EndTime - @StartTime) AS varchar (2)) , 2) + ':' + RIGHT ('0' + CAST (DATEPART (ss, @EndTime - @StartTime) AS varchar (2)) , 2) + '.' + RIGHT ('0' + CAST (DATEPART (ms, @EndTime - @StartTime) AS varchar (2)) , 2)) ;
		 PRINT '-------------------';
		 PRINT 'Execution Time to Select 100 Rows into TEMP TABLE: ' + @ETime;

		 --********************************************

		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_IV')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_IV;
			 END;
		 IF @rowcount > 1000
			 BEGIN
				 SET @StartTime = GETDATE () ;
				 SET @mysql = 'select top 1000 * into IVP_Temp_IV from ' + @vname;
				 EXEC (@mysql) ;
				 SET @EndTime = GETDATE () ;

				 --hours over 24, minutes,  seconds, milliseconds

				 SET @ETime = (SELECT
									  CAST (CAST (CAST (@EndTime AS float) - CAST (@StartTime AS float) AS int) * 24 + DATEPART (hh, @EndTime - @StartTime) AS varchar (10)) + ':' + RIGHT ('0' + CAST (DATEPART (mi, @EndTime - @StartTime) AS varchar (2)) , 2) + ':' + RIGHT ('0' + CAST (DATEPART (ss, @EndTime - @StartTime) AS varchar (2)) , 2) + '.' + RIGHT ('0' + CAST (DATEPART (ms, @EndTime - @StartTime) AS varchar (2)) , 2)) ;
				 PRINT '-------------------';
				 PRINT 'Execution Time to Select 1,000 Rows into TEMP TABLE: ' + @ETime;
			 END;

		 --********************************************

		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_V')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_V;
			 END;
		 IF @rowcount > 10000
			 BEGIN
				 SET @StartTime = GETDATE () ;
				 SET @mysql = 'select top 10000 * into IVP_Temp_V from ' + @vname;
				 EXEC (@mysql) ;
				 SET @EndTime = GETDATE () ;

				 --hours over 24, minutes,  seconds, milliseconds

				 SET @ETime = (SELECT
									  CAST (CAST (CAST (@EndTime AS float) - CAST (@StartTime AS float) AS int) * 24 + DATEPART (hh, @EndTime - @StartTime) AS varchar (10)) + ':' + RIGHT ('0' + CAST (DATEPART (mi, @EndTime - @StartTime) AS varchar (2)) , 2) + ':' + RIGHT ('0' + CAST (DATEPART (ss, @EndTime - @StartTime) AS varchar (2)) , 2) + '.' + RIGHT ('0' + CAST (DATEPART (ms, @EndTime - @StartTime) AS varchar (2)) , 2)) ;
				 PRINT '-------------------';
				 PRINT 'Execution Time to Select 10,000 Rows into TEMP TABLE: ' + @ETime;
			 END;

		 --********************************************

		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_IV')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_IV;
			 END;
		 IF @rowcount > 100000
			 BEGIN
				 SET @StartTime = GETDATE () ;
				 SET @mysql = 'select top 100000 * into IVP_Temp_IV from ' + @vname;
				 EXEC (@mysql) ;
				 SET @EndTime = GETDATE () ;

				 --hours over 24, minutes,  seconds, milliseconds

				 SET @ETime = (SELECT
									  CAST (CAST (CAST (@EndTime AS float) - CAST (@StartTime AS float) AS int) * 24 + DATEPART (hh, @EndTime - @StartTime) AS varchar (10)) + ':' + RIGHT ('0' + CAST (DATEPART (mi, @EndTime - @StartTime) AS varchar (2)) , 2) + ':' + RIGHT ('0' + CAST (DATEPART (ss, @EndTime - @StartTime) AS varchar (2)) , 2) + '.' + RIGHT ('0' + CAST (DATEPART (ms, @EndTime - @StartTime) AS varchar (2)) , 2)) ;
				 PRINT '-------------------';
				 PRINT 'Execution Time to Select 100,000 Rows into TEMP TABLE: ' + @ETime;
			 END;
		 PRINT '**************************************************************************************';
		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_II')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_II;
			 END;
		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_III')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_III;
			 END;
		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_IV')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_IV;
			 END;
		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_V')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_V;
			 END;
		 IF EXISTS (SELECT
						   name
					  FROM sysobjects
					  WHERE ID = OBJECT_ID (N'IVP_Temp_IV')) 
			 BEGIN
				 DROP TABLE
					  IVP_Temp_IV;
			 END;
		 SET NOCOUNT OFF;
	 END;
GO
PRINT 'CREATED procedure IVP_DataValidation';
GO