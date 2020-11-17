use KenticoCMS_Client
go

/************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************
 ------------------------------------------------------------

DESCRIPTION: Schema Synchronization Script for Object(s) \r\n
    views:
        [dbo].[view_EDW_Awards], [dbo].[view_EDW_BioMetrics], [dbo].[view_EDW_BiometricViewRejectCriteria], [dbo].[view_EDW_ClientCompany], [dbo].[view_EDW_Coaches], [dbo].[view_EDW_CoachingDefinition], [dbo].[view_EDW_CoachingDetail], [dbo].[view_EDW_EDW_TEST_DEL_DelAudit], [dbo].[view_EDW_Eligibility], [dbo].[view_EDW_EligibilityHistory], [dbo].[view_EDW_HealthAssesment], [dbo].[View_EDW_HealthAssesmentAnswers], [dbo].[view_EDW_HealthAssesmentClientView], [dbo].[view_EDW_HealthAssesmentDeffinition], [dbo].[view_EDW_HealthAssesmentDeffinitionCustom], [dbo].[View_EDW_HealthAssesmentQuestions], [dbo].[view_EDW_HealthAssessment_Staged], [dbo].[view_EDW_HealthAssessmentDefinition_Staged], [dbo].[view_EDW_HealthInterestDetail], [dbo].[view_EDW_HealthInterestList], [dbo].[view_EDW_Participant], [dbo].[view_EDW_RewardAwardDetail], [dbo].[View_EDW_RewardProgram_Joined], [dbo].[view_EDW_RewardsDefinition], [dbo].[view_EDW_RewardTriggerParameters], [dbo].[view_EDW_RewardUserDetail], [dbo].[view_EDW_RewardUserLevel], [dbo].[view_EDW_ScreeningsFromTrackers], [dbo].[view_EDW_SmallStepResponses], [dbo].[view_EDW_TrackerCompositeDetails], [dbo].[view_EDW_TrackerMetadata], [dbo].[view_EDW_TrackerShots], [dbo].[view_EDW_TrackerTests]

    procedures:
        [dbo].[IVP_DataValidation], [dbo].[proc_AddRejectMPI], [dbo].[Proc_Attach_Delete_Audit], [dbo].[proc_build_EDW_Eligibility], [dbo].[proc_Delete_EDW_BiometricViewRejectCriteria_Acct], [dbo].[proc_Delete_EDW_BiometricViewRejectCriteria_Site], [dbo].[proc_DelRejectMPI], [dbo].[Proc_EDW_Compare_MASTER], [dbo].[Proc_EDW_Compare_Tables], [dbo].[Proc_EDW_Compare_Views], [dbo].[proc_EDW_EligibilityDaily], [dbo].[proc_EDW_EligibilityExpired], [dbo].[proc_EDW_EligibilityStarted], [dbo].[Proc_EDW_GenerateMetadata], [dbo].[Proc_EDW_HealthAssessmentDefinition], [dbo].[proc_EDW_MeasurePerf], [dbo].[Proc_EDW_RewardUserDetail], [dbo].[Proc_EDW_TrackerMetadataExtract], [dbo].[proc_GetRecordCount], [dbo].[proc_Insert_EDW_BiometricViewRejectCriteria], [dbo].[sp_SchemaMonitorReport], [dbo].[UTIL_CalcPctNullDataInTable], [dbo].[UTIL_FindTablesInViews], [dbo].[UTIL_FindViewBaseColumns], [dbo].[UTIL_GenIndexRebuildStmts], [dbo].[UTIL_GenIndexReOrgStmts], [dbo].[UTIL_GenUpdateTableStats], [dbo].[UTIL_getUsageCount], [dbo].[UTIL_ListAllForeignKeyRelationships], [dbo].[UTIL_ListCurrentWaits], [dbo].[UTIL_SearchAllTables], [dbo].[UTIL_ViewAnalysis], [dbo].[UTILSearchAllTables], [dbo].[wdmViewAnalysis]

    functions:
        [dbo].[udfElapsedTime], [dbo].[udfGetCurrentIP], [dbo].[udfTimeSpanFromMilliSeconds]

    ddl triggers:
        [trgSchemaMonitor]

     Make hfit-tgt.cloudapp.net,2.KenticoCMS_Client Equal hfit-sqlqa.cloudapp.net, 1 = GREEN (QA).KenticoCMS_QA

   AUTHOR:	[Insert author name]

   DATE:	2/25/2015 3:06:44 PM

   LEGAL:	2014 [Insert company name]

   ------------------------------------------------------------ 
************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************/

SET NOEXEC OFF;
SET ANSI_WARNINGS ON;
SET XACT_ABORT ON;
SET IMPLICIT_TRANSACTIONS OFF;
SET ARITHABORT ON;
SET NOCOUNT ON;
SET QUOTED_IDENTIFIER ON;
SET NUMERIC_ROUNDABORT OFF;
SET CONCAT_NULL_YIELDS_NULL ON;
SET ANSI_NULLS ON;
SET ANSI_PADDING ON;
GO
USE [KenticoCMS_Client];
GO
BEGIN TRAN;
GO
REVOKE SELECT ON dbo.view_EDW_HealthAssesmentDeffinitionCustom TO [EDWReader_PRD];
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
REVOKE SELECT ON dbo.view_EDW_HealthAssesmentDeffinition TO [EDWReader_PRD];
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
REVOKE SELECT ON dbo.view_EDW_HealthAssesment TO [EDWReader_PRD];
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO


-- Create Function [dbo].[udfTimeSpanFromMilliSeconds]

PRINT 'Create Function [dbo].[udfTimeSpanFromMilliSeconds]';
GO

--DECLARE @ElapsedS INT
--declare @start_date datetime = getdate() ;
--declare @end_date  datetime = getdate() ;
--SET @ElapsedS = DATEDIFF(ms, @start_date, @end_date)
--SELECT TimeSpan = dbo.udfTimeSpanFromMilliSeconds(@ElapsedS)
--go

CREATE FUNCTION dbo.udfTimeSpanFromMilliSeconds (@milliSecs int) 
RETURNS varchar (20) 
AS
	 BEGIN

		 --**********************************************************************
		 --Author: W. Dale Miller / June 12, 2008
		 --USE:
		 --DECLARE @ElapsedS INT
		 --declare @start_date datetime = getdate() ;
		 --declare @end_date  datetime = getdate() ;
		 --SET @ElapsedS = DATEDIFF(ms, @start_date, @end_date)
		 --SELECT TimeSpan = dbo.udfTimeSpanFromMilliSeconds(@ElapsedS)
		 --**********************************************************************

		 DECLARE @DisplayTime varchar (50) 
			   , @Seconds int

				 --Variable to hold our result

			   , @DHMS varchar (15) 

				 --Integers for doing the math

			   , @MS int
			   , @Days int

				 --Integer days

			   , @Hours int

				 --Integer hours

			   , @Minutes int

				 --Integer minutes
				 --Strings for providing the display : Unused presently

			   , @sDays varchar (5) 

				 --String days

			   , @sHours varchar (2) 

				 --String hours

			   , @sMinutes varchar (2) 

				 --String minutes

			   , @sSeconds varchar (2) ;

		 --String seconds

		 SET @Minutes = 0;
		 SET @MS = 0;
		 SET @Hours = 0;

		 --set @milliSecs = 111071120;
		 --print (@milliSecs)
		 --Get the values using modulos where appropriate

		 SET @Seconds = @milliSecs / 1000;

		 --print (@Seconds ) ;

		 IF @Seconds > 59
			 BEGIN
				 SET @Minutes = @Seconds / 60;
				 SET @Seconds = @Seconds - @Minutes * 60;
			 END;
		 ELSE
			 BEGIN
				 SET @Minutes = 0;
			 END;
		 IF @Minutes > 59
			 BEGIN
				 SET @Hours = @Minutes / 60;
				 SET @Minutes = @Minutes - @Seconds * 60;
			 END;
		 ELSE
			 BEGIN
				 SET @Hours = 0;
			 END;
		 IF @Hours > 24
			 BEGIN
				 SET @Days = @Hours / 24;
				 SET @Hours = @Hours - @Minutes * 60;
			 END;
		 ELSE
			 BEGIN
				 SET @Days = 0;
			 END;
		 SET @milliSecs = @milliSecs % 1000;
		 SET @DisplayTime = CAST (@Days AS varchar (50)) + ':' + CAST (@Hours AS varchar (50)) + ':' + CAST (@Minutes AS varchar (50)) + ':' + CAST (@Seconds AS varchar (50)) + '.' + CAST (@milliSecs AS varchar (50)) ;

		 --print (@DisplayTime );

		 RETURN @DisplayTime;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Function [dbo].[udfGetCurrentIP]

PRINT 'Create Function [dbo].[udfGetCurrentIP]';
GO
CREATE FUNCTION dbo.udfGetCurrentIP () 
RETURNS varchar (255) 
AS
	 BEGIN

		 --*********************************************************
		 --WDM 03.21.2009 Get the IP address of the current client.
		 --Used to track a DBA/Developer IP address when change is 
		 --applied to a table or view.
		 --*********************************************************

		 DECLARE @IP_Address varchar (254) ;
		 SELECT
				@IP_Address = client_net_address
		   FROM sys.dm_exec_connections
		   WHERE Session_id = @@SPID;
		 RETURN @IP_Address;
	 END;

--Same as above
--SELECT CONVERT(char(15), CONNECTIONPROPERTY('client_net_address'))

GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Function [dbo].[udfElapsedTime]

PRINT 'Create Function [dbo].[udfElapsedTime]';
GO

--DECLARE @ElapsedS INT
--declare @start_date datetime = getdate() ;
--declare @end_date  datetime = getdate() ;
--SET @ElapsedS = DATEDIFF(ms, @start_date, @end_date)
--SELECT TimeSpan = dbo.udfTimeSpanFromMilliSeconds(@ElapsedS)
--go

CREATE FUNCTION dbo.udfElapsedTime (@StartTime AS datetime
								  , @EndTime AS datetime) 
RETURNS varchar (25) 
AS
	 BEGIN

		 --**********************************************************************
		 --Author: W. Dale Miller / June 12, 2008
		 --USE:
		 --DECLARE @ElapsedS INT
		 --declare @StartTime datetime = getdate() ;
		 --declare @EndTime  datetime = getdate() ;
		 --SET @ElapsedS = DATEDIFF(ms, @start_date, @end_date)
		 --SELECT TimeSpan = dbo.udfElapsedTime(@StartTime, @EndTime)
		 --**********************************************************************

		 DECLARE @milliSecs int
			   , @DisplayTime varchar (50) 
			   , @Seconds int

				 --Variable to hold our result

			   , @DHMS varchar (15) 

				 --Integers for doing the math

			   , @MS int
			   , @Days int

				 --Integer days

			   , @Hours int

				 --Integer hours

			   , @Minutes int

				 --Integer minutes
				 --Strings for providing the display : Unused presently

			   , @sDays varchar (5) 

				 --String days

			   , @sHours varchar (2) 

				 --String hours

			   , @sMinutes varchar (2) 

				 --String minutes

			   , @sSeconds varchar (2) ;

		 --String seconds

		 SET @milliSecs = (SELECT
								  DATEDIFF (millisecond, @StartTime, @EndTime)) ;
		 SET @Minutes = 0;
		 SET @MS = 0;
		 SET @Hours = 0;

		 --set @milliSecs = 111071120;
		 --print (@milliSecs)
		 --Get the values using modulos where appropriate

		 SET @Seconds = @milliSecs / 1000;

		 --print (@Seconds ) ;

		 IF @Seconds > 59
			 BEGIN
				 SET @Minutes = @Seconds / 60;
				 SET @Seconds = @Seconds - @Minutes * 60;
			 END;
		 ELSE
			 BEGIN
				 SET @Minutes = 0;
			 END;
		 IF @Minutes > 59
			 BEGIN
				 SET @Hours = @Minutes / 60;
				 SET @Minutes = @Minutes - @Seconds * 60;
			 END;
		 ELSE
			 BEGIN
				 SET @Hours = 0;
			 END;
		 IF @Hours > 24
			 BEGIN
				 SET @Days = @Hours / 24;
				 SET @Hours = @Hours - @Minutes * 60;
			 END;
		 ELSE
			 BEGIN
				 SET @Days = 0;
			 END;
		 SET @milliSecs = @milliSecs % 1000;
		 SET @DisplayTime = CAST (@Days AS varchar (50)) + ':' + CAST (@Hours AS varchar (50)) + ':' + CAST (@Minutes AS varchar (50)) + ':' + CAST (@Seconds AS varchar (50)) + '.' + CAST (@milliSecs AS varchar (50)) ;

		 --print (@DisplayTime );

		 RETURN @DisplayTime;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[UTIL_ViewAnalysis]

PRINT 'Create Procedure [dbo].[UTIL_ViewAnalysis]';
GO
CREATE PROCEDURE dbo.UTIL_ViewAnalysis @TargetView nvarchar (80) 
AS
	 BEGIN

		 ----------------------------------------------------------------------------
		 -- Analyze Nested Views - they will sooner or later cause great pain.
		 -- Created: 7/26/2008
		 -- DMA Limited, Chicago, IL
		 -- W. Dale Miller
		 -- dm@DmaChicago.com
		 ----------------------------------------------------------------------------
		 -- Create a temp table to hold the combination view/table hierarchy

		 IF EXISTS (SELECT
						   name
					  FROM tempdb.dbo.sysobjects
					  WHERE ID = OBJECT_ID (N'tempdb..#NestedViews')) 
			 BEGIN
				 DROP TABLE
					  #NestedViews;
			 END;
		 CREATE TABLE #NestedViews (
					  id int IDENTITY (1, 1) 
					, parent_view_id int
					, referenced_schema_name nvarchar (255) 
					, referenced_entity_name nvarchar (255) 
					, join_clause nvarchar (max) 
					, LEVEL tinyint
					, lineage nvarchar (max)) ;
		 DECLARE @viewname nvarchar (1000) 
			   , @count int
			   ,

				 -- Current ID

				 @maxCount int;

		 -- Max ID of the temp table
		 -- Set the name of the view you want to analyze
		 -- This is generally the TOP Level View, but can be one that is contained within another.

		 SELECT
				@viewName = @TargetView
			  , @count = 1;

		 ----------------------------------------------------------------------------
		 -- Seed the table with the root view, and the root view's referenced tables.
		 ----------------------------------------------------------------------------

		 INSERT INTO #NestedViews
		 SELECT
				NULL AS parent_view_id
			  , 'dbo' AS referenced_schema_name
			  , @viewName AS referenced_entity_name
			  , NULL AS join_clause
			  , 0 AS LEVEL
			  , '/' AS lineage;
		 INSERT INTO #NestedViews
		 SELECT DISTINCT
				@count AS parent_view_id
			  , referenced_schema_name
			  , referenced_entity_name
			  , '' AS join_clause
			  , 1 AS LEVEL
			  , '/1/' AS lineage
		   FROM sys.dm_sql_referenced_entities (N'dbo.' + @viewName, 'OBJECT') ;
		 SELECT
				@maxCount = MAX (id) 
		   FROM #NestedViews;

		 ----------------------------------------------------------------------------
		 -- Loop through the nested views and process ALL rows.
		 ----------------------------------------------------------------------------

		 WHILE @count < @maxCount
			 BEGIN
				 SELECT
						@count = @count + 1;

				 -- Get the name of the current view (that one of interest where references are desired)

				 SELECT
						@viewName = referenced_entity_name
				   FROM #NestedViews
				   WHERE id = @count;

				 -- If it's a view (not a table), insert referenced objects into temp table.

				 IF EXISTS (SELECT
								   name
							  FROM sys.objects
							  WHERE name = @viewName
								AND TYPE = 'v') 
					 BEGIN
						 INSERT INTO #NestedViews
						 SELECT DISTINCT
								@count AS parent_view_id
							  , referenced_schema_name
							  , referenced_entity_name
							  , '' AS join_clause
							  , NULL AS LEVEL
							  , '' AS lineage
						   FROM sys.dm_sql_referenced_entities (N'dbo.' + @viewName, 'OBJECT') ;
						 SELECT
								@maxCount = MAX (id) 
						   FROM #NestedViews;
					 END;
			 END;

		 --------------------------------------
		 --------------------------------------

		 WHILE EXISTS (SELECT
							  1
						 FROM #NestedViews
						 WHERE LEVEL IS NULL) 
			 UPDATE NVHL2
			 SET
				 NVHL2.Level = NVHL1.Level + 1
			   ,
				 NVHL2.Lineage = NVHL1.Lineage + LTRIM (STR (NVHL2.parent_view_id, 6, 0)) + '/'
			   FROM #NestedViews AS NVHL2
						INNER JOIN #NestedViews AS NVHL1
							ON NVHL2.parent_view_id = NVHL1.ID
			   WHERE
					 NVHL1.Level >= 0
				 AND NVHL1.Lineage IS NOT NULL
				 AND NVHL2.Level IS NULL;
		 SELECT
				parent.*
			  , child.id
			  , child.referenced_entity_name AS ChildName
		   FROM #NestedViews AS parent
					RIGHT OUTER JOIN #NestedViews AS child
						ON child.parent_view_id = parent.id
		   ORDER BY
					parent.id, child.id;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[UTIL_GenIndexReOrgStmts]

PRINT 'Create Procedure [dbo].[UTIL_GenIndexReOrgStmts]';
GO
CREATE PROC dbo.UTIL_GenIndexReOrgStmts
AS
	 BEGIN
		 SELECT
				'Alter Index ' + SI.name + ' ON ' + OBJECT_NAME (IPS.object_id) + ' REORGANIZE; ' AS CMD
			  , IPS.Index_type_desc
			  , IPS.avg_fragmentation_in_percent
			  , IPS.avg_fragment_size_in_pages
			  , CAST (IPS.avg_page_space_used_in_percent AS decimal (5, 2)) AS avg_page_space_used_in_percent
			  , IPS.record_count
			  , IPS.ghost_record_count
			  , IPS.fragment_count
			  , IPS.avg_fragment_size_in_pages
		   FROM sys.dm_db_index_physical_stats (DB_ID (N'DEV') , NULL, NULL, NULL, 'DETAILED') AS IPS
					JOIN sys.tables AS ST WITH (nolock) 
						ON IPS.object_id = ST.object_id
					JOIN sys.indexes AS SI WITH (nolock) 
						ON IPS.object_id = SI.object_id
					   AND IPS.index_id = SI.index_id
		   WHERE ST.is_ms_shipped = 0
			 AND IPS.avg_fragmentation_in_percent >= 10
			 AND IPS.avg_fragmentation_in_percent < 40
		   ORDER BY
					IPS.avg_fragmentation_in_percent DESC;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[UTIL_GenUpdateTableStats]

PRINT 'Create Procedure [dbo].[UTIL_GenUpdateTableStats]';
GO
CREATE PROC dbo.UTIL_GenUpdateTableStats
AS
	 BEGIN
		 SELECT
				'UPDATE STATISTICS ' + name + ' WITH FULLSCAN, ALL'
		   FROM sys.tables
		   WHERE type = 'u';
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[UTIL_FindViewBaseColumns]

PRINT 'Create Procedure [dbo].[UTIL_FindViewBaseColumns]';
GO
CREATE PROC dbo.UTIL_FindViewBaseColumns @SchemaName nvarchar (50) 
									   , @VIEWNAME nvarchar (80) 
AS
	 BEGIN

		 --*********************************************************************
		 --W. Dale Miller - find the associated table columns used within a view
		 --July 2005 - Developed to decompress nested views
		 --USE: exec wdmFindViewBaseColumns 'dbo', 'view_EDW_HealthAssesment'
		 --*********************************************************************

		 SELECT
				cu.VIEW_NAME
			  , c.TABLE_NAME
			  , c.COLUMN_NAME
			  , c.DATA_TYPE
			  , c.IS_NULLABLE
		   FROM INFORMATION_SCHEMA.VIEW_COLUMN_USAGE AS cu
					JOIN INFORMATION_SCHEMA.COLUMNS AS c
						ON c.TABLE_SCHEMA = cu.TABLE_SCHEMA
					   AND c.TABLE_CATALOG = cu.TABLE_CATALOG
					   AND c.TABLE_NAME = cu.TABLE_NAME
					   AND c.COLUMN_NAME = cu.COLUMN_NAME
		   WHERE cu.VIEW_NAME = @VIEWNAME
			 AND cu.VIEW_SCHEMA = @SchemaName;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[UTIL_GenIndexRebuildStmts]

PRINT 'Create Procedure [dbo].[UTIL_GenIndexRebuildStmts]';
GO
CREATE PROC dbo.UTIL_GenIndexRebuildStmts
AS
	 BEGIN

		 --If an index is very small (I believe less than 8 pages) it will use mixed extents. 
		 --Therefore, it'll appear as if there is still fragmentation remaining, as the housing 
		 --extent will contain pages from multiple indexes.
		 --Because of this, and also the fact that in such a small index that fragmentation is 
		 --typically negligable, you really should only be rebuilding indexes with a certain page 
		 --threshold. It is best practices to rebuild fragmented indexes that are a minimum of 1000 pages.

		 SELECT
				'Alter Index ' + SI.name + ' ON ' + OBJECT_NAME (IPS.object_id) + ' REBUILD; ' AS CMD
			  , IPS.Index_type_desc
			  , IPS.avg_fragmentation_in_percent
			  , IPS.avg_fragment_size_in_pages
			  , CAST (IPS.avg_page_space_used_in_percent AS decimal (5, 2)) AS avg_page_space_used_in_percent
			  , IPS.record_count
			  , IPS.ghost_record_count
			  , IPS.fragment_count
			  , IPS.avg_fragment_size_in_pages
		   FROM sys.dm_db_index_physical_stats (DB_ID (N'DEV') , NULL, NULL, NULL, 'DETAILED') AS IPS
					JOIN sys.tables AS ST WITH (nolock) 
						ON IPS.object_id = ST.object_id
					JOIN sys.indexes AS SI WITH (nolock) 
						ON IPS.object_id = SI.object_id
					   AND IPS.index_id = SI.index_id
		   WHERE ST.is_ms_shipped = 0
			 AND IPS.avg_fragmentation_in_percent >= 40
		   ORDER BY
					IPS.avg_fragmentation_in_percent DESC;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[UTIL_ListAllForeignKeyRelationships]

PRINT 'Create Procedure [dbo].[UTIL_ListAllForeignKeyRelationships]';
GO
CREATE PROCEDURE dbo.UTIL_ListAllForeignKeyRelationships (@TblName nvarchar (80)) 
AS
	 BEGIN

		 --*************************************************************************
		 --WDM : Pass in a table name and get all FK Rels both up and down the chain
		 --USE:	exec UTIL_ListAllForeignKeyRelationships 'CMS_TREE'
		 --*************************************************************************

		 SELECT
				KP.TABLE_SCHEMA AS PK_Schema
			  , KP.TABLE_NAME AS PK_Table
			  , KP.COLUMN_NAME AS PK_Column
			  , KF.TABLE_SCHEMA AS FK_Schema
			  , KF.TABLE_NAME AS FK_Table
			  , KF.COLUMN_NAME AS FK_Column
			  , RC.CONSTRAINT_NAME AS FK_CONSTRAINT_Name
			  , RC.UNIQUE_CONSTRAINT_NAME AS PK_Name
			  , RC.MATCH_OPTION AS MatchOption
			  , RC.UPDATE_RULE AS UpdateRule
			  , RC.DELETE_RULE AS DeleteRule
		   FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS AS RC
					JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KF
						ON RC.CONSTRAINT_NAME = KF.CONSTRAINT_NAME
					JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KP
						ON RC.UNIQUE_CONSTRAINT_NAME = KP.CONSTRAINT_NAME
		   WHERE KP.TABLE_NAME = @TblName
			  OR KF.TABLE_NAME = @TblName
		   ORDER BY
					KP.TABLE_SCHEMA, KP.TABLE_NAME, KP.COLUMN_NAME;
	 END;

--GRANT EXECUTE ON OBJECT::dbo.UTIL_ListAllForeignKeyRelationships TO public;

GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[UTILSearchAllTables]

PRINT 'Create Procedure [dbo].[UTILSearchAllTables]';
GO
CREATE PROC dbo.UTILSearchAllTables (@SearchStr nvarchar (100)) 
AS
	 BEGIN

		 --DMA Limited, Jan, 10, 2009
		 --W. Dale Miller - This procedure is designed to search through a database
		 --for the occurance of a TEXT string. 

		 CREATE TABLE #Results (
					  ColumnName nvarchar (370) 
					, ColumnValue nvarchar (3630)) ;
		 SET NOCOUNT ON;
		 DECLARE @TableName nvarchar (256) 
			   , @ColumnName nvarchar (128) 
			   , @SearchStr2 nvarchar (110) ;
		 SET @TableName = '';
		 SET @SearchStr2 = QUOTENAME ('%' + @SearchStr + '%', '''') ;
		 WHILE @TableName IS NOT NULL
			 BEGIN
				 SET @ColumnName = '';
				 SET @TableName = (SELECT
										  MIN (QUOTENAME (TABLE_SCHEMA) + '.' + QUOTENAME (TABLE_NAME)) 
									 FROM INFORMATION_SCHEMA.TABLES
									 WHERE TABLE_TYPE = 'BASE TABLE'
									   AND QUOTENAME (TABLE_SCHEMA) + '.' + QUOTENAME (TABLE_NAME) > @TableName
									   AND OBJECTPROPERTY (OBJECT_ID (QUOTENAME (TABLE_SCHEMA) + '.' + QUOTENAME (TABLE_NAME)) , 'IsMSShipped') = 0) ;
				 WHILE @TableName IS NOT NULL
				   AND @ColumnName IS NOT NULL
					 BEGIN
						 SET @ColumnName = (SELECT
												   MIN (QUOTENAME (COLUMN_NAME)) 
											  FROM INFORMATION_SCHEMA.COLUMNS
											  WHERE TABLE_SCHEMA = PARSENAME (@TableName, 2) 
												AND TABLE_NAME = PARSENAME (@TableName, 1) 
												AND DATA_TYPE IN ('char', 'varchar', 'nchar', 'nvarchar') 
												AND QUOTENAME (COLUMN_NAME) > @ColumnName) ;
						 IF @ColumnName IS NOT NULL
							 BEGIN
								 INSERT INTO #Results
								 EXEC ('SELECT '''+@TableName+'.'+@ColumnName+''', LEFT('+@ColumnName+', 3630) 
                    FROM '+@TableName+' (NOLOCK) '+' WHERE '+@ColumnName+' LIKE '+@SearchStr2) ;
							 END;
					 END;
			 END;
		 SELECT
				ColumnName
			  , ColumnValue
		   FROM #Results;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[wdmViewAnalysis]

PRINT 'Create Procedure [dbo].[wdmViewAnalysis]';
GO
CREATE PROCEDURE dbo.wdmViewAnalysis @TargetView nvarchar (80) 
AS
	 BEGIN

		 ----------------------------------------------------------------------------
		 -- Analyze Nested Views - they will sooner or later cause great pain.
		 -- Created: 7/26/2008
		 -- DMA Limited, Chicago, IL
		 -- W. Dale Miller
		 -- dm@DmaChicago.com
		 ----------------------------------------------------------------------------
		 -- Create a temp table to hold the combination view/table hierarchy

		 IF EXISTS (SELECT
						   name
					  FROM tempdb.dbo.sysobjects
					  WHERE ID = OBJECT_ID (N'tempdb..#NestedViews')) 
			 BEGIN
				 DROP TABLE
					  #NestedViews;
			 END;
		 CREATE TABLE #NestedViews (
					  id int IDENTITY (1, 1) 
					, parent_view_id int
					, referenced_schema_name nvarchar (255) 
					, referenced_entity_name nvarchar (255) 
					, join_clause nvarchar (max) 
					, LEVEL tinyint
					, lineage nvarchar (max)) ;
		 DECLARE @viewname nvarchar (1000) 
			   , @count int
			   ,

				 -- Current ID

				 @maxCount int;

		 -- Max ID of the temp table
		 -- Set the name of the view you want to analyze
		 -- This is generally the TOP Level View, but can be one that is contained within another.

		 SELECT
				@viewName = @TargetView
			  , @count = 1;

		 ----------------------------------------------------------------------------
		 -- Seed the table with the root view, and the root view's referenced tables.
		 ----------------------------------------------------------------------------

		 INSERT INTO #NestedViews
		 SELECT
				NULL AS parent_view_id
			  , 'dbo' AS referenced_schema_name
			  , @viewName AS referenced_entity_name
			  , NULL AS join_clause
			  , 0 AS LEVEL
			  , '/' AS lineage;
		 INSERT INTO #NestedViews
		 SELECT DISTINCT
				@count AS parent_view_id
			  , referenced_schema_name
			  , referenced_entity_name
			  , '' AS join_clause
			  , 1 AS LEVEL
			  , '/1/' AS lineage
		   FROM sys.dm_sql_referenced_entities (N'dbo.' + @viewName, 'OBJECT') ;
		 SELECT
				@maxCount = MAX (id) 
		   FROM #NestedViews;

		 ----------------------------------------------------------------------------
		 -- Loop through the nested views and process ALL rows.
		 ----------------------------------------------------------------------------

		 WHILE @count < @maxCount
			 BEGIN
				 SELECT
						@count = @count + 1;

				 -- Get the name of the current view (that one of interest where references are desired)

				 SELECT
						@viewName = referenced_entity_name
				   FROM #NestedViews
				   WHERE id = @count;

				 -- If it's a view (not a table), insert referenced objects into temp table.

				 IF EXISTS (SELECT
								   name
							  FROM sys.objects
							  WHERE name = @viewName
								AND TYPE = 'v') 
					 BEGIN
						 INSERT INTO #NestedViews
						 SELECT DISTINCT
								@count AS parent_view_id
							  , referenced_schema_name
							  , referenced_entity_name
							  , '' AS join_clause
							  , NULL AS LEVEL
							  , '' AS lineage
						   FROM sys.dm_sql_referenced_entities (N'dbo.' + @viewName, 'OBJECT') ;
						 SELECT
								@maxCount = MAX (id) 
						   FROM #NestedViews;
					 END;
			 END;

		 --------------------------------------
		 --------------------------------------

		 WHILE EXISTS (SELECT
							  1
						 FROM #NestedViews
						 WHERE LEVEL IS NULL) 
			 UPDATE NVHL2
			 SET
				 NVHL2.Level = NVHL1.Level + 1
			   ,
				 NVHL2.Lineage = NVHL1.Lineage + LTRIM (STR (NVHL2.parent_view_id, 6, 0)) + '/'
			   FROM #NestedViews AS NVHL2
						INNER JOIN #NestedViews AS NVHL1
							ON NVHL2.parent_view_id = NVHL1.ID
			   WHERE
					 NVHL1.Level >= 0
				 AND NVHL1.Lineage IS NOT NULL
				 AND NVHL2.Level IS NULL;
		 SELECT
				parent.*
			  , child.id
			  , child.referenced_entity_name AS ChildName
		   FROM #NestedViews AS parent
					RIGHT OUTER JOIN #NestedViews AS child
						ON child.parent_view_id = parent.id
		   ORDER BY
					parent.id, child.id;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[UTIL_ListCurrentWaits]

PRINT 'Create Procedure [dbo].[UTIL_ListCurrentWaits]';
GO
CREATE PROC dbo.UTIL_ListCurrentWaits
AS
	 BEGIN

		 --WDM 2/01/2013 :  Displays waits that are in effect right now.
		 --USE exec UTIL_ListCurrentWaits

		 SELECT
				wt.session_id
			  , wt.wait_type
			  , er.wait_resource
			  , wt.wait_duration_ms
			  , st.text
			  , er.start_time
		   FROM sys.dm_os_waiting_tasks AS wt
					INNER JOIN sys.dm_exec_requests AS er
						ON wt.waiting_task_address = er.task_address
					OUTER APPLY sys.dm_exec_sql_text (er.sql_handle) AS st
		   WHERE wt.wait_type NOT LIKE '%SLEEP%'
			 AND wt.session_id >= 50
		   ORDER BY
					wt.wait_duration_ms DESC;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Add Permissions To The procedure [dbo].[UTIL_ListCurrentWaits]

PRINT 'Add Permissions To The procedure [dbo].[UTIL_ListCurrentWaits]';
GRANT EXECUTE ON dbo.UTIL_ListCurrentWaits TO [public];
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[UTIL_SearchAllTables]

PRINT 'Create Procedure [dbo].[UTIL_SearchAllTables]';
GO

--EXEC UTIL_SearchAllTables 'View_HFit_UserGoals'
--GO 
--EXEC UTIL_SearchAllTables 'view_HFit_TrackerEvents'
--GO 
--EXEC UTIL_SearchAllTables 'view_EDW_Coaches'
--GO 
--EXEC UTIL_SearchAllTables 'View_EDW_HealthAssesmentQuestions'
--GO 
--select * from [dbo].[EDW_PerformanceMeasure]
--select * from [Staging_Task] where [TaskData] like '%view_HFit_TrackerEvents%'

CREATE PROC UTIL_SearchAllTables (@SearchStr nvarchar (100)) 
AS
	 BEGIN

		 --DECLARE @SearchStr NVARCHAR(100);
		 --SET @SearchStr = 'View_EDW_HealthAssesmentQuestions' ;
		 -- Purpose: To search all columns of all tables for a given string
		 -- Written by: WDM
		 -- Site: http://www.dmachicago.com
		 -- Tested on: SQL Server 7.0 and SQL Server 2000, 2005, 2008, 2012
		 -- Date created:  26 July 2000
		 -- Date modified: 26 July 2004
		 -- Date modified: 20 Aug  2014
		 --CREATE TABLE #Results (ColumnName nvarchar(370), ColumnValue nvarchar(3630), SearchTerm nvarchar(250))

		 CREATE TABLE #Results (
					  ColumnName nvarchar (370) 
					, ColumnValue nvarchar (3630)) ;
		 SET NOCOUNT ON;
		 DECLARE @TableName nvarchar (256) 
			   , @ColumnName nvarchar (128) 
			   , @SearchStr2 nvarchar (110) 
			   , @SearchStrMain nvarchar (110) ;
		 SET @TableName = '';
		 SET @SearchStr2 = QUOTENAME ('%' + @SearchStr + '%', '''') ;
		 SET @SearchStrMain = @SearchStr;
		 WHILE @TableName IS NOT NULL
			 BEGIN
				 SET @ColumnName = '';
				 SET @TableName = (SELECT
										  MIN (QUOTENAME (TABLE_SCHEMA) + '.' + QUOTENAME (TABLE_NAME)) 
									 FROM INFORMATION_SCHEMA.TABLES
									 WHERE TABLE_TYPE = 'BASE TABLE'
									   AND QUOTENAME (TABLE_SCHEMA) + '.' + QUOTENAME (TABLE_NAME) > @TableName
									   AND OBJECTPROPERTY (OBJECT_ID (QUOTENAME (TABLE_SCHEMA) + '.' + QUOTENAME (TABLE_NAME)) , 'IsMSShipped') = 0) ;
				 WHILE @TableName IS NOT NULL
				   AND @ColumnName IS NOT NULL
					 BEGIN
						 SET @ColumnName = (SELECT
												   MIN (QUOTENAME (COLUMN_NAME)) 
											  FROM INFORMATION_SCHEMA.COLUMNS
											  WHERE TABLE_SCHEMA = PARSENAME (@TableName, 2) 
												AND TABLE_NAME = PARSENAME (@TableName, 1) 
												AND DATA_TYPE IN ('char', 'varchar', 'nchar', 'nvarchar') 
												AND QUOTENAME (COLUMN_NAME) > @ColumnName) ;
						 IF @ColumnName IS NOT NULL
							 BEGIN
								 INSERT INTO #Results
								 EXEC ('SELECT '''+@TableName+'.'+@ColumnName+'.'+@SearchStrMain+''', LEFT('+@ColumnName+', 3630) 
					FROM '+@TableName+' (NOLOCK) '+' WHERE '+@ColumnName+' LIKE '+@SearchStr2) ;

							 --update #Results set SearchTerm = @SearchStr where SearchTerm is null ;
							 --INSERT INTO TempResults
							 --EXEC
							 --(
							 --	'Select * from #Results ' 
							 --)

							 END;
					 END;
			 END;
		 SELECT
				ColumnName
			  , ColumnValue
		   FROM #Results;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[UTIL_CalcPctNullDataInTable]

PRINT 'Create Procedure [dbo].[UTIL_CalcPctNullDataInTable]';
GO
CREATE PROC dbo.UTIL_CalcPctNullDataInTable (@Schema AS nvarchar (100) 
										   , @TBL AS nvarchar (100)) 
AS
	 BEGIN

		 --WDM 3/15/2012 :  Calculates the percentage of NULL data in each column within a table or view
		 --USE exec UTIL_CalcPctNullDataInTable 'dbo', 'view_EDW_HealthAssesment'

		 SET NOCOUNT ON;
		 DECLARE @Statement nvarchar (max) = '';
		 DECLARE @Statement2 nvarchar (max) = '';
		 DECLARE @FinalStatement nvarchar (max) = '';
		 DECLARE @TABLE_SCHEMA sysname = @Schema;
		 DECLARE @TABLE_NAME sysname = @TBL;
		 SELECT
				@Statement = @Statement + 'SUM(CASE WHEN ' + COLUMN_NAME + ' IS NULL THEN 1 ELSE 0 END) AS ' + COLUMN_NAME + ',' + CHAR (13) 
			  , @Statement2 = @Statement2 + COLUMN_NAME + '*100 / OverallCount AS ' + COLUMN_NAME + ',' + CHAR (13) 
		   FROM INFORMATION_SCHEMA.COLUMNS
		   WHERE TABLE_NAME = @TABLE_NAME
			 AND TABLE_SCHEMA = @TABLE_SCHEMA;
		 IF @@ROWCOUNT = 0
			 BEGIN
				 RAISERROR ('TABLE OR VIEW with schema "%s" and name "%s" does not exist or you do not have appropriate permissions.', 16, 1, @TABLE_SCHEMA, @TABLE_NAME) ;
			 END
		 ELSE
			 BEGIN
				 SELECT
						@FinalStatement = 'SELECT ' + LEFT (@Statement2, LEN (@Statement2) - 2) + ' FROM (SELECT ' + LEFT (@Statement, LEN (@Statement) - 2) + ', COUNT(*) AS OverallCount FROM ' + @TABLE_SCHEMA + '.' + @TABLE_NAME + ') SubQuery';
				 EXEC (@FinalStatement) ;
			 END;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Add Permissions To The procedure [dbo].[UTIL_CalcPctNullDataInTable]

PRINT 'Add Permissions To The procedure [dbo].[UTIL_CalcPctNullDataInTable]';
GRANT EXECUTE ON dbo.UTIL_CalcPctNullDataInTable TO [public];
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[UTIL_FindTablesInViews]

PRINT 'Create Procedure [dbo].[UTIL_FindTablesInViews]';
GO
CREATE PROC dbo.UTIL_FindTablesInViews @TBL nvarchar (80) 
AS
	 BEGIN
		 SELECT

		 --****************************************************************
		 --W. Dale Miller - March 2009
		 --Find objects referneced within other objects.
		 --In this instance, I needed to find tables referenced in views.
		 --To get all references of an object's use, remove the AND
		 --portion of the WHERE clause.
		 --USE: exec wdmFindTablesInViews 'UserTable'
		 --****************************************************************

				referencing_schema_name = SCHEMA_NAME (o.SCHEMA_ID) 
	   , referencing_object_name = o.name
	   , referencing_object_type_desc = o.type_desc
	   , referenced_schema_name
	   , referenced_object_name = referenced_entity_name
	   , referenced_object_type_desc = o1.type_desc
	   , referenced_server_name
	   , referenced_database_name

		 --,sed.* -- Uncomment for all the columns

		   FROM sys.sql_expression_dependencies AS sed
					INNER JOIN sys.objects AS o
						ON sed.referencing_id = o.object_id
					LEFT OUTER JOIN sys.objects AS o1
						ON sed.referenced_id = o1.object_id
		   WHERE referenced_entity_name = @TBL
			 AND o.type_desc = 'VIEW';
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[IVP_DataValidation]

PRINT 'Create Procedure [dbo].[IVP_DataValidation]';
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
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[Proc_EDW_Compare_Views]

PRINT 'Create Procedure [dbo].[Proc_EDW_Compare_Views]';
GO
CREATE PROCEDURE Proc_EDW_Compare_Views (@LinkedSVR AS nvarchar (254) 
									   , @LinkedDB AS nvarchar (254) 
									   , @LinkedVIEW AS nvarchar (254) 
									   , @CurrDB AS nvarchar (254) 
									   , @CurrVIEW AS nvarchar (254) 
									   , @NewRun AS int) 
AS
	 BEGIN

		 --set @LinkedSVR = 'hfit-sqlUAT.cloudapp.net,3' ;
		 --set @LinkedDB = 'KenticoCMS_ProdStaging' ;
		 --set @LinkedVIEW = 'SchemaChangeMonitor' ;
		 --set @CurrDB = 'KenticoCMS_DEV' ;
		 --set @CurrVIEW = 'SchemaChangeMonitor'
		 --exec Proc_EDW_Compare_Views 'hfit-sqlUAT.cloudapp.net,3', 'KenticoCMS_ProdStaging', 'HFit_HealthAssessment', 'KenticoCMS_DEV', 'HFit_HealthAssessment', 0
		 --exec Proc_EDW_Compare_Views 'hfit-sqlUAT.cloudapp.net,3', 'KenticoCMS_ProdStaging', 'SchemaChangeMonitor', 'KenticoCMS_DEV', 'HFit_HealthAssessment', 1
		 --exec Proc_EDW_Compare_Views 'hfit-sqlUAT.cloudapp.net,3', 'KenticoCMS_ProdStaging', 'SchemaChangeMonitor', 'KenticoCMS_DEV', 'SchemaChangeMonitor', 1
		 --exec Proc_EDW_Compare_Views 'hfit-sqlUAT.cloudapp.net,3', 'KenticoCMS_ProdStaging', 'view_EDW_HealthAssesment', 'KenticoCMS_DEV', 'view_EDW_HealthAssesment', 1

		 DECLARE @ParmDefinition AS nvarchar (max) ;
		 DECLARE @retval int = 0;
		 DECLARE @S AS nvarchar (250) = '';
		 DECLARE @SVR AS varchar (254) = @LinkedSVR;
		 DECLARE @iCnt AS int;
		 DECLARE @iRetval AS int = 0;
		 DECLARE @Note AS nvarchar (max) = '';
		 SET @S = 'SELECT @retval = count(*) FROM sys.servers WHERE name = @TgtSVR ';
		 SET @ParmDefinition = N'@TgtSVR nvarchar(254), @retval bit OUTPUT';
		 EXEC sp_executesql @S, @ParmDefinition, @TgtSVR = @LinkedSVR, @retval = @iRetval OUTPUT;
		 SET @iCnt = (SELECT
							 @iRetval) ;
		 IF @iCnt = 1
			 BEGIN EXEC master.sys.sp_dropserver @LinkedSVR, 'droplogins'
			 END;
		 EXEC sp_addlinkedserver @LinkedSVR, 'SQL Server';
		 SET @S = 'select @retval = count(*) from [' + @LinkedSVR + '].[' + @LinkedDB + '].sys.views where NAME = @TgtVIEW ';
		 SET @ParmDefinition = N'@TgtVIEW nvarchar(254), @retval int OUTPUT';
		 EXEC sp_executesql @S, @ParmDefinition, @TgtVIEW = @LinkedVIEW, @retval = @iRetval OUTPUT;
		 SET @iCnt = (SELECT
							 @iRetval) ;

		 --print ('Step01');

		 IF @iCnt = 0
			 BEGIN
				 PRINT @LinkedVIEW + ' : VIEW does not exist on server ' + @LinkedSVR + ' in database ' + @LinkedDB + '.';
				 DECLARE @SSQL AS nvarchar (max) = '';
				 DECLARE @msg AS nvarchar (max) = '';
				 SET @msg = @LinkedVIEW + ' : VIEW does not exist on server ' + @LinkedSVR + ' in database ' + @LinkedDB + '.';
				 SET @SSQL = 'INSERT INTO TBL_DIFF1 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ';
				 SET @SSQL = @SSQL + 'VALUES ( ';
				 SET @SSQL = @SSQL + '''' + @CurrVIEW + ''', null, null , null, null ,null,null, null, ''' + @msg + ''' ';
				 SET @SSQL = @SSQL + ')';
				 EXEC (@SSQL) ;
				 RETURN;
			 END;
		 IF NOT EXISTS (SELECT
							   name

						--FROM tempdb.dbo.sysobjects

						  FROM sysobjects
						  WHERE ID = OBJECT_ID (N'TBL_DIFF1')) 
			 BEGIN
				 CREATE TABLE dbo.TBL_DIFF1 (
							  table_name sysname NOT NULL
							, COLUMN_NAME sysname NULL
							, DATA_TYPE nvarchar (254) NULL
							, CHARACTER_MAXIMUM_LENGTH nvarchar (254) NULL
							, table_name2 sysname NULL
							, DATA_TYPE2 nvarchar (254) NULL
							, COLUMN_NAME2 sysname NULL
							, CHARACTER_MAXIMUM_LENGTH2 int NULL
							, NOTE varchar (max) 
							, CreateDate datetime2 (7) NULL
												  DEFAULT GETDATE () 
							, RowNbr int IDENTITY) ;
			 END;
		 IF NOT EXISTS (SELECT
							   name

						--FROM tempdb.dbo.sysobjects

						  FROM sysobjects
						  WHERE ID = OBJECT_ID (N'TBL_DIFF2')) 
			 BEGIN
				 CREATE TABLE dbo.TBL_DIFF2 (
							  table_name sysname NOT NULL
							, COLUMN_NAME sysname NULL
							, DATA_TYPE nvarchar (254) NULL
							, CHARACTER_MAXIMUM_LENGTH nvarchar (254) NULL
							, table_name2 sysname NULL
							, DATA_TYPE2 nvarchar (254) NULL
							, COLUMN_NAME2 sysname NULL
							, CHARACTER_MAXIMUM_LENGTH2 int NULL
							, NOTE varchar (max) 
							, RowNbr int IDENTITY) ;
			 END;
		 IF NOT EXISTS (SELECT
							   name

						--FROM tempdb.dbo.sysobjects

						  FROM sysobjects
						  WHERE ID = OBJECT_ID (N'TBL_DIFF3')) 
			 BEGIN
				 CREATE TABLE dbo.TBL_DIFF3 (
							  table_name sysname NOT NULL
							, COLUMN_NAME sysname NULL
							, DATA_TYPE nvarchar (254) NULL
							, CHARACTER_MAXIMUM_LENGTH nvarchar (254) NULL
							, table_name2 sysname NULL
							, DATA_TYPE2 nvarchar (254) NULL
							, COLUMN_NAME2 sysname NULL
							, CHARACTER_MAXIMUM_LENGTH2 int NULL
							, NOTE varchar (max) 
							, CreateDate datetime2 (7) NULL
												  DEFAULT GETDATE () 
							, RowNbr int IDENTITY) ;
			 END;
		 IF NOT EXISTS (SELECT
							   name

						--FROM tempdb.dbo.sysobjects

						  FROM sysobjects
						  WHERE ID = OBJECT_ID (N'TBL_DIFF4')) 
			 BEGIN
				 CREATE TABLE dbo.TBL_DIFF4 (
							  table_name sysname NOT NULL
							, COLUMN_NAME sysname NULL
							, DATA_TYPE nvarchar (254) NULL
							, CHARACTER_MAXIMUM_LENGTH nvarchar (254) NULL
							, table_name2 sysname NULL
							, DATA_TYPE2 nvarchar (254) NULL
							, COLUMN_NAME2 sysname NULL
							, CHARACTER_MAXIMUM_LENGTH2 int NULL
							, NOTE varchar (max) 
							, CreateDate datetime2 (7) NULL
												  DEFAULT GETDATE () 
							, RowNbr int IDENTITY) ;
			 END;
		 IF @NewRun = 1
			 BEGIN
				 truncate TABLE TBL_DIFF1;
				 truncate TABLE TBL_DIFF2;
				 truncate TABLE TBL_DIFF3;
			 END;

		 --DECLARE @LinkedDB as nvarchar(254), @LinkedVIEW as nvarchar(254),@CurrDB as nvarchar(254), @CurrVIEW as nvarchar(254) ;

		 DECLARE @MySQL AS nvarchar (max) ;

		 --set @LinkedDB = 'instrument' ;
		 --set @LinkedVIEW = 'SchemaChangeMonitor' ;
		 --set @CurrDB = 'KenticoCMS_DEV' ;
		 --set @CurrVIEW = 'SchemaChangeMonitor'
		 --select c1.table_name,c1.COLUMN_NAME,c1.DATA_TYPE , cast (c1.CHARACTER_MAXIMUM_LENGTH as nvarchar(254)) as CHARACTER_MAXIMUM_LENGTH, c2.table_name,c2.DATA_TYPE,c2.COLUMN_NAME, c2.CHARACTER_MAXIMUM_LENGTH
		 --from KenticoCMS_DEV.[INFORMATION_SCHEMA].[COLUMNS] c1
		 --left join instrument.[INFORMATION_SCHEMA].[COLUMNS] c2 on c1.TABLE_NAME=c2.TABLE_NAME
		 --where c1.TABLE_NAME= @LinkedVIEW and c2.TABLE_NAME = @CurrVIEW
		 --and C1.column_name = c2.column_name
		 --and ((c1.data_type <> c2.DATA_TYPE) 
		 --		OR (c1.data_type = c2.DATA_TYPE AND c1.CHARACTER_MAXIMUM_LENGTH <> c2.CHARACTER_MAXIMUM_LENGTH))
		 --print ('Step04');

		 SET @MySQL = 'INSERT INTO TBL_DIFF1 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ';
		 SET @MySQL = @MySql + 'select c1.table_name, c1.COLUMN_NAME, c1.DATA_TYPE , cast (c1.CHARACTER_MAXIMUM_LENGTH as nvarchar(254)) as CHARACTER_MAXIMUM_LENGTH, c2.table_name as table_name2 ,c2.DATA_TYPE as DATA_TYPE2 ,c2.COLUMN_NAME as COLUMN_NAME2, c2.CHARACTER_MAXIMUM_LENGTH as CHARACTER_MAXIMUM_LENGTH2, ''Data Types or Data Length Differ'' ';
		 SET @MySQL = @MySQL + 'from [' + @LinkedSVR + '].[' + @LinkedDB + '].[INFORMATION_SCHEMA].[COLUMNS] c1 ';
		 SET @MySQL = @MySQL + 'left join ' + @CurrDB + '.[INFORMATION_SCHEMA].[COLUMNS] c2 on c1.TABLE_NAME = c2.TABLE_NAME ';
		 SET @MySQL = @MySQL + 'where c1.TABLE_NAME= ''' + @LinkedVIEW + ''' and c2.TABLE_NAME = ''' + @CurrVIEW + ''' ';
		 SET @MySQL = @MySQL + 'and C1.column_name = c2.column_name ';
		 SET @MySQL = @MySQL + 'and ((c1.data_type <> c2.DATA_TYPE) ';
		 SET @MySQL = @MySQL + '		OR (c1.data_type = c2.DATA_TYPE AND c1.CHARACTER_MAXIMUM_LENGTH <> c2.CHARACTER_MAXIMUM_LENGTH))';
		 EXEC (@MySql) ;

		 --print ('Step05');

		 SET @MySQL = '';
		 SET @MySQL = 'INSERT INTO TBL_DIFF2 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ';
		 SET @MySQL = @MySQL + 'SELECT c1.TABLE_NAME, c1.COLUMN_NAME, c1.DATA_TYPE, ''' + @CurrDB + ''' as DBNAME, ''MISSING'' as C1, ''NA'' as C2 , ''NA'' as C3, 0 as I1, ''Column ''+c1.COLUMN_NAME+'' Missing in: ' + @CurrDB + '/' + @CurrVIEW + ' ''  ';
		 SET @MySQL = @MySQL + ' FROM  [' + @LinkedSVR + '].[' + @LinkedDB + '].INFORMATION_SCHEMA.COLUMNS AS c1 ';
		 SET @MySQL = @MySQL + ' WHERE  C1.table_name = ''' + @CurrVIEW + ''' ';
		 SET @MySQL = @MySQL + ' 	AND c1.column_name not in ';
		 SET @MySQL = @MySQL + ' 	(select column_name from ' + @CurrDB + '.INFORMATION_SCHEMA.columns C2 where C2.table_name = ''' + @LinkedVIEW + ''') ';
		 PRINT @MySql;
		 EXEC (@MySql) ;

		 --print ('Step06');

		 SET @MySQL = 'INSERT INTO TBL_DIFF3 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ';
		 SET @MySQL = @MySQL + 'SELECT c1.TABLE_NAME, c1.COLUMN_NAME, c1.DATA_TYPE, ''' + @LinkedDB + ''' as DBNAME, ''MISSING'' as C1, ''NA'' as C2, ''NA'' as C3, -1 as I1, ''Column ''+c1.COLUMN_NAME+'' Missing in: ' + @LinkedDB + '/' + @LinkedVIEW + ' ''  ';
		 SET @MySQL = @MySQL + ' FROM [' + @CurrDB + '].INFORMATION_SCHEMA.COLUMNS as C1 ';
		 SET @MySQL = @MySQL + ' WHERE  C1.table_name = ''' + @CurrVIEW + ''' ';
		 SET @MySQL = @MySQL + ' AND c1.column_name not in ';
		 SET @MySQL = @MySQL + ' (select column_name from [' + @LinkedSVR + '].[' + @LinkedDB + '].INFORMATION_SCHEMA.columns C2 where C2.table_name = ''' + @LinkedVIEW + ''') ';
		 EXEC (@MySql) ;

		 --print ('Step07');

		 SET @S = 'SELECT @retval = count(*) FROM sys.servers WHERE name = @TgtSVR ';
		 SET @ParmDefinition = N'@TgtSVR nvarchar(254), @retval bit OUTPUT';
		 EXEC sp_executesql @S, @ParmDefinition, @TgtSVR = @LinkedSVR, @retval = @iRetval OUTPUT;
		 SET @iCnt = (SELECT
							 @iRetval) ;
		 IF @iCnt = 1
			 BEGIN EXEC master.sys.sp_dropserver @LinkedSVR, 'droplogins'
			 END;

		 --print ('Step08');

		 IF NOT EXISTS (SELECT
							   name
						  FROM sys.views
						  WHERE name = 'view_SchemaDiff') 
			 BEGIN
				 DECLARE @sTxt AS nvarchar (max) = '';
				 SET @sTxt = @sTxt + 'Create view view_SchemaDiff AS ';
				 SET @sTxt = @sTxt + 'Select * from TBL_DIFF1 ';
				 SET @sTxt = @sTxt + 'union ';
				 SET @sTxt = @sTxt + 'Select * from TBL_DIFF2  ';
				 SET @sTxt = @sTxt + 'union ';
				 SET @sTxt = @sTxt + 'Select * from TBL_DIFF3  ';
				 EXEC (@sTxt) ;
				 PRINT 'Created view view_SchemaDiff.';
			 END;

		 --Select * from TBL_DIFF1 
		 --union
		 --Select * from TBL_DIFF2 
		 --union
		 --Select * from TBL_DIFF3 

		 PRINT 'To see "deltas" - select * from view_SchemaDiff';
		 PRINT '_________________________________________________';

	 --print ('Step09');

	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[Proc_EDW_Compare_Tables]

PRINT 'Create Procedure [dbo].[Proc_EDW_Compare_Tables]';
GO
CREATE PROCEDURE Proc_EDW_Compare_Tables (@LinkedSVR AS nvarchar (254) 
										, @LinkedDB AS nvarchar (254) 
										, @LinkedTBL AS nvarchar (254) 
										, @CurrDB AS nvarchar (254) 
										, @CurrTBL AS nvarchar (254) 
										, @NewRun AS int) 
AS
	 BEGIN
		 PRINT 'Comparing: ' + @LinkedSVR + ' : ' + @LinkedDB + ' : ' + @LinkedTBL;
		 PRINT 'TO: ' + @CurrDB + ' : ' + @CurrTBL;

		 --set @LinkedSVR = 'hfit-sqlUAT.cloudapp.net,3' ;
		 --set @LinkedDB = 'KenticoCMS_ProdStaging' ;
		 --set @LinkedTBL = 'SchemaChangeMonitor' ;
		 --set @CurrDB = 'KenticoCMS_DEV' ;
		 --set @CurrTBL = 'SchemaChangeMonitor'
		 --exec Proc_EDW_Compare_Tables 'hfit-sqlUAT.cloudapp.net,3', 'KenticoCMS_ProdStaging', 'HFit_HealthAssessment', 'KenticoCMS_DEV', 'HFit_HealthAssessment', 0
		 --exec Proc_EDW_Compare_Tables 'hfit-sqlUAT.cloudapp.net,3', 'KenticoCMS_ProdStaging', 'SchemaChangeMonitor', 'KenticoCMS_DEV', 'HFit_HealthAssessment', 1
		 --exec Proc_EDW_Compare_Tables 'hfit-sqlUAT.cloudapp.net,3', 'KenticoCMS_ProdStaging', 'SchemaChangeMonitor', 'KenticoCMS_DEV', 'SchemaChangeMonitor', 1
		 --exec Proc_EDW_Compare_Tables 'hfit-sqlUAT.cloudapp.net,3', 'KenticoCMS_DEV', 'SchemaChangeMonitor', 'instrument', 'HFit_HealthAssessment', 1

		 DECLARE @ParmDefinition AS nvarchar (max) ;
		 DECLARE @retval int = 0;
		 DECLARE @S AS nvarchar (254) = '';
		 DECLARE @SVR AS varchar (254) = @LinkedSVR;
		 DECLARE @iCnt AS int;
		 DECLARE @iRetval AS int = 0;
		 DECLARE @Note AS nvarchar (max) = '';
		 SET @S = 'SELECT @retval = count(*) FROM sys.servers WHERE name = @TgtSVR ';
		 SET @ParmDefinition = N'@TgtSVR nvarchar(254), @retval bit OUTPUT';
		 EXEC sp_executesql @S, @ParmDefinition, @TgtSVR = @LinkedSVR, @retval = @iRetval OUTPUT;
		 SET @iCnt = (SELECT
							 @iRetval) ;
		 IF @iCnt = 1
			 BEGIN EXEC master.sys.sp_dropserver @LinkedSVR, 'droplogins'
			 END;
		 EXEC sp_addlinkedserver @LinkedSVR, 'SQL Server';
		 SET @S = 'select @retval = count(*) from [' + @LinkedSVR + '].[' + @LinkedDB + '].sys.tables where NAME = @TgtTBL ';
		 SET @ParmDefinition = N'@TgtTBL nvarchar(254), @retval int OUTPUT';
		 EXEC sp_executesql @S, @ParmDefinition, @TgtTBL = @LinkedTBL, @retval = @iRetval OUTPUT;
		 SET @iCnt = (SELECT
							 @iRetval) ;

		 --print ('Step01');

		 IF @iCnt = 0
			 BEGIN
				 PRINT @LinkedTBL + ' : Table does not exist on server ' + @LinkedSVR + ' in database ' + @LinkedDB + '.';
				 DECLARE @SSQL AS nvarchar (max) = '';
				 DECLARE @msg AS nvarchar (max) = '';
				 SET @msg = @LinkedTBL + ' : Table does not exist on server ' + @LinkedSVR + ' in database ' + @LinkedDB + '.';
				 SET @SSQL = 'INSERT INTO TBL_DIFF1 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ';
				 SET @SSQL = @SSQL + 'VALUES ( ';
				 SET @SSQL = @SSQL + '''' + @CurrTBL + ''', null, null , null, null ,null,null, null, ''' + @msg + ''' ';
				 SET @SSQL = @SSQL + ')';
				 EXEC (@SSQL) ;
				 RETURN;
			 END;

		 --set @S  = 'SELECT @retval = count(*) FROM sys.servers WHERE name = @TgtSVR ' ;
		 --set @ParmDefinition  = N'@TgtSVR nvarchar(254), @retval bit OUTPUT' ;
		 --exec sp_executesql @S, @ParmDefinition, @TgtSVR = @LinkedSVR, @retval = @iRetval OUTPUT ;
		 --set @iCnt = (select @iRetval) ;
		 --IF (@iCnt = 1)
		 --	EXEC master.sys.sp_dropserver @LinkedSVR,'droplogins'  ;
		 --print ('Step02');

		 IF NOT EXISTS (SELECT
							   name

						--FROM tempdb.dbo.sysobjects

						  FROM sysobjects
						  WHERE ID = OBJECT_ID (N'TBL_DIFF1')) 
			 BEGIN
				 CREATE TABLE dbo.TBL_DIFF1 (
							  table_name sysname NOT NULL
							, COLUMN_NAME sysname NULL
							, DATA_TYPE nvarchar (254) NULL
							, CHARACTER_MAXIMUM_LENGTH nvarchar (254) NULL
							, table_name2 sysname NULL
							, DATA_TYPE2 nvarchar (254) NULL
							, COLUMN_NAME2 sysname NULL
							, CHARACTER_MAXIMUM_LENGTH2 int NULL
							, NOTE varchar (max) NULL
							, CreateDate datetime2 (7) NULL
												  DEFAULT GETDATE () 
							, RowNbr int IDENTITY) ;
			 END;
		 IF NOT EXISTS (SELECT
							   name

						--FROM tempdb.dbo.sysobjects

						  FROM sysobjects
						  WHERE ID = OBJECT_ID (N'TBL_DIFF2')) 
			 BEGIN
				 CREATE TABLE dbo.TBL_DIFF2 (
							  table_name sysname NOT NULL
							, COLUMN_NAME sysname NULL
							, DATA_TYPE nvarchar (254) NULL
							, CHARACTER_MAXIMUM_LENGTH nvarchar (254) NULL
							, table_name2 sysname NULL
							, DATA_TYPE2 nvarchar (254) NULL
							, COLUMN_NAME2 sysname NULL
							, CHARACTER_MAXIMUM_LENGTH2 int NULL
							, NOTE varchar (max) NULL
							, CreateDate datetime2 (7) NULL
												  DEFAULT GETDATE () 
							, RowNbr int IDENTITY) ;
			 END;
		 IF NOT EXISTS (SELECT
							   name

						--FROM tempdb.dbo.sysobjects

						  FROM sysobjects
						  WHERE ID = OBJECT_ID (N'TBL_DIFF3')) 
			 BEGIN
				 CREATE TABLE dbo.TBL_DIFF3 (
							  table_name sysname NOT NULL
							, COLUMN_NAME sysname NULL
							, DATA_TYPE nvarchar (254) NULL
							, CHARACTER_MAXIMUM_LENGTH nvarchar (254) NULL
							, table_name2 sysname NULL
							, DATA_TYPE2 nvarchar (254) NULL
							, COLUMN_NAME2 sysname NULL
							, CHARACTER_MAXIMUM_LENGTH2 int NULL
							, NOTE varchar (max) 
							, CreateDate datetime2 (7) DEFAULT GETDATE () 
							, RowNbr int IDENTITY) ;
			 END;
		 IF NOT EXISTS (SELECT
							   name

						--FROM tempdb.dbo.sysobjects

						  FROM sysobjects
						  WHERE ID = OBJECT_ID (N'TBL_DIFF4')) 
			 BEGIN
				 CREATE TABLE dbo.TBL_DIFF4 (
							  table_name sysname NOT NULL
							, COLUMN_NAME sysname NULL
							, DATA_TYPE nvarchar (254) NULL
							, CHARACTER_MAXIMUM_LENGTH nvarchar (254) NULL
							, table_name2 sysname NULL
							, DATA_TYPE2 nvarchar (254) NULL
							, COLUMN_NAME2 sysname NULL
							, CHARACTER_MAXIMUM_LENGTH2 int NULL
							, NOTE varchar (max) 
							, CreateDate datetime2 (7) DEFAULT GETDATE () 
							, RowNbr int IDENTITY) ;
			 END;
		 IF @NewRun = 1
			 BEGIN
				 truncate TABLE TBL_DIFF1;
				 truncate TABLE TBL_DIFF2;
				 truncate TABLE TBL_DIFF3;
			 END;

		 --DECLARE @LinkedDB as nvarchar(254), @LinkedTBL as nvarchar(254),@CurrDB as nvarchar(254), @CurrTBL as nvarchar(254) ;

		 DECLARE @MySQL AS nvarchar (max) ;

		 --set @LinkedDB = 'instrument' ;
		 --set @LinkedTBL = 'SchemaChangeMonitor' ;
		 --set @CurrDB = 'KenticoCMS_DEV' ;
		 --set @CurrTBL = 'SchemaChangeMonitor'
		 --select c1.table_name,c1.COLUMN_NAME,c1.DATA_TYPE , cast (c1.CHARACTER_MAXIMUM_LENGTH as nvarchar(254)) as CHARACTER_MAXIMUM_LENGTH, c2.table_name,c2.DATA_TYPE,c2.COLUMN_NAME, c2.CHARACTER_MAXIMUM_LENGTH
		 --from KenticoCMS_DEV.[INFORMATION_SCHEMA].[COLUMNS] c1
		 --left join instrument.[INFORMATION_SCHEMA].[COLUMNS] c2 on c1.TABLE_NAME=c2.TABLE_NAME
		 --where c1.TABLE_NAME= @LinkedTBL and c2.TABLE_NAME = @CurrTBL
		 --and C1.column_name = c2.column_name
		 --and ((c1.data_type <> c2.DATA_TYPE) 
		 --		OR (c1.data_type = c2.DATA_TYPE AND c1.CHARACTER_MAXIMUM_LENGTH <> c2.CHARACTER_MAXIMUM_LENGTH))
		 --print ('Step04');

		 SET @MySQL = 'INSERT INTO TBL_DIFF1 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ';
		 SET @MySQL = @MySql + 'select c1.table_name, c1.COLUMN_NAME, c1.DATA_TYPE , cast (c1.CHARACTER_MAXIMUM_LENGTH as nvarchar(254)) as CHARACTER_MAXIMUM_LENGTH, c2.table_name as table_name2 ,c2.DATA_TYPE as DATA_TYPE2 ,c2.COLUMN_NAME as COLUMN_NAME2, c2.CHARACTER_MAXIMUM_LENGTH as CHARACTER_MAXIMUM_LENGTH2, ''Data Types or Data Length Differ'' ';
		 SET @MySQL = @MySQL + 'from [' + @LinkedSVR + '].[' + @LinkedDB + '].[INFORMATION_SCHEMA].[COLUMNS] c1 ';
		 SET @MySQL = @MySQL + 'left join ' + @CurrDB + '.[INFORMATION_SCHEMA].[COLUMNS] c2 on c1.TABLE_NAME = c2.TABLE_NAME ';
		 SET @MySQL = @MySQL + 'where c1.TABLE_NAME= ''' + @LinkedTBL + ''' and c2.TABLE_NAME = ''' + @CurrTBL + ''' ';
		 SET @MySQL = @MySQL + 'and C1.column_name = c2.column_name ';
		 SET @MySQL = @MySQL + 'and ((c1.data_type <> c2.DATA_TYPE) ';
		 SET @MySQL = @MySQL + '		OR (c1.data_type = c2.DATA_TYPE AND c1.CHARACTER_MAXIMUM_LENGTH <> c2.CHARACTER_MAXIMUM_LENGTH))';
		 EXEC (@MySql) ;

		 --print ('Step05');

		 SET @MySQL = '';
		 SET @MySQL = 'INSERT INTO TBL_DIFF2 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ';
		 SET @MySQL = @MySQL + 'SELECT c1.TABLE_NAME, c1.COLUMN_NAME, c1.DATA_TYPE, ''' + @CurrDB + ''' as DBNAME, ''MISSING'' as C1, ''NA'' as C2 , ''NA'' as C3, 0 as I1, ''Column ''+c1.COLUMN_NAME+'' Missing in: ' + @CurrDB + ' / ' + @CurrTBL + ' ''  ';
		 SET @MySQL = @MySQL + ' FROM  [' + @LinkedSVR + '].[' + @LinkedDB + '].INFORMATION_SCHEMA.COLUMNS AS c1 ';
		 SET @MySQL = @MySQL + ' WHERE  C1.table_name = ''' + @CurrTBL + ''' ';
		 SET @MySQL = @MySQL + ' 	AND c1.column_name not in ';
		 SET @MySQL = @MySQL + ' 	(select column_name from ' + @CurrDB + '.INFORMATION_SCHEMA.columns C2 where C2.table_name = ''' + @LinkedTBL + ''') ';
		 EXEC (@MySql) ;

		 --print ('Step06');

		 SET @MySQL = 'INSERT INTO TBL_DIFF3 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ';
		 SET @MySQL = @MySQL + 'SELECT c1.TABLE_NAME, c1.COLUMN_NAME, c1.DATA_TYPE, ''' + @LinkedDB + ''' as DBNAME, ''MISSING'' as C1, ''NA'' as C2, ''NA'' as C3, -1 as I1, ''Column ''+c1.COLUMN_NAME+'' Missing in: ' + @LinkedDB + ' / ' + @LinkedTBL + ' ''  ';
		 SET @MySQL = @MySQL + ' FROM [' + @CurrDB + '].INFORMATION_SCHEMA.COLUMNS as C1 ';
		 SET @MySQL = @MySQL + ' WHERE  C1.table_name = ''' + @CurrTBL + ''' ';
		 SET @MySQL = @MySQL + ' AND c1.column_name not in ';
		 SET @MySQL = @MySQL + ' (select column_name from [' + @LinkedSVR + '].[' + @LinkedDB + '].INFORMATION_SCHEMA.columns C2 where C2.table_name = ''' + @LinkedTBL + ''') ';
		 EXEC (@MySql) ;

		 --print ('Step07');

		 SET @S = 'SELECT @retval = count(*) FROM sys.servers WHERE name = @TgtSVR ';
		 SET @ParmDefinition = N'@TgtSVR nvarchar(254), @retval bit OUTPUT';
		 EXEC sp_executesql @S, @ParmDefinition, @TgtSVR = @LinkedSVR, @retval = @iRetval OUTPUT;
		 SET @iCnt = (SELECT
							 @iRetval) ;
		 IF @iCnt = 1
			 BEGIN EXEC master.sys.sp_dropserver @LinkedSVR, 'droplogins'
			 END;

		 --print ('Step08');

		 IF NOT EXISTS (SELECT
							   name
						  FROM sys.views
						  WHERE name = 'view_SchemaDiff') 
			 BEGIN
				 DECLARE @sTxt AS nvarchar (max) = '';
				 SET @sTxt = @sTxt + 'Create view view_SchemaDiff AS ';
				 SET @sTxt = @sTxt + 'Select * from TBL_DIFF1 ';
				 SET @sTxt = @sTxt + 'union ';
				 SET @sTxt = @sTxt + 'Select * from TBL_DIFF2  ';
				 SET @sTxt = @sTxt + 'union ';
				 SET @sTxt = @sTxt + 'Select * from TBL_DIFF3  ';
				 EXEC (@sTxt) ;
				 PRINT 'Created view view_SchemaDiff.';
			 END;

		 --Select * from TBL_DIFF1 
		 --union
		 --Select * from TBL_DIFF2 
		 --union
		 --Select * from TBL_DIFF3 

		 PRINT 'To see "deltas" - select * from view_SchemaDiff';
		 PRINT '_________________________________________________';
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[Proc_Attach_Delete_Audit]

PRINT 'Create Procedure [dbo].[Proc_Attach_Delete_Audit]';
GO
CREATE PROCEDURE Proc_Attach_Delete_Audit (@Tbl AS nvarchar (500)) 
AS
	 BEGIN

/****************************************************************
*************************************************************
This procedure will copy a table and recreate it using only the
raw column data types to recreate the MIRROR table. No defaults, 
identities, or constraints are copied over. All columns are 
defined as NULLABLE. This new table has the parent table's name
with a suffix of "_DelAudit".

A column "RowDeletionDate" is added to the new table and is 
defaulted to getdate(). An index is applied to this column so
that max perfomance can be acheived when pulling a particular
datetime.

A trigger is added to the parent table using the parent name 
plus a suffix of "_DelTRIG". This trigger only fires when a 
delete operation is completed. It then copies the deleted rows
into the "_DelAudit" table.
*************************************************************
****************************************************************/

/***************************
Declare the needed variables
***************************/

		 --DECLARE @Tbl AS nvarchar (500) = 'EDW_TEST_DEL';

		 DECLARE @Trktbl AS nvarchar (500) = '';
		 DECLARE @Deltriggername AS nvarchar (500) = '';
		 DECLARE @Mysql AS nvarchar (2000) = '';
		 DECLARE @CreateDDL AS nvarchar (max) = '';
		 DECLARE @SelectCOLS AS nvarchar (max) = '';
		 DECLARE @Colname AS nvarchar (254) = '';
		 DECLARE @Dtype AS nvarchar (254) = '';
		 DECLARE @CHARACTER_MAXIMUM_LENGTH AS int;
		 DECLARE @NUMERIC_PRECISION AS int;
		 DECLARE @NUMERIC_SCALE AS int;

/*****************
Set initial values
*****************/

		 SET @Trktbl = @Tbl + '_DelAudit';
		 SET @Deltriggername = @Tbl + '_DelTRIG';
		 IF EXISTS (SELECT
						   Name
					  FROM Sys.Tables
					  WHERE Name = @Trktbl) 
			 BEGIN
				 PRINT 'Dropping table ' + @Trktbl;
				 SET @Mysql = 'DROP TABLE ' + @Trktbl;
				 EXEC Sp_Executesql @Mysql;
				 PRINT 'Dropped table ' + @Trktbl;
			 END;
		 IF OBJECT_ID (@Deltriggername, 'TR') IS NOT NULL
			 BEGIN
				 PRINT 'Dropping TRIGGER ' + @Deltriggername;
				 SET @Mysql = 'DROP TRIGGER ' + @Deltriggername;
				 EXEC Sp_Executesql @Mysql;
			 END;
		 SET @CreateDDL = 'CREATE TABLE ' + @Trktbl + '(';
		 DECLARE Col_Cursor CURSOR
			 FOR SELECT
						Column_Name
					  , Data_Type
					  , CHARACTER_MAXIMUM_LENGTH
					  , NUMERIC_PRECISION
					  , NUMERIC_SCALE
				   FROM Information_Schema.Columns
				   WHERE Table_Name = @Tbl;
		 OPEN Col_Cursor;
		 FETCH Next FROM Col_Cursor INTO @Colname, @Dtype, @CHARACTER_MAXIMUM_LENGTH, @NUMERIC_PRECISION, @NUMERIC_SCALE;
		 WHILE @@Fetch_Status = 0
			 BEGIN
				 SET @SelectCOLS = @SelectCOLS + QUOTENAME (@Colname) + ',';
				 SET @CreateDDL = @CreateDDL + QUOTENAME (@Colname) + ' ' + QUOTENAME (@Dtype) ;
				 IF @Dtype = 'float'
					 BEGIN
						 PRINT 'FLOAT DDL: ' + @CreateDDL;
					 END;
				 ELSE
					 BEGIN
						 IF @Dtype = 'int'
						 OR @Dtype = 'bigint'
						 OR @Dtype = 'tinyint'
						 OR @Dtype = 'smallint'
							 BEGIN
								 PRINT @Dtype + ': INT DDL: ' + @CreateDDL;
							 END;
						 ELSE
							 BEGIN
								 IF @Dtype = 'nvarchar'
								 OR @Dtype = 'varchar'
									 BEGIN
										 PRINT @Dtype + ' DDL: ' + @CreateDDL;
										 IF @CHARACTER_MAXIMUM_LENGTH = -1
											 BEGIN
												 SET @CreateDDL = @CreateDDL + '(max) ';
											 END
										 ELSE
											 BEGIN
												 SET @CreateDDL = @CreateDDL + '(' + CAST (@CHARACTER_MAXIMUM_LENGTH AS nvarchar (50)) + ') ';
											 END;
									 END;
								 ELSE
									 BEGIN
										 IF @Dtype = 'varbinary'
											 BEGIN
												 PRINT @Dtype + ' DDL: ' + @CreateDDL;
												 IF @CHARACTER_MAXIMUM_LENGTH = -1
													 BEGIN
														 SET @CreateDDL = @CreateDDL + '(max) ';
													 END
												 ELSE
													 BEGIN
														 SET @CreateDDL = @CreateDDL + '(' + CAST (@CHARACTER_MAXIMUM_LENGTH AS nvarchar (50)) + ') ';
													 END;
											 END;
										 ELSE
											 BEGIN
												 IF @CHARACTER_MAXIMUM_LENGTH IS NOT NULL
													 BEGIN
														 PRINT '00 - DDL: ' + @CreateDDL;
														 SET @CreateDDL = @CreateDDL + '(' + CAST (@CHARACTER_MAXIMUM_LENGTH AS nvarchar (50)) + ') ';
													 END;
												 ELSE
													 BEGIN
														 IF @NUMERIC_PRECISION IS NOT NULL
														AND @NUMERIC_SCALE IS NOT NULL
															 BEGIN
																 PRINT '01 - DDL: ' + @CreateDDL;
																 SET @CreateDDL = @CreateDDL + '(' + CAST (@NUMERIC_PRECISION AS nvarchar (50)) + ', ' + CAST (@NUMERIC_SCALE AS nvarchar (50)) + ') ';
															 END;
														 ELSE
															 BEGIN
																 IF @NUMERIC_PRECISION IS NOT NULL
																AND @NUMERIC_SCALE IS NULL
																	 BEGIN
																		 PRINT '02 - DDL: ' + @CreateDDL;
																		 SET @CreateDDL = @CreateDDL + '(' + CAST (@NUMERIC_PRECISION AS nvarchar (50)) + ', ' + CAST (@NUMERIC_SCALE AS nvarchar (50)) + ') ';
																	 END;
																 ELSE
																	 BEGIN
																		 IF @CHARACTER_MAXIMUM_LENGTH IS NOT NULL
																			 BEGIN
																				 PRINT '03 - DDL: ' + @CreateDDL;
																				 IF @CHARACTER_MAXIMUM_LENGTH = -1
																					 BEGIN
																						 SET @CreateDDL = @CreateDDL + '(max) ';
																					 END
																				 ELSE
																					 BEGIN
																						 SET @CreateDDL = @CreateDDL + '(' + CAST (@CHARACTER_MAXIMUM_LENGTH AS nvarchar (50)) + ') ';
																					 END;
																			 END;
																		 ELSE
																			 BEGIN
																				 PRINT '04 - DDL: ' + @CreateDDL;
																			 END;;
																	 END;
															 END;
													 END;
											 END;
									 END;
							 END;
					 END;
				 SET @CreateDDL = @CreateDDL + ' NULL, ';

				 -- PRINT ('05 - DDL: ' + @CreateDDL);		 

				 FETCH Next FROM Col_Cursor INTO @Colname, @Dtype, @CHARACTER_MAXIMUM_LENGTH, @NUMERIC_PRECISION, @NUMERIC_SCALE;

/*********************************************************************
				 --TURN On these statements when needed to track individual items.
				 print (@Colname) ;
				 print (@Dtype) ;
				 print ( @CHARACTER_MAXIMUM_LENGTH) ;
				 print ( @NUMERIC_PRECISION) ;
				 print ( @NUMERIC_SCALE ) ;
*********************************************************************/

			 END;
		 CLOSE Col_Cursor;
		 DEALLOCATE Col_Cursor;

		 --Strip off the last COMMA

		 SET @SelectCOLS = RTRIM (@SelectCOLS) ;
		 SET @CreateDDL = RTRIM (@CreateDDL) ;
		 SET @CreateDDL = LEFT (@CreateDDL, LEN (@CreateDDL) - 1) ;
		 SET @CreateDDL = @CreateDDL + ')';
		 PRINT '____________________________________________________________';
		 PRINT '1 - Creating table ' + @Trktbl;
		 PRINT '2- DLL: ';
		 PRINT '3- ' + @CreateDDL;
		 EXEC Sp_Executesql @CreateDDL;
		 PRINT '____________________________________________________________';
		 IF EXISTS (SELECT
						   Name
					  FROM Sys.Tables
					  WHERE Name = @Trktbl) 
			 BEGIN
				 SET @Mysql = 'alter table ' + @Trktbl + ' add RowDeletionDate datetime default getdate() ';
				 EXEC Sp_Executesql @Mysql;
				 PRINT 'Added RowDeletionDate: ';
			 END;
		 SET @CreateDDL = 'CREATE NONCLUSTERED INDEX [PI_' + @Trktbl + '] ON [' + @Trktbl + '] ';
		 SET @CreateDDL = @CreateDDL + '(';
		 SET @CreateDDL = @CreateDDL + '	[RowDeletionDate] ASC ';
		 SET @CreateDDL = @CreateDDL + ')';
		 EXEC Sp_Executesql @CreateDDL;
		 PRINT 'Added RowDeletionDate INDEX ';
		 SET @CreateDDL = '';
		 SET @CreateDDL = @CreateDDL + 'CREATE TRIGGER ' + @Tbl + '_DelTRIG ';
		 SET @CreateDDL = @CreateDDL + '    ON ' + @Tbl;
		 SET @CreateDDL = @CreateDDL + '    FOR DELETE ';
		 SET @CreateDDL = @CreateDDL + 'AS ';
		 SET @CreateDDL = @CreateDDL + '	INSERT INTO ' + @Trktbl + ' SELECT ' + @SelectCOLS + ' getdate() from deleted ';
		 EXEC Sp_Executesql @CreateDDL;
		 PRINT 'Added ' + @Tbl + ' TRIGGER';
		 PRINT @CreateDDL;
		 DECLARE @viewname AS nvarchar (250) = '';
		 SET @viewname = 'view_EDW_' + @Tbl + '_DelAudit ';
		 IF EXISTS (SELECT
						   name
					  FROM sys.views
					  WHERE name = @viewname) 
			 BEGIN
				 SET @Mysql = 'drop view ' + @viewname;
				 EXEC Sp_Executesql @Mysql;
				 PRINT 'Dropped existing view ' + @viewname;
			 END;
		 SET @CreateDDL = '';
		 SET @CreateDDL = @CreateDDL + 'CREATE VIEW view_EDW_' + @Tbl + '_DelAudit ';
		 SET @CreateDDL = @CreateDDL + 'AS ';
		 SET @CreateDDL = @CreateDDL + ' SELECT * from ' + @Trktbl;
		 EXEC Sp_Executesql @CreateDDL;
		 PRINT 'Added VIEW: ' + @viewname;
		 PRINT @CreateDDL;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Trigger [trgSchemaMonitor]

PRINT 'Create Trigger [trgSchemaMonitor]';
GO

--disable TRIGGER dbo.trgSchemaMonitor

CREATE TRIGGER trgSchemaMonitor ON DATABASE
	FOR DDL_DATABASE_LEVEL_EVENTS
AS
	 DECLARE @data xml;
	 DECLARE @IPADDR nvarchar (254) ;
	 DECLARE @CUR_User nvarchar (254) ;
	 SET @CUR_User = SYSTEM_USER;
	 SET @IPADDR = (SELECT
						   CONVERT (nvarchar (254) , CONNECTIONPROPERTY ('client_net_address'))) ;
	 SET @data = EVENTDATA () ;
	 SET NOCOUNT ON;
	 INSERT INTO SchemaChangeMonitor (
				 PostTime
			   , DB_User
			   , IP_Address
			   , CUR_User
			   , OBJ
			   , Event
			   , TSQL) 
	 VALUES
			(GETDATE () , CONVERT (nvarchar (254) , CURRENT_USER) , @IPADDR, @CUR_User, @data.value ('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(254)') , @data.value ('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(254)') , @data.value ('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(max)')) ;
	 SET NOCOUNT OFF;

--THIS WILL DELETE records older than 90 days.
--delete from SchemaChangeMonitor where PostTime < getdate() - 90 ;

GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create View [dbo].[view_EDW_Awards]

PRINT 'Create View [dbo].[view_EDW_Awards]';
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
CREATE VIEW view_EDW_Awards
AS

	 --*************************************************************************************
	 -- 2.3.2015 : WDM - Created the initial view for Awards (HEW)
	 -- 2.3.2015 : WDM - Laura B. had objections as to how the data was pulled, Nate agreed
	 --					to look at it again.
	 --*************************************************************************************

	 SELECT
			AWARD.*
		  , ATYPE.AwardType
		  , ATRIGGER.RewardTriggerLKPName
		  , ATRIGGER.RewardTriggerRewardActivityLKPID
		  , ATRIGGER.RewardTriggerLKPDisplayName
		  , ATRIGGER.HESCode
	   FROM HFit_HES_Award AS AWARD
				JOIN HFit_LKP_RewardTrigger AS ATRIGGER
					ON AWARD.RewardTriggerID = ATRIGGER.RewardTriggerLKPID
				JOIN HFit_LKP_HES_AwardType AS ATYPE
					ON AWARD.HESAwardID = ATYPE.itemID;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create View [dbo].[view_EDW_EligibilityHistory]

PRINT 'Create View [dbo].[view_EDW_EligibilityHistory]';
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

--************************************************************************************
--view_EDW_EligibilityHistory provides users access to the EDW_GroupMemberHistory table.
--************************************************************************************

CREATE VIEW view_EDW_EligibilityHistory
AS
	 SELECT
			GroupName
		  , UserMpiNumber
		  , StartedDate
		  , EndedDate
		  , RowNbr
	   FROM dbo.EDW_GroupMemberHistory;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create View [dbo].[view_EDW_HealthAssessmentDefinition_Staged]

PRINT 'Create View [dbo].[view_EDW_HealthAssessmentDefinition_Staged]';
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
CREATE VIEW dbo.view_EDW_HealthAssessmentDefinition_Staged
AS

	 --****************************************************************************
	 --09/04/2014 WDM
	 --The view Health Assessment Definition runs very poorly. This view/table is 
	 --created as as a staging table allowing the data to already exist when the 
	 --EDW needs it. This is the view that data from the staging table 
	 --(EDW_HealthAssessmentDefinition) allowing the EDW to launch a much faster 
	 --start when processing Health Assessment Definition data.
	 --****************************************************************************

	 SELECT
			SiteGuid
		  , AccountCD
		  , HANodeID
		  , HANodeName
		  , HADocumentID
		  , HANodeSiteID
		  , HADocPubVerID
		  , ModTitle
		  , IntroText
		  , ModDocGuid
		  , ModWeight
		  , ModIsEnabled
		  , ModCodeName
		  , ModDocPubVerID
		  , RCTitle
		  , RCWeight
		  , RCDocumentGUID
		  , RCIsEnabled
		  , RCCodeName
		  , RCDocPubVerID
		  , RATytle
		  , RAWeight
		  , RADocumentGuid
		  , RAIsEnabled
		  , RACodeName
		  , RAScoringStrategyID
		  , RADocPubVerID
		  , QuestionType
		  , QuesTitle
		  , QuesWeight
		  , QuesIsRequired
		  , QuesDocumentGuid
		  , QuesIsEnabled
		  , QuesIsVisible
		  , QuesIsSTaging
		  , QuestionCodeName
		  , QuesDocPubVerID
		  , AnsValue
		  , AnsPoints
		  , AnsDocumentGuid
		  , AnsIsEnabled
		  , AnsCodeName
		  , AnsUOM
		  , AnsDocPUbVerID
		  , ChangeType
		  , DocumentCreatedWhen
		  , DocumentModifiedWhen
		  , CmsTreeNodeGuid
		  , HANodeGUID
	   FROM dbo.EDW_HealthAssessmentDefinition;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create View [dbo].[view_EDW_HealthAssessment_Staged]

PRINT 'Create View [dbo].[view_EDW_HealthAssessment_Staged]';
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
CREATE VIEW dbo.view_EDW_HealthAssessment_Staged
AS

	 --****************************************************************************
	 --09/04/2014 WDM
	 --The view Health Assessment runs poorly. This view/table is created as 
	 --as a staging table allowing the data to already exist when the EDW needs it.
	 --This is the view that pulls data from the staging table (EDW_HealthAssessment) 
	 --allowing the EDW to launch a much faster start when processing Health 
	 --Assessment data.
	 --****************************************************************************

	 SELECT
			UserStartedItemID
		  , HealthAssesmentUserStartedNodeGUID
		  , UserID
		  , UserGUID
		  , HFitUserMpiNumber
		  , SiteGUID
		  , AccountID
		  , AccountCD
		  , HAStartedDt
		  , HACompletedDt
		  , UserModuleItemId
		  , UserModuleCodeName
		  , HAModuleNodeGUID
		  , CMSNodeGuid
		  , HAModuleVersionID
		  , UserRiskCategoryItemID
		  , UserRiskCategoryCodeName
		  , HARiskCategoryNodeGUID
		  , HARiskCategoryVersionID
		  , UserRiskAreaItemID
		  , UserRiskAreaCodeName
		  , HARiskAreaNodeGUID
		  , HARiskAreaVersionID
		  , UserQuestionItemID
		  , Title
		  , HAQuestionGuid
		  , UserQuestionCodeName
		  , HAQuestionDocumentID
		  , HAQuestionVersionID
		  , HAQuestionNodeGUID
		  , UserAnswerItemID
		  , HAAnswerNodeGUID
		  , HAAnswerVersionID
		  , UserAnswerCodeName
		  , HAAnswerValue
		  , HAModuleScore
		  , HARiskCategoryScore
		  , HARiskAreaScore
		  , HAQuestionScore
		  , HAAnswerPoints
		  , PointResults
		  , UOMCode
		  , HAScore
		  , ModulePreWeightedScore
		  , RiskCategoryPreWeightedScore
		  , RiskAreaPreWeightedScore
		  , QuestionPreWeightedScore
		  , QuestionGroupCodeName
		  , ChangeType
		  , IsProfessionallyCollected
		  , ItemCreatedWhen
		  , ItemModifiedWhen
		  , HARiskCategory_ItemModifiedWhen
		  , HAUserRiskArea_ItemModifiedWhen
		  , HAUserQuestion_ItemModifiedWhen
		  , HAUserAnswers_ItemModifiedWhen
	   FROM dbo.EDW_HealthAssessment;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create View [dbo].[view_EDW_BiometricViewRejectCriteria]

PRINT 'Create View [dbo].[view_EDW_BiometricViewRejectCriteria]';
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
CREATE VIEW view_EDW_BiometricViewRejectCriteria
AS
	 SELECT
			AccountCD
		  , ItemCreatedWhen
		  , SiteID
		  , RejectGUID
	   FROM dbo.EDW_BiometricViewRejectCriteria;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create View [dbo].[view_EDW_ScreeningsFromTrackers]

PRINT 'Create View [dbo].[view_EDW_ScreeningsFromTrackers]';
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

--********************************************************************************************************
--09.11.2014 : (wdm) Verified last mod date available to EDW 
--********************************************************************************************************

CREATE VIEW dbo.view_EDW_ScreeningsFromTrackers
AS
	 SELECT
			t.userid
		  , t.EventDate
		  , t.TrackerCollectionSourceID
		  , t.ItemCreatedBy
		  , t.ItemCreatedWhen
		  , t.ItemModifiedBy
		  , t.ItemModifiedWhen
	   FROM (
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerBloodPressure
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerBloodSugarAndGlucose
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerBMI
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerBodyFat
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerBodyMeasurements
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerCardio
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerCholesterol
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerDailySteps
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerFlexibility
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerFruits
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerHbA1c
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerHeight
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerHighFatFoods
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerHighSodiumFoods
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerInstance_Tracker
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerMealPortions
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerMedicalCarePlan
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerRegularMeals
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerRestingHeartRate
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerShots
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerSitLess
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerSleepPlan
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerStrength
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerStress
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerStressManagement
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerSugaryDrinks
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerSugaryFoods
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerTests
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerTobaccoFree
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerVegetables
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerWater
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerWeight
			 UNION ALL
			 SELECT
					userid
				  , eventdate
				  , TrackerCollectionSourceID
				  , ItemCreatedBy
				  , ItemCreatedWhen
				  , ItemModifiedBy
				  , ItemModifiedWhen
			   FROM HFit_TrackerWholeGrains) AS T
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON t.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
	   WHERE HFTCS.isProfessionallyCollected = 1;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[proc_AddRejectMPI]

PRINT 'Create Procedure [dbo].[proc_AddRejectMPI]';
GO
CREATE PROC proc_AddRejectMPI (@MpiToReject AS int) 
AS
	 BEGIN
		 INSERT INTO dbo.HFit_LKP_EDW_RejectMPI (
					 RejectMPICode
				   , ItemCreatedWhen
				   , ItemModifiedWhen) 
		 VALUES
				(@MpiToReject, GETDATE () , GETDATE ()) ;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[proc_Delete_EDW_BiometricViewRejectCriteria_Acct]

PRINT 'Create Procedure [dbo].[proc_Delete_EDW_BiometricViewRejectCriteria_Acct]';
GO
CREATE PROC proc_Delete_EDW_BiometricViewRejectCriteria_Acct (@AccountCD AS nvarchar (50) 
															, @ItemCreatedWhen AS datetime) 
AS
	 BEGIN
		 DELETE FROM dbo.EDW_BiometricViewRejectCriteria
		 WHERE
			   AccountCD = @AccountCD
		   AND ItemCreatedWhen = @ItemCreatedWhen;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[proc_Delete_EDW_BiometricViewRejectCriteria_Site]

PRINT 'Create Procedure [dbo].[proc_Delete_EDW_BiometricViewRejectCriteria_Site]';
GO
CREATE PROC proc_Delete_EDW_BiometricViewRejectCriteria_Site (@SiteID AS int
															, @ItemCreatedWhen AS datetime) 
AS
	 BEGIN
		 DELETE FROM dbo.EDW_BiometricViewRejectCriteria
		 WHERE
			   SiteID = @SiteID
		   AND ItemCreatedWhen = @ItemCreatedWhen;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[proc_EDW_EligibilityExpired]

PRINT 'Create Procedure [dbo].[proc_EDW_EligibilityExpired]';
GO

--exec proc_EDW_EligibilityExpired

CREATE PROCEDURE proc_EDW_EligibilityExpired
AS
	 BEGIN

		 --******************************************************************************************
		 --proc_EDW_EligibilityExpired looks for PPT group memebers that existed previously and
		 --    does not currently exist in the daily pull. If one is found missing from the daily,
		 --    that PPT is maked with an END DATE indicating the participation within that group
		 --    for that PPT has ended. Every 1,000 records processed will generate a message and at
		 --    the end, a total records closed count will be displayed.
		 --    Step 1 - Call procedure proc_EDW_EligibilityDaily
		 --    Step 2 - Call procedure proc_EDW_EligibilityStarted
		 --    Step 3 - Call procedure proc_EDW_EligibilityExpired
		 --    Step 4 - Retrieve the PPT membership history using the view view_EDW_EligibilityHistory
		 --******************************************************************************************

		 SET NOCOUNT OFF;
		 PRINT 'Starting [proc_EDW_EligibilityExpired] NOW: ' + CAST (GETDATE () AS nvarchar (50)) ;
		 DECLARE @iCnt AS integer = 0;

		 --SET @iCnt = (SELECT COUNT (*) 
		 --			FROM EDW_GroupMemberHistory
		 --			WHERE EndedDate IS NULL AND UserMpiNumber IS NOT NULL AND UserMpiNumber NOT IN (
		 --																							SELECT HFitUserMpiNumber
		 --																							  FROM EDW_GroupMemberToday)) ;

		 SET @iCnt = (SELECT
							 COUNT (*) 
						FROM EDW_GroupMemberHistory AS HIST WITH (NOLOCK) 
								 LEFT JOIN EDW_GroupMemberToday AS TDAY WITH (NOLOCK) 
									 ON HIST.UserMpiNumber = TDAY.HFitUserMpiNumber
						WHERE HIST.EndedDate IS NULL
						  AND TDAY.HFitUserMpiNumber IS NULL) ;
		 IF @iCnt > 0
			 BEGIN
				 PRINT CAST (@iCnt AS nvarchar (50)) + ' EligibilityExpired PPTs FOUND: ' + CAST (GETDATE () AS nvarchar (50)) ;
				 UPDATE HIST
				 SET
					 EndedDate = GETDATE () 
				   FROM EDW_GroupMemberHistory HIST WITH (NOLOCK) 
							LEFT JOIN EDW_GroupMemberToday TDAY WITH (NOLOCK) 
								ON HIST.UserMpiNumber = TDAY.HFitUserMpiNumber
				   WHERE
						 HIST.EndedDate IS NULL
					 AND TDAY.HFitUserMpiNumber IS NULL;

			 --WITH ExpiredPPT (EndedDate, RowNbr) 
			 -- AS (SELECT EndedDate, RowNbr
			 --	   FROM EDW_GroupMemberHistory
			 --	   WHERE EndedDate IS NULL AND UserMpiNumber IS NOT NULL AND UserMpiNumber NOT IN (
			 --																					   SELECT HFitUserMpiNumber
			 --																						 FROM EDW_GroupMemberToday)) 
			 -- UPDATE ExpiredPPT
			 -- SET EndedDate = GETDATE () ;

			 END;
		 ELSE
			 BEGIN
				 PRINT 'NO EligibilityExpired PPTs: ' + CAST (GETDATE () AS nvarchar (50)) ;
			 END;
		 PRINT 'Completed proc_EDW_EligibilityExpired: ' + CAST (GETDATE () AS nvarchar (50)) ;
		 PRINT '*******************************************************';
		 PRINT 'Ending NOW: ' + CAST (GETDATE () AS nvarchar (50)) ;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[proc_DelRejectMPI]

PRINT 'Create Procedure [dbo].[proc_DelRejectMPI]';
GO
CREATE PROC proc_DelRejectMPI (@MpiToReject AS int) 
AS
	 BEGIN
		 DELETE FROM dbo.HFit_LKP_EDW_RejectMPI
		 WHERE
			   RejectMPICode = @MpiToReject;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[proc_GetRecordCount]

PRINT 'Create Procedure [dbo].[proc_GetRecordCount]';
GO
CREATE PROCEDURE proc_GetRecordCount (@TblView AS nvarchar (80)) 
AS
	 BEGIN

		 --declare @TblView nvarchar(80); 
		 --set @TblView = 'view_EDW_TrackerMetadata';

		 DECLARE @rowcount TABLE (
								 Value int) ;
		 DECLARE @ActualNumberOfResults int;
		 DECLARE @StartTime datetime;
		 DECLARE @EndTime datetime;
		 DECLARE @iCnt int;
		 DECLARE @qry varchar (56) ;
		 DECLARE @T int;
		 DECLARE @hrs int;
		 DECLARE @mins int;
		 DECLARE @secs int;
		 DECLARE @ms int;
		 SET @StartTime = GETDATE () ;
		 SET @qry = 'select COUNT(*) as RecCount from  ' + @TblView;
		 INSERT INTO @rowcount
		 EXEC (@qry) ;
		 SELECT
				@ActualNumberOfResults = Value
		   FROM @rowcount;
		 SET @EndTime = GETDATE () ;
		 SET @T = DATEDIFF (ms, @StartTime, @EndTime) ;
		 SET @hrs = @T / 56000 % 100;
		 SET @mins = @T / 560 % 100;
		 SET @secs = @T / 100 % 100;
		 SET @ms = @T % 100 * 10;
		 SET @EndTime = (SELECT
								DATEADD (hour, @T / 56000 % 100, DATEADD (minute, @T / 560 % 100, DATEADD (second, @T / 100 % 100, DATEADD (millisecond, @T % 100 * 10, CAST ('00:00:00' AS time (2))))))) ;
		 PRINT @ActualNumberOfResults;
		 PRINT @EndTime;
		 PRINT @TblView + ' row cnt = ' + CAST (@iCnt AS varchar (20)) ;
		 INSERT INTO dbo.EDW_PerformanceMeasure (
					 TypeTest
				   , ObjectName
				   , RecCount
				   , StartTime
				   , EndTime
				   , hrs
				   , mins
				   , secs
				   , ms) 
		 VALUES
				('RowCount', @TblView, @ActualNumberOfResults, @StartTime, @T, @hrs, @mins, @secs, @ms) ;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[proc_EDW_EligibilityStarted]

PRINT 'Create Procedure [dbo].[proc_EDW_EligibilityStarted]';
GO
CREATE PROCEDURE proc_EDW_EligibilityStarted
AS
	 BEGIN
		 SET NOCOUNT ON;

		 --**********************************************************************************************************
		 --*******************************************************************************************************
		 --    This procedure, proc_EDW_EligibilityStarted, is a starting point point for new PPTs that are eligibile
		 --    to participate. In order to capture those PPTs that may have closed and eligibility, lost it, or had it
		 --    expire, an END DATE is also tracked. This is done through the table, EDW_GroupMemberHistory.
		 --    Step 1 - Call procedure proc_EDW_EligibilityDaily
		 --    Step 2 - Call procedure proc_EDW_EligibilityStarted
		 --    Step 3 - Call procedure proc_EDW_EligibilityExpired
		 --    Step 4 - Retrieve the PPT membership history using the view view_EDW_EligibilityHistory
		 --    *******************************************************************************************************
		 --**********************************************************************************************************

		 PRINT 'Starting proc_EDW_EligibilityStarted: ' + CAST (GETDATE () AS nvarchar (50)) ;
		 WITH NewPPT (
			  GroupName
			, MpiNumber) 
			 AS (SELECT
						GroupName
					  , HFitUserMpiNumber
				   FROM EDW_GroupMemberToday
				 EXCEPT
				 SELECT
						GroupName
					  , UserMpiNumber
				   FROM EDW_GroupMemberHistory
				   WHERE EndedDate IS NULL) 
			 INSERT INTO EDW_GroupMemberHistory (
						 GroupName
					   , UserMpiNumber
					   , StartedDate) 
			 SELECT
					GroupName
				  , MpiNumber
				  , (
					 SELECT
							CONVERT (date, GETDATE () , 110)) AS Today
			   FROM NewPPT;
		 DECLARE @iAdded AS int = 0;
		 SET @iAdded = (SELECT
							   COUNT (*) 
						  FROM EDW_GroupMemberHistory
						  WHERE CAST (StartedDate AS date) = CAST (GETDATE () AS date)) ;
		 SET NOCOUNT OFF;
		 PRINT CAST (@iAdded AS nvarchar (50)) + ' Eligibility Records Processed on: ' + CAST (GETDATE () AS nvarchar (50)) ;
		 PRINT 'Ending [proc_EDW_EligibilityStarted]: ' + CAST (GETDATE () AS nvarchar (50)) ;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[proc_EDW_MeasurePerf]

PRINT 'Create Procedure [dbo].[proc_EDW_MeasurePerf]';
GO
CREATE PROCEDURE dbo.proc_EDW_MeasurePerf (@TypeTest AS nvarchar (50) 
										 , @ObjectName AS nvarchar (50) 
										 , @RecCount AS int
										 , @StartTime AS datetime
										 , @EndTime AS datetime) 
AS
	 BEGIN
		 DECLARE @T int;
		 DECLARE @eSecs int;
		 DECLARE @hrs int;
		 DECLARE @mins int;
		 DECLARE @secs int;
		 DECLARE @ms int;
		 IF @EndTime IS NULL
			 BEGIN
				 SET @EndTime = GETDATE () ;
			 END;
		 PRINT '@EndTime: ' + CAST (@EndTime AS nvarchar (20)) ;
		 SET @ms = DATEDIFF (ms, @StartTime, @EndTime) ;
		 SET @secs = DATEDIFF (ss, @StartTime, @EndTime) ;
		 SET @mins = DATEDIFF (mi, @StartTime, @EndTime) ;
		 SET @hrs = DATEDIFF (hh, @StartTime, @EndTime) ;

		 --set @hrs = @T / 1000000 % 100 ;
		 --set @mins = @T / 10000 % 100 ;
		 --set @secs = @T / 100 % 100 ;
		 --set @ms = @T % 1000 % 10 ;
		 --set @EndTime = (select dateadd(hour, (@T / 1000000) % 100,
		 --	   dateadd(minute, (@T / 10000) % 100,
		 --	   dateadd(second, (@T / 100) % 100,
		 --	   dateadd(millisecond, (@T % 100) * 10, cast('00:00:00' as time(2))))))  );

		 INSERT INTO dbo.EDW_PerformanceMeasure (
					 TypeTest
				   , ObjectName
				   , RecCount
				   , StartTime
				   , EndTime
				   , hrs
				   , mins
				   , secs
				   , ms) 
		 VALUES
				(@TypeTest, @ObjectName, @RecCount, @StartTime, @EndTime, @hrs, @mins, @secs, @ms) ;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[proc_Insert_EDW_BiometricViewRejectCriteria]

PRINT 'Create Procedure [dbo].[proc_Insert_EDW_BiometricViewRejectCriteria]';
GO
CREATE PROC proc_Insert_EDW_BiometricViewRejectCriteria (@AccountCD AS nvarchar (50) 
													   , @ItemCreatedWhen AS datetime
													   , @SiteID AS int) 
AS
	 BEGIN
		 IF @SiteID IS NULL
			 BEGIN
				 SET @SiteID = -1
			 END;
		 DECLARE @iCnt integer = 0;
		 SET @iCnt = (SELECT
							 COUNT (*) 
						FROM EDW_BiometricViewRejectCriteria
						WHERE AccountCD = @AccountCD
						  AND SiteID = @SiteID) ;
		 IF @iCnt <= 0
			 BEGIN
				 INSERT INTO dbo.EDW_BiometricViewRejectCriteria (
							 AccountCD
						   , ItemCreatedWhen
						   , SiteID) 
				 VALUES
						(@AccountCD, @ItemCreatedWhen, @SiteID) ;
				 PRINT 'ADDED ' + @AccountCD + ' to EDW_BiometricViewRejectCriteria.';
			 END;
		 ELSE
			 BEGIN
				 PRINT 'Account ' + @AccountCD + ' already defined to EDW_BiometricViewRejectCriteria.';
			 END;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create View [dbo].[view_EDW_TrackerCompositeDetails]

PRINT 'Create View [dbo].[view_EDW_TrackerCompositeDetails]';
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
CREATE VIEW dbo.view_EDW_TrackerCompositeDetails
AS

	 --************************************************************************************************************************************
	 -- NOTES:
	 --************************************************************************************************************************************
	 --WDM 6/26/2014
	 --This view is needed by EDW in order to process the Tracker tables' data.
	 --As of now, the Tracker tables are representative of objects and that would cause 
	 --	large volumes of ETL to be devloped and maintained. 
	 --This view represents a columnar representation of all tracker tables in a Key/Value pair representation.
	 --Each tracker table to be processed into the EDW must be represented in this view.
	 --ALL new tracker tables need only be entered once using the structure contained within this view
	 --	and the same EDW ETL should be able to process it.
	 --If there is a change to the strucuture of any one query in this view, then all have to be modified 
	 --	to be support the change.
	 --Column TrackerNameAggregratetable (AggregateTableName) will be NULL if the Tracker is not a member 
	 --		of the DISPLAYED Trackers. This allows us to capture all trackers, displayed or not.
	 --7/29/2014
	 --ISSUE: HFit_TrackerBMI,  HFit_TrackerCholesterol, and HFit_TrackerHeight are not in the HFIT_Tracker
	 --		table. This causes T.IsAvailable, T.IsCustom, T.UniqueName to be NULL. 
	 --		This raises the need for the Tracker Definition Table.
	 --NOTE: It is a goal to keep this view using BASE tables in order to gain max performance. Nested views will 
	 --		be avoided here if possible.
	 --**************** SPECIFIC TRACKER DATA **********************
	 --**************** on 7/29/2014          **********************
	 --Tracker GUID or Unique ID across all DB Instances (ItemGuid)
	 --Tracker NodeID (we use it for the External ID for Audit and error Triage)  (John: can use ItemID in this case)
	 --Tracker Table Name or Value Group Name (e.g. Body Measurements) - Categorization (TrackerNameAggregateTable)
	 --Tracker Column Unique Name ( In English)  Must be consistent across all DB Instances  ([UniqueName] will be 
	 --		the TABLE NAME if tracker name not found in the HFIT_Tracker table)
	 --Tracker Column Description (In English) (???)
	 --Tracker Column Data Type (e.g. Character, Numeric, Date, Bit or Yes/No) – so that we can set up the answer type
	 --	NULLS accepted for No Answer?	(KEY1, KEY2, VAL1, VAL2, etc)
	 --Tracker Active flag (IsAvailable will be null if tracker name not found in the HFIT_Tracker table)
	 --Tracker Unit of Measure (character) (Currently, the UOM is supplied in the view based on the table and type of Tracker)
	 --Tracker Insert Date ([ItemCreatedWhen])
	 --Tracker Last Update Date ([ItemModifiedWhen])
	 --NOTE: Convert all numerics to floats 7/30/2104 John/Dale
	 --****************************************************************************************************************************
	 -- 12.23.2014 - Added the Vendor ID and Vendor name to the view via the HFit_LKP_TrackerVendor table
	 -- 12.25.2014 - Tested the view to see that it returned the correct VendorID description
	 --************************************************************************************************************************************
	 --USE:
	 --select * from view_EDW_TrackerCompositeDetails where EventDate between '2013-11-01 15:02:00.000' and '2013-12-01 15:02:00.000'
	 --Set statistics IO ON
	 --GO

	 SELECT
			'HFit_TrackerBloodPressure' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'mm/Hg' AS UOM
		  , 'Systolic' AS KEY1
		  , CAST (Systolic AS float) AS VAL1
		  , 'Diastolic' AS KEY2
		  , CAST (Diastolic AS float) AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , ISNULL (T.UniqueName, 'bp') AS UniqueName
		  , ISNULL (T.UniqueName, 'bp') AS ColDesc
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerBloodPressure AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerBloodPressure'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT
			'HFit_TrackerBloodSugarAndGlucose' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'mmol/L' AS UOM
		  , 'Units' AS KEY1
		  , CAST (Units AS float) AS VAL1
		  , 'FastingState' AS KEY2
		  , CAST (FastingState AS float) AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , ISNULL (T.UniqueName, 'glucose') AS UniqueName
		  , ISNULL (T.UniqueName, 'glucose') AS ColDesc
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerBloodSugarAndGlucose AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerBloodSugarAndGlucose'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT
			'HFit_TrackerBMI' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'kg/m2' AS UOM
		  , 'BMI' AS KEY1
		  , CAST (BMI AS float) AS VAL1
		  , 'NA' AS KEY2
		  , 0 AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , TT.ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , ISNULL (T.UniqueName, 'HFit_TrackerBMI') AS UniqueName
		  , ISNULL (T.UniqueName, 'HFit_TrackerBMI') AS ColDesc
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerBMI AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerBMI'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT
			'HFit_TrackerBodyFat' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'PCT' AS UOM
		  , 'Value' AS KEY1
		  , CAST ([Value] AS float) AS VAL1
		  , 'NA' AS KEY2
		  , 0 AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemModifiedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , ISNULL (T.UniqueName, 'HFit_TrackerBodyFat') AS UniqueName
		  , ISNULL (T.UniqueName, 'HFit_TrackerBodyFat') AS ColDesc
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerBodyFat AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerBodyFat'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION

	 --******************************************************************************

	 SELECT
			'HFit_TrackerBodyMeasurements' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'Inch' AS UOM
		  , 'WaistInches' AS KEY1
		  , CAST (WaistInches AS float) AS VAL1
		  , 'HipInches' AS KEY2
		  , CAST (HipInches AS float) AS VAL2
		  , 'ThighInches' AS KEY3
		  , CAST (ThighInches AS float) AS VAL3
		  , 'ArmInches' AS KEY4
		  , CAST (ArmInches AS float) AS VAL4
		  , 'ChestInches' AS KEY5
		  , CAST (ChestInches AS float) AS VAL5
		  , 'CalfInches' AS KEY6
		  , CAST (CalfInches AS float) AS VAL6
		  , 'NeckInches' AS KEY7
		  , CAST (NeckInches AS float) AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemModifiedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedWhen
		  , IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerBodyMeasurements AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerBodyMeasurements'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID

	 --******************************************************************************

	 UNION
	 SELECT
			'HFit_TrackerCardio' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'NA' AS UOM
		  , 'Minutes' AS KEY1
		  , CAST (Minutes AS float) AS VAL1
		  , 'Distance' AS KEY2
		  , CAST (Distance AS float) AS VAL2
		  , 'DistanceUnit' AS KEY3
		  , CAST (DistanceUnit AS float) AS VAL3
		  , 'Intensity' AS KEY4
		  , CAST (Intensity AS float) AS VAL4
		  , 'ActivityID' AS KEY5
		  , CAST (ActivityID AS float) AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemModifiedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , NULL AS VendorID

			--VENDOR.ItemID as VendorID

		  , NULL AS VendorName

	 --VENDOR.VendorName

	   FROM dbo.HFit_TrackerCardio AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerCardio'

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			'HFit_TrackerCholesterol' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'mg/dL' AS UOM
		  , 'HDL' AS KEY1
		  , CAST (HDL AS float) AS VAL1
		  , 'LDL' AS KEY2
		  , CAST (LDL AS float) AS VAL2
		  , 'Total' AS KEY3
		  , CAST (Total AS float) AS VAL3
		  , 'Tri' AS KEY4
		  , CAST (Tri AS float) AS VAL4
		  , 'Ratio' AS KEY5
		  , CAST (Ratio AS float) AS VAL5
		  , 'Fasting' AS KEY6
		  , CAST (Fasting AS float) AS VAL6
		  , 'VLDL' AS VLDL
		  , CAST (VLDL AS float) AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , ISNULL (T.UniqueName, 'HFit_TrackerCholesterol') AS UniqueName
		  , ISNULL (T.UniqueName, 'HFit_TrackerCholesterol') AS ColDesc
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerCholesterol AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerCholesterol'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT
			'HFit_TrackerDailySteps' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'Step' AS UOM
		  , 'Steps' AS KEY1
		  , CAST (Steps AS float) AS VAL1
		  , 'NA' AS KEY2
		  , NULL AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , ISNULL (T.UniqueName, 'HFit_TrackerDailySteps') AS UniqueName
		  , ISNULL (T.UniqueName, 'HFit_TrackerDailySteps') AS ColDesc
		  , NULL AS VendorID

			--VENDOR.ItemID as VendorID

		  , NULL AS VendorName

	 --VENDOR.VendorName

	   FROM dbo.HFit_TrackerDailySteps AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerDailySteps'

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			'HFit_TrackerFlexibility' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'Y/N' AS UOM
		  , 'HasStretched' AS KEY1
		  , CAST (HasStretched AS float) AS VAL1
		  , 'NA' AS KEY2
		  , NULL AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'Activity' AS TXTKEY1
		  , Activity AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , NULL AS VendorID

			--VENDOR.ItemID as VendorID

		  , NULL AS VendorName

	 --VENDOR.VendorName

	   FROM dbo.HFit_TrackerFlexibility AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerFlexibility'

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			'HFit_TrackerFruits' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'CUP(8oz)' AS UOM
		  , 'Cups' AS KEY1
		  , CAST (Cups AS float) AS VAL1
		  , 'NA' AS KEY2
		  , NULL AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , NULL AS VendorID

			--VENDOR.ItemID as VendorID

		  , NULL AS VendorName

	 --VENDOR.VendorName

	   FROM dbo.HFit_TrackerFruits AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerFruits'

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			'HFit_TrackerHbA1c' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'mmol/mol' AS UOM
		  , 'Value' AS KEY1
		  , CAST ([Value] AS float) AS VAL1
		  , 'NA' AS KEY2
		  , NULL AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerHbA1c AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerHbA1c'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT
			'HFit_TrackerHeight' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'inch' AS UOM
		  , 'Height' AS KEY1
		  , Height AS VAL1
		  , 'NA' AS KEY2
		  , NULL AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , TT.ItemOrder
		  , TT.ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , ISNULL (T.UniqueName, 'HFit_TrackerHeight') AS UniqueName
		  , ISNULL (T.UniqueName, 'HFit_TrackerHeight') AS ColDesc
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerHeight AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerHeight'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT
			'HFit_TrackerHighFatFoods' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'Occurs' AS UOM
		  , 'Times' AS KEY1
		  , CAST (Times AS float) AS VAL1
		  , 'NA' AS KEY2
		  , NULL AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , NULL AS VendorID

			--VENDOR.ItemID as VendorID

		  , NULL AS VendorName

	 --VENDOR.VendorName

	   FROM dbo.HFit_TrackerHighFatFoods AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerHighFatFoods'

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			'HFit_TrackerHighSodiumFoods' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'Occurs' AS UOM
		  , 'Times' AS KEY1
		  , CAST (Times AS float) AS VAL1
		  , 'NA' AS KEY2
		  , NULL AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , NULL AS VendorID

			--VENDOR.ItemID as VendorID

		  , NULL AS VendorName

	 --VENDOR.VendorName

	   FROM dbo.HFit_TrackerHighSodiumFoods AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerHighSodiumFoods'

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			'HFit_TrackerInstance_Tracker' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'Y/N' AS UOM
		  , 'TrackerDefID' AS KEY1
		  , CAST (TrackerDefID AS float) AS VAL1
		  , 'YesNoValue' AS KEY2
		  , CAST (YesNoValue AS float) AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , NULL AS VendorID

			--VENDOR.ItemID as VendorID

		  , NULL AS VendorName

	 --VENDOR.VendorName

	   FROM dbo.HFit_TrackerInstance_Tracker AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerInstance_Tracker'

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			'HFit_TrackerMealPortions' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'NA-portion' AS UOM
		  , 'Portions' AS KEY1
		  , CAST (Portions AS float) AS VAL1
		  , 'NA' AS KEY2
		  , NULL AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , NULL AS VendorID

			--VENDOR.ItemID as VendorID

		  , NULL AS VendorName

	 --VENDOR.VendorName

	   FROM dbo.HFit_TrackerMealPortions AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerMealPortions'

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			'HFit_TrackerMedicalCarePlan' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'Y/N' AS UOM
		  , 'FollowedPlan' AS KEY1
		  , CAST (FollowedPlan AS float) AS VAL1
		  , 'NA' AS KEY2
		  , NULL AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , NULL AS VendorID

			--VENDOR.ItemID as VendorID

		  , NULL AS VendorName

	 --VENDOR.VendorName

	   FROM dbo.HFit_TrackerMedicalCarePlan AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerMedicalCarePlan'

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			'HFit_TrackerRegularMeals' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'Occurs' AS UOM
		  , 'Units' AS KEY1
		  , CAST (Units AS float) AS VAL1
		  , 'NA' AS KEY2
		  , NULL AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , NULL AS VendorID

			--VENDOR.ItemID as VendorID

		  , NULL AS VendorName

	 --VENDOR.VendorName

	   FROM dbo.HFit_TrackerRegularMeals AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerRegularMeals'

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			'HFit_TrackerRestingHeartRate' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'BPM' AS UOM
		  , 'HeartRate' AS KEY1
		  , CAST (HeartRate AS float) AS VAL1
		  , 'NA' AS KEY2
		  , NULL AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerRestingHeartRate AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerRestingHeartRate'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT
			'HFit_TrackerShots' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'Y/N' AS UOM
		  , 'FluShot' AS KEY1
		  , CAST (FluShot AS float) AS VAL1
		  , 'PneumoniaShot' AS KEY2
		  , CAST (PneumoniaShot AS float) AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , TT.ItemOrder
		  , TT.ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerShots AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerShots'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT
			'HFit_TrackerSitLess' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'Occurs' AS UOM
		  , 'Times' AS KEY1
		  , CAST (Times AS float) AS VAL1
		  , 'NA' AS KEY2
		  , NULL AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , NULL AS VendorID

			--VENDOR.ItemID as VendorID

		  , NULL AS VendorName

	 --VENDOR.VendorName

	   FROM dbo.HFit_TrackerSitLess AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerSitLess'

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			'HFit_TrackerSleepPlan' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'HR' AS UOM
		  , 'DidFollow' AS KEY1
		  , CAST (DidFollow AS float) AS VAL1
		  , 'HoursSlept' AS KEY2
		  , HoursSlept AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'Techniques' AS TXTKEY1
		  , Techniques AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , NULL AS VendorID

			--VENDOR.ItemID as VendorID

		  , NULL AS VendorName

	 --VENDOR.VendorName

	   FROM dbo.HFit_TrackerSleepPlan AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerSleepPlan'

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			'HFit_TrackerStrength' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'Y/N' AS UOM
		  , 'HasTrained' AS KEY1
		  , CAST (HasTrained AS float) AS VAL1
		  , 'NA' AS KEY2
		  , NULL AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'Activity' AS TXTKEY1
		  , Activity AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , NULL AS VendorID

			--VENDOR.ItemID as VendorID

		  , NULL AS VendorName

	 --VENDOR.VendorName

	   FROM dbo.HFit_TrackerStrength AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerStrength'

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			'HFit_TrackerStress' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'gradient' AS UOM
		  , 'Intensity' AS KEY1
		  , CAST (Intensity AS float) AS VAL1
		  , 'NA' AS KEY2
		  , NULL AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'Awareness' AS TXTKEY1
		  , Awareness AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , NULL AS VendorID

			--VENDOR.ItemID as VendorID

		  , NULL AS VendorName

	 --VENDOR.VendorName

	   FROM dbo.HFit_TrackerStress AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerStress'

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			'HFit_TrackerStressManagement' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'gradient' AS UOM
		  , 'HasPracticed' AS KEY1
		  , CAST (HasPracticed AS float) AS VAL1
		  , 'Effectiveness' AS KEY2
		  , CAST (Effectiveness AS float) AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'Activity' AS TXTKEY1
		  , Activity AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , NULL AS VendorID

			--VENDOR.ItemID as VendorID

		  , NULL AS VendorName

	 --VENDOR.VendorName

	   FROM dbo.HFit_TrackerStressManagement AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerStressManagement'

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			'HFit_TrackerSugaryDrinks' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'OZ' AS UOM
		  , 'Ounces' AS KEY1
		  , CAST (Ounces AS float) AS VAL1
		  , 'NA' AS KEY2
		  , NULL AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , NULL AS VendorID

			--VENDOR.ItemID as VendorID

		  , NULL AS VendorName

	 --VENDOR.VendorName

	   FROM dbo.HFit_TrackerSugaryDrinks AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerSugaryDrinks'

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			'HFit_TrackerSugaryFoods' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'NA-portion' AS UOM
		  , 'Portions' AS KEY1
		  , CAST (Portions AS float) AS VAL1
		  , 'NA' AS KEY2
		  , NULL AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , NULL AS VendorID

			--VENDOR.ItemID as VendorID

		  , NULL AS VendorName

	 --VENDOR.VendorName

	   FROM dbo.HFit_TrackerSugaryFoods AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerSugaryFoods'

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			'HFit_TrackerTests' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'NA' AS UOM
		  , 'PSATest' AS KEY1
		  , CAST (PSATest AS float) AS VAL1
		  , 'OtherExam' AS KEY1
		  , CAST (OtherExam AS float) AS VAL2
		  , 'TScore' AS KEY3
		  , CAST (TScore AS float) AS VAL3
		  , 'DRA' AS KEY4
		  , CAST (DRA AS float) AS VAL4
		  , 'CotinineTest' AS KEY5
		  , CAST (CotinineTest AS float) AS VAL5
		  , 'ColoCareKit' AS KEY6
		  , CAST (ColoCareKit AS float) AS VAL6
		  , 'CustomTest' AS KEY7
		  , CAST (CustomTest AS float) AS VAL7
		  , 'TSH' AS KEY8
		  , CAST (TSH AS float) AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'CustomDesc' AS TXTKEY1
		  , CustomDesc AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , TT.ItemOrder
		  , TT.ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerTests AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerTests'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT
			'HFit_TrackerTobaccoFree' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'Y/N' AS UOM
		  , 'WasTobaccoFree' AS KEY1
		  , CAST (WasTobaccoFree AS float) AS VAL1
		  , 'NA' AS KEY2
		  , NULL AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'QuitAids' AS TXTKEY1
		  , QuitAids AS TXTVAL1
		  , 'QuitMeds' AS TXTKEY2
		  , QuitMeds AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , NULL AS VendorID

			--VENDOR.ItemID as VendorID

		  , NULL AS VendorName

	 --VENDOR.VendorName

	   FROM dbo.HFit_TrackerTobaccoFree AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerTobaccoFree'

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			'HFit_TrackerVegetables' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'CUP(8oz)' AS UOM
		  , 'Cups' AS KEY1
		  , CAST (Cups AS float) AS VAL1
		  , 'NA' AS KEY2
		  , NULL AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , NULL AS VendorID

			--VENDOR.ItemID as VendorID

		  , NULL AS VendorName

	 --VENDOR.VendorName

	   FROM dbo.HFit_TrackerVegetables AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerVegetables'

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			'HFit_TrackerWater' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'OZ' AS UOM
		  , 'Ounces' AS KEY1
		  , CAST (Ounces AS float) AS VAL1
		  , 'NA' AS KEY2
		  , NULL AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , NULL AS VendorID

			--VENDOR.ItemID as VendorID

		  , NULL AS VendorName

	 --VENDOR.VendorName

	   FROM dbo.HFit_TrackerWater AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerWater'

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			'HFit_TrackerWeight' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'LBS' AS UOM
		  , 'Value' AS KEY1
		  , [Value] AS VAL1
		  , 'NA' AS KEY2
		  , NULL AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerWeight AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerWeight'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT
			'HFit_TrackerWholeGrains' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'NA-serving' AS UOM
		  , 'Servings' AS KEY1
		  , CAST (Servings AS float) AS VAL1
		  , 'NA' AS KEY2
		  , NULL AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , NULL AS VendorID

			--VENDOR.ItemID as VendorID

		  , NULL AS VendorName

	 --VENDOR.VendorName

	   FROM dbo.HFit_TrackerWholeGrains AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerWholeGrains'

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			'HFit_TrackerShots' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , NULL AS CollectionSourceName_Internal
		  , NULL AS CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'NA' AS UOM
		  , 'FluShot' AS KEY1
		  , CAST (FluShot AS float) AS VAL1
		  , 'PneumoniaShot' AS KEY2
		  , CAST (PneumoniaShot AS float) AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerShots AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerShots'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT
			'HFit_TrackerTests' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , NULL AS CollectionSourceName_Internal
		  , NULL AS CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'NA' AS UOM
		  , 'PSATest' AS KEY1
		  , CAST (PSATest AS float) AS VAL1
		  , 'OtherExam' AS KEY2
		  , CAST (OtherExam AS float) AS VAL2
		  , 'TScore' AS KEY3
		  , CAST (TScore AS float) AS VAL3
		  , 'DRA' AS KEY4
		  , CAST (DRA AS float) AS VAL4
		  , 'CotinineTest' AS KEY5
		  , CAST (CotinineTest AS float) AS VAL5
		  , 'ColoCareKit' AS KEY6
		  , CAST (ColoCareKit AS float) AS VAL6
		  , 'CustomTest' AS KEY7
		  , CAST (CustomTest AS float) AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , 'CustomDesc' AS TXTKEY1
		  , CustomDesc AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerTests AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerTests'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT
			'HFit_TrackerCotinine' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , NULL AS CollectionSourceName_Internal
		  , NULL AS CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'NA' AS UOM
		  , 'NicotineAssessment' AS KEY1
		  , CAST (NicotineAssessment AS float) AS VAL1
		  , 'NA' AS KEY2
		  , NULL AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  ,

			--VENDOR.ItemID AS VendorID ,
			--VENDOR.VendorName,

			NULL AS VendorID
		  , NULL AS VendorName
	   FROM dbo.HFit_TrackerCotinine AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerTests'

	 --LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
	 --	ON TT.VendorID = VENDOR.ItemID;

	 UNION
	 SELECT
			'HFit_TrackerPreventiveCare' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , NULL AS CollectionSourceName_Internal
		  , NULL AS CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'NA' AS UOM
		  , 'PreventiveCare' AS KEY1
		  , CAST (PreventiveCare AS float) AS VAL1
		  , 'NA' AS KEY2
		  , NULL AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  ,

			--VENDOR.ItemID AS VendorID ,
			--VENDOR.VendorName,

			NULL AS VendorID
		  , NULL AS VendorName
	   FROM dbo.HFit_TrackerPreventiveCare AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerTests'

	 --LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
	 --	ON TT.VendorID = VENDOR.ItemID;

	 UNION
	 SELECT
			'HFit_TrackerTobaccoAttestation' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , NULL AS CollectionSourceName_Internal
		  , NULL AS CollectionSourceName_External
		  , 'MISSING' AS EventName
		  , 'NA' AS UOM
		  , 'TobaccoAttestation' AS KEY1
		  , CAST (TobaccoAttestation AS float) AS VAL1
		  , 'NA' AS KEY2
		  , NULL AS VAL2
		  , 'NA' AS KEY3
		  , NULL AS VAL3
		  , 'NA' AS KEY4
		  , NULL AS VAL4
		  , 'NA' AS KEY5
		  , NULL AS VAL5
		  , 'NA' AS KEY6
		  , NULL AS VAL6
		  , 'NA' AS KEY7
		  , NULL AS VAL7
		  , 'NA' AS KEY8
		  , NULL AS VAL8
		  , 'NA' AS KEY9
		  , NULL AS VAL9
		  , 'NA' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , IsProcessedForHa
		  , 'NA' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , 'NA' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , 'NA' AS TXTKEY3
		  , NULL AS TXTVAL3
		  , NULL AS ItemOrder
		  , NULL AS ItemGuid
		  , C.UserGuid
		  , PP.MPI
		  , PP.ClientCode
		  , S.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , T.IsAvailable
		  , T.IsCustom
		  , T.UniqueName
		  , T.UniqueName AS ColDesc
		  ,

			--VENDOR.ItemID AS VendorID ,
			--VENDOR.VendorName,

			NULL AS VendorID
		  , NULL AS VendorName
	   FROM dbo.HFit_TrackerTobaccoAttestation AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerTests';

--LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
--	ON TT.VendorID = VENDOR.ItemID;

GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Alter View [dbo].[view_EDW_ClientCompany]

PRINT 'Alter View [dbo].[view_EDW_ClientCompany]';
GO
ALTER VIEW dbo.view_EDW_ClientCompany
AS

	 --************************************************************
	 --One of the few views in the system that is not nested. 
	 --It combines the Account, Site and Company data.
	 --Last Tested: 09/04/2014 WDM
	 --WDM 9.10.2014 - verified dates were available to the EDW
	 --************************************************************

	 SELECT
			hfa.AccountID
		  , HFA.AccountCD
		  , HFA.AccountName
		  , HFA.ItemCreatedWhen AS AccountCreated
		  , HFA.ItemModifiedWhen AS AccountModified
		  , HFA.ItemGUID AS AccountGUID
		  , CS.SiteID
		  , CS.SiteGUID
		  , CS.SiteLastModified
		  , HFC.CompanyID
		  , HFC.ParentID
		  , HFC.CompanyName
		  , HFC.CompanyShortName
		  , HFC.CompanyStartDate
		  , HFC.CompanyEndDate
		  , HFC.CompanyStatus
		  , CASE
				WHEN CAST (hfa.ItemCreatedWhen AS date) = CAST (HFA.ItemModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , NULL AS CompanyCreated
		  , NULL AS CompanyModified
	   FROM dbo.HFit_Account AS HFA
				INNER JOIN dbo.CMS_Site AS CS
					ON HFA.SiteID = cs.SiteID
				LEFT OUTER JOIN dbo.HFit_Company AS HFC
					ON HFA.AccountID = hfc.AccountID;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[Proc_EDW_Compare_MASTER]

PRINT 'Create Procedure [dbo].[Proc_EDW_Compare_MASTER]';
GO
CREATE PROC Proc_EDW_Compare_MASTER (@LinkedSVR AS nvarchar (254) 
								   , @LinkedDB AS nvarchar (254) 
								   , @CurrDB AS nvarchar (254)) 
AS
	 BEGIN

		 --DECLARE @LinkedSVR as nvarchar(254) ;
		 --DECLARE @LinkedDB as nvarchar(254);

		 DECLARE @LinkedVIEW AS nvarchar (254) ;

		 --DECLARE @CurrDB as nvarchar(254);

		 DECLARE @CurrVIEW AS nvarchar (254) ;
		 DECLARE @NewRun AS int = 0;

		 --set @LinkedSVR = 'hfit-sqlUAT.cloudapp.net,3' ;
		 --set @LinkedDB = 'KenticoCMS_ProdStaging' ;

		 SET @LinkedVIEW = 'SchemaChangeMonitor';

		 --set @CurrDB = 'KenticoCMS_DEV' ;

		 SET @CurrVIEW = 'SchemaChangeMonitor';
		 SET @NewRun = 1;
		 SET @LinkedVIEW = 'CMS_Class';
		 SET @CurrVIEW = 'CMS_Class';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @NewRun = 0;
		 SET @LinkedVIEW = 'CMS_Document';
		 SET @CurrVIEW = 'CMS_Document';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'CMS_Site';
		 SET @CurrVIEW = 'CMS_Site';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'CMS_Tree';
		 SET @CurrVIEW = 'CMS_Tree';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'CMS_User';
		 SET @CurrVIEW = 'CMS_User';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'CMS_UserSettings';
		 SET @CurrVIEW = 'CMS_UserSettings';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'CMS_UserSite';
		 SET @CurrVIEW = 'CMS_UserSite';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'COM_SKU';
		 SET @CurrVIEW = 'COM_SKU';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'EDW_HealthAssessment';
		 SET @CurrVIEW = 'EDW_HealthAssessment';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'EDW_HealthAssessmentDefinition';
		 SET @CurrVIEW = 'EDW_HealthAssessmentDefinition';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_Account';
		 SET @CurrVIEW = 'HFit_Account';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_Coaches';
		 SET @CurrVIEW = 'HFit_Coaches';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_Company';
		 SET @CurrVIEW = 'HFit_Company';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_Goal';
		 SET @CurrVIEW = 'HFit_Goal';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_GoalOutcome';
		 SET @CurrVIEW = 'HFit_GoalOutcome';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HACampaign';
		 SET @CurrVIEW = 'HFit_HACampaign';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentMatrixQuestion';
		 SET @CurrVIEW = 'HFit_HealthAssesmentMatrixQuestion';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentModule';
		 SET @CurrVIEW = 'HFit_HealthAssesmentModule';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentMultipleChoiceQuestion';
		 SET @CurrVIEW = 'HFit_HealthAssesmentMultipleChoiceQuestion';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentPredefinedAnswer';
		 SET @CurrVIEW = 'HFit_HealthAssesmentPredefinedAnswer';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentRiskArea';
		 SET @CurrVIEW = 'HFit_HealthAssesmentRiskArea';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentRiskCategory';
		 SET @CurrVIEW = 'HFit_HealthAssesmentRiskCategory';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentUserAnswers';
		 SET @CurrVIEW = 'HFit_HealthAssesmentUserAnswers';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentUserModule';
		 SET @CurrVIEW = 'HFit_HealthAssesmentUserModule';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentUserQuestion';
		 SET @CurrVIEW = 'HFit_HealthAssesmentUserQuestion';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentUserQuestionGroupResults';
		 SET @CurrVIEW = 'HFit_HealthAssesmentUserQuestionGroupResults';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentUserRiskArea';
		 SET @CurrVIEW = 'HFit_HealthAssesmentUserRiskArea';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentUserRiskCategory';
		 SET @CurrVIEW = 'HFit_HealthAssesmentUserRiskCategory';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssesmentUserStarted';
		 SET @CurrVIEW = 'HFit_HealthAssesmentUserStarted';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssessment';
		 SET @CurrVIEW = 'HFit_HealthAssessment';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_HealthAssessmentFreeForm';
		 SET @CurrVIEW = 'HFit_HealthAssessmentFreeForm';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_LKP_Frequency';
		 SET @CurrVIEW = 'HFit_LKP_Frequency';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_LKP_GoalStatus';
		 SET @CurrVIEW = 'HFit_LKP_GoalStatus';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_LKP_RewardLevelType';
		 SET @CurrVIEW = 'HFit_LKP_RewardLevelType';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_LKP_RewardTrigger';
		 SET @CurrVIEW = 'HFit_LKP_RewardTrigger';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_LKP_RewardTriggerParameterOperator';
		 SET @CurrVIEW = 'HFit_LKP_RewardTriggerParameterOperator';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_LKP_RewardType';
		 SET @CurrVIEW = 'HFit_LKP_RewardType';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_LKP_UnitOfMeasure';
		 SET @CurrVIEW = 'HFit_LKP_UnitOfMeasure';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'hfit_ppteligibility';
		 SET @CurrVIEW = 'hfit_ppteligibility';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardActivity';
		 SET @CurrVIEW = 'HFit_RewardActivity';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardException';
		 SET @CurrVIEW = 'HFit_RewardException';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardGroup';
		 SET @CurrVIEW = 'HFit_RewardGroup';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardLevel';
		 SET @CurrVIEW = 'HFit_RewardLevel';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardProgram';
		 SET @CurrVIEW = 'HFit_RewardProgram';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardsAwardUserDetail';
		 SET @CurrVIEW = 'HFit_RewardsAwardUserDetail';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardsUserActivityDetail';
		 SET @CurrVIEW = 'HFit_RewardsUserActivityDetail';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardsUserLevelDetail';
		 SET @CurrVIEW = 'HFit_RewardsUserLevelDetail';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardTrigger';
		 SET @CurrVIEW = 'HFit_RewardTrigger';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_RewardTriggerParameter';
		 SET @CurrVIEW = 'HFit_RewardTriggerParameter';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_Tobacco_Goal';
		 SET @CurrVIEW = 'HFit_Tobacco_Goal';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFIT_Tracker';
		 SET @CurrVIEW = 'HFIT_Tracker';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerBloodPressure';
		 SET @CurrVIEW = 'HFit_TrackerBloodPressure';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerBloodSugarAndGlucose';
		 SET @CurrVIEW = 'HFit_TrackerBloodSugarAndGlucose';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerBMI';
		 SET @CurrVIEW = 'HFit_TrackerBMI';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerBodyFat';
		 SET @CurrVIEW = 'HFit_TrackerBodyFat';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerBodyMeasurements';
		 SET @CurrVIEW = 'HFit_TrackerBodyMeasurements';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerCardio';
		 SET @CurrVIEW = 'HFit_TrackerCardio';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerCholesterol';
		 SET @CurrVIEW = 'HFit_TrackerCholesterol';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerCollectionSource';
		 SET @CurrVIEW = 'HFit_TrackerCollectionSource';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerDailySteps';
		 SET @CurrVIEW = 'HFit_TrackerDailySteps';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerFlexibility';
		 SET @CurrVIEW = 'HFit_TrackerFlexibility';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerFruits';
		 SET @CurrVIEW = 'HFit_TrackerFruits';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerHbA1c';
		 SET @CurrVIEW = 'HFit_TrackerHbA1c';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerHeight';
		 SET @CurrVIEW = 'HFit_TrackerHeight';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerHighFatFoods';
		 SET @CurrVIEW = 'HFit_TrackerHighFatFoods';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerHighSodiumFoods';
		 SET @CurrVIEW = 'HFit_TrackerHighSodiumFoods';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerInstance_Tracker';
		 SET @CurrVIEW = 'HFit_TrackerInstance_Tracker';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerMealPortions';
		 SET @CurrVIEW = 'HFit_TrackerMealPortions';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerMedicalCarePlan';
		 SET @CurrVIEW = 'HFit_TrackerMedicalCarePlan';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerRegularMeals';
		 SET @CurrVIEW = 'HFit_TrackerRegularMeals';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerRestingHeartRate';
		 SET @CurrVIEW = 'HFit_TrackerRestingHeartRate';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerShots';
		 SET @CurrVIEW = 'HFit_TrackerShots';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerSitLess';
		 SET @CurrVIEW = 'HFit_TrackerSitLess';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerSleepPlan';
		 SET @CurrVIEW = 'HFit_TrackerSleepPlan';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerStrength';
		 SET @CurrVIEW = 'HFit_TrackerStrength';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerStress';
		 SET @CurrVIEW = 'HFit_TrackerStress';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerStressManagement';
		 SET @CurrVIEW = 'HFit_TrackerStressManagement';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerSugaryDrinks';
		 SET @CurrVIEW = 'HFit_TrackerSugaryDrinks';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerSugaryFoods';
		 SET @CurrVIEW = 'HFit_TrackerSugaryFoods';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerTests';
		 SET @CurrVIEW = 'HFit_TrackerTests';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerTobaccoFree';
		 SET @CurrVIEW = 'HFit_TrackerTobaccoFree';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerVegetables';
		 SET @CurrVIEW = 'HFit_TrackerVegetables';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerWater';
		 SET @CurrVIEW = 'HFit_TrackerWater';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerWeight';
		 SET @CurrVIEW = 'HFit_TrackerWeight';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_TrackerWholeGrains';
		 SET @CurrVIEW = 'HFit_TrackerWholeGrains';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'HFit_UserGoal';
		 SET @CurrVIEW = 'HFit_UserGoal';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'Tracker_EDW_Metadata';
		 SET @CurrVIEW = 'Tracker_EDW_Metadata';
		 EXEC Proc_EDW_Compare_Tables @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'View_CMS_Tree_Joined';
		 SET @CurrVIEW = 'View_CMS_Tree_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_CMS_Tree_Joined_Linked';
		 SET @CurrVIEW = 'VIEW_CMS_Tree_Joined_Linked';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_CMS_Tree_Joined_Regular';
		 SET @CurrVIEW = 'VIEW_CMS_Tree_Joined_Regular';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_COM_SKU';
		 SET @CurrVIEW = 'VIEW_COM_SKU';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_ClientCompany';
		 SET @CurrVIEW = 'VIEW_EDW_ClientCompany';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_Coaches';
		 SET @CurrVIEW = 'VIEW_EDW_Coaches';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_CoachingDefinition';
		 SET @CurrVIEW = 'VIEW_EDW_CoachingDefinition';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_CoachingDetail';
		 SET @CurrVIEW = 'VIEW_EDW_CoachingDetail';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HAassessment';
		 SET @CurrVIEW = 'VIEW_EDW_HAassessment';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HADefinition';
		 SET @CurrVIEW = 'VIEW_EDW_HADefinition';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HealthAssesment';
		 SET @CurrVIEW = 'VIEW_EDW_HealthAssesment';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HealthAssesmentAnswers';
		 SET @CurrVIEW = 'VIEW_EDW_HealthAssesmentAnswers';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HealthAssesmentClientView';
		 SET @CurrVIEW = 'VIEW_EDW_HealthAssesmentClientView';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HealthAssesmentDeffinition';
		 SET @CurrVIEW = 'VIEW_EDW_HealthAssesmentDeffinition';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HealthAssesmentDeffinitionCustom';
		 SET @CurrVIEW = 'VIEW_EDW_HealthAssesmentDeffinitionCustom';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HealthAssesmentQuestions';
		 SET @CurrVIEW = 'VIEW_EDW_HealthAssesmentQuestions';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HealthAssessment_Staged';
		 SET @CurrVIEW = 'VIEW_EDW_HealthAssessment_Staged';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_HealthAssessmentDefinition_Staged';
		 SET @CurrVIEW = 'VIEW_EDW_HealthAssessmentDefinition_Staged';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_Participant';
		 SET @CurrVIEW = 'VIEW_EDW_Participant';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_RewardAwardDetail';
		 SET @CurrVIEW = 'VIEW_EDW_RewardAwardDetail';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_RewardsDefinition';
		 SET @CurrVIEW = 'VIEW_EDW_RewardsDefinition';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_RewardTriggerParameters';
		 SET @CurrVIEW = 'VIEW_EDW_RewardTriggerParameters';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_RewardUserDetail';
		 SET @CurrVIEW = 'VIEW_EDW_RewardUserDetail';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_ScreeningsFromTrackers';
		 SET @CurrVIEW = 'VIEW_EDW_ScreeningsFromTrackers';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_TrackerCompositeDetails';
		 SET @CurrVIEW = 'VIEW_EDW_TrackerCompositeDetails';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_TrackerMetadata';
		 SET @CurrVIEW = 'VIEW_EDW_TrackerMetadata';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_TrackerShots';
		 SET @CurrVIEW = 'VIEW_EDW_TrackerShots';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_EDW_TrackerTests';
		 SET @CurrVIEW = 'VIEW_EDW_TrackerTests';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_Goal_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_Goal_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HACampaign_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HACampaign_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HealthAssesmentMatrixQuestion_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HealthAssesmentMatrixQuestion_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HealthAssesmentModule_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HealthAssesmentModule_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HealthAssesmentMultipleChoiceQuestion_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HealthAssesmentMultipleChoiceQuestion_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HealthAssesmentPredefinedAnswer_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HealthAssesmentPredefinedAnswer_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HealthAssesmentRiskArea_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HealthAssesmentRiskArea_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HealthAssesmentRiskCategory_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HealthAssesmentRiskCategory_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HealthAssessment_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HealthAssessment_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_HealthAssessmentFreeForm_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_HealthAssessmentFreeForm_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_RewardActivity_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_RewardActivity_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_RewardGroup_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_RewardGroup_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_RewardLevel_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_RewardLevel_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_RewardProgram_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_RewardProgram_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_RewardTrigger_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_RewardTrigger_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_RewardTriggerParameter_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_RewardTriggerParameter_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SET @LinkedVIEW = 'VIEW_HFit_Tobacco_Goal_Joined';
		 SET @CurrVIEW = 'VIEW_HFit_Tobacco_Goal_Joined';
		 EXEC Proc_EDW_Compare_Views @LinkedSVR, @LinkedDB, @LinkedVIEW, @CurrDB, @CurrVIEW, @NewRun;

		 --GO

		 SELECT
				*
		   FROM view_SchemaDiff;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[sp_SchemaMonitorReport]

PRINT 'Create Procedure [dbo].[sp_SchemaMonitorReport]';
GO
CREATE PROC dbo.sp_SchemaMonitorReport
AS
	 BEGIN

		 --print('Start') ;

		 truncate TABLE SchemaChangeMonitor_rptData;
		 DECLARE deltas CURSOR
			 FOR SELECT
						PostTime
					  , DB_User
					  , IP_Address
					  , CUR_User
					  , Event
					  , TSQL
					  , OBJ
					  , RowNbr
				   FROM SchemaChangeMonitor
				   WHERE PostTime BETWEEN GETDATE () - 1 AND GETDATE () 
					 AND Event IN (
								   SELECT
										  Event
									 FROM SchemaChangeMonitorEvent) 
				   ORDER BY
							OBJ, PostTime;
		 DECLARE @PostTime datetime;
		 DECLARE @DB_User nvarchar (254) ;
		 DECLARE @IP_Address nvarchar (254) ;
		 DECLARE @CUR_User nvarchar (254) ;
		 DECLARE @Event nvarchar (254) ;
		 DECLARE @TSQL nvarchar (max) ;
		 DECLARE @OBJ nvarchar (254) ;
		 DECLARE @DisplayOrder int;
		 DECLARE @RowNbr int;
		 DECLARE @DOrder int;
		 DECLARE @onerecipient varchar (254) ;
		 DECLARE @allrecipients varchar (max) = '';
		 DECLARE @fromDate varchar (254) = CAST (GETDATE () - 1 AS varchar (254)) ;
		 DECLARE @toDate varchar (254) = CAST (GETDATE () AS varchar (254)) ;
		 DECLARE @subj varchar (254) = 'Schema Mods between ' + @fromDate + ' and ' + @toDate;
		 OPEN deltas;
		 FETCH next FROM deltas INTO @PostTime, @DB_User, @IP_Address, @CUR_User, @Event, @TSQL, @OBJ, @RowNbr;
		 WHILE @@fetch_status = 0
			 BEGIN
				 SET @DOrder = 1;
				 INSERT INTO SchemaChangeMonitor_rptData (
							 label
						   , sText
						   , DisplayOrder
						   , RowNbr) 
				 VALUES
						('OBJ', @OBJ, @DOrder, @RowNbr) ;
				 SET @DOrder = 2;
				 INSERT INTO SchemaChangeMonitor_rptData (
							 label
						   , sText
						   , DisplayOrder
						   , RowNbr) 
				 VALUES
						('Event', @Event, @DOrder, @RowNbr) ;
				 SET @DOrder = 3;
				 INSERT INTO SchemaChangeMonitor_rptData (
							 label
						   , sText
						   , DisplayOrder
						   , RowNbr) 
				 VALUES
						('TSQL', @TSQL, @DOrder, @RowNbr) ;
				 SET @DOrder = @DOrder + 1;
				 INSERT INTO SchemaChangeMonitor_rptData (
							 label
						   , sText
						   , DisplayOrder
						   , RowNbr) 
				 VALUES
						('PostTime', @PostTime, @DOrder, @RowNbr) ;
				 SET @DOrder = @DOrder + 1;
				 INSERT INTO SchemaChangeMonitor_rptData (
							 label
						   , sText
						   , DisplayOrder
						   , RowNbr) 
				 VALUES
						('IP_Address', @IP_Address, @DOrder, @RowNbr) ;
				 SET @DOrder = @DOrder + 1;
				 INSERT INTO SchemaChangeMonitor_rptData (
							 label
						   , sText
						   , DisplayOrder
						   , RowNbr) 
				 VALUES
						('DB_User', @DB_User, @DOrder, @RowNbr) ;
				 SET @DOrder = @DOrder + 1;
				 INSERT INTO SchemaChangeMonitor_rptData (
							 label
						   , sText
						   , DisplayOrder
						   , RowNbr) 
				 VALUES
						('CUR_User', @CUR_User, @DOrder, @RowNbr) ;
				 SET @DOrder = @DOrder + 1;
				 INSERT INTO SchemaChangeMonitor_rptData (
							 label
						   , sText
						   , DisplayOrder
						   , RowNbr) 
				 VALUES
						('END', '******************************', @DOrder, @RowNbr) ;
				 FETCH next FROM deltas INTO @PostTime, @DB_User, @IP_Address, @CUR_User, @Event, @TSQL, @OBJ, @RowNbr;
			 END;
		 CLOSE deltas;
		 DEALLOCATE deltas;
		 DECLARE getemails CURSOR
			 FOR SELECT
						EmailAddr
				   FROM SchemaMonitorObjectNotify;
		 OPEN getemails;
		 FETCH next FROM getemails INTO @onerecipient;
		 WHILE @@fetch_status = 0
			 BEGIN
				 SET @allrecipients = @allrecipients + @onerecipient + ';';
				 FETCH next FROM getemails INTO @onerecipient;
			 END;
		 CLOSE getemails;
		 DEALLOCATE getemails;
		 DECLARE @CURRSVR AS nvarchar (254) = '';
		 SET @CURRSVR = @@servername;
		 DECLARE @ModifiedObjects AS nvarchar (max) = 'Server: ' + @CURRSVR + CHAR (13) + CHAR (10) + '- The following DB Objects have been modified within the last 24 hours:' + CHAR (13) + CHAR (10) ;
		 DECLARE @sText AS nvarchar (max) ;
		 DECLARE getObjs CURSOR
			 FOR SELECT DISTINCT
						sText
				   FROM view_SchemaChangeMonitor_rptData
				   WHERE label = 'OBJ'
				   GROUP BY
							sText
				   ORDER BY
							sText;
		 OPEN getObjs;
		 FETCH next FROM getObjs INTO @sText;
		 WHILE @@fetch_status = 0
			 BEGIN
				 SET @ModifiedObjects = @ModifiedObjects + CHAR (13) + CHAR (10) + @sText;
				 FETCH next FROM getObjs INTO @sText;
			 END;
		 CLOSE getObjs;
		 DEALLOCATE getObjs;
		 SET @ModifiedObjects = @ModifiedObjects + CHAR (13) + CHAR (10) + ' ';
		 SET @ModifiedObjects = @ModifiedObjects + CHAR (13) + CHAR (10) + '_______________________________________________________' + CHAR (13) + CHAR (10) ;
		 SET @ModifiedObjects = @ModifiedObjects + 'The Following Views can be used to review the changes:' + CHAR (13) + CHAR (10) + ' ';
		 SET @ModifiedObjects = @ModifiedObjects + '    view_SchemaChangeMonitor_rptData' + CHAR (13) + CHAR (10) + ' ';
		 SET @ModifiedObjects = @ModifiedObjects + '    view_SchemaChangeMonitor' + CHAR (13) + CHAR (10) + ' ';
		 PRINT @ModifiedObjects;
		 PRINT 'Report Sent To: ' + @allrecipients;
		 EXEC msdb..sp_send_dbmail @profile_name = 'databaseBot', @recipients = @allrecipients, @subject = @subj, @body = @ModifiedObjects, @execute_query_database = 'msdb',

		 --@query = 'SELECT distinct OBJ, Event, CUR_User, IP_Address, TSQL FROM KenticoCMS_DEV..SchemaChangeMonitor where PostTime between getdate()- 1 and getdate()'
		 --@query = 'select ltrim(rtrim(label)), ltrim(rtrim(sText)), DisplayOrder, RowNbr from KenticoCMS_DEV..SchemaChangeMonitor_rptData'

		 @query = NULL;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create View [dbo].[view_EDW_TrackerMetadata]

PRINT 'Create View [dbo].[view_EDW_TrackerMetadata]';
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
CREATE VIEW dbo.view_EDW_TrackerMetadata
AS

	 --******************************************************************************************************
	 --TableName - this is the CMS_CLASS ClassName and is used to identify the needed metadata. 
	 --ColumnName - Each Class has a set of columns. This is the name of the column as contained
	 --				within the CLASS.
	 --AttrName - The name of the attribute as it applies to the column (e.g. column type 
	 --				describes the datatype of the column (ColName) within the CLASS (ClassName).
	 --AttrVal - the value assigned to the AttrName.
	 --CreatedDate - the date this row of metadata was created.
	 --LastModifiedDate - the date this row of metadata was last changed in the Tracker_EDW_Metadata table.
	 --ID - An identity field within the Tracker_EDW_Metadata table.
	 --ClassLastModified - The last date the CLASS within CMS_CLASS was changed.
	 --09.11.2014 : (wdm) Verified last mod date available to EDW 
	 --******************************************************************************************************

	 SELECT
			TableName
		  , ColName
		  , AttrName
		  , AttrVal
		  , CreatedDate
		  , LastModifiedDate
		  , ID
		  , CMS_CLASS.ClassLastModified
	   FROM Tracker_EDW_Metadata
				JOIN CMS_CLASS
					ON CMS_CLASS.ClassName = TableName;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[proc_EDW_EligibilityDaily]

PRINT 'Create Procedure [dbo].[proc_EDW_EligibilityDaily]';
GO

--exec [proc_EDW_EligibilityDaily]

CREATE PROCEDURE proc_EDW_EligibilityDaily
AS
	 BEGIN

		 --*****************************************************************************************
		 --Find all members and their respective groups that exist at this point in time.
		 --    This is a snapshot of PPTs, Groups, and Memberships as it appears in the moment.
		 --    This will allow us to track members when they go into or leave a group, daily.
		 --    Get all records of PPTs within groups and save them as the daily starting point
		 --    for tracking PPT group membership. To ensure the data is fresh, drop the
		 --    EDW_GroupMemberToday table and fill it with current PPTs.
		 --    Step 1 - Call procedure proc_EDW_EligibilityDaily
		 --    Step 2 - Call procedure proc_EDW_EligibilityStarted
		 --    Step 3 - Call procedure proc_EDW_EligibilityExpired
		 --    Step 4 - Retrieve the PPT membership history using the view view_EDW_EligibilityHistory
		 --*****************************************************************************************

		 IF EXISTS (SELECT
						   name
					  FROM sys.tables
					  WHERE name = 'EDW_GroupMemberToday') 
			 BEGIN
				 truncate TABLE EDW_GroupMemberToday;
			 END;
		 INSERT INTO dbo.EDW_GroupMemberToday (
					 ContactGroupMemberRelatedID
				   , GroupName
				   , HFitUserMpiNumber
				   , Today) 
		 SELECT
				GRPMBR.ContactGroupMemberRelatedID
			  , GRP.ContactGroupName AS GroupName
			  , USERSET.HFitUserMpiNumber
			  , (
				 SELECT
						CONVERT (date, GETDATE () , 110)) AS Today
		   FROM OM_CONTACTGroupMember AS GRPMBR
					JOIN CMS_USERSettings AS USERSET
						ON USERSET.HFitPRimaryContactID = GRPMBR.ContactGroupMemberRelatedID
					JOIN OM_ContactGroup AS GRP
						ON GRP.ContactGroupID = GRPMBR.ContactGroupMemberContactGroupID
		   WHERE HFitUserMpiNumber IS NOT NULL;
		 DECLARE @iCnt AS integer = 0;
		 SET @iCnt = (SELECT
							 COUNT (*) 
						FROM EDW_GroupMemberToday) ;
		 PRINT 'Beginning to process: ' + CAST (@iCnt AS nvarchar (50)) + ' eligibility records on ' + CAST (GETDATE () AS nvarchar (50)) ;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[Proc_EDW_TrackerMetadataExtract]

PRINT 'Create Procedure [dbo].[Proc_EDW_TrackerMetadataExtract]';
GO

--exec Proc_EDW_TrackerMetadataExtract 'HFit.TrackerWater'
--select * from #Temp_TrackerMetaData
--select * from Tracker_EDW_Metadata
--truncate table Tracker_EDW_Metadata

CREATE PROCEDURE dbo.Proc_EDW_TrackerMetadataExtract (@TrackerClassName AS nvarchar (250)) 
AS
	 BEGIN
		 IF EXISTS (SELECT
						   name
					  FROM tempdb.dbo.sysobjects
					  WHERE ID = OBJECT_ID (N'tempdb..#Temp_TrackerMetaData')) 
			 BEGIN
				 DROP TABLE
					  #Temp_TrackerMetaData;
			 END;
		 DECLARE @MetaDataLastLoadDate datetime;
		 DECLARE @ClassLastModified datetime;
		 DECLARE @Xml xml;
		 DECLARE @docHandle int;
		 DECLARE @form nvarchar (250) ;
		 DECLARE @dbForm nvarchar (250) ;
		 DECLARE @id int;
		 DECLARE @parent int;
		 DECLARE @nodetype int;
		 DECLARE @localname nvarchar (250) ;
		 DECLARE @prefix nvarchar (250) ;
		 DECLARE @namespaceuri nvarchar (250) ;
		 DECLARE @datatype nvarchar (250) ;
		 DECLARE @prev nvarchar (250) ;
		 DECLARE @dbText nvarchar (250) ;
		 DECLARE @ParentName nvarchar (250) ;

		 --declare @xdbForm nvarchar(250) ;
		 --declare @xid int ;
		 --declare @xparent int;
		 --declare @xnodetype int;
		 --declare @xlocalname nvarchar(250);
		 --declare @xprefix nvarchar(250);
		 --declare @xnamespaceuri nvarchar(250);
		 --declare @xdatatype nvarchar(250);
		 --declare @xprev nvarchar(250);
		 --declare @xdbText nvarchar(250);

		 DECLARE @TableName nvarchar (100) ;
		 DECLARE @ColName nvarchar (100) ;
		 DECLARE @AttrName nvarchar (100) ;
		 DECLARE @AttrVal nvarchar (250) ;
		 DECLARE @CurrName nvarchar (250) ;
		 DECLARE @SkipIfNoChange bit;

		 --select @form = 'HFit.TrackerWater' ;

		 SELECT
				@form = @TrackerClassName;
		 SELECT
				@MetaDataLastLoadDate = (
										 SELECT TOP 1
												ClassLastModified
										   FROM Tracker_EDW_Metadata
										   WHERE TableName = @form) ;
		 SELECT
				@ClassLastModified = (
									  SELECT TOP 1
											 ClassLastModified
										FROM CMS_CLASS
										WHERE ClassName = @form) ;
		 SET @SkipIfNoChange = 1;
		 IF @SkipIfNoChange = 1
			 BEGIN
				 IF @MetaDataLastLoadDate = @ClassLastModified
					 BEGIN
						 PRINT 'No Change in ' + @form + ', no updates needed.';
						 RETURN;
					 END;
				 ELSE
					 BEGIN
						 PRINT 'Changes found in ' + @form + ', processing.';
					 END;
			 END;
		 PRINT '@MetaDataLastLoadDate: ' + CAST (@MetaDataLastLoadDate AS varchar (50)) ;
		 PRINT '@ClassLastModified: ' + CAST (@ClassLastModified AS varchar (50)) ;
		 SELECT
				@Xml = (
						SELECT
							   ClassFormDefinition
						  FROM CMS_Class
						  WHERE ClassName LIKE @form) ;

		 --print (cast( @Xml as varchar(max)));

		 EXEC sp_xml_preparedocument @docHandle OUTPUT, @Xml;

		 --alter table [Tracker_EDW_Metadata] add ClassLastModified datetime null

		 IF NOT EXISTS (SELECT
							   name
						  FROM sysobjects
						  WHERE ID = OBJECT_ID (N'Tracker_EDW_Metadata')) 
			 BEGIN
				 CREATE TABLE dbo.Tracker_EDW_Metadata (
							  TableName nvarchar (100) NOT NULL
							, ColName nvarchar (100) NOT NULL
							, AttrName nvarchar (100) NOT NULL
							, AttrVal nvarchar (250) NULL
							, CreatedDate datetime2 (7) NULL
							, LastModifiedDate datetime2 (7) NULL
							, ID int IDENTITY (1, 1) 
									 NOT NULL
							, ClassLastModified datetime2 (7) NULL) ;
				 ALTER TABLE dbo.Tracker_EDW_Metadata
				 ADD
							 CONSTRAINT DF_Tracker_EDW_Metadata_CreatedDate DEFAULT GETDATE () FOR CreatedDate;
				 ALTER TABLE dbo.Tracker_EDW_Metadata
				 ADD
							 CONSTRAINT DF_Tracker_EDW_Metadata_LastModifiedDate DEFAULT GETDATE () FOR LastModifiedDate;
				 CREATE UNIQUE CLUSTERED INDEX PK_Tracker_EDW_Metadata ON dbo.Tracker_EDW_Metadata (TableName ASC, ColName ASC, AttrName ASC) ;
			 END;
		 IF NOT EXISTS (SELECT
							   name
						  FROM tempdb.dbo.sysobjects
						  WHERE ID = OBJECT_ID (N'tempdb..#Temp_TrackerMetaData')) 
			 BEGIN
				 SELECT
						@form AS form
					  , id
					  , parentid
					  , nodetype
					  , localname
					  , prefix
					  , namespaceuri
					  , datatype
					  , prev
					  , text INTO
								  #Temp_TrackerMetaData
				   FROM OPENXML (@docHandle, N'/form/field') AS XMLDATA;

				 --WHERE localname not in ('isPK');		

				 CREATE INDEX TMPPI_HealthAssesmentUserQuestion ON #Temp_TrackerMetaData (parentid) ;
				 CREATE INDEX TMPPI2_HealthAssesmentUserQuestion ON #Temp_TrackerMetaData (id) ;
			 END;
		 ELSE
			 BEGIN
				 truncate TABLE #Temp_TrackerMetaData;
				 INSERT INTO #Temp_TrackerMetaData
				 SELECT
						@form AS form
					  , id
					  , parentid
					  , nodetype
					  , localname
					  , prefix
					  , namespaceuri
					  , datatype
					  , prev
					  , text
				   FROM OPENXML (@docHandle, N'/form/field') AS XMLDATA;
			 END;
		 DELETE FROM Tracker_EDW_Metadata
		 WHERE
			   TableName = @form;
		 SET @ClassLastModified = (SELECT
										  ClassLastModified
									 FROM CMS_CLASS
									 WHERE ClassName = @Form) ;
		 PRINT '@ClassLastModified: ' + CAST (@ClassLastModified AS varchar (250)) ;
		 DECLARE C CURSOR
			 FOR SELECT
						@form AS form
					  , id
					  , parentid
					  , nodetype
					  , localname
					  , prefix
					  , namespaceuri
					  , datatype
					  , prev
					  , text
				   FROM #Temp_TrackerMetaData AS XMLDATA;
		 OPEN C;
		 FETCH NEXT FROM C INTO @dbForm, @id, @parent, @nodetype, @localname, @prefix, @namespaceuri, @datatype, @prev, @dbText;
		 WHILE @@FETCH_STATUS = 0
			 BEGIN

				 --print ('* @localname :' + @localname) ;
				 --print ('* @ColName :' + isnull(@ColName, 'XX') + ':') ;
				 --print ('* @dbText :' + @dbText + ':') ;

				 IF @localname = 'column'
					 BEGIN

						 --print ('** START COLUMN DEF: ') ;

						 SET @ColName = (SELECT
												text
										   FROM #Temp_TrackerMetaData
										   WHERE parentid = @id) ;

					 --print ('** COLUMN DEF: ' + @form + ' : ' + @colname) ;

					 END;
				 IF @dbText IS NOT NULL
					 BEGIN

						 --print ('* ENTER @dbText :' + @dbText + ':' + cast(@parent as varchar(10))) ;

						 SET @AttrName = (SELECT
												 localname
											FROM #Temp_TrackerMetaData
											WHERE id = @parent) ;

						 --set @ParentName = (select [localname] FROM OPENXML(@docHandle, N'/form/field') where id = @parent);	
						 --print ('1 - @AttrName: ' + @form +' : ' + isnull(@ColName, 'NA') + ' : ' + @AttrName + ' : ' + @dbText) ;	

						 IF EXISTS (SELECT
										   TableName
									  FROM Tracker_EDW_Metadata
									  WHERE Tablename = @form
										AND ColName = @ColName
										AND AttrName = @dbText) 
							 BEGIN

								 --print('Update Tracker_EDW_Metadata set AttrVal = ' + @dbText + ' Where Tablename = ' + @form + ' and ColName = ' + @ColName + ' and AttrName = ' + @AttrName + ';');

								 UPDATE Tracker_EDW_Metadata
								 SET
									 AttrVal = @dbText
								   ,
									 ClassLastModified = @ClassLastModified
								 WHERE
									   Tablename = @form
								   AND ColName = @ColName
								   AND AttrName = @dbText;
							 END;
						 ELSE
							 BEGIN

								 --print ('insert into Tracker_EDW_Metadata (TableName, ColName, AttrName, AttrVal, ClassLastModified) values ('+@form+', '+@ColName+', '+@AttrName+', '+@dbText +', ' + cast(@ClassLastModified as varchar(50))+ ') ') ;

								 INSERT INTO Tracker_EDW_Metadata (
											 TableName
										   , ColName
										   , AttrName
										   , AttrVal
										   , ClassLastModified) 
								 VALUES
										(@form, @ColName, @AttrName, @dbText, @ClassLastModified) ;
								 UPDATE Tracker_EDW_Metadata
								 SET
									 ClassLastModified = @ClassLastModified
								 WHERE
									   Tablename = @form
								   AND ColName = @ColName
								   AND AttrName = @dbText;
							 END;
					 END;
				 IF @localname = 'columntype'
				AND @ColName IS NOT NULL
					 BEGIN
						 PRINT '---- COLUMN TYPE DEF: ' + @form + ' : ' + @colname + ' : ' + @dbText;
					 END;
				 IF @localname = 'field'
					 BEGIN
						 SET @ParentName = NULL;
						 SET @ColName = NULL;

					 --print ('***** field @ParentName: ' + @ParentName) ;

					 END;
				 FETCH NEXT FROM C INTO @dbForm, @id, @parent, @nodetype, @localname, @prefix, @namespaceuri, @datatype, @prev, @dbText;
			 END;
		 CLOSE C;
		 DEALLOCATE C;
	 END;

--Clean up the EDW Tracker MetaData
--delete from Tracker_EDW_Metadata where colname in ('ItemID','ItemCreatedBy','ItemCreatedWhen','ItemModifiedBy','ItemModifiedWhen','EventDate','IsProfessionally Collected','TrackerCollectionSourceId','UserID','Notes','IsProcessedForHA');

GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Alter View [dbo].[view_EDW_TrackerTests]

PRINT 'Alter View [dbo].[view_EDW_TrackerTests]';
GO

--********************************************************************************************************
--09.11.2014 : (wdm) Verified last mod date available to EDW 
--********************************************************************************************************

ALTER VIEW dbo.view_EDW_TrackerTests
AS
	 SELECT
			HFTT.UserID
		  , cus.UserSettingsUserGUID
		  , CUS.HFitUserMpiNumber
		  , CS.SiteID
		  , cs.SiteGUID
		  , HFTT.EventDate
		  , HFTT.IsProfessionallyCollected
		  , HFTT.TrackerCollectionSourceID
		  , HFTT.Notes
		  , HFTT.PSATest
		  , HFTT.OtherExam
		  , HFTT.TScore
		  , HFTT.DRA
		  , HFTT.CotinineTest
		  , HFTT.ColoCareKit
		  , HFTT.CustomTest
		  , HFTT.CustomDesc
		  , HFTT.TSH
		  , HFTT.ItemCreatedWhen
		  , HFTT.ItemModifiedWhen
		  , HFTT.ItemGUID
	   FROM dbo.HFit_TrackerTests AS HFTT
				INNER JOIN dbo.HFit_PPTEligibility AS HFPE WITH (NOLOCK) 
					ON HFTT.UserID = HFPE.UserID
				INNER JOIN dbo.CMS_UserSettings AS CUS WITH (NOLOCK) 
					ON HFTT.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2 WITH (NOLOCK) 
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS WITH (NOLOCK) 
					ON cus2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
					ON CS.SiteID = HFA.SiteID;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Alter View [dbo].[view_EDW_TrackerShots]

PRINT 'Alter View [dbo].[view_EDW_TrackerShots]';
GO

--********************************************************************************************************
--09.11.2014 : (wdm) Verified last mod date available to EDW 
--********************************************************************************************************

ALTER VIEW dbo.view_EDW_TrackerShots
AS
	 SELECT
			HFTS.UserID
		  , cus.UserSettingsUserGUID
		  , CUS.HFitUserMpiNumber
		  , CS.SiteID
		  , cs.SiteGUID
		  , HFTS.ItemID
		  , HFTS.EventDate
		  , HFTS.IsProfessionallyCollected
		  , HFTS.TrackerCollectionSourceID
		  , HFTS.Notes
		  , HFTS.FluShot
		  , HFTS.PneumoniaShot
		  , HFTS.ItemCreatedWhen
		  , HFTS.ItemModifiedWhen
		  , HFTS.ItemGUID
	   FROM dbo.HFit_TrackerShots AS HFTS
				INNER JOIN dbo.HFit_PPTEligibility AS HFPE WITH (NOLOCK) 
					ON HFTS.UserID = HFPE.UserID
				INNER JOIN dbo.CMS_UserSettings AS CUS WITH (NOLOCK) 
					ON HFTS.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2 WITH (NOLOCK) 
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS WITH (NOLOCK) 
					ON cus2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
					ON CS.SiteID = HFA.SiteID;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Alter View [dbo].[view_EDW_Participant]

PRINT 'Alter View [dbo].[view_EDW_Participant]';
GO

--*********************************************************************************************
--WDM Reviewed 8/6/2014 for needed updates, none required
--09.11.2014 (wdm) added date fields to facilitate EDW determination of last mod date 
--*********************************************************************************************

ALTER VIEW dbo.view_EDW_Participant
AS
	 SELECT
			cus.HFitUserMpiNumber
		  , cu.UserID
		  , cu.UserGUID
		  , CS.SiteGUID
		  , hfa.AccountID
		  , hfa.AccountCD
		  , cus.HFitUserPreferredMailingAddress
		  , cus.HFitUserPreferredMailingCity
		  , cus.HFitUserPreferredMailingState
		  , cus.HFitUserPreferredMailingPostalCode
		  , cus.HFitCoachingEnrollDate
		  , cus.HFitUserAltPreferredPhone
		  , cus.HFitUserAltPreferredPhoneExt
		  , cus.HFitUserAltPreferredPhoneType
		  , cus.HFitUserPreferredPhone
		  , cus.HFitUserPreferredFirstName
		  , CASE
				WHEN CAST (cu.UserCreated AS date) = CAST (cu.UserLastModified AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , cu.UserCreated
		  , cu.UserLastModified
		  , HFA.ItemModifiedWhen AS Account_ItemModifiedWhen

	 --wdm: 09.11.2014 added to view

	   FROM dbo.CMS_User AS CU
				INNER JOIN dbo.CMS_UserSite AS CUS2 WITH (NOLOCK) 
					ON CU.UserID = CUS2.UserID
				INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
					ON cus2.SiteID = hfa.SiteID
				INNER JOIN dbo.CMS_Site AS CS WITH (NOLOCK) 
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.CMS_UserSettings AS CUS WITH (NOLOCK) 
					ON CU.UserID = CUS.UserSettingsUserID;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create View [dbo].[view_EDW_BioMetrics]

PRINT 'Create View [dbo].[view_EDW_BioMetrics]';
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
CREATE VIEW dbo.view_EDW_BioMetrics
AS

	 --*****************************************************************************************************************************************
	 --************** TEST Criteria and Results for view_EDW_BioMetrics ************************************************************************
	 --INSERT INTO [dbo].[EDW_BiometricViewRejectCriteria] ([AccountCD],[ItemCreatedWhen],[SiteID]) VALUES('XX','2013-12-01',17  )  
	 --NOTE:		XX is used so that the AccountCD is NOT taken into account and only SiteID and ItemCreatedWhen is used.
	 --GO	--Tested by wdm on 11.21.2014
	 -- select count(*) from view_EDW_BioMetrics		--(wdm) & (jc) : testing on {ProdStaging = 136348} / With reject on 136339 = 9
	 --select * from view_EDW_BioMetrics	 where AccountCD = 'peabody' AND COALESCE (EventDate,ItemCreatedWhen) is not NULL and COALESCE (EventDate,ItemCreatedWhen) < '2013-12-01'	: 9 
	 --select * from view_Hfit_BioMetrics where AccountCD = 'peabody' AND COALESCE (EventDate,ItemCreatedWhen) is not NULL and COALESCE (EventDate,ItemCreatedWhen) < '2013-12-01'	: 9 
	 --select * from view_EDW_BioMetrics	where AccountCD = 'peabody' and ItemCreatedWhen < '2013-12-01 00:00:00.000'		: 7 
	 --select * from view_EDW_BioMetrics	where AccountCD = 'peaboOK dy' and EventDate < '2013-12-01 00:00:00.000'		: 9 
	 --select count(*) from view_EDW_BioMetrics		--NO REJECT FILTER : 136348
	 --select count(*) from view_EDW_BioMetrics		--REJECT FILTER ON : 136339 == 9 GOOD TEST
	 --select count(*) from view_Hfit_BioMetrics	:136393
	 --select count(*) from view_Hfit_BioMetrics where COALESCE (EventDate,ItemCreatedWhen) is not NULL 	:136348
	 --NOTE: All tests passed 11.21.2014, 11.23.2014, 12.2.2014, 12,4,2014
	 --truncate table EDW_BiometricViewRejectCriteria
	 --INSERT INTO [dbo].[EDW_BiometricViewRejectCriteria]([AccountCD],[ItemCreatedWhen],[SiteID])VALUES('peabody','2013-12-01',-1)         
	 --NOTE:		-1 is used so that the SiteID is NOT taken into account and only AccountCD and ItemCreatedWhen is used.
	 --GO	--Tested by wdm on 11.21.2014
	 --select * from view_EDW_BioMetrics where ItemCreatedWhen < '2013-12-01' and AccountCD = 'peabody' returns 1034
	 --		so the number should be 43814 - 1034 = 42780 with AccountCD = 'peabody' and ItemCreatedWhen = '2014-03-19'
	 --		in table EDW_BiometricViewRejectCriteria. And it worked (wdm) 11.21.2014
	 --GO	--Tested by wdm on 11.21.2014
	 --select * from view_EDW_BioMetrics where SiteID = 17 and ItemCreatedWhen < '2014-03-19' returns 22,974
	 --		so the number should be 43814 - 22974 = 20840 with SIteID = 17 and ItemCreatedWhen = '2014-03-19'
	 --		in table EDW_BiometricViewRejectCriteria. And it worked (wdm) 11.21.2014
	 --GO	--Tested by wdm on 11.21.2014
	 --	11.24.2014 (wdm) -	requested a review of this code and validation with EDW.
	 -- 12.22.2014 - Received an SR from John C. via Richard to add two fields to the view, Table name and Item ID.
	 -- 12.23.2014 - Added the Vendor ID and Vendor name to the view via the HFit_LKP_TrackerVendor table
	 -- 12.25.2014 - Added the EDW_BiometricViewRejectCriteria to allow selective rejection of historical records
	 -- 01.19.2014 - Prepared for Simpson Willams
	 --*****************************************************************************************************************************************

	 SELECT DISTINCT

	 --HFit_UserTracker

			HFUT.UserID
   , cus.UserSettingsUserGUID AS UserGUID
   , cus.HFitUserMpiNumber
   , cus2.SiteID
   , cs.SiteGUID
   , NULL AS CreatedDate
   , NULL AS ModifiedDate
   , NULL AS Notes
   , NULL AS IsProfessionallyCollected
   , NULL AS EventDate
   , 'Not Build Yet' AS EventName

			--HFit_TrackerWeight

   , NULL AS PPTWeight

			--HFit_TrackerHbA1C

   , NULL AS PPTHbA1C

			--HFit_TrackerCholesterol

   , NULL AS Fasting
   , NULL AS HDL
   , NULL AS LDL
   , NULL AS Ratio
   , NULL AS Total
   , NULL AS Triglycerides

			--HFit_TrackerBloodSugarandGlucose

   , NULL AS Glucose
   , NULL AS FastingState

			--HFit_TrackerBloodPressure

   , NULL AS Systolic
   , NULL AS Diastolic

			--HFit_TrackerBodyFat

   , NULL AS PPTBodyFatPCT

			--HFit_TrackerBMI

   , NULL AS BMI

			--HFit_TrackerBodyMeasurements

   , NULL AS WaistInches
   , NULL AS HipInches
   , NULL AS ThighInches
   , NULL AS ArmInches
   , NULL AS ChestInches
   , NULL AS CalfInches
   , NULL AS NeckInches

			--HFit_TrackerHeight

   , NULL AS Height

			--HFit_TrackerRestingHeartRate

   , NULL AS HeartRate
   ,

			--HFit_TrackerShots

			NULL AS FluShot
   , NULL AS PneumoniaShot

			--HFit_TrackerTests

   , NULL AS PSATest
   , NULL AS OtherExam
   , NULL AS TScore
   , NULL AS DRA
   , NULL AS CotinineTest
   , NULL AS ColoCareKit
   , NULL AS CustomTest
   , NULL AS CustomDesc
   , NULL AS CollectionSource
   , HFA.AccountID
   , HFA.AccountCD
   , CASE
		 WHEN HFUT.ItemCreatedWhen = COALESCE (HFUT.ItemModifiedWhen, hfut.ItemCreatedWhen) 
		 THEN 'I'
		 ELSE 'U'
	 END AS ChangeType
   , HFUT.ItemCreatedWhen
   , HFUT.ItemModifiedWhen
   , 0 AS TrackerCollectionSourceID
   , HFUT.itemid
   , 'HFit_UserTracker' AS TBL
   , NULL AS VendorID

			--VENDOR.ItemID as VendorID

   , NULL AS VendorName

	 --VENDOR.VendorName

	   FROM dbo.HFit_UserTracker AS HFUT
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON hfut.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID

	   --left outer join HFit_LKP_TrackerVendor as VENDOR on HFUT.VendorID = VENDOR.ItemID
	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE HFUT.ItemCreatedWhen < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND HFUT.ItemCreatedWhen < ItemCreatedWhen) 

			 --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified within table EDW_BiometricViewRejectCriteria

		 AND HFUT.ItemCreatedWhen IS NOT NULL

	 --Add per Robert and Laura 12.4.2014

	 UNION ALL
	 SELECT
			hftw.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTW.ItemCreatedWhen
		  , HFTW.ItemModifiedWhen
		  , HFTW.Notes
		  , HFTW.IsProfessionallyCollected
		  , HFTW.EventDate
		  , 'Not Build Yet' AS EventName
		  , hftw.Value AS PPTWeight
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTCS.CollectionSourceName_External
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN HFTW.ItemCreatedWhen = COALESCE (HFTW.ItemModifiedWhen, HFTW.ItemCreatedWhen) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFTW.ItemCreatedWhen
		  , HFTW.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTW.itemid
		  , 'HFit_TrackerWeight' AS TBL
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerWeight AS HFTW
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON HFTW.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON HFTW.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON HFTW.VendorID = VENDOR.ItemID

	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria	  

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTW.EventDate, HFTW.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTW.EventDate, HFTW.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTW.ItemCreatedWhen IS NOT NULL
		   OR HFTW.EventDate IS NOT NULL) 

	 --Add per RObert and Laura 12.4.2014			

	 UNION ALL
	 SELECT
			HFTHA.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTHA.ItemCreatedWhen
		  , HFTHA.ItemModifiedWhen
		  , HFTHA.Notes
		  , HFTHA.IsProfessionallyCollected
		  , HFTHA.EventDate
		  , 'Not Build Yet' AS EventName
		  , NULL
		  , HFTHA.Value AS PPTHbA1C
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTCS.CollectionSourceName_External
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN HFTHA.ItemCreatedWhen = COALESCE (HFTHA.ItemModifiedWhen, HFTHA.ItemCreatedWhen) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFTHA.ItemCreatedWhen
		  , HFTHA.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTHA.itemid
		  , 'HFit_TrackerHbA1c' AS TBL
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerHbA1c AS HFTHA
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON HFTHA.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON HFTHA.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON HFTHA.VendorID = VENDOR.ItemID

	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTHA.EventDate, HFTHA.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTHA.EventDate, HFTHA.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTHA.ItemCreatedWhen IS NOT NULL
		   OR HFTHA.EventDate IS NOT NULL) 

	 --Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT
			HFTC.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTC.ItemCreatedWhen
		  , HFTC.ItemModifiedWhen
		  , HFTC.Notes
		  , HFTC.IsProfessionallyCollected
		  , HFTC.EventDate
		  , 'Not Build Yet' AS EventName
		  , NULL
		  , NULL
		  , HFTC.Fasting
		  , HFTC.HDL
		  , HFTC.LDL
		  , HFTC.Ratio
		  , HFTC.Total
		  , HFTC.Tri
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTCS.CollectionSourceName_External
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN HFTC.ItemCreatedWhen = COALESCE (HFTC.ItemModifiedWhen, HFTC.ItemCreatedWhen) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFTC.ItemCreatedWhen
		  , HFTC.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTC.itemid
		  , 'HFit_TrackerCholesterol' AS TBL
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerCholesterol AS HFTC
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON HFTC.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON HFTC.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON HFTC.VendorID = VENDOR.ItemID

	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTC.EventDate, HFTC.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTC.EventDate, HFTC.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTC.ItemCreatedWhen IS NOT NULL
		   OR HFTC.EventDate IS NOT NULL) 

	 --Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT
			HFTBSAG.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTBSAG.ItemCreatedWhen
		  , HFTBSAG.ItemModifiedWhen
		  , HFTBSAG.Notes
		  , HFTBSAG.IsProfessionallyCollected
		  , HFTBSAG.EventDate
		  , 'Not Build Yet' AS EventName
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTBSAG.Units
		  , HFTBSAG.FastingState
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTCS.CollectionSourceName_External
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN HFTBSAG.ItemCreatedWhen = COALESCE (HFTBSAG.ItemModifiedWhen, HFTBSAG.ItemCreatedWhen) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFTBSAG.ItemCreatedWhen
		  , HFTBSAG.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTBSAG.itemid
		  , 'HFit_TrackerBloodSugarAndGlucose' AS TBL
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerBloodSugarAndGlucose AS HFTBSAG
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON HFTBSAG.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON HFTBSAG.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON HFTBSAG.VendorID = VENDOR.ItemID

	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTBSAG.EventDate, HFTBSAG.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTBSAG.EventDate, HFTBSAG.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTBSAG.ItemCreatedWhen IS NOT NULL
		   OR HFTBSAG.EventDate IS NOT NULL) 

	 --Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT
			HFTBP.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTBP.ItemCreatedWhen
		  , HFTBP.ItemModifiedWhen
		  , HFTBP.Notes
		  , HFTBP.IsProfessionallyCollected
		  , HFTBP.EventDate
		  , 'Not Build Yet' AS EventName
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTBP.Systolic
		  , HFTBP.Diastolic
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTCS.CollectionSourceName_External
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN HFTBP.ItemCreatedWhen = COALESCE (HFTBP.ItemModifiedWhen, HFTBP.ItemCreatedWhen) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFTBP.ItemCreatedWhen
		  , HFTBP.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTBP.itemid
		  , 'HFit_TrackerBloodPressure' AS TBL
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerBloodPressure AS HFTBP
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON HFTBP.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON HFTBP.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON HFTBP.VendorID = VENDOR.ItemID

	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTBP.EventDate, HFTBP.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTBP.EventDate, HFTBP.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTBP.ItemCreatedWhen IS NOT NULL
		   OR HFTBP.EventDate IS NOT NULL) 

	 --Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT
			HFTBF.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTBF.ItemCreatedWhen
		  , HFTBF.ItemModifiedWhen
		  , HFTBF.Notes
		  , HFTBF.IsProfessionallyCollected
		  , HFTBF.EventDate
		  , 'Not Build Yet' AS EventName
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTBF.Value AS PPTBodyFatPCT
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTCS.CollectionSourceName_External
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN HFTBF.ItemCreatedWhen = COALESCE (HFTBF.ItemModifiedWhen, HFTBF.ItemCreatedWhen) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFTBF.ItemCreatedWhen
		  , HFTBF.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTBF.itemid
		  , 'HFit_TrackerBodyFat' AS TBL
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerBodyFat AS HFTBF
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON HFTBF.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON HFTBF.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON HFTBF.VendorID = VENDOR.ItemID

	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTBF.EventDate, HFTBF.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTBF.EventDate, HFTBF.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTBF.ItemCreatedWhen IS NOT NULL
		   OR HFTBF.EventDate IS NOT NULL) 

	 --Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT
			HFTB.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTB.ItemCreatedWhen
		  , HFTB.ItemModifiedWhen
		  , HFTB.Notes
		  , HFTB.IsProfessionallyCollected
		  , HFTB.EventDate
		  , 'Not Build Yet' AS EventName
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTB.BMI
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTCS.CollectionSourceName_External
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN HFTB.ItemCreatedWhen = COALESCE (HFTB.ItemModifiedWhen, HFTB.ItemCreatedWhen) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFTB.ItemCreatedWhen
		  , HFTB.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTB.itemid
		  , 'HFit_TrackerBMI' AS TBL
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerBMI AS HFTB
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON HFTB.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON HFTB.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON HFTB.VendorID = VENDOR.ItemID

	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTB.EventDate, HFTB.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTB.EventDate, HFTB.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTB.ItemCreatedWhen IS NOT NULL
		   OR HFTB.EventDate IS NOT NULL) 

	 --Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT
			HFTBM.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTBM.ItemCreatedWhen
		  , HFTBM.ItemModifiedWhen
		  , HFTBM.Notes
		  , HFTBM.IsProfessionallyCollected
		  , HFTBM.EventDate
		  , 'Not Build Yet' AS EventName
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTBM.WaistInches
		  , HFTBM.HipInches
		  , HFTBM.ThighInches
		  , HFTBM.ArmInches
		  , HFTBM.ChestInches
		  , HFTBM.CalfInches
		  , HFTBM.NeckInches
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTCS.CollectionSourceName_External
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN HFTBM.ItemCreatedWhen = COALESCE (HFTBM.ItemModifiedWhen, HFTBM.ItemCreatedWhen) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFTBM.ItemCreatedWhen
		  , HFTBM.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTBM.itemid
		  , 'HFit_TrackerBodyMeasurements' AS TBL
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerBodyMeasurements AS HFTBM
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON HFTBM.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON HFTBM.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON HFTBM.VendorID = VENDOR.ItemID

	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTBM.EventDate, HFTBM.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTBM.EventDate, HFTBM.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTBM.ItemCreatedWhen IS NOT NULL
		   OR HFTBM.EventDate IS NOT NULL) 

	 --Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT
			HFTH.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTH.ItemCreatedWhen
		  , HFTH.ItemModifiedWhen
		  , HFTH.Notes
		  , HFTH.IsProfessionallyCollected
		  , HFTH.EventDate
		  , 'Not Build Yet' AS EventName
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTH.Height
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTCS.CollectionSourceName_External
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN HFTH.ItemCreatedWhen = COALESCE (HFTH.ItemModifiedWhen, HFTH.ItemCreatedWhen) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFTH.ItemCreatedWhen
		  , HFTH.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTH.itemid
		  , 'HFit_TrackerHeight' AS TBL
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerHeight AS HFTH
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON HFTH.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON HFTH.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON HFTH.VendorID = VENDOR.ItemID

	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria		

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTH.EventDate, HFTH.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTH.EventDate, HFTH.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTH.ItemCreatedWhen IS NOT NULL
		   OR HFTH.EventDate IS NOT NULL) 

	 --Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT
			HFTRHR.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTRHR.ItemCreatedWhen
		  , HFTRHR.ItemModifiedWhen
		  , HFTRHR.Notes
		  , HFTRHR.IsProfessionallyCollected
		  , HFTRHR.EventDate
		  , 'Not Build Yet' AS EventName
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTRHR.HeartRate
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTCS.CollectionSourceName_External
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN HFTRHR.ItemCreatedWhen = COALESCE (HFTRHR.ItemModifiedWhen, HFTRHR.ItemCreatedWhen) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFTRHR.ItemCreatedWhen
		  , HFTRHR.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTRHR.itemid
		  , 'HFit_TrackerRestingHeartRate' AS TBL
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerRestingHeartRate AS HFTRHR
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON HFTRHR.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON HFTRHR.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON HFTRHR.VendorID = VENDOR.ItemID

	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTRHR.EventDate, HFTRHR.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTRHR.EventDate, HFTRHR.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTRHR.ItemCreatedWhen IS NOT NULL
		   OR HFTRHR.EventDate IS NOT NULL) 

	 --Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT
			HFTS.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTS.ItemCreatedWhen
		  , HFTS.ItemModifiedWhen
		  , HFTS.Notes
		  , HFTS.IsProfessionallyCollected
		  , HFTS.EventDate
		  , 'Not Build Yet' AS EventName
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTS.FluShot
		  , HFTS.PneumoniaShot
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTCS.CollectionSourceName_External
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN HFTS.ItemCreatedWhen = COALESCE (HFTS.ItemModifiedWhen, HFTS.ItemCreatedWhen) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFTS.ItemCreatedWhen
		  , HFTS.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTS.itemid
		  , 'HFit_TrackerShots' AS TBL
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerShots AS HFTS
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON HFTS.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON HFTS.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON HFTS.VendorID = VENDOR.ItemID

	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTS.EventDate, HFTS.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTS.EventDate, HFTS.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTS.ItemCreatedWhen IS NOT NULL
		   OR HFTS.EventDate IS NOT NULL) 

	 --Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT
			HFTT.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTT.ItemCreatedWhen
		  , HFTT.ItemModifiedWhen
		  , HFTT.Notes
		  , HFTT.IsProfessionallyCollected
		  , HFTT.EventDate
		  , 'Not Build Yet' AS EventName
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTT.PSATest
		  , HFTT.OtherExam
		  , HFTT.TScore
		  , HFTT.DRA
		  , HFTT.CotinineTest
		  , HFTT.ColoCareKit
		  , HFTT.CustomTest
		  , HFTT.CustomDesc
		  , HFTCS.CollectionSourceName_External
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN HFTT.ItemCreatedWhen = COALESCE (HFTT.ItemModifiedWhen, HFTT.ItemCreatedWhen) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFTT.ItemCreatedWhen
		  , HFTT.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTT.itemid
		  , 'HFit_TrackerTests' AS TBL
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerTests AS HFTT
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON HFTT.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON HFTT.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON HFTT.VendorID = VENDOR.ItemID

	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTT.EventDate, HFTT.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTT.EventDate, HFTT.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTT.ItemCreatedWhen IS NOT NULL
		   OR HFTT.EventDate IS NOT NULL) ;

--Add per RObert and Laura 12.4.2014
--HFit_TrackerBMI
--HFit_TrackerBodyMeasurements
--HFit_TrackerHeight
--HFit_TrackerRestingHeartRate
--HFit_TrackerShots
--HFit_TrackerTests

GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create View [dbo].[view_EDW_Eligibility]

PRINT 'Create View [dbo].[view_EDW_Eligibility]';
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

--select top 100 * from view_EDW_Eligibility

CREATE VIEW view_EDW_Eligibility
AS

	 --*************************************************************************************************************************
	 --view_EDW_Eligibility is the starting point for the EDW to pull data. As of 11.11.2014, all columns
	 --within the view are just a starting point. We will work with the EDW team to define and pull all the data
	 --they are needing.
	 --A PPT becomes eligible to participate through the Rules
	 --Rules of Engagement:
	 --00: ROLES are tied to a feature ; if the ROLE is not on a Kentico page - you don't see it.
	 --01: When the Kentico group rebuild executes, all is lost. There is no retained MEMBER/User history.
	 --02: The group does not track when a member enters or leaves a group, simply that they exist in that group.
	 --NOTE: Any data deemed necessary can be added to this view for the EDW
	 --01.27.2015 (WDM) #48941 - Add Client Identifier to View_EDW_Eligibility
	 --	   In analyzing this requirement, found that the PPT.ClientID is nvarchar (alphanumeric)
	 --	   and Hfit_Client.ClientID is integer. A bit of a domain/naming issue.
	 --02.02.2015 (WDM) #44691 - Added the Site ID, Site Name, and Site Display Name to the returned cols of data
	 --	  per the conversation with John C. earlier this morning.
	 --02.05.2015 (WDM) #44691 - Added the Site GUID
	 --*************************************************************************************************************************

	 SELECT
			ROLES.RoleID
		  , ROLES.RoleName
		  , ROLES.RoleDescription
		  , ROLES.RoleGUID
		  , MemberROLE.MembershipID
		  , MemberROLE.RoleID AS MbrRoleID
		  , MemberSHIP.UserID AS MemberShipUserID
		  , MemberSHIP.ValidTo AS MemberShipValidTo
		  , USERSET.HFitUserMpiNumber
		  , USERSET.UserNickName
		  , USERSET.UserDateOfBirth
		  , USERSET.UserGender
		  , PPT.PPTID
		  , PPT.FirstName
		  , PPT.LastName
		  , PPT.City
		  , PPT.State
		  , PPT.PostalCode
		  , PPT.UserID AS PPTUserID
		  , GRPMBR.ContactGroupMemberContactGroupID
		  , GRPMBR.ContactGroupMemberRelatedID
		  , GRPMBR.ContactGroupMemberType
		  , GRP.ContactGroupName
		  , GRP.ContactGroupDisplayName
		  , PPT.ClientCode
		  , ACCT.AccountName
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , ACCT.SiteID
		  , SITE.SiteGUID
		  , SITE.SiteName
		  , SITE.SiteDisplayName
		  , EHIST.GroupName AS EligibilityGroupName
		  , EHIST.StartedDate AS EligibilityStartDate
		  , EHIST.EndedDate AS EligibilityEndDate
		  , GHIST.GroupName AS GroupName
		  , GHIST.StartedDate AS GroupStartDate
		  , GHIST.EndedDate AS GroupEndDate
	   FROM CMS_Role AS ROLES
				JOIN cms_MembershipRole AS MemberROLE
					ON ROLES.RoleID = MemberROLE.RoleID
				JOIN cms_MembershipUser AS MemberSHIP
					ON MemberROLE.MembershipID = MemberSHIP.MembershipID
				JOIN HFit_PPTEligibility AS PPT
					ON PPT.UserID = MemberSHIP.UserID
				JOIN CMS_USERSettings AS USERSET
					ON USERSET.UserSettingsUserID = PPT.UserID
				JOIN OM_ContactGroupMember AS GRPMBR
					ON GRPMBR.ContactGroupMemberRelatedID = USERSET.HFitPrimaryContactID
				JOIN OM_ContactGroup AS GRP
					ON GRP.ContactGroupID = GRPMBR.ContactGroupMemberContactGroupID
				JOIN HFit_ContactGroupMembership AS GroupMBR
					ON GroupMBR.cmsMembershipID = MemberSHIP.MembershipID

	 --LEFT OUTER JOIN [Hfit_Client] AS [CLIENT]
	 --ON [PPT].[ClientCode] = [CLIENT].[ClientName]

				LEFT OUTER JOIN HFit_Account AS ACCT
					ON ROLES.SiteID = ACCT.SiteID
				LEFT OUTER JOIN CMS_Site AS SITE
					ON SITE.SiteID = ACCT.SiteID
				LEFT OUTER JOIN view_EDW_EligibilityHistory AS EHIST
					ON EHIST.UserMpiNumber = USERSET.HFitUserMpiNumber
				LEFT OUTER JOIN EDW_GroupMemberHistory AS GHIST
					ON GHIST.UserMpiNumber = USERSET.HFitUserMpiNumber;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Alter View [dbo].[view_EDW_Coaches]

PRINT 'Alter View [dbo].[view_EDW_Coaches]';
GO

--****************************************************
-- Verified last mod date available to EDW 9.10.2014
--****************************************************

ALTER VIEW dbo.view_EDW_Coaches
AS
	 SELECT DISTINCT
			cu.UserGUID
		  , cs.SiteGUID
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CoachID
		  , hfc.LastName
		  , hfc.FirstName
		  , hfc.StartDate
		  , hfc.Phone
		  , hfc.email
		  , hfc.Supervisor
		  , hfc.SuperCoach
		  , hfc.MaxParticipants
		  , hfc.Inactive
		  , hfc.MaxRiskLevel
		  , hfc.Locked
		  , hfc.TimeLocked
		  , hfc.terminated
		  , hfc.APMaxParticipants
		  , hfc.RNMaxParticipants
		  , hfc.RNPMaxParticipants
		  , hfc.Change_Type
		  , hfc.Last_Update_Dt
	   FROM dbo.HFit_Coaches AS HFC
				LEFT OUTER JOIN dbo.CMS_User AS CU
					ON hfc.KenticoUserID = cu.UserID
				LEFT OUTER JOIN dbo.CMS_UserSite AS CUS
					ON cu.userid = cus.UserID
				LEFT OUTER JOIN dbo.CMS_Site AS CS
					ON CS.SiteID = CUS.SiteID
				LEFT OUTER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = hfa.SiteID;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[UTIL_getUsageCount]

PRINT 'Create Procedure [dbo].[UTIL_getUsageCount]';
GO

-- exec UTIL_getUsageCount 'view_EDW_Coaches'

CREATE PROC UTIL_getUsageCount (@SearchToken AS nvarchar (200)) 
AS
	 BEGIN

		 --***************************************************************************************
		 --Author: W. Dale Miller
		 --Date:   08/24/2014
		 --USE:	  UTIL_getUsageCount('view_EDW_Coaches')
		 --This utility will wrap @SearchToken in '%' so that is performs a wildcard search.
		 --The search is limited to a select number of tables, not the entire database.
		 --To search the entire database, use UTIL_SearchAllTables 'view_EDW_Coaches'.
		 --Execution time varies upon DB load at the time, but usually in about 40 minutes.
		 --***************************************************************************************

		 DECLARE @token nvarchar (250) ;
		 DECLARE @totCnt int;
		 DECLARE @iCnt int;
		 DECLARE @sTime datetime;
		 DECLARE @eTime datetime;
		 DECLARE @Secs int;
		 SET @iCnt = 0;
		 SET @totCnt = 0;
		 SET @token = '%' + @SearchToken + '%';
		 SET @sTime = GETDATE () ;
		 SET @iCnt = (SELECT
							 COUNT (*) 
						FROM CMS_Class
						WHERE ClassFormDefinition LIKE @token) ;
		 SET @eTime = GETDATE () ;
		 SET @Secs = (SELECT
							 DATEDIFF (SECOND, @sTime, @eTime)) ;
		 PRINT 'Secs: ' + CAST (@Secs AS nvarchar) ;
		 PRINT 'CMS_Class: ' + CAST (@iCnt AS nvarchar) ;
		 SET @totCnt = @totCnt + @iCnt;
		 SET @sTime = GETDATE () ;
		 SET @iCnt = (SELECT
							 COUNT (*) 
						FROM CMS_Query
						WHERE QueryText LIKE @token) ;
		 SET @eTime = GETDATE () ;
		 SET @Secs = (SELECT
							 DATEDIFF (SECOND, @sTime, @eTime)) ;
		 PRINT 'Secs: ' + CAST (@Secs AS nvarchar) ;
		 PRINT 'CMS_Query: ' + CAST (@iCnt AS nvarchar) ;
		 SET @totCnt = @totCnt + @iCnt;
		 SET @sTime = GETDATE () ;
		 SET @iCnt = (SELECT
							 COUNT (*) 
						FROM CMS_Email
						WHERE EmailBody LIKE @token) ;
		 SET @eTime = GETDATE () ;
		 SET @Secs = (SELECT
							 DATEDIFF (SECOND, @sTime, @eTime)) ;
		 PRINT 'Secs: ' + CAST (@Secs AS nvarchar) ;
		 PRINT 'CMS_Email: ' + CAST (@iCnt AS nvarchar) ;
		 SET @totCnt = @totCnt + @iCnt;
		 SET @sTime = GETDATE () ;
		 SET @iCnt = (SELECT
							 COUNT (*) 
						FROM AuditObjects
						WHERE ObjectName LIKE @token) ;
		 SET @eTime = GETDATE () ;
		 SET @Secs = (SELECT
							 DATEDIFF (SECOND, @sTime, @eTime)) ;
		 PRINT 'Secs: ' + CAST (@Secs AS nvarchar) ;
		 PRINT 'AuditObjects: ' + CAST (@iCnt AS nvarchar) ;
		 SET @totCnt = @totCnt + @iCnt;
		 SET @sTime = GETDATE () ;
		 SET @iCnt = (SELECT
							 COUNT (*) 
						FROM CMS_EventLogArchive
						WHERE EventDescription LIKE @token) ;
		 SET @eTime = GETDATE () ;
		 SET @Secs = (SELECT
							 DATEDIFF (SECOND, @sTime, @eTime)) ;
		 PRINT 'Secs: ' + CAST (@Secs AS nvarchar) ;
		 PRINT 'CMS_EventLogArchive: ' + CAST (@iCnt AS nvarchar) ;
		 SET @totCnt = @totCnt + @iCnt;
		 SET @sTime = GETDATE () ;
		 SET @iCnt = (SELECT
							 COUNT (*) 
						FROM CMS_ObjectVersionHistory
						WHERE VersionXML LIKE @token) ;
		 SET @eTime = GETDATE () ;
		 SET @Secs = (SELECT
							 DATEDIFF (SECOND, @sTime, @eTime)) ;
		 PRINT 'Secs: ' + CAST (@Secs AS nvarchar) ;
		 PRINT 'CMS_ObjectVersionHistory: ' + CAST (@iCnt AS nvarchar) ;
		 SET @totCnt = @totCnt + @iCnt;

		 --print ('Total Count for '+@token+': ' + cast(@totCnt as nvarchar));

		 SET @sTime = GETDATE () ;
		 SET @iCnt = (SELECT
							 COUNT (*) 
						FROM Newsletter_NewsletterIssue
						WHERE IssueText LIKE @token) ;
		 SET @eTime = GETDATE () ;
		 SET @Secs = (SELECT
							 DATEDIFF (SECOND, @sTime, @eTime)) ;
		 PRINT 'Secs: ' + CAST (@Secs AS nvarchar) ;
		 PRINT '[Newsletter_NewsletterIssue]: ' + CAST (@iCnt AS nvarchar) ;
		 SET @totCnt = @totCnt + @iCnt;

		 --print ('Total Count for '+@token+': ' + cast(@totCnt as nvarchar));

		 SET @sTime = GETDATE () ;
		 SET @iCnt = (SELECT
							 COUNT (*) 
						FROM Reporting_ReportGraph
						WHERE GraphQuery LIKE @token) ;
		 SET @eTime = GETDATE () ;
		 SET @Secs = (SELECT
							 DATEDIFF (SECOND, @sTime, @eTime)) ;
		 PRINT 'Secs: ' + CAST (@Secs AS nvarchar) ;
		 PRINT '[Reporting_ReportGraph]: ' + CAST (@iCnt AS nvarchar) ;
		 SET @totCnt = @totCnt + @iCnt;

		 --print ('Total Count for '+@token+': ' + cast(@totCnt as nvarchar));

		 SET @sTime = GETDATE () ;
		 SET @iCnt = (SELECT
							 COUNT (*) 
						FROM CMS_ResourceTranslation
						WHERE TranslationText LIKE @token) ;
		 SET @eTime = GETDATE () ;
		 SET @Secs = (SELECT
							 DATEDIFF (SECOND, @sTime, @eTime)) ;
		 PRINT 'Secs: ' + CAST (@Secs AS nvarchar) ;
		 PRINT '[CMS_ResourceTranslation]: ' + CAST (@iCnt AS nvarchar) ;
		 SET @totCnt = @totCnt + @iCnt;

		 --print ('Total Count for '+@token+': ' + cast(@totCnt as nvarchar));

		 SET @sTime = GETDATE () ;
		 SET @iCnt = (SELECT
							 COUNT (*) 
						FROM CMS_WebPart
						WHERE WebPartProperties LIKE @token) ;
		 SET @eTime = GETDATE () ;
		 SET @Secs = (SELECT
							 DATEDIFF (SECOND, @sTime, @eTime)) ;
		 PRINT 'Secs: ' + CAST (@Secs AS nvarchar) ;
		 PRINT '[CMS_WebPart]: ' + CAST (@iCnt AS nvarchar) ;
		 SET @totCnt = @totCnt + @iCnt;

		 --print ('Total Count for '+@token+': ' + cast(@totCnt as nvarchar));

		 SET @sTime = GETDATE () ;
		 SET @iCnt = (SELECT
							 COUNT (*) 
						FROM CMS_Widget
						WHERE WidgetProperties LIKE @token) ;
		 SET @eTime = GETDATE () ;
		 SET @Secs = (SELECT
							 DATEDIFF (SECOND, @sTime, @eTime)) ;
		 PRINT 'Secs: ' + CAST (@Secs AS nvarchar) ;
		 PRINT '[CMS_Widget]: ' + CAST (@iCnt AS nvarchar) ;
		 SET @totCnt = @totCnt + @iCnt;

		 --print ('Total Count for '+@token+': ' + cast(@totCnt as nvarchar));

		 SET @sTime = GETDATE () ;
		 SET @iCnt = (SELECT
							 COUNT (*) 
						FROM DDLEvents
						WHERE ObjectName LIKE @token) ;
		 SET @eTime = GETDATE () ;
		 SET @Secs = (SELECT
							 DATEDIFF (SECOND, @sTime, @eTime)) ;
		 PRINT 'Secs: ' + CAST (@Secs AS nvarchar) ;
		 PRINT '[DDLEvents]: ' + CAST (@iCnt AS nvarchar) ;
		 SET @totCnt = @totCnt + @iCnt;

		 --print ('Total Count for '+@token+': ' + cast(@totCnt as nvarchar));

		 SET @sTime = GETDATE () ;
		 SET @iCnt = (SELECT
							 COUNT (*) 
						FROM Reporting_ReportTable
						WHERE TableQuery LIKE @token) ;
		 SET @eTime = GETDATE () ;
		 SET @Secs = (SELECT
							 DATEDIFF (SECOND, @sTime, @eTime)) ;
		 PRINT 'Secs: ' + CAST (@Secs AS nvarchar) ;
		 PRINT '[Reporting_ReportTable]: ' + CAST (@iCnt AS nvarchar) ;
		 SET @totCnt = @totCnt + @iCnt;

		 --print ('Total Count for '+@token+': ' + cast(@totCnt as nvarchar));

		 SET @sTime = GETDATE () ;
		 SET @iCnt = (SELECT
							 COUNT (*) 
						FROM Staging_Task
						WHERE TaskData LIKE @token) ;
		 SET @eTime = GETDATE () ;
		 SET @Secs = (SELECT
							 DATEDIFF (SECOND, @sTime, @eTime)) ;
		 PRINT 'Secs: ' + CAST (@Secs AS nvarchar) ;
		 PRINT '[Staging_Task]: ' + CAST (@iCnt AS nvarchar) ;
		 SET @totCnt = @totCnt + @iCnt;
		 SET @sTime = GETDATE () ;
		 SET @iCnt = (SELECT
							 COUNT (*) 
						FROM Reporting_ReportValue
						WHERE ValueQuery LIKE @token) ;
		 SET @eTime = GETDATE () ;
		 SET @Secs = (SELECT
							 DATEDIFF (SECOND, @sTime, @eTime)) ;
		 PRINT 'Secs: ' + CAST (@Secs AS nvarchar) ;
		 PRINT '[Reporting_ReportValue]: ' + CAST (@iCnt AS nvarchar) ;
		 SET @totCnt = @totCnt + @iCnt;
		 SET @sTime = GETDATE () ;
		 SET @iCnt = (SELECT
							 COUNT (*) 
						FROM EDW_PerformanceMeasure
						WHERE ObjectName LIKE @token) ;
		 SET @eTime = GETDATE () ;
		 SET @Secs = (SELECT
							 DATEDIFF (SECOND, @sTime, @eTime)) ;
		 PRINT 'Secs: ' + CAST (@Secs AS nvarchar) ;
		 PRINT '[EDW_PerformanceMeasure]: ' + CAST (@iCnt AS nvarchar) ;
		 SET @totCnt = @totCnt + @iCnt;
		 PRINT 'Total Count for ' + @token + ': ' + CAST (@totCnt AS nvarchar) ;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[proc_build_EDW_Eligibility]

PRINT 'Create Procedure [dbo].[proc_build_EDW_Eligibility]';
GO
CREATE PROCEDURE proc_build_EDW_Eligibility
AS
	 BEGIN

		 --*******************************************************************************************
		 --Step 1 - Call procedure proc_EDW_EligibilityDaily
		 --    Step 2 - Call procedure proc_EDW_EligibilityStarted
		 --    Step 3 - Call procedure proc_EDW_EligibilityExpired
		 --    Step 4 - Retrieve the PPT membership history using the view view_EDW_EligibilityHistory
		 --    proc_build_EDW_Eligibility runs all three required procedures that are needed
		 --    to apply current eligibility new, current, and expired (missing).
		 --*******************************************************************************************

		 SET NOCOUNT ON;
		 EXEC proc_EDW_EligibilityDaily;
		 EXEC proc_EDW_EligibilityStarted;
		 EXEC proc_EDW_EligibilityExpired;
		 SET NOCOUNT OFF;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[Proc_EDW_GenerateMetadata]

PRINT 'Create Procedure [dbo].[Proc_EDW_GenerateMetadata]';
GO

--select * from view_EDW_TrackerMetadata where TableName = 'HFit.CustomTrackerInstances'
--select * from Tracker_EDW_Metadata
--delete from Tracker_EDW_Metadata where TableName = 'HFit.TrackerWholeGrains'
--exec Proc_EDW_GenerateMetadata
--2014-07-30 20:59:10.940

CREATE PROCEDURE dbo.Proc_EDW_GenerateMetadata
AS
	 BEGIN

		 --truncate table Tracker_EDW_Metadata;

		 BEGIN TRAN T1;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFIT.Tracker';
		 COMMIT TRAN T1;
		 BEGIN TRAN T2;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerCategory';
		 COMMIT TRAN T2;
		 BEGIN TRAN T3;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerDocument';
		 COMMIT TRAN T3;
		 BEGIN TRAN T4;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.UserTracker';
		 COMMIT TRAN T4;
		 BEGIN TRAN T5;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.UserTrackerCategory';
		 COMMIT TRAN T5;
		 BEGIN TRAN T6;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerCollectionSource';
		 COMMIT TRAN T6;
		 BEGIN TRAN T7;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerVegetables';
		 COMMIT TRAN T7;
		 BEGIN TRAN T8;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.LKP_TrackerTobaccoQuitAids';
		 COMMIT TRAN T8;
		 BEGIN TRAN T9;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerTobaccoFree';
		 COMMIT TRAN T9;
		 BEGIN TRAN T10;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerWholeGrains';
		 COMMIT TRAN T10;
		 BEGIN TRAN T11;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerFruits';
		 COMMIT TRAN T11;
		 BEGIN TRAN T12;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerSugaryDrinks';
		 COMMIT TRAN T12;
		 BEGIN TRAN T13;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerWater';
		 COMMIT TRAN T13;
		 BEGIN TRAN T14;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerHighSodiumFoods';
		 COMMIT TRAN T15;
		 BEGIN TRAN T16;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerHighFatFoods';
		 COMMIT TRAN T16;
		 BEGIN TRAN T17;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerSleepPlan';
		 COMMIT TRAN T17;
		 BEGIN TRAN T18;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.LKP_TrackerSleepPlanTechniques';
		 COMMIT TRAN T18;
		 BEGIN TRAN T19;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerMedicalCarePlan';
		 COMMIT TRAN T19;
		 BEGIN TRAN T20;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerSummary';
		 COMMIT TRAN T20;
		 BEGIN TRAN T21;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerRegularMeals';
		 COMMIT TRAN T21;
		 BEGIN TRAN T22;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerBodyFat';
		 COMMIT TRAN T22;
		 BEGIN TRAN T23;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerWeight';
		 COMMIT TRAN T23;
		 BEGIN TRAN T24;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerBloodSugarGlucose';
		 COMMIT TRAN T24;
		 BEGIN TRAN T25;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerHbA1c';
		 COMMIT TRAN T25;
		 BEGIN TRAN T26;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerMealPortions';
		 COMMIT TRAN T26;
		 BEGIN TRAN T27;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerSugaryFoods';
		 COMMIT TRAN T27;
		 BEGIN TRAN T28;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.LKP_TrackerStrengthActivity';
		 COMMIT TRAN T29;
		 BEGIN TRAN T30;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerRestingHeartRate';
		 COMMIT TRAN T30;
		 BEGIN TRAN T31;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerCholesterol';
		 COMMIT TRAN T31;
		 BEGIN TRAN T32;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerBodyMeasurements';
		 COMMIT TRAN T32;
		 BEGIN TRAN T33;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerBloodPressure';
		 COMMIT TRAN T33;
		 BEGIN TRAN T34;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.LKP_TrackerFlexibilityActivity';
		 COMMIT TRAN T34;
		 BEGIN TRAN T35;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerStressManagement';
		 COMMIT TRAN T35;
		 BEGIN TRAN T36;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerFlexibility';
		 COMMIT TRAN T36;
		 BEGIN TRAN T37;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerStress';
		 COMMIT TRAN T37;
		 BEGIN TRAN T38;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerCardio';
		 COMMIT TRAN T39;
		 BEGIN TRAN T40;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerSitLess';
		 COMMIT TRAN T40;
		 BEGIN TRAN T41;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerStrength';
		 COMMIT TRAN T41;
		 BEGIN TRAN T42;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.LKP_TrackerCardioActivity';
		 COMMIT TRAN T42;
		 BEGIN TRAN T43;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerBMI';
		 COMMIT TRAN T43;
		 BEGIN TRAN T44;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.Ref_RewardTrackerValidation';
		 COMMIT TRAN T45;
		 BEGIN TRAN T46;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.HFit_TrackerHeight';
		 COMMIT TRAN T46;
		 BEGIN TRAN T47;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.HFit_TrackerShots';
		 COMMIT TRAN T47;
		 BEGIN TRAN T48;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.HFit_TrackerTests';
		 COMMIT TRAN T48;

		 --BEGIN  TRAN T49;
		 --EXEC Proc_EDW_TrackerMetadataExtract 'HFit.HealthAssessmentCodeNamesToTrackerMapping';
		 --COMMIT TRAN T49;

		 BEGIN TRAN T50;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.CustomTrackerInstances';
		 COMMIT TRAN T50;
		 BEGIN TRAN T51;
		 EXEC Proc_EDW_TrackerMetadataExtract 'HFit.TrackerDailySteps';
		 COMMIT TRAN T51;
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create View [dbo].[View_EDW_RewardProgram_Joined]

PRINT 'Create View [dbo].[View_EDW_RewardProgram_Joined]';
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

--This view is created in place of View_Hfit_RewardProgram_Joined so that 
--Document Culture can be taken into consideration. 

CREATE VIEW dbo.View_EDW_RewardProgram_Joined
AS
	 SELECT
			View_CMS_Tree_Joined.*
		  , HFit_RewardProgram.*
	   FROM View_CMS_Tree_Joined
				INNER JOIN HFit_RewardProgram
					ON View_CMS_Tree_Joined.DocumentForeignKeyValue = HFit_RewardProgram.RewardProgramID
	   WHERE ClassName = 'HFit.RewardProgram'
		 AND View_CMS_Tree_Joined.documentculture = 'en-US';
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Alter View [dbo].[view_EDW_HealthAssesmentClientView]

PRINT 'Alter View [dbo].[view_EDW_HealthAssesmentClientView]';
GO

--GRANT SELECT
--	ON [dbo].[view_EDW_HealthAssesmentClientView]
--	TO [EDWReader_PRD]
--GO
--******************************************************************************
--8/8/2014 - Generated corrected view in DEV (WDM)
--09.11.2014 (wdm) added to facilitate EDW last mod date
--02.04.2015 (wdm) #48828 added , HACampaign.BiometricCampaignStartDate, 
--		  HACampaign.BiometricCampaignEndDate, HACampaign.CampaignStartDate, 
--		  HACampaign.CampaignEndDate, HACampaign.Name, 
--		  HACampaign.NodeGuid as CampaignNodeGuid
--02.05.2015 Ashwin and I reviewed and approved
-- select top 100 * from view_EDW_HealthAssesmentClientView
--******************************************************************************

ALTER VIEW dbo.view_EDW_HealthAssesmentClientView
AS
	 SELECT
			HFitAcct.AccountID
		  , HFitAcct.AccountCD
		  , HFitAcct.AccountName
		  , HFitAcct.ItemGUID AS ClientGuid
		  , CMSSite.SiteGUID
		  , NULL AS CompanyID
		  , NULL AS CompanyGUID
		  , NULL AS CompanyName
		  , HAJoined.DocumentName
		  , HACampaign.DocumentPublishFrom AS HAStartDate
		  , HACampaign.DocumentPublishTo AS HAEndDate
		  , HACampaign.NodeSiteID
		  , HAAssessmentMod.Title
		  , HAAssessmentMod.CodeName
		  , HAAssessmentMod.IsEnabled
		  , CASE
				WHEN CAST (HACampaign.DocumentCreatedWhen AS date) = CAST (HACampaign.DocumentModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HACampaign.DocumentCreatedWhen
		  , HACampaign.DocumentModifiedWhen
		  , HAAssessmentMod.DocumentModifiedWhen AS AssesmentModule_DocumentModifiedWhen

			--09.11.2014 (wdm) added to facilitate EDW last mod date

		  , HAAssessmentMod.DocumentCulture AS DocumentCulture_HAAssessmentMod
		  , HACampaign.DocumentCulture AS DocumentCulture_HACampaign
		  , HAJoined.DocumentCulture AS DocumentCulture_HAJoined
		  , HACampaign.BiometricCampaignStartDate
		  , HACampaign.BiometricCampaignEndDate
		  , HACampaign.CampaignStartDate
		  , HACampaign.CampaignEndDate
		  , HACampaign.Name
		  , HACampaign.NodeGuid AS CampaignNodeGuid
		  , HACampaign.HACampaignID
	   FROM dbo.View_HFit_HACampaign_Joined AS HACampaign
				INNER JOIN dbo.CMS_Site AS CMSSite
					ON HACampaign.NodeSiteID = CMSSite.SiteID
				INNER JOIN dbo.HFit_Account AS HFitAcct
					ON HACampaign.NodeSiteID = HFitAcct.SiteID
				INNER JOIN dbo.View_HFit_HealthAssessment_Joined AS HAJoined
					ON CASE
						   WHEN HACampaign.HealthAssessmentConfigurationID < 0
						   THEN HACampaign.HealthAssessmentID
						   ELSE HACampaign.HealthAssessmentConfigurationID
					   END = HAJoined.DocumentID
				   AND HAJoined.DocumentCulture = 'en-US'
				INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS HAAssessmentMod
					ON HAJoined.nodeid = HAAssessmentMod.NodeParentID
				   AND HAAssessmentMod.DocumentCulture = 'en-US'
	   WHERE HACampaign.DocumentCulture = 'en-US';
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create View [dbo].[View_EDW_HealthAssesmentAnswers]

PRINT 'Create View [dbo].[View_EDW_HealthAssesmentAnswers]';
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
CREATE VIEW dbo.View_EDW_HealthAssesmentAnswers
AS

	 --********************************************************************************************************
	 --WDM 8.8.2014 - Created this view in order to add the DocumentGUID as 
	 --			required by the EDW team. Was having a bit of push-back
	 --			from the developers, so created this one in order to 
	 --			expedite filling the need for runnable views for the EDW.
	 -- Verified last mod date available to EDW 9.10.2014
	 --********************************************************************************************************

	 SELECT
			VHFHAPAJ.ClassName AS AnswerType
		  , VHFHAPAJ.Value
		  , VHFHAPAJ.Points
		  , VHFHAPAJ.NodeGUID
		  , VHFHAPAJ.IsEnabled
		  , VHFHAPAJ.CodeName
		  , VHFHAPAJ.InputType
		  , VHFHAPAJ.UOM
		  , VHFHAPAJ.NodeAliasPath
		  , VHFHAPAJ.DocumentPublishedVersionHistoryID
		  , VHFHAPAJ.NodeID
		  , VHFHAPAJ.NodeOrder
		  , VHFHAPAJ.NodeLevel
		  , VHFHAPAJ.NodeParentID
		  , VHFHAPAJ.NodeLinkedNodeID
		  , VHFHAPAJ.DocumentCulture
		  , VHFHAPAJ.DocumentGuid
		  , VHFHAPAJ.DocumentModifiedWhen
	   FROM dbo.View_HFit_HealthAssesmentPredefinedAnswer_Joined AS VHFHAPAJ WITH (NOLOCK) 
	   WHERE VHFHAPAJ.DocumentCulture = 'en-US';
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Alter View [dbo].[view_EDW_CoachingDetail]

PRINT 'Alter View [dbo].[view_EDW_CoachingDetail]';
GO

--GRANT SELECT
--	ON [dbo].[[view_EDW_CoachingDetail]]
--	TO [EDWReader_PRD]
--GO

/******************************************************************
 TEST Queries
select * from [view_EDW_CoachingDetail]
select * from [view_EDW_CoachingDetail] where CloseReasonLKPID != 0
select count(*) from [view_EDW_CoachingDetail]
******************************************************************/

ALTER VIEW dbo.view_EDW_CoachingDetail
AS

	 --********************************************************************************************
	 --8/7/2014 - added and commented out DocumentGuid in case needed later
	 --8/8/2014 - Generated corrected view in DEV (WDM)
	 -- Verified last mod date available to EDW 9.10.2014
	 -- 01.02.2014 (WDM) added column HFUG.CloseReasonLKPID in order to satisfy Story #47923
	 -- 01.06.2014 (WDM) Tested with team B and found that the data was being returned. Stipulating that 
	 --					we converted the inner join to left outer join dbo.HFit_GoalOutcome. This 
	 --					allows data to be returned with the meaning that if NULL HFGO.EvaluationDate
	 --					is returned, the GOAL may exist without any input/update from the coach or
	 --					PPT
	 -- 01.07.2014 (WDM) This also takes care of 47976
	 --********************************************************************************************

	 SELECT
			HFUG.ItemID
		  , HFUG.ItemGUID
		  , GJ.GoalID
		  , HFUG.UserID
		  , cu.UserGUID
		  , cus.HFitUserMpiNumber
		  , cs.SiteGUID
		  , hfa.AccountID
		  , hfa.AccountCD
		  , hfa.AccountName
		  , HFUG.IsCreatedByCoach
		  , HFUG.BaselineAmount
		  , HFUG.GoalAmount
		  , NULL AS DocumentID
		  , HFUG.GoalStatusLKPID
		  , HFLGS.GoalStatusLKPName
		  , HFUG.EvaluationStartDate
		  , HFUG.EvaluationEndDate
		  , HFUG.GoalStartDate
		  , HFUG.CoachDescription
		  , HFGO.EvaluationDate
		  , HFGO.Passed
		  , HFGO.WeekendDate
		  , CASE
				WHEN CAST (HFUG.ItemCreatedWhen AS date) = CAST (HFUG.ItemModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFUG.ItemCreatedWhen
		  , HFUG.ItemModifiedWhen
		  , GJ.NodeGUID
		  , HFUG.CloseReasonLKPID
		  , GRC.CloseReason
	   FROM dbo.HFit_UserGoal AS HFUG WITH (NOLOCK) 
				INNER JOIN (
							SELECT
								   VHFGJ.GoalID
								 , VHFGJ.NodeID
								 , VHFGJ.NodeGUID
								 , VHFGJ.DocumentCulture
								 , VHFGJ.DocumentGuid
								 , VHFGJ.DocumentModifiedWhen

							--WDM added 9.10.2014

							  FROM dbo.View_HFit_Goal_Joined AS VHFGJ WITH (NOLOCK) 
							UNION ALL
							SELECT
								   VHFTGJ.GoalID
								 , VHFTGJ.NodeID
								 , VHFTGJ.NodeGUID
								 , VHFTGJ.DocumentCulture
								 , VHFTGJ.DocumentGuid
								 , VHFTGJ.DocumentModifiedWhen

							--WDM added 9.10.2014

							  FROM dbo.View_HFit_Tobacco_Goal_Joined AS VHFTGJ WITH (NOLOCK)) AS GJ
					ON hfug.NodeID = gj.NodeID
				   AND GJ.DocumentCulture = 'en-us'
				LEFT OUTER JOIN dbo.HFit_GoalOutcome AS HFGO WITH (NOLOCK) 
					ON HFUG.ItemID = HFGO.UserGoalItemID
				INNER JOIN dbo.HFit_LKP_GoalStatus AS HFLGS WITH (NOLOCK) 
					ON HFUG.GoalStatusLKPID = HFLGS.GoalStatusLKPID
				INNER JOIN dbo.CMS_User AS CU WITH (NOLOCK) 
					ON HFUG.UserID = cu.UserID
				INNER JOIN dbo.CMS_UserSettings AS CUS WITH (NOLOCK) 
					ON CU.UserGUID = CUS.UserSettingsUserGUID
				INNER JOIN dbo.CMS_UserSite AS CUS2 WITH (NOLOCK) 
					ON cu.UserID = CUS2.UserID
				INNER JOIN dbo.CMS_Site AS CS WITH (NOLOCK) 
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
					ON cs.SiteID = hfa.SiteID
				LEFT OUTER JOIN HFit_LKP_GoalCloseReason AS GRC
					ON GRC.CloseReasonID = HFUG.CloseReasonLKPID;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create View [dbo].[view_EDW_HealthInterestList]

PRINT 'Create View [dbo].[view_EDW_HealthInterestList]';
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
CREATE VIEW dbo.view_EDW_HealthInterestList
AS
	 SELECT
			CHA.CoachingHealthAreaID AS HealthAreaID
		  , CHA.NodeID
		  , CHA.NodeGuid
		  , A.AccountCD
		  , CHA.NodeName AS HealthAreaName
		  , CHA.HealthAreaDescription
		  , CHA.CodeName
		  , CHA.DocumentCreatedWhen
		  , CHA.DocumentModifiedWhen
	   FROM View_HFit_CoachingHealthArea_Joined AS CHA
				JOIN HFit_Account AS A
					ON A.SiteID = CHA.NodeSiteID
	   WHERE DocumentCulture = 'en-us';
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create View [dbo].[view_EDW_HealthInterestDetail]

PRINT 'Create View [dbo].[view_EDW_HealthInterestDetail]';
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
CREATE VIEW dbo.view_EDW_HealthInterestDetail
AS
	 SELECT
			HI.UserID
		  , U.UserGUID
		  , US.HFitUserMpiNumber
		  , S.SiteGUID
		  , HI.CoachingHealthInterestID
		  , HA1.CoachingHealthAreaID AS FirstHealthAreaID
		  , HA1.NodeID AS FirstNodeID
		  , HA1.NodeGuid AS FirstNodeGuid
		  , HA1.DocumentName AS FirstHealthAreaName
		  , HA1.HealthAreaDescription AS FirstHealthAreaDescription
		  , HA1.CodeName AS FirstCodeName
		  , HA2.CoachingHealthAreaID AS SecondHealthAreaID
		  , HA2.NodeID AS SecondNodeID
		  , HA2.NodeGuid AS SecondNodeGuid
		  , HA2.DocumentName AS SecondHealthAreaName
		  , HA2.HealthAreaDescription AS SecondHealthAreaDescription
		  , HA2.CodeName AS SecondCodeName
		  , HA3.CoachingHealthAreaID AS ThirdHealthAreaID
		  , HA3.NodeID AS ThirdNodeID
		  , HA3.NodeGuid AS ThirdNodeGuid
		  , HA3.DocumentName AS ThirdHealthAreaName
		  , HA3.HealthAreaDescription AS ThirdHealthAreaDescription
		  , HA3.CodeName AS ThirdCodeName
		  , HI.ItemCreatedWhen
		  , HI.ItemModifiedWhen
	   FROM HFit_CoachingHealthInterest AS HI
				JOIN CMS_User AS U
					ON HI.UserID = U.UserID
				JOIN CMS_UserSettings AS US
					ON HI.UserID = US.UserSettingsUserID
				JOIN CMS_UserSite AS US1
					ON HI.UserID = US1.UserID
				JOIN CMS_Site AS S
					ON US1.SiteID = S.SiteID
				LEFT JOIN View_HFit_CoachingHealthArea_Joined AS HA1
					ON HI.FirstInterest = HA1.NodeID
				   AND HA1.DocumentCulture = 'en-us'
				LEFT JOIN View_HFit_CoachingHealthArea_Joined AS HA2
					ON HI.SecondInterest = HA2.NodeID
				   AND HA2.DocumentCulture = 'en-us'
				LEFT JOIN View_HFit_CoachingHealthArea_Joined AS HA3
					ON HI.ThirdInterest = HA3.NodeID
				   AND HA3.DocumentCulture = 'en-us';
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create View [dbo].[View_EDW_HealthAssesmentQuestions]

PRINT 'Create View [dbo].[View_EDW_HealthAssesmentQuestions]';
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
CREATE VIEW dbo.View_EDW_HealthAssesmentQuestions
AS

	 --**********************************************************************************
	 --09.11.2014 (wdm) Added the DocumentModifiedWhen to facilitate the EDW need to 
	 --		determine the last mod date of a record.
	 --10.17.2014 (wdm)
	 -- view_EDW_HealthAssesmentDeffinition calls 
	 -- View_EDW_HealthAssesmentQuestions which calls
	 -- View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined
	 --		and two other JOINED views.
	 --View view_EDW_HealthAssesmentDeffinition has a filter on document culture of 'EN-US'
	 --		which limits the retured data to Engoish only.
	 --Today, John found a number of TITLES in view_EDW_HealthAssesmentDeffinition that were Spanish.
	 --The problem seems to come from sevel levels of nesting causing intersection data to seep through 
	 --the EN-US filter if placed at the highest level of a set of nested views.
	 --I took the filter and applied it to all the joined views within View_EDW_HealthAssesmentQuestions 
	 --		and the issue seems to have resolved itself.
	 --10.17.2014 (wdm) Added a filter "DocumentCulture" - the issue appears to be 
	 --			caused in view view_EDW_HealthAssesmentDeffinition becuase
	 --			the FILTER at that level on EN-US allows a portion of the intersection 
	 --			data to be missed for whatever reason. Adding the filter at this level
	 --			of the nesting seems to omit the non-english titles found by John Croft.
	 --**********************************************************************************

	 SELECT
			VHFHAMCQJ.ClassName AS QuestionType
		  , VHFHAMCQJ.Title
		  , VHFHAMCQJ.Weight
		  , VHFHAMCQJ.IsRequired
		  , VHFHAMCQJ.QuestionImageLeft
		  , VHFHAMCQJ.QuestionImageRight
		  , VHFHAMCQJ.NodeGUID
		  , VHFHAMCQJ.DocumentCulture
		  , VHFHAMCQJ.IsEnabled
		  , VHFHAMCQJ.IsVisible
		  , VHFHAMCQJ.IsStaging
		  , VHFHAMCQJ.CodeName
		  , VHFHAMCQJ.QuestionGroupCodeName
		  , VHFHAMCQJ.NodeAliasPath
		  , VHFHAMCQJ.DocumentPublishedVersionHistoryID
		  , VHFHAMCQJ.NodeLevel
		  , VHFHAMCQJ.NodeOrder
		  , VHFHAMCQJ.NodeID
		  , VHFHAMCQJ.NodeParentID
		  , VHFHAMCQJ.NodeLinkedNodeID
		  , 0 AS DontKnowEnabled
		  , '' AS DontKnowLabel
		  , (
			 SELECT
					pp.NodeOrder
			   FROM dbo.CMS_Tree AS pp
						INNER JOIN dbo.CMS_Tree AS p
							ON p.NodeParentID = pp.NodeID
			   WHERE p.NodeID = VHFHAMCQJ.NodeParentID) AS ParentNodeOrder
		  , VHFHAMCQJ.DocumentGuid
		  , VHFHAMCQJ.DocumentModifiedWhen

	 --(WDM) 09.11.2014 added to facilitate determining document last mod date 

	   FROM dbo.View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS VHFHAMCQJ WITH (NOLOCK) 
	   WHERE VHFHAMCQJ.DocumentCulture = 'en-US'

	 --(WDM) 10.19.2014 added to filter at this level of nesting

	 UNION ALL
	 SELECT
			VHFHAMQJ.ClassName AS QuestionType
		  , VHFHAMQJ.Title
		  , VHFHAMQJ.Weight
		  , VHFHAMQJ.IsRequired
		  , VHFHAMQJ.QuestionImageLeft
		  , VHFHAMQJ.QuestionImageRight
		  , VHFHAMQJ.NodeGUID
		  , VHFHAMQJ.DocumentCulture
		  , VHFHAMQJ.IsEnabled
		  , VHFHAMQJ.IsVisible
		  , VHFHAMQJ.IsStaging
		  , VHFHAMQJ.CodeName
		  , VHFHAMQJ.QuestionGroupCodeName
		  , VHFHAMQJ.NodeAliasPath
		  , VHFHAMQJ.DocumentPublishedVersionHistoryID
		  , VHFHAMQJ.NodeLevel
		  , VHFHAMQJ.NodeOrder
		  , VHFHAMQJ.NodeID
		  , VHFHAMQJ.NodeParentID
		  , VHFHAMQJ.NodeLinkedNodeID
		  , 0 AS DontKnowEnabled
		  , '' AS DontKnowLabel
		  , (
			 SELECT
					pp.NodeOrder
			   FROM dbo.CMS_Tree AS pp
						INNER JOIN dbo.CMS_Tree AS p
							ON p.NodeParentID = pp.NodeID
			   WHERE p.NodeID = VHFHAMQJ.NodeParentID) AS ParentNodeOrder
		  , VHFHAMQJ.DocumentGuid
		  , VHFHAMQJ.DocumentModifiedWhen

	 --(WDM) 09.11.2014 added to facilitate determining document last mod date 

	   FROM dbo.View_HFit_HealthAssesmentMatrixQuestion_Joined AS VHFHAMQJ WITH (NOLOCK) 
	   WHERE VHFHAMQJ.DocumentCulture = 'en-US'

	 --(WDM) 10.19.2014 added to filter at this level of nesting

	 UNION ALL
	 SELECT
			VHFHAFFJ.ClassName AS QuestionType
		  , VHFHAFFJ.Title
		  , VHFHAFFJ.Weight
		  , VHFHAFFJ.IsRequired
		  , VHFHAFFJ.QuestionImageLeft
		  , '' AS QuestionImageRight
		  , VHFHAFFJ.NodeGUID
		  , VHFHAFFJ.DocumentCulture
		  , VHFHAFFJ.IsEnabled
		  , VHFHAFFJ.IsVisible
		  , VHFHAFFJ.IsStaging
		  , VHFHAFFJ.CodeName
		  , VHFHAFFJ.QuestionGroupCodeName
		  , VHFHAFFJ.NodeAliasPath
		  , VHFHAFFJ.DocumentPublishedVersionHistoryID
		  , VHFHAFFJ.NodeLevel
		  , VHFHAFFJ.NodeOrder
		  , VHFHAFFJ.NodeID
		  , VHFHAFFJ.NodeParentID
		  , VHFHAFFJ.NodeLinkedNodeID
		  , VHFHAFFJ.DontKnowEnabled
		  , VHFHAFFJ.DontKnowLabel
		  , (
			 SELECT
					pp.NodeOrder
			   FROM dbo.CMS_Tree AS pp
						INNER JOIN dbo.CMS_Tree AS p
							ON p.NodeParentID = pp.NodeID
			   WHERE p.NodeID = VHFHAFFJ.NodeParentID) AS ParentNodeOrder
		  , VHFHAFFJ.DocumentGuid
		  , VHFHAFFJ.DocumentModifiedWhen

	 --(WDM) 09.11.2014 added to facilitate determining document last mod date 

	   FROM dbo.View_HFit_HealthAssessmentFreeForm_Joined AS VHFHAFFJ WITH (NOLOCK) 
	   WHERE VHFHAFFJ.DocumentCulture = 'en-US';

--(WDM) 10.19.2014 added to filter at this level of nesting

GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Alter View [dbo].[view_EDW_CoachingDefinition]

PRINT 'Alter View [dbo].[view_EDW_CoachingDefinition]';
GO

--GRANT SELECT
--	ON [dbo].[view_EDW_CoachingDefinition]
--	TO [EDWReader_PRD]
--GO

ALTER VIEW dbo.view_EDW_CoachingDefinition
AS

	 --********************************************************************************************************
	 --8/7/2014 - added DocumentGuid 
	 --8/8/2014 - Generated corrected view in DEV (WDM)
	 -- Verified last mod date available to EDW 9.10.2014
	 --11.17.2014 - (wdm) John Croft found an issue with multiple languages being returned.
	 --		View_EDW_CoachingDefinition pulls its data from a nested view View_HFit_Tobacco_Goal_Joined. I added 
	 --		a Document Culture filter on the SELECT STATEMENT pulling the data from View_HFit_Tobacco_Goal_Joined.
	 --		In LAB DB, when the view is executed W/O the filter, I get 90 rows. When executed with the filter, I 
	 --		get 89 rows. This would indicate the filter can be applied at the SELCT statement level. The view has 
	 --		the change applied and is ready to be regenerated. Also, I needed to add a language filter to 
	 --		View_HFit_Goal_Joined. Additionally, I allow the view to return the Document Culture as a column so 
	 --		that we can see the associated language. This can be removed if not wanted, but for troubleshooting 
	 --		it is useful.
	 --********************************************************************************************************

	 SELECT
			GJ.GoalID
		  , GJ.DocumentGuid

			--, GJ.DocumentID

		  , GJ.NodeSiteID
		  , cs.SiteGUID
		  , GJ.GoalImage
		  , GJ.Goal
		  , dbo.udf_StripHTML (GJ.GoalText) AS GoalText

			--

		  , dbo.udf_StripHTML (GJ.GoalSummary) AS GoalSummary

			--

		  , GJ.TrackerAssociation

			--GJ.TrackerAssociation

		  , GJ.GoalFrequency
		  , HFLF.FrequencySingular
		  , HFLF.FrequencyPlural
		  , GJ.GoalUnitOfMeasure
		  , HFLUOM.UnitOfMeasure
		  , GJ.GoalDirection
		  , GJ.GoalPrecision
		  , GJ.GoalAbsoluteMin
		  , GJ.GoalAbsoluteMax
		  , dbo.udf_StripHTML (GJ.SetGoalText) AS SetGoalText

			--

		  , dbo.udf_StripHTML (GJ.HelpText) AS HelpText

			--

		  , GJ.EvaluationType
		  , GJ.CatalogDisplay
		  , GJ.AllowModification
		  , GJ.ActivityText
		  , dbo.udf_StripHTML (GJ.SetGoalModifyText) AS SetgoalModifyText
		  , GJ.IsLifestyleGoal
		  , GJ.CodeName
		  , CASE
				WHEN CAST (gj.DocumentCreatedWhen AS date) = CAST (gj.DocumentModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , GJ.DocumentCreatedWhen
		  , GJ.DocumentModifiedWhen
		  , GJ.DocumentCulture
	   FROM (
			 SELECT
					VHFGJ.GoalID
				  , VHFGJ.DocumentGuid

					--, VHFGJ.DocumentID

				  , VHFGJ.NodeSiteID
				  , VHFGJ.GoalImage
				  , VHFGJ.Goal
				  , VHFGJ.GoalText
				  , VHFGJ.GoalSummary
				  , VHFGJ.TrackerNodeGUID AS TrackerAssociation

					--VHFGJ.TrackerAssociation

				  , VHFGJ.GoalFrequency
				  , VHFGJ.GoalUnitOfMeasure
				  , VHFGJ.GoalDirection
				  , VHFGJ.GoalPrecision
				  , VHFGJ.GoalAbsoluteMin
				  , VHFGJ.GoalAbsoluteMax
				  , VHFGJ.SetGoalText
				  , VHFGJ.HelpText
				  , VHFGJ.EvaluationType
				  , VHFGJ.CatalogDisplay
				  , VHFGJ.AllowModification
				  , VHFGJ.ActivityText
				  , VHFGJ.SetGoalModifyText
				  , VHFGJ.IsLifestyleGoal
				  , VHFGJ.CodeName
				  , VHFGJ.DocumentCreatedWhen
				  , VHFGJ.DocumentModifiedWhen
				  , VHFGJ.DocumentCulture
			   FROM dbo.View_HFit_Goal_Joined AS VHFGJ
			   WHERE VHFGJ.DocumentCulture = 'en-US'
			 UNION ALL
			 SELECT
					VHFTGJ.GoalID
				  , VHFTGJ.DocumentGuid

					--, VHFTGJ.DocumentID

				  , VHFTGJ.NodeSiteID
				  , VHFTGJ.GoalImage
				  , VHFTGJ.Goal
				  , NULL AS GoalText
				  , VHFTGJ.GoalSummary
				  , VHFTGJ.TrackerNodeGUID AS TrackerAssociation

					--VHFTGJ.TrackerAssociation

				  , VHFTGJ.GoalFrequency
				  , NULL AS GoalUnitOfMeasure
				  , VHFTGJ.GoalDirection
				  , VHFTGJ.GoalPrecision
				  , VHFTGJ.GoalAbsoluteMin
				  , VHFTGJ.GoalAbsoluteMax
				  , NULL AS SetGoalText
				  , NULL AS HelpText
				  , VHFTGJ.EvaluationType
				  , VHFTGJ.CatalogDisplay
				  , VHFTGJ.AllowModification
				  , VHFTGJ.ActivityText
				  , NULL AS SetGoalModifyText
				  , VHFTGJ.IsLifestyleGoal
				  , VHFTGJ.CodeName
				  , VHFTGJ.DocumentCreatedWhen
				  , VHFTGJ.DocumentModifiedWhen
				  , VHFTGJ.DocumentCulture
			   FROM dbo.View_HFit_Tobacco_Goal_Joined AS VHFTGJ
			   WHERE VHFTGJ.DocumentCulture = 'en-US') AS GJ
				LEFT OUTER JOIN dbo.HFit_LKP_UnitOfMeasure AS HFLUOM
					ON GJ.GoalUnitOfMeasure = HFLUOM.UnitOfMeasureID
				LEFT OUTER JOIN dbo.HFit_LKP_Frequency AS HFLF
					ON GJ.GoalFrequency = HFLF.FrequencyID
				INNER JOIN cms_site AS CS
					ON gj.nodesiteid = cs.siteid

	   --INNER JOIN cms_site AS CS ON gj.siteguid = cs.siteguid

	   WHERE gj.DocumentCreatedWhen IS NOT NULL
		 AND gj.DocumentModifiedWhen IS NOT NULL;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create View [dbo].[view_EDW_SmallStepResponses]

PRINT 'Create View [dbo].[view_EDW_SmallStepResponses]';
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
CREATE VIEW dbo.view_EDW_SmallStepResponses
AS

	 --********************************************************************************************************
	 --02.13.2014 : (Sowmiya Venkiteswaran) : Updated the view to include  the fields:
	 --AccountCD, SiteGUID,SSOutcomeMessage as info. text,
	 -- Small Steps Program Info( HACampaignNodeGUID,HACampaignName,HACampaignStartDate,HACampaignEndDate)
	 -- HAUserStartedRecord Info (HAStartedDate,HACompletedDate,HAStartedMode,HACompletedMode)
	 -- Added filters by document culture and replacing HTML quote with a SQL single quote
	 --********************************************************************************************************
	 --02.23.2014 : (Dale Miller & Sowmiya V) : Performance tuning - removed the following WHERE clause and 
	 --			incorporated them into the JOIN statements for perfoamnce enhancement.
	 -- WHERE vwOutcome.DocumentCulture = 'en-US' AND vwCamp.DocumentCulture = 'en-US';
	 --********************************************************************************************************
	 --02.23.2014 : (Dale Miller & Sowmiya V) : Performance tuning
	 --	Prod1, 2 and 3 Labs - Incorporated doc. culture to the Joins
	 -- 1 - executed DBCC dropcleanbuffers everytime
	 -- 2 - Tested REPLACE against No REPLACE, insignificant perf. hit.
	 -- Test Controls:
	 -- Prod1 Lab - NO SQL DISTINCT - 184311 ( rows) - 14 (seconds) 
	 -- Prod1 Lab - WITH SQL DISTINCT - 184311 ( rows) - 32 (seconds) 
	 -- Prod2 Lab - NO SQL DISTINCT -  81120( rows) -  10(seconds) 
	 -- Prod2 Lab - WITH SQL DISTINCT - 81120 ( rows) -  22(seconds) 
	 -- Prod3 Lab - NO SQL DISTINCT - 136763 ( rows) - 10 (seconds) 
	 -- Prod3 Lab - WITH SQL DISTINCT - 136763 ( rows) -  21(seconds)  
	 --02.24.2015 (SV) - Added column SSHealthAssesmentUserStartedItemID per request from John C.
	 --02.24.2015 (WDM) - Verified changes applied correctly from within the IVP
	 --02.24.2015 (WDM) - Verified changes are tracked from within the Schema Change Monitor
	 --02.24.2015 (WDM) - Add the view to the Data/View IVP
	 --********************************************************************************************************

	 SELECT
			ss.UserID
		  , acct.AccountCD
		  , ste.SiteGUID
		  , ss.ItemID AS SSItemID
		  , ss.ItemCreatedBy AS SSItemCreatedBy
		  , ss.ItemCreatedWhen AS SSItemCreatedWhen
		  , ss.ItemModifiedBy AS SSItemModifiedBy
		  , ss.ItemModifiedWhen AS SSItemModifiedWhen
		  , ss.ItemOrder AS SSItemOrder
		  , ss.ItemGUID AS SSItemGUID
		  , ss.HealthAssesmentUserStartedItemID AS SSHealthAssesmentUserStartedItemID
		  , ss.OutComeMessageGUID AS SSOutcomeMessageGuid
		  , REPLACE (vwOutcome.Message, '&#39;', '''') AS SSOutcomeMessage
		  , usrstd.HACampaignNodeGUID
		  , vwCamp.Name AS HACampaignName
		  , vwCamp.CampaignStartDate AS HACampaignStartDate
		  , vwCamp.CampaignEndDate AS HACampaignEndDate
		  , usrstd.HAStartedDt AS HAStartedDate
		  , usrstd.HACompletedDt AS HACompletedDate
		  , usrstd.HAStartedMode
		  , usrstd.HACompletedMode
	   FROM dbo.Hfit_SmallStepResponses AS ss
				JOIN HFit_HealthAssesmentUserStarted AS usrstd
					ON usrstd.UserID = ss.UserID
				   AND usrstd.ItemID = ss.HealthAssesmentUserStartedItemID
				JOIN View_HFit_HACampaign_Joined AS vwCamp
					ON vwCamp.NodeGuid = usrstd.HACampaignNodeGUID
				   AND vwCamp.DocumentCulture = 'en-US'
				JOIN View_HFit_OutComeMessages_Joined AS vwOutcome
					ON vwOutcome.NodeGUID = ss.OutComeMessageGUID
				   AND vwOutcome.DocumentCulture = 'en-US'
				JOIN CMS_UserSite AS usrste
					ON usrste.UserID = ss.UserID
				JOIN CMS_Site AS ste
					ON ste.SiteID = usrste.SiteID
				JOIN HFit_Account AS acct
					ON acct.SiteID = usrste.SiteID;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Alter View [dbo].[view_EDW_RewardTriggerParameters]

PRINT 'Alter View [dbo].[view_EDW_RewardTriggerParameters]';
GO

--GRANT SELECT
--	ON [dbo].[view_EDW_RewardTriggerParameters]
--	TO [EDWReader_PRD]
--GO
--********************************************************************************************************
--09.11.2014 : (wdm) Verified last mod date available to EDW - RewardTriggerParameter_DocumentModifiedWhen
--11.17.2014 : (wdm) John C. found that Spanish was being brought across in TriggerName and 
--				ParameterDisplayName. Found that View_HFit_RewardTrigger_Joined has no way to limit the 
--				returned data to Spanish. Created a new view, View_EDW_RewardProgram_Joined, and provided 
--				a FILTER on Document Culture. The, added Launguage fitlers as: 
--					where VHFRTJ.DocumentCulture = 'en-US' AND VHFRTPJ.DocumentCulture = 'en-US'
--				This appears to have eliminated the Spanish.
--********************************************************************************************************

ALTER VIEW dbo.view_EDW_RewardTriggerParameters
AS

	 --8/7/2014 - added and commented out DocumentGuid and NodeGuid in case needed later
	 --8/8/2014 - Generated corrected view in DEV (WDM)

	 SELECT DISTINCT
			cs.SiteGUID
		  , VHFRTJ.RewardTriggerID
		  , VHFRTJ.TriggerName
		  , HFLRTPO.RewardTriggerParameterOperatorLKPDisplayName
		  , VHFRTPJ.ParameterDisplayName
		  , VHFRTPJ.RewardTriggerParameterOperator
		  , VHFRTPJ.Value
		  , hfa.AccountID
		  , hfa.AccountCD
		  , CASE
				WHEN CAST (VHFRTJ.DocumentCreatedWhen AS date) = CAST (VHFRTJ.DocumentModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , VHFRTJ.DocumentGuid

			--WDM Added 8/7/2014 in case needed

		  , VHFRTJ.NodeGuid

			--WDM Added 8/7/2014 in case needed

		  , VHFRTJ.DocumentCreatedWhen
		  , VHFRTJ.DocumentModifiedWhen
		  , VHFRTPJ.DocumentModifiedWhen AS RewardTriggerParameter_DocumentModifiedWhen
		  , VHFRTPJ.documentculture AS documentculture_VHFRTPJ
		  , VHFRTJ.documentculture AS documentculture_VHFRTJ
	   FROM dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ

	 --dbo.[View_EDW_RewardProgram_Joined] AS VHFRTJ 		

				INNER JOIN dbo.View_HFit_RewardTriggerParameter_Joined AS VHFRTPJ
					ON vhfrtj.NodeID = VHFRTPJ.NodeParentID
				INNER JOIN dbo.HFit_LKP_RewardTriggerParameterOperator AS HFLRTPO
					ON VHFRTPJ.RewardTriggerParameterOperator = HFLRTPO.RewardTriggerParameterOperatorLKPID
				INNER JOIN dbo.CMS_Site AS CS
					ON VHFRTJ.NodeSiteID = cs.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
	   WHERE VHFRTJ.DocumentCulture = 'en-US'
		 AND VHFRTPJ.DocumentCulture = 'en-US';
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Alter View [dbo].[view_EDW_RewardAwardDetail]

PRINT 'Alter View [dbo].[view_EDW_RewardAwardDetail]';
GO
ALTER VIEW dbo.view_EDW_RewardAwardDetail
AS

	 --*************************************************************************************************
	 --WDM Reviewed 8/6/2014 for needed updates, none required
	 --09.11.2014 : (wdm) reviewed for EDW last mod date and the view is OK as is
	 --11.19.2014 : added language to verify returned data
	 --02.03.2015 : LevelName, LevelHeader, GroupHeadingText, GroupHeadingDescription
	 --*************************************************************************************************

	 SELECT DISTINCT
			cu.UserGUID
		  , cs.SiteGUID
		  , cus.HFitUserMpiNumber
		  , RL_Joined.RewardLevelID
		  , HFRAUD.AwardDisplayName
		  , HFRAUD.RewardValue
		  , HFRAUD.ThresholdNumber
		  , HFRAUD.UserNotified
		  , HFRAUD.IsFulfilled
		  , hfa.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN CAST (HFRAUD.ItemCreatedWhen AS date) = CAST (HFRAUD.ItemModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFRAUD.ItemCreatedWhen
		  , HFRAUD.ItemModifiedWhen
		  , RL_Joined.DocumentCulture
		  , HFRAUD.CultureCode
		  , RL_Joined.LevelName
		  , RL_Joined.LevelHeader
		  , RL_Joined.GroupHeadingText
		  , RL_Joined.GroupHeadingDescription
	   FROM dbo.HFit_RewardsAwardUserDetail AS HFRAUD
				INNER JOIN dbo.View_HFit_RewardLevel_Joined AS RL_Joined
					ON hfraud.RewardLevelNodeId = RL_Joined.NodeID
				   AND RL_Joined.DocumentCulture = 'en-US'
				   AND HFRAUD.CultureCode = 'en-US'
				INNER JOIN dbo.CMS_User AS CU
					ON hfraud.UserId = cu.UserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cu.UserID = cus2.UserID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cus2.SiteID = HFA.SiteID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON cu.UserID = cus.UserSettingsUserID;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Alter View [dbo].[view_EDW_RewardUserDetail]

PRINT 'Alter View [dbo].[view_EDW_RewardUserDetail]';
GO
ALTER VIEW dbo.view_EDW_RewardUserDetail
AS
	 SELECT DISTINCT

	 --02.03.2015 : LevelName, LevelHeader, GroupHeadingText, GroupHeadingDescription

			cu.UserGUID
   , CS2.SiteGUID
   , cus2.HFitUserMpiNumber
   , VHFRAJ.RewardActivityID
   , VHFRPJ.RewardProgramName
   , VHFRPJ.RewardProgramID
   , VHFRPJ.RewardProgramPeriodStart
   , VHFRPJ.RewardProgramPeriodEnd
   , VHFRPJ.DocumentModifiedWhen AS RewardModifiedDate
   , VHFRGJ.GroupName
   , VHFRGJ.RewardGroupID
   , VHFRGJ.RewardGroupPeriodStart
   , VHFRGJ.RewardGroupPeriodEnd
   , VHFRGJ.DocumentModifiedWhen AS RewardGroupModifieDate
   , RL_Joined.Level
   , HFLRLT.RewardLevelTypeLKPName
   , RL_Joined.DocumentModifiedWhen AS RewardLevelModifiedDate
   , HFRULD.LevelCompletedDt
   , HFRULD.LevelVersionHistoryID
   , RL_Joined.RewardLevelPeriodStart
   , RL_Joined.RewardLevelPeriodEnd
   , VHFRAJ.ActivityName
   , HFRUAD.ActivityPointsEarned
   , HFRUAD.ActivityCompletedDt
   , HFRUAD.ActivityVersionID
   , HFRUAD.ItemModifiedWhen AS RewardActivityModifiedDate
   , VHFRAJ.RewardActivityPeriodStart
   , VHFRAJ.RewardActivityPeriodEnd
   , VHFRAJ.ActivityPoints
   , HFRE.UserAccepted
   , HFRE.UserExceptionAppliedTo
   , HFRE.ItemModifiedWhen AS RewardExceptionModifiedDate
   , VHFRTJ.TriggerName
   , VHFRTJ.RewardTriggerID
   , HFLRT2.RewardTriggerLKPDisplayName
   , HFLRT2.RewardTriggerDynamicValue
   , HFLRT2.ItemModifiedWhen AS RewardTriggerModifiedDate
   , HFLRT.RewardTypeLKPName
   , HFA.AccountID
   , HFA.AccountCD
   , CASE
		 WHEN CAST (HFRULD.ItemCreatedWhen AS date) = CAST (HFRULD.ItemModifiedWhen AS date) 
		 THEN 'I'
		 ELSE 'U'
	 END AS ChangeType
   , HFRULD.ItemCreatedWhen
   , HFRULD.ItemModifiedWhen
   , RL_Joined.LevelName
   , RL_Joined.LevelHeader
   , RL_Joined.GroupHeadingText
   , RL_Joined.GroupHeadingDescription
	   FROM dbo.View_HFit_RewardProgram_Joined AS VHFRPJ
				LEFT OUTER JOIN dbo.View_HFit_RewardGroup_Joined AS VHFRGJ
					ON VHFRPJ.NodeID = VHFRGJ.NodeParentID
				LEFT OUTER JOIN dbo.View_HFit_RewardLevel_Joined AS RL_Joined
					ON VHFRGJ.NodeID = RL_Joined.NodeParentID
				LEFT OUTER JOIN dbo.HFit_LKP_RewardType AS HFLRT
					ON RL_Joined.AwardType = HFLRT.RewardTypeLKPID
				LEFT OUTER JOIN dbo.HFit_LKP_RewardLevelType AS HFLRLT
					ON RL_Joined.LevelType = HFLRLT.RewardLevelTypeLKPID
				INNER JOIN dbo.HFit_RewardsUserLevelDetail AS HFRULD
					ON RL_Joined.NodeID = HFRULD.LevelNodeID
				INNER JOIN dbo.CMS_User AS CU
					ON hfruld.UserID = cu.UserID
				INNER JOIN dbo.CMS_UserSite AS CUS
					ON CU.UserID = CUS.UserID
				INNER JOIN dbo.CMS_Site AS CS2
					ON CUS.SiteID = CS2.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs2.SiteID = HFA.SiteID
				INNER JOIN dbo.CMS_UserSettings AS CUS2
					ON cu.UserID = cus2.UserSettingsUserID
				LEFT OUTER JOIN dbo.View_HFit_RewardActivity_Joined AS VHFRAJ
					ON RL_Joined.NodeID = VHFRAJ.NodeParentID
				INNER JOIN dbo.HFit_RewardsUserActivityDetail AS HFRUAD
					ON VHFRAJ.NodeID = HFRUAD.ActivityNodeID
				LEFT OUTER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ
					ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
				LEFT OUTER JOIN dbo.HFit_LKP_RewardTrigger AS HFLRT2
					ON VHFRTJ.RewardTriggerLKPID = HFLRT2.RewardTriggerLKPID
				LEFT OUTER JOIN dbo.HFit_RewardException AS HFRE
					ON HFRE.RewardActivityID = VHFRAJ.RewardActivityID
				   AND HFRE.UserID = cu.UserID;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Alter View [dbo].[view_EDW_RewardsDefinition]

PRINT 'Alter View [dbo].[view_EDW_RewardsDefinition]';
GO
ALTER VIEW dbo.view_EDW_RewardsDefinition
AS

	 --02.03.2015 : LevelName, LevelHeader, GroupHeadingText, GroupHeadingDescription

	 SELECT DISTINCT
			cs.SiteGUID
		  , HFA.AccountID
		  , hfa.AccountCD
		  , RewardProgramID
		  , RewardProgramName
		  , RewardProgramPeriodStart
		  , RewardProgramPeriodEnd
		  , ProgramDescription
		  , RewardGroupID
		  , GroupName
		  , RewardContactGroups
		  , RewardGroupPeriodStart
		  , RewardGroupPeriodEnd
		  , RewardLevelID
		  , Level
		  , RewardLevelTypeLKPName
		  , RewardLevelPeriodStart
		  , RewardLevelPeriodEnd
		  , FrequencyMenu
		  , AwardDisplayName
		  , AwardType
		  , AwardThreshold1
		  , AwardThreshold2
		  , AwardThreshold3
		  , AwardThreshold4
		  , AwardValue1
		  , AwardValue2
		  , AwardValue3
		  , AwardValue4
		  , CompletionText
		  , ExternalFulfillmentRequired
		  , RewardHistoryDetailDescription
		  , VHFRAJ.RewardActivityID
		  , VHFRAJ.ActivityName
		  , VHFRAJ.ActivityFreqOrCrit
		  , VHFRAJ.RewardActivityPeriodStart
		  , VHFRAJ.RewardActivityPeriodEnd
		  , VHFRAJ.RewardActivityLKPID
		  , VHFRAJ.ActivityPoints
		  , VHFRAJ.IsBundle
		  , VHFRAJ.IsRequired
		  , VHFRAJ.MaxThreshold
		  , VHFRAJ.AwardPointsIncrementally
		  , VHFRAJ.AllowMedicalExceptions
		  , VHFRAJ.BundleText
		  , RewardTriggerID
		  , HFLRT.RewardTriggerDynamicValue
		  , TriggerName
		  , RequirementDescription
		  , VHFRTPJ.RewardTriggerParameterOperator
		  , VHFRTPJ.Value
		  , vhfrtpj.ParameterDisplayName
		  , CASE
				WHEN CAST (VHFRPJ.DocumentCreatedWhen AS date) = CAST (VHFRPJ.DocumentModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , VHFRPJ.DocumentCreatedWhen
		  , VHFRPJ.DocumentModifiedWhen
		  , RL_Joined.LevelName
		  , RL_Joined.LevelHeader
		  , RL_Joined.GroupHeadingText
		  , RL_Joined.GroupHeadingDescription
	   FROM dbo.View_HFit_RewardProgram_Joined AS VHFRPJ
				INNER JOIN dbo.View_HFit_RewardGroup_Joined AS VHFRGJ
					ON VHFRPJ.NodeID = VHFRGJ.NodeParentID
				INNER JOIN dbo.View_HFit_RewardLevel_Joined AS RL_Joined
					ON VHFRGJ.NodeID = RL_Joined.NodeParentID
				INNER JOIN dbo.HFit_LKP_RewardLevelType AS HFLRLT
					ON RL_Joined.LevelType = HFLRLT.RewardLevelTypeLKPID
				INNER JOIN dbo.View_HFit_RewardActivity_Joined AS VHFRAJ
					ON RL_Joined.NodeID = VHFRAJ.NodeParentID
				INNER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ
					ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
				INNER JOIN dbo.View_HFit_RewardTriggerParameter_Joined AS VHFRTPJ
					ON vhfrtj.nodeid = vhfrtpj.nodeparentid
				INNER JOIN dbo.HFit_LKP_RewardTrigger AS HFLRT
					ON VHFRTJ.RewardTriggerLKPID = HFLRT.RewardTriggerLKPID
				INNER JOIN dbo.CMS_Site AS CS
					ON VHFRPJ.NodeSiteID = cs.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create View [dbo].[view_EDW_RewardUserLevel]

PRINT 'Create View [dbo].[view_EDW_RewardUserLevel]';
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
CREATE VIEW view_EDW_RewardUserLevel
AS

	 --***************************************************************************************************
	 --Changes:
	 --01.20.2015 - (WDM) Added RL_Joined.nodeguid to satisfy #38393
	 --02.03.2015 : LevelName, LevelHeader, GroupHeadingText, GroupHeadingDescription, SiteGuid
	 --***************************************************************************************************

	 SELECT DISTINCT
			us.UserId
		  , dl.LevelCompletedDt
		  , RL_Joined.NodeName AS LevelName
		  , s.SiteName
		  , RL_Joined.nodeguid
		  , s.SiteGuid
		  , RL_Joined.LevelHeader
		  , RL_Joined.GroupHeadingText
		  , RL_Joined.GroupHeadingDescription
	   FROM HFit_RewardsUserLevelDetail AS dl
				INNER JOIN View_HFit_RewardLevel_Joined AS RL_Joined
					ON RL_Joined.NodeId = dl.LevelNodeId
				JOIN CMS_UserSite AS us
					ON us.UserId = dl.UserId
				JOIN CMS_Site AS s
					ON s.SiteId = us.SiteId;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[Proc_EDW_RewardUserDetail]

PRINT 'Create Procedure [dbo].[Proc_EDW_RewardUserDetail]';
GO
CREATE PROC dbo.Proc_EDW_RewardUserDetail (@StartDate AS datetime
										 , @EndDate AS datetime
										 , @TrackPerf AS nvarchar (1)) 
AS
	 BEGIN

		 --********************************************************************************************************************
		 --select * from [view_EDW_RewardUserDetail] where ItemModifiedWhen between '2000-11-14' and '2014-11-15'
		 --select * from [view_EDW_RewardUserDetail] where ItemModifiedWhen between '2014-05-12' and '2014-05-13' 
		 --8/7/2014 - added and commented out DocumentGuid and NodeGuid in case needed later
		 --8/08/2014 - Generated corrected view in DEV (WDM)
		 --8/12/2014 - Performance Issue - 00:06:49 @ 258502
		 --8/12/2014 - Performance Issue - Add PI01_view_EDW_RewardUserDetail
		 --8/12/2014 - Performance Issue - 00:03:46 @ 258502
		 --8/12/2014 - Performance Issue - Add PI02_view_EDW_RewardUserDetail
		 --8/12/2014 - Performance Issue - 00:03:45 @ 258502
		 --********************************************************************************************************************
		 --********************************************************************************************************************
		 --EXECUTION:
		 --	@StartDate: The date from which to begin selection of data
		 --	@EndDate  : The date from which to stop selection of data
		 --	@TrackPerf: Anything other than a NULL char to track performance.
		 --	exec Proc_EDW_RewardUserDetail NULL, NULL, 'Y'
		 --	exec Proc_EDW_RewardUserDetail '2010-11-14', '2014-11-15', 'Y'
		 --	exec Proc_EDW_RewardUserDetail '2010-06-10', '2014-06-11', NULL
		 --********************************************************************************************************************

		 DECLARE @P0Start AS datetime;
		 DECLARE @P0End AS datetime;
		 SET @P0Start = GETDATE () ;
		 IF @StartDate IS NULL
			 BEGIN
				 SET @StartDate = DATEADD (Day, 0, DATEDIFF (Day, 0, GETDATE ())) ;

				 --Midnight yesterday;	

				 SET @StartDate = @StartDate - 1;
			 END;
		 IF @EndDate IS NULL
			 BEGIN
				 SET @EndDate = CAST (GETDATE () AS date) ;
			 END;

		 --*************************************************************************

		 IF EXISTS (SELECT
						   name
					  FROM sys.tables
					  WHERE name = 'EDW_RewardUserDetail') 
			 BEGIN
				 DROP TABLE
					  EDW_RewardUserDetail;
			 END;
		 IF NOT EXISTS (SELECT
							   name
						  FROM SYS.INDEXES
						  WHERE NAME = 'pi_CMS_UserSettings_IDMPI') 
			 BEGIN
				 CREATE NONCLUSTERED INDEX pi_CMS_UserSettings_IDMPI ON CMS_UserSettings (UserSettingsID ASC, HFitUserMpiNumber) ;
			 END;
		 IF NOT EXISTS (SELECT
							   name
						  FROM SYS.INDEXES
						  WHERE NAME = 'pi_CMS_UserSettings_IDMPI') 
			 BEGIN
				 CREATE NONCLUSTERED INDEX pi_CMS_UserSettings_IDMPI ON CMS_UserSettings (UserSettingsID ASC, HFitUserMpiNumber) ;
			 END;

		 --GO	

		 IF NOT EXISTS (SELECT
							   name
						  FROM SYS.INDEXES
						  WHERE NAME = 'PI_CMS_UserSite_SiteID') 
			 BEGIN
				 CREATE NONCLUSTERED INDEX PI_CMS_UserSite_SiteID ON dbo.CMS_UserSite (SiteID) INCLUDE (
						UserID) ;
			 END;
		 IF EXISTS (SELECT
						   name
					  FROM tempdb.dbo.sysobjects
					  WHERE ID = OBJECT_ID (N'tempdb..#Temp_View_HFit_RewardProgram_Joined')) 
			 BEGIN
				 DROP TABLE
					  #Temp_View_HFit_RewardProgram_Joined;
			 END;

		 --GO			

		 SELECT
				NodeID
			  , RewardProgramName
			  , RewardProgramID
			  , RewardProgramPeriodStart
			  , RewardProgramPeriodEnd
			  , DocumentModifiedWhen
			  , NodeGUID
			  , DocumentGUID INTO
								  #Temp_View_HFit_RewardProgram_Joined
		   FROM View_HFit_RewardProgram_Joined
		   WHERE View_HFit_RewardProgram_Joined.DocumentCulture = 'en-us';
		 CREATE CLUSTERED INDEX PI_Temp_View_HFit_RewardProgram_Joined ON #Temp_View_HFit_RewardProgram_Joined (NodeID) ;

		 --*************************************************************************

		 IF EXISTS (SELECT
						   name
					  FROM tempdb.dbo.sysobjects
					  WHERE ID = OBJECT_ID (N'tempdb..#TEMP_View_HFit_RewardGroup_Joined')) 
			 BEGIN
				 DROP TABLE
					  #TEMP_View_HFit_RewardGroup_Joined;
			 END;

		 --GO			

		 SELECT
				NodeID
			  , NodeParentID
			  , GroupName
			  , RewardGroupID
			  , RewardGroupPeriodStart
			  , RewardGroupPeriodEnd
			  , DocumentModifiedWhen INTO
										  #TEMP_View_HFit_RewardGroup_Joined
		   FROM View_HFit_RewardGroup_Joined
		   WHERE View_HFit_RewardGroup_Joined.DocumentCulture = 'en-us';
		 CREATE CLUSTERED INDEX PI_TEMP_View_HFit_RewardGroup_Joined ON #TEMP_View_HFit_RewardGroup_Joined (NodeID, NodeParentID, GroupName, RewardGroupID, RewardGroupPeriodStart, RewardGroupPeriodEnd, DocumentModifiedWhen) ;

		 --*************************************************************************
		 --*************************************************************************

		 IF EXISTS (SELECT
						   name
					  FROM tempdb.dbo.sysobjects
					  WHERE ID = OBJECT_ID (N'tempdb..#TEMP_View_HFit_RewardLevel_Joined')) 
			 BEGIN
				 DROP TABLE
					  #TEMP_View_HFit_RewardLevel_Joined;
			 END;

		 --GO			

		 SELECT
				NodeID
			  , NodeParentID
			  , AwardType
			  , LevelType
			  , Level
			  , DocumentModifiedWhen
			  , RewardLevelPeriodStart
			  , RewardLevelPeriodEnd INTO
										  #TEMP_View_HFit_RewardLevel_Joined
		   FROM View_HFit_RewardLevel_Joined
		   WHERE View_HFit_RewardLevel_Joined.DocumentCulture = 'en-us';
		 CREATE CLUSTERED INDEX PI_TEMP_View_HFit_RewardLevel_Joined ON #TEMP_View_HFit_RewardLevel_Joined (NodeID, NodeParentID, AwardType, LevelType, Level, DocumentModifiedWhen, RewardLevelPeriodStart, RewardLevelPeriodEnd) ;

		 --*************************************************************************
		 --*************************************************************************

		 IF EXISTS (SELECT
						   name
					  FROM tempdb.dbo.sysobjects
					  WHERE ID = OBJECT_ID (N'tempdb..#TEMP_View_HFit_RewardActivity_Joined')) 
			 BEGIN
				 DROP TABLE
					  #TEMP_View_HFit_RewardActivity_Joined;
			 END;

		 --GO			

		 SELECT
				NodeID
			  , NodeParentID
			  , RewardActivityID
			  , ActivityName
			  , RewardActivityPeriodStart
			  , RewardActivityPeriodEnd
			  , ActivityPoints INTO
									#TEMP_View_HFit_RewardActivity_Joined
		   FROM View_HFit_RewardActivity_Joined
		   WHERE View_HFit_RewardActivity_Joined.DocumentCulture = 'en-us';
		 CREATE CLUSTERED INDEX PI_TEMP_View_HFit_RewardActivity_Joined ON #TEMP_View_HFit_RewardActivity_Joined (NodeID, NodeParentID, RewardActivityID, ActivityName, RewardActivityPeriodStart, RewardActivityPeriodEnd, ActivityPoints) ;

		 --*************************************************************************
		 --*************************************************************************	

		 IF EXISTS (SELECT
						   name
					  FROM tempdb.dbo.sysobjects
					  WHERE ID = OBJECT_ID (N'tempdb..#TEMP_View_HFit_RewardTrigger_Joined')) 
			 BEGIN
				 DROP TABLE
					  #TEMP_View_HFit_RewardTrigger_Joined;
			 END;

		 --GO			

		 SELECT
				NodeParentID
			  , RewardTriggerLKPID
			  , TriggerName
			  , RewardTriggerID INTO
									 #TEMP_View_HFit_RewardTrigger_Joined
		   FROM View_HFit_RewardTrigger_Joined
		   WHERE View_HFit_RewardTrigger_Joined.DocumentCulture = 'en-us';
		 CREATE CLUSTERED INDEX PI_TEMP_View_HFit_RewardTrigger_Joined ON #TEMP_View_HFit_RewardTrigger_Joined (NodeParentID, RewardTriggerLKPID, TriggerName, RewardTriggerID) ;

		 --*************************************************************************
		 --*************************************************************************	

		 IF EXISTS (SELECT
						   name
					  FROM tempdb.dbo.sysobjects
					  WHERE ID = OBJECT_ID (N'tempdb..#TEMP_CMS_UserSettings')) 
			 BEGIN
				 DROP TABLE
					  #TEMP_CMS_UserSettings;
			 END;

		 --GO			

		 SELECT
				HFitUserMpiNumber
			  , UserSettingsUserID INTO
										#TEMP_CMS_UserSettings
		   FROM CMS_UserSettings;
		 CREATE CLUSTERED INDEX PI_TEMP_CMS_UserSettings ON #TEMP_CMS_UserSettings (HFitUserMpiNumber, UserSettingsUserID) ;
		 CREATE NONCLUSTERED INDEX PI_TEMP_CMS_UserSettings2 ON dbo.#TEMP_CMS_UserSettings (UserSettingsUserID) INCLUDE (
				HFitUserMpiNumber) ;

		 --*************************************************************************
		 --***********************************************************************************************
		 -- This is the data extraction QUERY
		 --***********************************************************************************************

		 SELECT
				cu.UserGUID
			  , CS2.SiteGUID
			  , cus2.HFitUserMpiNumber
			  , VHFRAJ.RewardActivityID
			  , VHFRPJ.RewardProgramName
			  , VHFRPJ.RewardProgramID
			  , VHFRPJ.RewardProgramPeriodStart
			  , VHFRPJ.RewardProgramPeriodEnd
			  , VHFRPJ.DocumentModifiedWhen AS RewardModifiedDate
			  , VHFRGJ.GroupName
			  , VHFRGJ.RewardGroupID
			  , VHFRGJ.RewardGroupPeriodStart
			  , VHFRGJ.RewardGroupPeriodEnd
			  , VHFRGJ.DocumentModifiedWhen AS RewardGroupModifieDate
			  , VHFRLJ.Level
			  , HFLRLT.RewardLevelTypeLKPName
			  , VHFRLJ.DocumentModifiedWhen AS RewardLevelModifiedDate
			  , HFRULD.LevelCompletedDt
			  , HFRULD.LevelVersionHistoryID
			  , VHFRLJ.RewardLevelPeriodStart
			  , VHFRLJ.RewardLevelPeriodEnd
			  , VHFRAJ.ActivityName
			  , HFRUAD.ActivityPointsEarned
			  , HFRUAD.ActivityCompletedDt
			  , HFRUAD.ActivityVersionID
			  , HFRUAD.ItemModifiedWhen AS RewardActivityModifiedDate
			  , VHFRAJ.RewardActivityPeriodStart
			  , VHFRAJ.RewardActivityPeriodEnd
			  , VHFRAJ.ActivityPoints
			  , HFRE.UserAccepted
			  , HFRE.UserExceptionAppliedTo

				--, HFRE.ItemModifiedWhen AS RewardExceptionModifiedDate

			  , VHFRTJ.TriggerName
			  , VHFRTJ.RewardTriggerID
			  , HFLRT2.RewardTriggerLKPDisplayName
			  , HFLRT2.RewardTriggerDynamicValue
			  , HFLRT2.ItemModifiedWhen AS RewardTriggerModifiedDate
			  , HFLRT.RewardTypeLKPName
			  , HFA.AccountID
			  , HFA.AccountCD
			  , CASE
					WHEN CAST (HFRULD.ItemCreatedWhen AS date) = CAST (HFRULD.ItemModifiedWhen AS date) 
					THEN 'I'
					ELSE 'U'
				END AS ChangeType
			  , HFRULD.ItemCreatedWhen
			  , HFRULD.ItemModifiedWhen
			  , HFRE.ItemModifiedWhen AS RewardExceptionModifiedDate
			  , HFRUAD.ItemModifiedWhen AS RewardsUserActivity_ItemModifiedWhen

				--09.11.2014 (wdm) added for EDW

			  , VHFRTJ.DocumentModifiedWhen AS RewardTrigger_DocumentModifiedWhen
			  , VHFRPJ.DocumentGuid

				--WDM added 8/7/2014 in case needed

			  , VHFRPJ.NodeGuid

		 --WDM added 8/7/2014 in case needed		

		 INTO
			  EDW_RewardUserDetail
		   FROM #Temp_View_HFit_RewardProgram_Joined AS VHFRPJ WITH (NOLOCK) 
					LEFT OUTER JOIN #TEMP_View_HFit_RewardGroup_Joined AS VHFRGJ WITH (NOLOCK) 
						ON VHFRPJ.NodeID = VHFRGJ.NodeParentID
					LEFT OUTER JOIN #TEMP_View_HFit_RewardLevel_Joined AS VHFRLJ WITH (NOLOCK) 
						ON VHFRGJ.NodeID = VHFRLJ.NodeParentID
					LEFT OUTER JOIN dbo.HFit_LKP_RewardType AS HFLRT WITH (NOLOCK) 
						ON VHFRLJ.AwardType = HFLRT.RewardTypeLKPID
					LEFT OUTER JOIN dbo.HFit_LKP_RewardLevelType AS HFLRLT WITH (NOLOCK) 
						ON vhfrlj.LevelType = HFLRLT.RewardLevelTypeLKPID
					INNER JOIN dbo.HFit_RewardsUserLevelDetail AS HFRULD WITH (NOLOCK) 
						ON VHFRLJ.NodeID = HFRULD.LevelNodeID
					INNER JOIN dbo.CMS_User AS CU WITH (NOLOCK) 
						ON hfruld.UserID = cu.UserID
					INNER JOIN dbo.CMS_UserSite AS CUS WITH (NOLOCK) 
						ON CU.UserID = CUS.UserID
					INNER JOIN dbo.CMS_Site AS CS2 WITH (NOLOCK) 
						ON CUS.SiteID = CS2.SiteID
					INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
						ON cs2.SiteID = HFA.SiteID
					INNER JOIN #TEMP_CMS_UserSettings AS CUS2
						ON cu.UserID = cus2.UserSettingsUserID
					LEFT OUTER JOIN #TEMP_View_HFit_RewardActivity_Joined AS VHFRAJ WITH (NOLOCK) 
						ON VHFRLJ.NodeID = VHFRAJ.NodeParentID
					INNER JOIN dbo.HFit_RewardsUserActivityDetail AS HFRUAD WITH (NOLOCK) 
						ON VHFRAJ.NodeID = HFRUAD.ActivityNodeID
					LEFT OUTER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ WITH (NOLOCK) 
						ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
					LEFT OUTER JOIN dbo.HFit_LKP_RewardTrigger AS HFLRT2 WITH (NOLOCK) 
						ON VHFRTJ.RewardTriggerLKPID = HFLRT2.RewardTriggerLKPID
					LEFT OUTER JOIN dbo.HFit_RewardException AS HFRE WITH (NOLOCK) 
						ON HFRE.RewardActivityID = VHFRAJ.RewardActivityID
					   AND HFRE.UserID = cu.UserID
		   WHERE HFRULD.ItemModifiedWhen >= @StartDate
			 AND HFRULD.ItemModifiedWhen <= @EndDate;

		 --OPTION (TABLE HINT(CUS2 , index (pi_CMS_UserSettings_IDMPI)))

		 IF @TrackPerf IS NOT NULL
			 BEGIN
				 SET @P0End = GETDATE () ;
				 EXEC proc_EDW_MeasurePerf 'ElapsedTime', 'HARewardUSer-P0', 0, @P0Start, @P0End;
			 END;
	 END;

--End of Proc

GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Alter View [dbo].[view_EDW_HealthAssesmentDeffinitionCustom]

PRINT 'Alter View [dbo].[view_EDW_HealthAssesmentDeffinitionCustom]';
GO

--GRANT SELECT
--	ON [dbo].[view_EDW_HealthAssesmentDeffinitionCustom]
--	TO [EDWReader_PRD]
--GO
--***********************************************************************************************
-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--***********************************************************************************************

ALTER VIEW dbo.view_EDW_HealthAssesmentDeffinitionCustom
AS

	 --8/8/2014 - DocGUID changes, NodeGuid
	 --8/8/2014 - Generated corrected view in DEV
	 --8/10/2014 - added WHERE to limit to English language
	 --09.11.2014 - WDM : Added date fields to facilitate Last Mod Date determination

	 SELECT
			cs.SiteGUID
		  , HFA.AccountCD

			--WDM 08.07.2014

		  , HA.NodeID AS HANodeID

			--WDM 08.07.2014

		  , HA.NodeName AS HANodeName

			--WDM 08.07.2014

		  , HA.DocumentID AS HADocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID AS HANodeSiteID

			--WDM 08.07.2014

		  , HA.DocumentPublishedVersionHistoryID AS HADocPubVerID

			--WDM 08.07.2014

		  , VHFHAMJ.Title AS ModTitle

			--Per EDW Team, HTML text is truncated to 4000 bytes - we'll just do it here

		  , dbo.udf_StripHTML (LEFT (LEFT (VHFHAMJ.IntroText, 4000) , 4000)) AS IntroText
		  , VHFHAMJ.DocumentGuid AS ModDocGuid

			--, VHFHAMJ.DocumentID AS ModDocID	--WDM 08.07.2014

		  , VHFHAMJ.Weight AS ModWeight
		  , VHFHAMJ.IsEnabled AS ModIsEnabled
		  , VHFHAMJ.CodeName AS ModCodeName
		  , VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
		  , VHFHARCJ.Title AS RCTitle
		  , VHFHARCJ.Weight AS RCWeight
		  , VHFHARCJ.DocumentGuid AS RCDocumentGUID

			--, VHFHARCJ.DocumentID AS RCDocumentID	--WDM 08.07.2014

		  , VHFHARCJ.IsEnabled AS RCIsEnabled
		  , VHFHARCJ.CodeName AS RCCodeName
		  , VHFHARCJ.DocumentPublishedVersionHistoryID AS RCDocPubVerID
		  , VHFHARAJ.Title AS RATytle
		  , VHFHARAJ.Weight AS RAWeight
		  , VHFHARAJ.DocumentGuid AS RADocumentGuid

			--, VHFHARAJ.DocumentID AS RADocumentID	--WDM 08.07.2014

		  , VHFHARAJ.IsEnabled AS RAIsEnabled
		  , VHFHARAJ.CodeName AS RACodeName
		  , VHFHARAJ.ScoringStrategyID AS RAScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID AS RADocPubVerID
		  , VHFHAQ.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ.Title, 4000)) AS QuesTitle
		  , VHFHAQ.Weight AS QuesWeight
		  , VHFHAQ.IsRequired AS QuesIsRequired
		  , VHFHAQ.DocumentGuid AS QuesDocumentGuid

			--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014

		  , VHFHAQ.IsEnabled AS QuesIsEnabled
		  , LEFT (VHFHAQ.IsVisible, 4000) AS QuesIsVisible
		  , VHFHAQ.IsStaging AS QuesIsSTaging
		  , VHFHAQ.CodeName AS QuestionCodeName
		  , VHFHAQ.DocumentPublishedVersionHistoryID AS QuesDocPubVerID
		  , VHFHAA.Value AS AnsValue
		  , VHFHAA.Points AS AnsPoints
		  , VHFHAA.DocumentGuid AS AnsDocumentGuid

			--, VHFHAA.DocumentID AS AnsDocumentID	--WDM 08.07.2014

		  , VHFHAA.IsEnabled AS AnsIsEnabled
		  , VHFHAA.CodeName AS AnsCodeName
		  , VHFHAA.UOM AS AnsUOM
		  , VHFHAA.DocumentPublishedVersionHistoryID AS AnsDocPUbVerID
		  , CASE
				WHEN CAST (VCTJ.DocumentCreatedWhen AS date) = CAST (vctj.DocumentModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , VCTJ.DocumentCreatedWhen
		  , VCTJ.DocumentModifiedWhen
		  , VCTJ.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014 ADDED TO the returned Columns

		  , CS.SiteLastModified
		  , hfa.ItemModifiedWhen AS Account_ItemModifiedWhen
		  , c.DocumentModifiedWhen AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
	   FROM dbo.View_CMS_Tree_Joined AS VCTJ
				INNER JOIN dbo.CMS_Site AS CS
					ON VCTJ.NodeSiteID = cs.SiteID
				INNER JOIN HFit_Account AS hfa WITH (NOLOCK) 
					ON cs.SiteID = hfa.SiteID

	 --Campaign links Client which links to Assessment

				INNER JOIN dbo.View_HFit_HACampaign_Joined AS c WITH (NOLOCK) 
					ON VCTJ.NodeID = c.NodeParentID
				INNER JOIN View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
					ON c.HealthAssessmentID = HA.DocumentID

	 --WDM 08.07.2014

				INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
					ON HA.NodeID = VHFHAMJ.NodeParentID
				INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
					ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
				INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
					ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
					ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
				LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
					ON VHFHAQ.NodeID = VHFHAA.NodeParentID
	   WHERE VCTJ.DocumentCulture = 'en-us'

			 --WDM 08.07.2014

		 AND VHFHAMJ.NodeName = 'Custom'
	 UNION ALL

	 --WDM Retrieve Matrix Level 1 Question Group

	 SELECT
			cs.SiteGUID
		  , HFA.AccountCD
		  , HA.NodeID

			--WDM 08.07.2014

		  , HA.NodeName

			--WDM 08.07.2014

		  , HA.DocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID

			--WDM 08.07.2014
			--,VCTJ.NodeAliasPath

		  , HA.DocumentPublishedVersionHistoryID

			--WDM 08.07.2014

		  , VHFHAMJ.Title
		  , dbo.udf_StripHTML (LEFT (LEFT (VHFHAMJ.IntroText, 4000) , 4000)) AS IntroText
		  , VHFHAMJ.DocumentGUID
		  , VHFHAMJ.Weight
		  , VHFHAMJ.IsEnabled
		  , VHFHAMJ.CodeName

			--,VHFHAMJ.NodeAliasPath

		  , VHFHAMJ.DocumentPublishedVersionHistoryID
		  , VHFHARCJ.Title
		  , VHFHARCJ.Weight
		  , VHFHARCJ.DocumentGUID
		  , VHFHARCJ.IsEnabled
		  , VHFHARCJ.CodeName

			--,VHFHARCJ.NodeAliasPath

		  , VHFHARCJ.DocumentPublishedVersionHistoryID
		  , VHFHARAJ.Title
		  , VHFHARAJ.Weight
		  , VHFHARAJ.DocumentGUID
		  , VHFHARAJ.IsEnabled
		  , VHFHARAJ.CodeName

			--,VHFHARAJ.NodeAliasPath

		  , VHFHARAJ.ScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID
		  , VHFHAQ2.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ2.Title, 4000)) AS QuesTitle
		  , VHFHAQ2.Weight
		  , VHFHAQ2.IsRequired
		  , VHFHAQ2.DocumentGUID
		  , VHFHAQ2.IsEnabled
		  , LEFT (VHFHAQ2.IsVisible, 4000) 
		  , VHFHAQ2.IsStaging
		  , VHFHAQ2.CodeName AS QuestionCodeName

			--,VHFHAQ2.NodeAliasPath

		  , VHFHAQ2.DocumentPublishedVersionHistoryID
		  , VHFHAA2.Value
		  , VHFHAA2.Points
		  , VHFHAA2.DocumentGUID
		  , VHFHAA2.IsEnabled
		  , VHFHAA2.CodeName
		  , VHFHAA2.UOM

			--,VHFHAA2.NodeAliasPath

		  , VHFHAA2.DocumentPublishedVersionHistoryID
		  , CASE
				WHEN CAST (VCTJ.DocumentCreatedWhen AS date) = CAST (vctj.DocumentModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , VCTJ.DocumentCreatedWhen
		  , VCTJ.DocumentModifiedWhen
		  , VCTJ.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014

		  , CS.SiteLastModified
		  , hfa.ItemModifiedWhen AS Account_ItemModifiedWhen
		  , c.DocumentModifiedWhen AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
	   FROM dbo.View_CMS_Tree_Joined AS VCTJ
				INNER JOIN dbo.CMS_Site AS CS
					ON VCTJ.NodeSiteID = cs.SiteID
				INNER JOIN HFit_Account AS hfa WITH (NOLOCK) 
					ON cs.SiteID = hfa.SiteID
				INNER JOIN dbo.View_HFit_HACampaign_Joined AS c WITH (NOLOCK) 
					ON VCTJ.NodeID = c.NodeParentID
				INNER JOIN View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
					ON c.HealthAssessmentID = HA.DocumentID
				INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
					ON HA.NodeID = VHFHAMJ.NodeParentID
				INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
					ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
				INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
					ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
					ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
				LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
					ON VHFHAQ.NodeID = VHFHAA.NodeParentID

	 --matrix level 1 questiongroup

				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2
					ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
				INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2
					ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	   WHERE VCTJ.DocumentCulture = 'en-us'

			 --WDM 08.07.2014

		 AND VHFHAMJ.NodeName = 'Custom'
	 UNION ALL

	 --WDM Retrieve Branching Level 1 Question and Matrix Level 1 Question Group

	 SELECT
			cs.SiteGUID
		  , HFA.AccountCD
		  , HA.NodeID

			--WDM 08.07.2014

		  , HA.NodeName

			--WDM 08.07.2014

		  , HA.DocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID

			--WDM 08.07.2014
			--,VCTJ.NodeAliasPath

		  , HA.DocumentPublishedVersionHistoryID

			--WDM 08.07.2014

		  , VHFHAMJ.Title
		  , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
		  , VHFHAMJ.DocumentGUID
		  , VHFHAMJ.Weight
		  , VHFHAMJ.IsEnabled
		  , VHFHAMJ.CodeName

			--,VHFHAMJ.NodeAliasPath

		  , VHFHAMJ.DocumentPublishedVersionHistoryID
		  , VHFHARCJ.Title
		  , VHFHARCJ.Weight
		  , VHFHARCJ.DocumentGUID
		  , VHFHARCJ.IsEnabled
		  , VHFHARCJ.CodeName

			--,VHFHARCJ.NodeAliasPath

		  , VHFHARCJ.DocumentPublishedVersionHistoryID
		  , VHFHARAJ.Title
		  , VHFHARAJ.Weight
		  , VHFHARAJ.DocumentGUID
		  , VHFHARAJ.IsEnabled
		  , VHFHARAJ.CodeName

			--,VHFHARAJ.NodeAliasPath

		  , VHFHARAJ.ScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID
		  , VHFHAQ3.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ3.Title, 4000)) AS QuesTitle
		  , VHFHAQ3.Weight
		  , VHFHAQ3.IsRequired
		  , VHFHAQ3.DocumentGUID
		  , VHFHAQ3.IsEnabled
		  , LEFT (VHFHAQ3.IsVisible, 4000) 
		  , VHFHAQ3.IsStaging
		  , VHFHAQ3.CodeName AS QuestionCodeName

			--,VHFHAQ3.NodeAliasPath

		  , VHFHAQ3.DocumentPublishedVersionHistoryID
		  , VHFHAA3.Value
		  , VHFHAA3.Points
		  , VHFHAA3.DocumentGUID
		  , VHFHAA3.IsEnabled
		  , VHFHAA3.CodeName
		  , VHFHAA3.UOM

			--,VHFHAA3.NodeAliasPath

		  , VHFHAA3.DocumentPublishedVersionHistoryID
		  , CASE
				WHEN CAST (VCTJ.DocumentCreatedWhen AS date) = CAST (vctj.DocumentModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , VCTJ.DocumentCreatedWhen
		  , VCTJ.DocumentModifiedWhen
		  , VCTJ.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014

		  , CS.SiteLastModified
		  , hfa.ItemModifiedWhen AS Account_ItemModifiedWhen
		  , c.DocumentModifiedWhen AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
	   FROM dbo.View_CMS_Tree_Joined AS VCTJ
				INNER JOIN dbo.CMS_Site AS CS
					ON VCTJ.NodeSiteID = cs.SiteID
				INNER JOIN HFit_Account AS hfa WITH (NOLOCK) 
					ON cs.SiteID = hfa.SiteID
				INNER JOIN dbo.View_HFit_HACampaign_Joined AS c WITH (NOLOCK) 
					ON VCTJ.NodeID = c.NodeParentID
				INNER JOIN View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
					ON c.HealthAssessmentID = HA.DocumentID
				INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
					ON HA.NodeID = VHFHAMJ.NodeParentID
				INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
					ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
				INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
					ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
					ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
				LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
					ON VHFHAQ.NodeID = VHFHAA.NodeParentID

	 --matrix level 1 questiongroup
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	 --Branching Level 1 Question 

				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
					ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
				LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
					ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
	   WHERE VCTJ.DocumentCulture = 'en-us'

			 --WDM 08.07.2014

		 AND VHFHAMJ.NodeName = 'Custom'
	 UNION ALL

	 --WDM Retrieve Branching Level 1 Question and Matrix Level 2 Question Group

	 SELECT
			cs.SiteGUID
		  , HFA.AccountCD
		  , HA.NodeID

			--WDM 08.07.2014

		  , HA.NodeName

			--WDM 08.07.2014

		  , HA.DocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID

			--WDM 08.07.2014
			--,VCTJ.NodeAliasPath

		  , HA.DocumentPublishedVersionHistoryID

			--WDM 08.07.2014

		  , VHFHAMJ.Title
		  , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
		  , VHFHAMJ.DocumentGUID
		  , VHFHAMJ.Weight
		  , VHFHAMJ.IsEnabled
		  , VHFHAMJ.CodeName

			--,VHFHAMJ.NodeAliasPath

		  , VHFHAMJ.DocumentPublishedVersionHistoryID
		  , VHFHARCJ.Title
		  , VHFHARCJ.Weight
		  , VHFHARCJ.DocumentGUID
		  , VHFHARCJ.IsEnabled
		  , VHFHARCJ.CodeName

			--,VHFHARCJ.NodeAliasPath

		  , VHFHARCJ.DocumentPublishedVersionHistoryID
		  , VHFHARAJ.Title
		  , VHFHARAJ.Weight
		  , VHFHARAJ.DocumentGUID
		  , VHFHARAJ.IsEnabled
		  , VHFHARAJ.CodeName

			--,VHFHARAJ.NodeAliasPath

		  , VHFHARAJ.ScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID
		  , VHFHAQ7.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ7.Title, 4000)) AS QuesTitle
		  , VHFHAQ7.Weight
		  , VHFHAQ7.IsRequired
		  , VHFHAQ7.DocumentGUID
		  , VHFHAQ7.IsEnabled
		  , LEFT (VHFHAQ7.IsVisible, 4000) 
		  , VHFHAQ7.IsStaging
		  , VHFHAQ7.CodeName AS QuestionCodeName

			--,VHFHAQ7.NodeAliasPath

		  , VHFHAQ7.DocumentPublishedVersionHistoryID
		  , VHFHAA7.Value
		  , VHFHAA7.Points
		  , VHFHAA7.DocumentGUID
		  , VHFHAA7.IsEnabled
		  , VHFHAA7.CodeName
		  , VHFHAA7.UOM

			--,VHFHAA7.NodeAliasPath

		  , VHFHAA7.DocumentPublishedVersionHistoryID
		  , CASE
				WHEN CAST (VCTJ.DocumentCreatedWhen AS date) = CAST (vctj.DocumentModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , VCTJ.DocumentCreatedWhen
		  , VCTJ.DocumentModifiedWhen
		  , VCTJ.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014

		  , CS.SiteLastModified
		  , hfa.ItemModifiedWhen AS Account_ItemModifiedWhen
		  , c.DocumentModifiedWhen AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
	   FROM dbo.View_CMS_Tree_Joined AS VCTJ
				INNER JOIN dbo.CMS_Site AS CS
					ON VCTJ.NodeSiteID = cs.SiteID
				INNER JOIN HFit_Account AS hfa WITH (NOLOCK) 
					ON cs.SiteID = hfa.SiteID
				INNER JOIN dbo.View_HFit_HACampaign_Joined AS c WITH (NOLOCK) 
					ON VCTJ.NodeID = c.NodeParentID
				INNER JOIN View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
					ON c.HealthAssessmentID = HA.DocumentID
				INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
					ON HA.NodeID = VHFHAMJ.NodeParentID
				INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
					ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
				INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
					ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
					ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
				LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
					ON VHFHAQ.NodeID = VHFHAA.NodeParentID

	 --matrix level 1 questiongroup
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	 --Branching Level 1 Question 

				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
					ON VHFHAA.NodeID = VHFHAQ3.NodeParentID

	 --LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
	 --Matrix Level 2 Question Group

				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7
					ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
				INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7
					ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
	   WHERE VCTJ.DocumentCulture = 'en-us'

			 --WDM 08.07.2014

		 AND VHFHAMJ.NodeName = 'Custom'
	 UNION ALL

	 --****************************************************
	 --WDM 6/25/2014 Retrieve the Branching level 1 Question Group
	 --THE PROBLEM LIES HERE in this part of query : 1:40 minute
	 -- Added two perf indexes to the first query: 25 Sec
	 --****************************************************

	 SELECT
			cs.SiteGUID
		  , HFA.AccountCD
		  , HA.NodeID

			--WDM 08.07.2014

		  , HA.NodeName

			--WDM 08.07.2014

		  , HA.DocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID

			--WDM 08.07.2014
			--,VCTJ.NodeAliasPath

		  , HA.DocumentPublishedVersionHistoryID

			--WDM 08.07.2014

		  , VHFHAMJ.Title
		  , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
		  , VHFHAMJ.DocumentGUID
		  , VHFHAMJ.Weight
		  , VHFHAMJ.IsEnabled
		  , VHFHAMJ.CodeName

			--,VHFHAMJ.NodeAliasPath

		  , VHFHAMJ.DocumentPublishedVersionHistoryID
		  , VHFHARCJ.Title
		  , VHFHARCJ.Weight
		  , VHFHARCJ.DocumentGUID
		  , VHFHARCJ.IsEnabled
		  , VHFHARCJ.CodeName

			--,VHFHARCJ.NodeAliasPath

		  , VHFHARCJ.DocumentPublishedVersionHistoryID
		  , VHFHARAJ.Title
		  , VHFHARAJ.Weight
		  , VHFHARAJ.DocumentGUID
		  , VHFHARAJ.IsEnabled
		  , VHFHARAJ.CodeName

			--,VHFHARAJ.NodeAliasPath

		  , VHFHARAJ.ScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID
		  , VHFHAQ8.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ8.Title, 4000)) AS QuesTitle
		  , VHFHAQ8.Weight
		  , VHFHAQ8.IsRequired
		  , VHFHAQ8.DocumentGUID
		  , VHFHAQ8.IsEnabled
		  , LEFT (VHFHAQ8.IsVisible, 4000) 
		  , VHFHAQ8.IsStaging
		  , VHFHAQ8.CodeName AS QuestionCodeName

			--,VHFHAQ8.NodeAliasPath

		  , VHFHAQ8.DocumentPublishedVersionHistoryID
		  , VHFHAA8.Value
		  , VHFHAA8.Points
		  , VHFHAA8.DocumentGUID
		  , VHFHAA8.IsEnabled
		  , VHFHAA8.CodeName
		  , VHFHAA8.UOM

			--,VHFHAA8.NodeAliasPath

		  , VHFHAA8.DocumentPublishedVersionHistoryID
		  , CASE
				WHEN CAST (VCTJ.DocumentCreatedWhen AS date) = CAST (vctj.DocumentModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , VCTJ.DocumentCreatedWhen
		  , VCTJ.DocumentModifiedWhen
		  , VCTJ.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014

		  , CS.SiteLastModified
		  , hfa.ItemModifiedWhen AS Account_ItemModifiedWhen
		  , c.DocumentModifiedWhen AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
	   FROM dbo.View_CMS_Tree_Joined AS VCTJ
				INNER JOIN dbo.CMS_Site AS CS
					ON VCTJ.NodeSiteID = cs.SiteID
				INNER JOIN HFit_Account AS hfa WITH (NOLOCK) 
					ON cs.SiteID = hfa.SiteID
				INNER JOIN dbo.View_HFit_HACampaign_Joined AS c WITH (NOLOCK) 
					ON VCTJ.NodeID = c.NodeParentID
				INNER JOIN View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
					ON c.HealthAssessmentID = HA.DocumentID
				INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
					ON HA.NodeID = VHFHAMJ.NodeParentID
				INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
					ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
				INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
					ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
					ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
				LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
					ON VHFHAQ.NodeID = VHFHAA.NodeParentID

	 --matrix level 1 questiongroup
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	 --Branching Level 1 Question 

				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
					ON VHFHAA.NodeID = VHFHAQ3.NodeParentID

	 --LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
	 --Matrix Level 2 Question Group

				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7
					ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
				INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7
					ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

	 --Matrix branching level 1 question group

				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8
					ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
				INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8
					ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
	   WHERE VCTJ.DocumentCulture = 'en-us'

			 --WDM 08.07.2014

		 AND VHFHAMJ.NodeName = 'Custom'
	 UNION ALL

	 --****************************************************
	 --WDM 6/25/2014 Retrieve the Branching level 2 Question Group
	 --THE PROBLEM LIES HERE in this part of query : 1:48  minutes
	 --With the new indexes: 29 Secs
	 --****************************************************

	 SELECT
			cs.SiteGUID
		  , HFA.AccountCD
		  , HA.NodeID

			--WDM 08.07.2014

		  , HA.NodeName

			--WDM 08.07.2014

		  , HA.DocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID

			--WDM 08.07.2014
			--,VCTJ.NodeAliasPath

		  , HA.DocumentPublishedVersionHistoryID

			--WDM 08.07.2014

		  , VHFHAMJ.Title
		  , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
		  , VHFHAMJ.DocumentGUID
		  , VHFHAMJ.Weight
		  , VHFHAMJ.IsEnabled
		  , VHFHAMJ.CodeName

			--,VHFHAMJ.NodeAliasPath

		  , VHFHAMJ.DocumentPublishedVersionHistoryID
		  , VHFHARCJ.Title
		  , VHFHARCJ.Weight
		  , VHFHARCJ.DocumentGUID
		  , VHFHARCJ.IsEnabled
		  , VHFHARCJ.CodeName

			--,VHFHARCJ.NodeAliasPath

		  , VHFHARCJ.DocumentPublishedVersionHistoryID
		  , VHFHARAJ.Title
		  , VHFHARAJ.Weight
		  , VHFHARAJ.DocumentGUID
		  , VHFHARAJ.IsEnabled
		  , VHFHARAJ.CodeName

			--,VHFHARAJ.NodeAliasPath

		  , VHFHARAJ.ScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID
		  , VHFHAQ4.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ4.Title, 4000)) AS QuesTitle
		  , VHFHAQ4.Weight
		  , VHFHAQ4.IsRequired
		  , VHFHAQ4.DocumentGUID
		  , VHFHAQ4.IsEnabled
		  , LEFT (VHFHAQ4.IsVisible, 4000) 
		  , VHFHAQ4.IsStaging
		  , VHFHAQ4.CodeName AS QuestionCodeName

			--,VHFHAQ4.NodeAliasPath

		  , VHFHAQ4.DocumentPublishedVersionHistoryID
		  , VHFHAA4.Value
		  , VHFHAA4.Points
		  , VHFHAA4.DocumentGUID
		  , VHFHAA4.IsEnabled
		  , VHFHAA4.CodeName
		  , VHFHAA4.UOM

			--,VHFHAA4.NodeAliasPath

		  , VHFHAA4.DocumentPublishedVersionHistoryID
		  , CASE
				WHEN CAST (VCTJ.DocumentCreatedWhen AS date) = CAST (vctj.DocumentModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , VCTJ.DocumentCreatedWhen
		  , VCTJ.DocumentModifiedWhen
		  , VCTJ.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014

		  , CS.SiteLastModified
		  , hfa.ItemModifiedWhen AS Account_ItemModifiedWhen
		  , c.DocumentModifiedWhen AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
	   FROM dbo.View_CMS_Tree_Joined AS VCTJ
				INNER JOIN dbo.CMS_Site AS CS
					ON VCTJ.NodeSiteID = cs.SiteID
				INNER JOIN HFit_Account AS hfa WITH (NOLOCK) 
					ON cs.SiteID = hfa.SiteID
				INNER JOIN dbo.View_HFit_HACampaign_Joined AS c WITH (NOLOCK) 
					ON VCTJ.NodeID = c.NodeParentID
				INNER JOIN View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
					ON c.HealthAssessmentID = HA.DocumentID
				INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
					ON HA.NodeID = VHFHAMJ.NodeParentID
				INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
					ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
				INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
					ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
					ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
				LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
					ON VHFHAQ.NodeID = VHFHAA.NodeParentID

	 --matrix level 1 questiongroup
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	 --Branching Level 1 Question 

				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
					ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
				LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
					ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

	 --Matrix Level 2 Question Group
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
	 --Matrix branching level 1 question group
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
	 --Branching level 2 Question Group

				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4
					ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
				INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
					ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID
	   WHERE VCTJ.DocumentCulture = 'en-us'

			 --WDM 08.07.2014

		 AND VHFHAMJ.NodeName = 'Custom'
	 UNION ALL

	 --WDM 6/25/2014 Retrieve the Branching level 3 Question Group

	 SELECT
			cs.SiteGUID
		  , HFA.AccountCD
		  , HA.NodeID

			--WDM 08.07.2014

		  , HA.NodeName

			--WDM 08.07.2014

		  , HA.DocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID

			--WDM 08.07.2014
			--,VCTJ.NodeAliasPath

		  , HA.DocumentPublishedVersionHistoryID

			--WDM 08.07.2014

		  , VHFHAMJ.Title
		  , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
		  , VHFHAMJ.DocumentGUID
		  , VHFHAMJ.Weight
		  , VHFHAMJ.IsEnabled
		  , VHFHAMJ.CodeName

			--,VHFHAMJ.NodeAliasPath

		  , VHFHAMJ.DocumentPublishedVersionHistoryID
		  , VHFHARCJ.Title
		  , VHFHARCJ.Weight
		  , VHFHARCJ.DocumentGUID
		  , VHFHARCJ.IsEnabled
		  , VHFHARCJ.CodeName

			--,VHFHARCJ.NodeAliasPath

		  , VHFHARCJ.DocumentPublishedVersionHistoryID
		  , VHFHARAJ.Title
		  , VHFHARAJ.Weight
		  , VHFHARAJ.DocumentGUID
		  , VHFHARAJ.IsEnabled
		  , VHFHARAJ.CodeName

			--,VHFHARAJ.NodeAliasPath

		  , VHFHARAJ.ScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID
		  , VHFHAQ5.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ5.Title, 4000)) AS QuesTitle
		  , VHFHAQ5.Weight
		  , VHFHAQ5.IsRequired
		  , VHFHAQ5.DocumentGUID
		  , VHFHAQ5.IsEnabled
		  , LEFT (VHFHAQ5.IsVisible, 4000) 
		  , VHFHAQ5.IsStaging
		  , VHFHAQ5.CodeName AS QuestionCodeName

			--,VHFHAQ5.NodeAliasPath

		  , VHFHAQ5.DocumentPublishedVersionHistoryID
		  , VHFHAA5.Value
		  , VHFHAA5.Points
		  , VHFHAA5.DocumentGUID
		  , VHFHAA5.IsEnabled
		  , VHFHAA5.CodeName
		  , VHFHAA5.UOM

			--,VHFHAA5.NodeAliasPath

		  , VHFHAA5.DocumentPublishedVersionHistoryID
		  , CASE
				WHEN CAST (VCTJ.DocumentCreatedWhen AS date) = CAST (vctj.DocumentModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , VCTJ.DocumentCreatedWhen
		  , VCTJ.DocumentModifiedWhen
		  , VCTJ.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014

		  , CS.SiteLastModified
		  , hfa.ItemModifiedWhen AS Account_ItemModifiedWhen
		  , c.DocumentModifiedWhen AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
	   FROM dbo.View_CMS_Tree_Joined AS VCTJ
				INNER JOIN dbo.CMS_Site AS CS
					ON VCTJ.NodeSiteID = cs.SiteID
				INNER JOIN HFit_Account AS hfa WITH (NOLOCK) 
					ON cs.SiteID = hfa.SiteID
				INNER JOIN dbo.View_HFit_HACampaign_Joined AS c WITH (NOLOCK) 
					ON VCTJ.NodeID = c.NodeParentID
				INNER JOIN View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
					ON c.HealthAssessmentID = HA.DocumentID
				INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
					ON HA.NodeID = VHFHAMJ.NodeParentID
				INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
					ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
				INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
					ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
					ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
				LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
					ON VHFHAQ.NodeID = VHFHAA.NodeParentID

	 --matrix level 1 questiongroup
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	 --Branching Level 1 Question 

				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
					ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
				LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
					ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

	 --Matrix Level 2 Question Group
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
	 --Matrix branching level 1 question group
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
	 --Branching level 2 Question Group

				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4
					ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
				INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
					ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

	 --Branching level 3 Question Group

				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5
					ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
				INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5
					ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID
	   WHERE VCTJ.DocumentCulture = 'en-us'

			 --WDM 08.07.2014

		 AND VHFHAMJ.NodeName = 'Custom'
	 UNION ALL

	 --WDM 6/25/2014 Retrieve the Branching level 4 Question Group

	 SELECT
			cs.SiteGUID
		  , HFA.AccountCD
		  , HA.NodeID

			--WDM 08.07.2014

		  , HA.NodeName

			--WDM 08.07.2014

		  , HA.DocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID

			--WDM 08.07.2014
			--,VCTJ.NodeAliasPath

		  , HA.DocumentPublishedVersionHistoryID

			--WDM 08.07.2014

		  , VHFHAMJ.Title
		  , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
		  , VHFHAMJ.DocumentGUID
		  , VHFHAMJ.Weight
		  , VHFHAMJ.IsEnabled
		  , VHFHAMJ.CodeName

			--,VHFHAMJ.NodeAliasPath

		  , VHFHAMJ.DocumentPublishedVersionHistoryID
		  , VHFHARCJ.Title
		  , VHFHARCJ.Weight
		  , VHFHARCJ.DocumentGUID
		  , VHFHARCJ.IsEnabled
		  , VHFHARCJ.CodeName

			--,VHFHARCJ.NodeAliasPath

		  , VHFHARCJ.DocumentPublishedVersionHistoryID
		  , VHFHARAJ.Title
		  , VHFHARAJ.Weight
		  , VHFHARAJ.DocumentGUID
		  , VHFHARAJ.IsEnabled
		  , VHFHARAJ.CodeName

			--,VHFHARAJ.NodeAliasPath

		  , VHFHARAJ.ScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID
		  , VHFHAQ6.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ6.Title, 4000)) AS QuesTitle
		  , VHFHAQ6.Weight
		  , VHFHAQ6.IsRequired
		  , VHFHAQ6.DocumentGUID
		  , VHFHAQ6.IsEnabled
		  , LEFT (VHFHAQ6.IsVisible, 4000) 
		  , VHFHAQ6.IsStaging
		  , VHFHAQ6.CodeName AS QuestionCodeName

			--,VHFHAQ6.NodeAliasPath

		  , VHFHAQ6.DocumentPublishedVersionHistoryID
		  , VHFHAA6.Value
		  , VHFHAA6.Points
		  , VHFHAA6.DocumentGUID
		  , VHFHAA6.IsEnabled
		  , VHFHAA6.CodeName
		  , VHFHAA6.UOM

			--,VHFHAA6.NodeAliasPath

		  , VHFHAA6.DocumentPublishedVersionHistoryID
		  , CASE
				WHEN CAST (VCTJ.DocumentCreatedWhen AS date) = CAST (vctj.DocumentModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , VCTJ.DocumentCreatedWhen
		  , VCTJ.DocumentModifiedWhen
		  , VCTJ.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014

		  , CS.SiteLastModified
		  , hfa.ItemModifiedWhen AS Account_ItemModifiedWhen
		  , c.DocumentModifiedWhen AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
	   FROM dbo.View_CMS_Tree_Joined AS VCTJ
				INNER JOIN dbo.CMS_Site AS CS
					ON VCTJ.NodeSiteID = cs.SiteID
				INNER JOIN HFit_Account AS hfa WITH (NOLOCK) 
					ON cs.SiteID = hfa.SiteID
				INNER JOIN dbo.View_HFit_HACampaign_Joined AS c WITH (NOLOCK) 
					ON VCTJ.NodeID = c.NodeParentID
				INNER JOIN View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
					ON c.HealthAssessmentID = HA.DocumentID
				INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
					ON HA.NodeID = VHFHAMJ.NodeParentID
				INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
					ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
				INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
					ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
					ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
				LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
					ON VHFHAQ.NodeID = VHFHAA.NodeParentID

	 --matrix level 1 questiongroup
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	 --Branching Level 1 Question 

				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
					ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
				LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
					ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

	 --Matrix Level 2 Question Group
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
	 --Matrix branching level 1 question group
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
	 --Branching level 2 Question Group

				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4
					ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
				INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
					ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

	 --Branching level 3 Question Group
	 --select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4

				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5
					ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
				INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5
					ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

	 --Branching level 4 Question Group

				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6
					ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
				INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6
					ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID
	   WHERE VCTJ.DocumentCulture = 'en-us'

			 --WDM 08.07.2014

		 AND VHFHAMJ.NodeName = 'Custom'
	 UNION ALL

	 --WDM 6/25/2014 Retrieve the Branching level 5 Question Group

	 SELECT
			cs.SiteGUID
		  , HFA.AccountCD
		  , HA.NodeID

			--WDM 08.07.2014

		  , HA.NodeName

			--WDM 08.07.2014

		  , HA.DocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID

			--WDM 08.07.2014
			--,VCTJ.NodeAliasPath

		  , HA.DocumentPublishedVersionHistoryID

			--WDM 08.07.2014

		  , VHFHAMJ.Title
		  , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
		  , VHFHAMJ.DocumentGUID
		  , VHFHAMJ.Weight
		  , VHFHAMJ.IsEnabled
		  , VHFHAMJ.CodeName

			--,VHFHAMJ.NodeAliasPath

		  , VHFHAMJ.DocumentPublishedVersionHistoryID
		  , VHFHARCJ.Title
		  , VHFHARCJ.Weight
		  , VHFHARCJ.DocumentGUID
		  , VHFHARCJ.IsEnabled
		  , VHFHARCJ.CodeName

			--,VHFHARCJ.NodeAliasPath

		  , VHFHARCJ.DocumentPublishedVersionHistoryID
		  , VHFHARAJ.Title
		  , VHFHARAJ.Weight
		  , VHFHARAJ.DocumentGUID
		  , VHFHARAJ.IsEnabled
		  , VHFHARAJ.CodeName

			--,VHFHARAJ.NodeAliasPath

		  , VHFHARAJ.ScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID
		  , VHFHAQ9.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ9.Title, 4000)) AS QuesTitle
		  , VHFHAQ9.Weight
		  , VHFHAQ9.IsRequired
		  , VHFHAQ9.DocumentGUID
		  , VHFHAQ9.IsEnabled
		  , LEFT (VHFHAQ9.IsVisible, 4000) 
		  , VHFHAQ9.IsStaging
		  , VHFHAQ9.CodeName AS QuestionCodeName

			--,VHFHAQ9.NodeAliasPath

		  , VHFHAQ9.DocumentPublishedVersionHistoryID
		  , VHFHAA9.Value
		  , VHFHAA9.Points
		  , VHFHAA9.DocumentGUID
		  , VHFHAA9.IsEnabled
		  , VHFHAA9.CodeName
		  , VHFHAA9.UOM

			--,VHFHAA9.NodeAliasPath

		  , VHFHAA9.DocumentPublishedVersionHistoryID
		  , CASE
				WHEN CAST (VCTJ.DocumentCreatedWhen AS date) = CAST (vctj.DocumentModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , VCTJ.DocumentCreatedWhen
		  , VCTJ.DocumentModifiedWhen
		  , VCTJ.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014

		  , CS.SiteLastModified
		  , hfa.ItemModifiedWhen AS Account_ItemModifiedWhen
		  , c.DocumentModifiedWhen AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
	   FROM dbo.View_CMS_Tree_Joined AS VCTJ
				INNER JOIN dbo.CMS_Site AS CS
					ON VCTJ.NodeSiteID = cs.SiteID
				INNER JOIN HFit_Account AS hfa WITH (NOLOCK) 
					ON cs.SiteID = hfa.SiteID
				INNER JOIN dbo.View_HFit_HACampaign_Joined AS c WITH (NOLOCK) 
					ON VCTJ.NodeID = c.NodeParentID
				INNER JOIN View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
					ON c.HealthAssessmentID = HA.DocumentID
				INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
					ON HA.NodeID = VHFHAMJ.NodeParentID
				INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
					ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
				INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
					ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
					ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
				LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
					ON VHFHAQ.NodeID = VHFHAA.NodeParentID

	 --matrix level 1 questiongroup
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	 --Branching Level 1 Question 

				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
					ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
				LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
					ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

	 --Matrix Level 2 Question Group
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
	 --Matrix branching level 1 question group
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
	 --Branching level 2 Question Group

				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4
					ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
				INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
					ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

	 --Branching level 3 Question Group
	 --select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4

				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5
					ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
				INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5
					ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

	 --Branching level 4 Question Group

				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6
					ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
				INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6
					ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID

	 --Branching level 5 Question Group

				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ9
					ON VHFHAA6.NodeID = VHFHAQ9.NodeParentID
				INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA9
					ON VHFHAQ9.NodeID = VHFHAA9.NodeParentID
	   WHERE VCTJ.DocumentCulture = 'en-us'

			 --WDM 08.07.2014

		 AND VHFHAMJ.NodeName = 'Custom';
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Alter View [dbo].[view_EDW_HealthAssesment]

PRINT 'Alter View [dbo].[view_EDW_HealthAssesment]';
GO

--select top 100 * from [view_EDW_HealthAssesment]

ALTER VIEW dbo.view_EDW_HealthAssesment
AS

	 --********************************************************************************************************
	 --7/15/2014 17:19 min. 46,750 Rows DEV
	 --7/15/2014 per Mark Turner
	 --HAModuleDocumentID is on its way out, so is - 
	 --Module - RiskCategory - RiskArea - Question - Answer 
	 --all the "DocumentID" fields are deprecated and replaced by corresponding NodeGUID fields
	 --8/7/2014 - Executed in DEV with GUID changes and returned 51K Rows in 00:43:10.
	 --8/8/2014 - Generated corrected view in DEV
	 -- Verified last mod date available to EDW 9.10.2014
	 --09.08.2014: John Croft and I working together, realized there is a deficit in the ability 
	 --of the EDW to recognize changes to database records based on the last modified date of a row. 
	 --The views that we are currently using in the database or deeply nested. This means that 
	 --several base tables are involved in building a single view of data.
	 --09.30.2014: Verified with John Croft that he does want this view to return multi-languages.
	 --
	 --The views were initially designed to recognize a date change based on a record change very 
	 --high in the data hierarchy, the CMS Tree level which is the top most level. However, John 
	 --and I recognize that data can change at any level in the hierarchy and those changes must be 
	 --recognized as well. Currently, that is not the case. With the new modification to the views, 
	 --changes in CMS documents and base tables will filter up through the hierarchy and the EDW load 
	 --process will be able to realize that a change in this row’s data may affect and intrude into 
	 --the warehouse.
	 -- 10.01.2014 - Reviewed by Mark and Dale for use of the GUIDS
	 -- 10.01.2014 - Reviewed by Mark and Dale for use of Joins and fixed two that were incorrect (Thanks to Mark)
	 -- 10.23.2014 - (WDM) added two columns for the EDW HAPaperFlg / HATelephonicFlg
	 --			HAPaperFlg is whether the question was reveived electronically or on paper
	 --			HATelephonicFlg is whether the question was reveived by telephone or not
	 -- FIVE Pieces needed per John C. 10.16.2014
	 --	Document GUID -> HealthAssesmentUserStartedNodeGUID
	 --	Module GUID -> Module -> HAUserModule.HAModuleNodeGUID
	 --	Category GUID -> Category
	 --	RiskArea Node Guid -> RiskArea 
	 --	Question Node Guid -> Question
	 --	Answer Node Guid -> Answer 
	 --   10.30.2014 : Sowmiya 
	 --   The following are the possible values allowed in the HAStartedMode and HACompletedMode columns of the Hfit_HealthAssesmentUserStarted table
	 --      Unknown = 0, 
	 --       Paper = 1,  // Paper HA
	 --       Telephonic = 2, // Telephonic HA
	 --       Online = 3, // Online HA
	 --       Ipad = 4 // iPAD
	 -- 08/07/2014 - (WDM) as HAModuleDocumentID	--WDM 10.02.2014 place holder for EDW ETL per John C., Added back per John C. 10.16.2014
	 -- 09/30/2014 - (WDM) as HAModuleDocumentID	--Mark and Dale use NodeGUID instead of Doc GUID
	 --WDM 10.02.2014 place holder for EDW ETL
	 --Per John C. 10.16.2014 requested that this be put back into the view.	
	 --11.05.2014 - Changed from CMS_TREE Joined to View_HFit_HealthAssessment_Joined Mark T. / Dale M.
	 -- 11.05.2014 - Mark T. / Dale M. needed to get the Document for the user : ADDED inner join View_HFit_HealthAssessment_Joined as VHAJ on VHAJ.DocumentID = VHCJ.HealthAssessmentID
	 -- 11.05.2014 - removed the Distinct - may find it necessary to put it back as duplicates may be there. But the server resources required to do this may not be avail on P5.
	 --11.05.2014 - Mark T. / Dale M. removed the link to View_CMS_Tree_Joined and replaced with View_HFit_HealthAssessment_Joined
	 --inner join View_CMS_Tree_Joined as VCTJ on VCTJ.NodeGUID = HAUserModule.HAModuleNodeGUID
	 --	and VCTJ.DocumentCulture = 'en-US'	--10.01.2014 put here to match John C. req. for language agnostic.
	 -- 12.02.2014 - (wdm)Found that the view was being overwritten between Prod 1 and the copy of Prod 5 / Prod 1. Found a script inside a job on PRod 5 that reverted the view to a previous state. Removed the script and the view migrates correctly (d. miller and m. kimenski)
	 -- 12.02.2014 - (wdm) Found DUPS in Prod 1 and Prod 2, none in Prod 3. 
	 -- 12.17.2014 - Added two columns requested by the EDW team as noted by comments next to each column.
	 -- 12.29.2014 - Stripped HTML out of Title #47619
	 -- 12.31.2014 - Eliminated negative MPI's in response to CR47516 
	 -- 01.02.2014 - Tested the removal of negative MPI's in response to CR47516 
	 --01.27.2015 (WDM) #48941 - Add Client Identifier to View_EDW_Eligibility
	 --	   In analyzing this requirement, found that the PPT.ClientID is nvarchar (alphanumeric)
	 --	   and Hfit_Client.ClientID is integer. A bit of a domain/naming issue.
	 --	   This is NOT needed as the data is already contained in columns [AccountID] and [AccountCD]
	 --	   NOTE: Added the column [AccountName], just in case it were to be needed later.
	 --02.04.2015 (WDM) #48828 added:
	 --	    [HAUserStarted].[HACampaignNodeGUID], VCJ.BiometricCampaignStartDate
	 --	   , VCJ.BiometricCampaignEndDate, VCJ.CampaignStartDate
	 --	   , VCJ.CampaignEndDate, VCJ.Name as CampaignName, HACampaignID
	 --02.05.2015 Ashwin and I reviewed and approved
	 --********************************************************************************************************

	 SELECT
			HAUserStarted.ItemID AS UserStartedItemID
		  , VHAJ.NodeGUID AS HealthAssesmentUserStartedNodeGUID
		  , HAUserStarted.UserID
		  , CMSUser.UserGUID
		  , UserSettings.HFitUserMpiNumber
		  , CMSSite.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , ACCT.AccountName
		  , HAUserStarted.HAStartedDt
		  , HAUserStarted.HACompletedDt
		  , HAUserModule.ItemID AS UserModuleItemId
		  , HAUserModule.CodeName AS UserModuleCodeName
		  , HAUserModule.HAModuleNodeGUID
		  , VHAJ.NodeGUID AS CMSNodeGuid
		  , NULL AS HAModuleVersionID
		  , HARiskCategory.ItemID AS UserRiskCategoryItemID
		  , HARiskCategory.CodeName AS UserRiskCategoryCodeName
		  , HARiskCategory.HARiskCategoryNodeGUID

			--WDM 8/7/2014 as HARiskCategoryDocumentID

		  , NULL AS HARiskCategoryVersionID

			--WDM 10.02.2014 place holder for EDW ETL

		  , HAUserRiskArea.ItemID AS UserRiskAreaItemID
		  , HAUserRiskArea.CodeName AS UserRiskAreaCodeName
		  , HAUserRiskArea.HARiskAreaNodeGUID

			--WDM 8/7/2014 as HARiskAreaDocumentID

		  , NULL AS HARiskAreaVersionID

			--WDM 10.02.2014 place holder for EDW ETL

		  , HAUserQuestion.ItemID AS UserQuestionItemID
		  , dbo.udf_StripHTML (HAQuestionsView.Title) AS Title

			--WDM 47619 12.29.2014

		  , HAUserQuestion.HAQuestionNodeGUID AS HAQuestionGuid

			--WDM 9.2.2014	This is a repeat field but had to stay to match the previous view - this is the NODE GUID and matches to the definition file to get the question. This tells you the question, language agnostic.

		  , HAUserQuestion.CodeName AS UserQuestionCodeName
		  , NULL AS HAQuestionDocumentID

			--WDM 10.1.2014 - this is GOING AWAY 		--WDM 10.02.2014 place holder for EDW ETL

		  , NULL AS HAQuestionVersionID

			--WDM 10.1.2014 - this is GOING AWAY - no versions across environments 		--WDM 10.02.2014 place holder for EDW ETL

		  , HAUserQuestion.HAQuestionNodeGUID

			--WDM 10.01.2014	Left this in place to preserve column structure.		

		  , HAUserAnswers.ItemID AS UserAnswerItemID
		  , HAUserAnswers.HAAnswerNodeGUID

			--WDM 8/7/2014 as HAAnswerDocumentID

		  , NULL AS HAAnswerVersionID

			--WDM 10.1.2014 - this is GOING AWAY - no versions across environments		--WDM 10.02.2014 place holder for EDW ETL

		  , HAUserAnswers.CodeName AS UserAnswerCodeName
		  , HAUserAnswers.HAAnswerValue
		  , HAUserModule.HAModuleScore
		  , HARiskCategory.HARiskCategoryScore
		  , HAUserRiskArea.HARiskAreaScore
		  , HAUserQuestion.HAQuestionScore
		  , HAUserAnswers.HAAnswerPoints
		  , HAUserQuestionGroupResults.PointResults
		  , HAUserAnswers.UOMCode
		  , HAUserStarted.HAScore
		  , HAUserModule.PreWeightedScore AS ModulePreWeightedScore
		  , HARiskCategory.PreWeightedScore AS RiskCategoryPreWeightedScore
		  , HAUserRiskArea.PreWeightedScore AS RiskAreaPreWeightedScore
		  , HAUserQuestion.PreWeightedScore AS QuestionPreWeightedScore
		  , HAUserQuestionGroupResults.CodeName AS QuestionGroupCodeName
		  , CASE
				WHEN HAUserAnswers.ItemCreatedWhen = HAUserAnswers.ItemModifiedWhen
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HAUserAnswers.ItemCreatedWhen
		  , HAUserAnswers.ItemModifiedWhen
		  , HAUserQuestion.IsProfessionallyCollected
		  , HARiskCategory.ItemModifiedWhen AS HARiskCategory_ItemModifiedWhen
		  , HAUserRiskArea.ItemModifiedWhen AS HAUserRiskArea_ItemModifiedWhen
		  , HAUserQuestion.ItemModifiedWhen AS HAUserQuestion_ItemModifiedWhen
		  , HAUserAnswers.ItemModifiedWhen AS HAUserAnswers_ItemModifiedWhen
		  , HAUserStarted.HAPaperFlg
		  , HAUserStarted.HATelephonicFlg
		  , HAUserStarted.HAStartedMode

			--12.11.2014 WDM Sowmiya and dale talked and decided to implement this column 12.17.2014 - Added 

		  , HAUserStarted.HACompletedMode

			--12.11.2014 WDM Sowmiya and dale talked and decided to implement this column 12.17.2014 - Added 

		  , VHCJ.DocumentCulture AS DocumentCulture_VHCJ
		  , HAQuestionsView.DocumentCulture AS DocumentCulture_HAQuestionsView
		  , HAUserStarted.HACampaignNodeGUID AS CampaignNodeGUID

	 -- PER John C. 2.6.2015 - Please comment out all columns except the GUID in the Assesment view.  It will reduce the amount of data coming through the delta process.  Thank you
	 --, [VHCJ].BiometricCampaignStartDate
	 --, [VHCJ].BiometricCampaignEndDate
	 --, [VHCJ].CampaignStartDate
	 --, [VHCJ].CampaignEndDate
	 --, [VHCJ].Name as CampaignName 
	 --, [VHCJ].HACampaignID

/****************************************
--the below are need in this view 
, HACampaign.BiometricCampaignStartDate
, HACampaign.BiometricCampaignEndDate
, HACampaign.CampaignStartDate
, HACampaign.CampaignEndDate
, HACampaign.Name

or only the 
select * from HAUserStarted
, HACampaign.NodeGuid as CampaignNodeGuid
****************************************/

	   FROM dbo.HFit_HealthAssesmentUserStarted AS HAUserStarted
				INNER JOIN dbo.CMS_User AS CMSUser
					ON HAUserStarted.UserID = CMSUser.UserID
				INNER JOIN dbo.CMS_UserSettings AS UserSettings
					ON UserSettings.UserSettingsUserID = CMSUser.UserID
				   AND HFitUserMpiNumber >= 0
				   AND HFitUserMpiNumber IS NOT NULL

	 -- (WDM) CR47516 

				INNER JOIN dbo.CMS_UserSite AS UserSite
					ON CMSUser.UserID = UserSite.UserID
				INNER JOIN dbo.CMS_Site AS CMSSite
					ON UserSite.SiteID = CMSSite.SiteID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON ACCT.SiteID = CMSSite.SiteID
				INNER JOIN dbo.HFit_HealthAssesmentUserModule AS HAUserModule
					ON HAUserStarted.ItemID = HAUserModule.HAStartedItemID
				INNER JOIN View_HFit_HACampaign_Joined AS VHCJ
					ON VHCJ.NodeGUID = HAUserStarted.HACampaignNodeGUID
				   AND VHCJ.NodeSiteID = UserSite.SiteID
				   AND VHCJ.DocumentCulture = 'en-US'

	 --11.05.2014 - Mark T. / Dale M. - 

				INNER JOIN View_HFit_HealthAssessment_Joined AS VHAJ
					ON VHAJ.DocumentID = VHCJ.HealthAssessmentID
				INNER JOIN dbo.HFit_HealthAssesmentUserRiskCategory AS HARiskCategory
					ON HAUserModule.ItemID = HARiskCategory.HAModuleItemID
				INNER JOIN dbo.HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea
					ON HARiskCategory.ItemID = HAUserRiskArea.HARiskCategoryItemID
				INNER JOIN dbo.HFit_HealthAssesmentUserQuestion AS HAUserQuestion
					ON HAUserRiskArea.ItemID = HAUserQuestion.HARiskAreaItemID
				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS HAQuestionsView
					ON HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID
				   AND HAQuestionsView.DocumentCulture = 'en-US'
				LEFT OUTER JOIN dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults
					ON HAUserRiskArea.ItemID = HAUserQuestionGroupResults.HARiskAreaItemID
				INNER JOIN dbo.HFit_HealthAssesmentUserAnswers AS HAUserAnswers
					ON HAUserQuestion.ItemID = HAUserAnswers.HAQuestionItemID

	   --left outer join View_HFit_HACampaign_Joined as VCJ 
	   --on VCJ.NodeGuid = [HAUserStarted].[HACampaignNodeGUID]

	   WHERE UserSettings.HFitUserMpiNumber NOT IN (
													SELECT
														   RejectMPICode
													  FROM HFit_LKP_EDW_RejectMPI) ;

--CMSUser.UserGUID not in  (Select RejectUserGUID from HFit_LKP_EDW_RejectMPI)	--61788DF7-955D-4A78-B77E-3DA340847AE7

GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Alter View [dbo].[view_EDW_HealthAssesmentDeffinition]

PRINT 'Alter View [dbo].[view_EDW_HealthAssesmentDeffinition]';
GO
ALTER VIEW dbo.view_EDW_HealthAssesmentDeffinition
AS
	 SELECT DISTINCT

	 --**************************************************************************************************************
	 --NOTE: The column DocumentModifiedWhen comes from the CMS_TREE join - it was left 
	 --		unchanged when other dates added for the Last Mod Date additions. 
	 --		Therefore, the 'ChangeType' was left dependent upon this date only. 09.12.2014 (wdm)
	 --*****************************************************************************************************************************************************
	 --Test Queries:
	 --select * from view_EDW_HealthAssesmentDeffinition where AnsDocumentGuid is not NULL
	 --Changes:
	 --WDM - 6/25/2014
	 --Query was returning a NULL dataset. Found that it is being caused by the AccountCD join.
	 --Worked with Shane to discover the CMS Tree had been modified.
	 --Modified the code so that reads it reads the CMS tree correctly - working.
	 --7/14/2014 1:29 time to run - 79024 rows - DEV
	 --7/14/2014 0:58 time to run - 57472 rows - PROD1
	 --7/15/2014 - Query was returning NodeName of 'Campaigns' only
	 --	Found the issue in view View_HFit_HACampaign_Joined. Documented the change in the view.
	 --7/16/2014 - Full Select: Using a DocumentModifiedWhen filter 00:17:28 - Record Cnt: 793,520
	 --8/7/2014 - Executed in DEV with GUID changes and returned 1.13M Rows in 23:14.
	 --8/8/2014 - Executed in DEV with GUID changes, new views, and returned 1.13M Rows in 20:16.
	 --8/8/2014 - Generated corrected view in DEV
	 --8/12/2014 - John C. explained that Account Code and Site Guid are not needed, NULLED
	 --				them out. With them in the QRY, returned 43104 rows, with them nulled
	 --				out, returned 43104 rows. Using a DISTINCT, 28736 rows returned and execution
	 --				time doubled approximately.
	 --				Has to add a DISTINCT to all the queries - .
	 --				Original Query 0:25 @ 43104
	 --				Original Query 0:46 @ 28736 (distinct)
	 --				Filter added - VHFHAQ.DocumentCulture 0:22 @ 14368
	 --				Filter added - and VHFHARCJ.DocumentCulture = 'en-us'	 0:06 @ 3568
	 --				Filter added - and VHFHARAJ.DocumentCulture = 'en-us'	 0:03 @ 1784
	 --8/12/2014 - Applied the language filters with John C. and performance improved, as expected,
	 --				such that when running the view in QA: 
	 --8/12/2014 - select * from [view_EDW_HealthAssesmentDeffinition] where DocumentModifiedWhen between '2000-11-14' and 
	 --				'2014-11-15' now runs exceptionally fast
	 --08/12/2014 - ProdStaging 00:21:52 @ 2442
	 --08/12/2014 - ProdStaging 00:21:09 @ 13272 (UNION ALL   --UNION)
	 --08/12/2014 - ProdStaging 00:21:37 @ 13272 (UNION ONLY)
	 --08/12/2014 - ProdStaging 00:06:26 @ 1582 (UNION ONLY & Select Filters Added for Culture)
	 --08/12/2014 - ProdStaging 00:10:07 @ 6636 (UNION ALL   --UNION) and all selected
	 --08/12/2014 - ProdStaging added PI PI_View_CMS_Tree_Joined_Regular_DocumentCulture: 00:2:34 @ 6636 
	 --08/12/2014 - DEV 00:00:58 @ 3792
	 --09.11.2014 - (wdm) added the needed date fields to help EDW in determining the last mod date of a row.
	 --10.01.2014 - Dale and Mark reworked this view to use NodeGUIDS and eliminated the CMS_TREE View from participating as 
	 --				well as Site and Account data
	 --11.25.2014 - (wdm) added multi-select column capability. The values can be 0,1, NULL
	 --12.29.2014 - (wdm) Added HTML stripping to two columns #47619, the others mentioned already had stripping applied
	 --12.31.2014 - (wdm) Started the review to apply CR-47517: Eliminate Matrix Questions with NULL Answer GUID's
	 --01.07.2014 - (wdm) 47619 The Health Assessment Definition interface view contains HTML tags - corrected with udf_StripHTML
	 --************************************************************************************************************************************************************

			NULL AS SiteGUID

			--cs.SiteGUID								--WDM 08.12.2014 per John C.

   , NULL AS AccountCD

			--, HFA.AccountCD						--WDM 08.07.2014 per John C.

   , HA.NodeID AS HANodeID

			--WDM 08.07.2014

   , HA.NodeName AS HANodeName

			--WDM 08.07.2014
			--, HA.DocumentID AS HADocumentID								--WDM 08.07.2014 commented out and left in place for history

   , NULL AS HADocumentID

			--WDM 08.07.2014; 09.29.2014: Mark and Dale discussed that NODEGUID should be used such that the multi-language/culture is not a problem.

   , HA.NodeSiteID AS HANodeSiteID

			--WDM 08.07.2014

   , HA.DocumentPublishedVersionHistoryID AS HADocPubVerID

			--WDM 08.07.2014

   , dbo.udf_StripHTML (VHFHAMJ.Title) AS ModTitle

			--WDM 47619

   , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText

			--WDM 47619

   , VHFHAMJ.NodeGuid AS ModDocGuid

			--, VHFHAMJ.DocumentID AS ModDocID	--WDM 08.07.2014	M&D 10.01.2014

   , VHFHAMJ.Weight AS ModWeight
   , VHFHAMJ.IsEnabled AS ModIsEnabled
   , VHFHAMJ.CodeName AS ModCodeName
   , VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
   , dbo.udf_StripHTML (VHFHARCJ.Title) AS RCTitle

			--WDM 47619

   , VHFHARCJ.Weight AS RCWeight
   , VHFHARCJ.NodeGuid AS RCDocumentGUID

			--, VHFHARCJ.DocumentID AS RCDocumentID	--WDM 08.07.2014	M&D 10.01.2014

   , VHFHARCJ.IsEnabled AS RCIsEnabled
   , VHFHARCJ.CodeName AS RCCodeName
   , VHFHARCJ.DocumentPublishedVersionHistoryID AS RCDocPubVerID
   , dbo.udf_StripHTML (VHFHARAJ.Title) AS RATytle

			--WDM 47619

   , VHFHARAJ.Weight AS RAWeight
   , VHFHARAJ.NodeGuid AS RADocumentGuid

			--, VHFHARAJ.DocumentID AS RADocumentID	--WDM 08.07.2014	M&D 10.01.2014

   , VHFHARAJ.IsEnabled AS RAIsEnabled
   , VHFHARAJ.CodeName AS RACodeName
   , VHFHARAJ.ScoringStrategyID AS RAScoringStrategyID
   , VHFHARAJ.DocumentPublishedVersionHistoryID AS RADocPubVerID
   , VHFHAQ.QuestionType
   , dbo.udf_StripHTML (LEFT (VHFHAQ.Title, 4000)) AS QuesTitle

			--WDM 47619

   , VHFHAQ.Weight AS QuesWeight
   , VHFHAQ.IsRequired AS QuesIsRequired

			--, VHFHAQ.DocumentGuid AS QuesDocumentGuid	--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014	M&D 10.01.2014

   , VHFHAQ.NodeGuid AS QuesDocumentGuid

			--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014

   , VHFHAQ.IsEnabled AS QuesIsEnabled
   , LEFT (VHFHAQ.IsVisible, 4000) AS QuesIsVisible
   , VHFHAQ.IsStaging AS QuesIsSTaging
   , VHFHAQ.CodeName AS QuestionCodeName
   , VHFHAQ.DocumentPublishedVersionHistoryID AS QuesDocPubVerID
   , VHFHAA.Value AS AnsValue
   , VHFHAA.Points AS AnsPoints
   , VHFHAA.NodeGuid AS AnsDocumentGuid

			--ref: #47517

   , VHFHAA.IsEnabled AS AnsIsEnabled
   , VHFHAA.CodeName AS AnsCodeName
   , VHFHAA.UOM AS AnsUOM
   , VHFHAA.DocumentPublishedVersionHistoryID AS AnsDocPUbVerID
   , CASE
		 WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
		 THEN 'I'
		 ELSE 'U'
	 END AS ChangeType
   , HA.DocumentCreatedWhen
   , HA.DocumentModifiedWhen
   , HA.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014 ADDED TO the returned Columns

   , HA.NodeGUID AS HANodeGUID

			--, NULL as SiteLastModified

   , NULL AS SiteLastModified

			--, NULL as Account_ItemModifiedWhen

   , NULL AS Account_ItemModifiedWhen

			--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen

   , NULL AS Campaign_DocumentModifiedWhen
   , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
   , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
   , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
   , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
   , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
   , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
   , HAMCQ.AllowMultiSelect
   , 'SID01' AS LocID
	   FROM

	 --dbo.View_CMS_Tree_Joined AS VCTJ
	 --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	 --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
	 --Campaign links Client which links to Assessment
	 --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

	 View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
		 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
			 ON HA.NodeID = VHFHAMJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
			 ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
			 ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
			 ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
			 ON VHFHAQ.NodeID = VHFHAA.NodeParentID
		 LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
			 ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
	   WHERE VHFHAQ.DocumentCulture = 'en-us'

			 --WDM 08.12.2014	

		 AND (VHFHAA.DocumentCulture = 'en-us'
		   OR VHFHAA.DocumentCulture IS NULL) 

			 --WDM 08.12.2014		

		 AND VHFHARCJ.DocumentCulture = 'en-us'

			 --WDM 08.12.2014		

		 AND VHFHARAJ.DocumentCulture = 'en-us'

			 --WDM 08.12.2014		

		 AND VHFHAMJ.DocumentCulture = 'en-us'

			 --WDM 08.12.2014	

		 AND HA.DocumentCulture = 'en-us'

			 --WDM 08.12.2014	

		 AND VHFHAA.NodeGuid IS NOT NULL

	 --ref: #47517

	 UNION ALL

	 --UNION
	 --WDM Retrieve Matrix Level 1 Question Group

	 SELECT DISTINCT
			NULL AS SiteGUID

			--cs.SiteGUID		--WDM 08.12.2014

		  , NULL AS AccountCD

			--, HFA.AccountCD												--WDM 08.07.2014

		  , HA.NodeID

			--WDM 08.07.2014

		  , HA.NodeName

			--WDM 08.07.2014

		  , NULL AS HADocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID

			--WDM 08.07.2014
			--,VCTJ.NodeAliasPath

		  , HA.DocumentPublishedVersionHistoryID

			--WDM 08.07.2014

		  , dbo.udf_StripHTML (VHFHAMJ.Title) 

			--WDM 47619

		  , dbo.udf_StripHTML (LEFT (LEFT (VHFHAMJ.IntroText, 4000) , 4000)) AS IntroText

			--WDM 47619

		  , VHFHAMJ.NodeGuid
		  , VHFHAMJ.Weight
		  , VHFHAMJ.IsEnabled
		  , VHFHAMJ.CodeName

			--,VHFHAMJ.NodeAliasPath

		  , VHFHAMJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARCJ.Title) 

			--WDM 47619

		  , VHFHARCJ.Weight
		  , VHFHARCJ.NodeGuid
		  , VHFHARCJ.IsEnabled
		  , VHFHARCJ.CodeName

			--,VHFHARCJ.NodeAliasPath

		  , VHFHARCJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARAJ.Title) 

			--WDM 47619

		  , VHFHARAJ.Weight
		  , VHFHARAJ.NodeGuid
		  , VHFHARAJ.IsEnabled
		  , VHFHARAJ.CodeName

			--,VHFHARAJ.NodeAliasPath

		  , VHFHARAJ.ScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID
		  , VHFHAQ2.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ2.Title, 4000)) AS QuesTitle

			--WDM 47619

		  , VHFHAQ2.Weight
		  , VHFHAQ2.IsRequired
		  , VHFHAQ2.NodeGuid
		  , VHFHAQ2.IsEnabled
		  , LEFT (VHFHAQ2.IsVisible, 4000) 
		  , VHFHAQ2.IsStaging
		  , VHFHAQ2.CodeName AS QuestionCodeName

			--,VHFHAQ2.NodeAliasPath

		  , VHFHAQ2.DocumentPublishedVersionHistoryID
		  , VHFHAA2.Value
		  , VHFHAA2.Points
		  , VHFHAA2.NodeGuid

			--ref: #47517

		  , VHFHAA2.IsEnabled
		  , VHFHAA2.CodeName
		  , VHFHAA2.UOM

			--,VHFHAA2.NodeAliasPath

		  , VHFHAA2.DocumentPublishedVersionHistoryID
		  , CASE
				WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HA.DocumentCreatedWhen
		  , HA.DocumentModifiedWhen
		  , HA.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014

		  , HA.NodeGUID AS HANodeGUID
		  , NULL AS SiteLastModified
		  , NULL AS Account_ItemModifiedWhen

			--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen

		  , NULL AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
		  , HAMCQ.AllowMultiSelect
		  , 'SID02' AS LocID
	   FROM

	 --dbo.View_CMS_Tree_Joined AS VCTJ
	 --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	 --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
	 --Campaign links Client which links to Assessment
	 --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

	 View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
		 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
			 ON HA.NodeID = VHFHAMJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
			 ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
			 ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
			 ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
			 ON VHFHAQ.NodeID = VHFHAA.NodeParentID

	 --matrix level 1 questiongroup

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2
			 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2
			 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
		 LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
			 ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
	   WHERE VHFHAQ.DocumentCulture = 'en-us'
		 AND (VHFHAA.DocumentCulture = 'en-us'
		   OR VHFHAA.DocumentCulture IS NULL) 

			 --WDM 08.12.2014		

		 AND VHFHARCJ.DocumentCulture = 'en-us'
		 AND VHFHARAJ.DocumentCulture = 'en-us'
		 AND VHFHAMJ.DocumentCulture = 'en-us'

			 --WDM 08.12.2014	

		 AND HA.DocumentCulture = 'en-us'

			 --WDM 08.12.2014		

		 AND VHFHAA2.NodeGuid IS NOT NULL

	 --ref: #47517

	 UNION ALL

	 --UNION
	 --WDM Retrieve Branching Level 1 Question and Matrix Level 1 Question Group

	 SELECT DISTINCT
			NULL AS SiteGUID

			--cs.SiteGUID		--WDM 08.12.2014

		  , NULL AS AccountCD

			--, HFA.AccountCD												--WDM 08.07.2014

		  , HA.NodeID

			--WDM 08.07.2014

		  , HA.NodeName

			--WDM 08.07.2014

		  , NULL AS HADocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID

			--WDM 08.07.2014
			--,VCTJ.NodeAliasPath

		  , HA.DocumentPublishedVersionHistoryID

			--WDM 08.07.2014

		  , dbo.udf_StripHTML (VHFHAMJ.Title) 
		  , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
		  , VHFHAMJ.NodeGuid
		  , VHFHAMJ.Weight
		  , VHFHAMJ.IsEnabled
		  , VHFHAMJ.CodeName

			--,VHFHAMJ.NodeAliasPath

		  , VHFHAMJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARCJ.Title) 
		  , VHFHARCJ.Weight
		  , VHFHARCJ.NodeGuid
		  , VHFHARCJ.IsEnabled
		  , VHFHARCJ.CodeName

			--,VHFHARCJ.NodeAliasPath

		  , VHFHARCJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARAJ.Title) 
		  , VHFHARAJ.Weight
		  , VHFHARAJ.NodeGuid
		  , VHFHARAJ.IsEnabled
		  , VHFHARAJ.CodeName

			--,VHFHARAJ.NodeAliasPath

		  , VHFHARAJ.ScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID
		  , VHFHAQ3.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ3.Title, 4000)) AS QuesTitle
		  , VHFHAQ3.Weight
		  , VHFHAQ3.IsRequired
		  , VHFHAQ3.NodeGuid
		  , VHFHAQ3.IsEnabled
		  , LEFT (VHFHAQ3.IsVisible, 4000) 
		  , VHFHAQ3.IsStaging
		  , VHFHAQ3.CodeName AS QuestionCodeName

			--,VHFHAQ3.NodeAliasPath

		  , VHFHAQ3.DocumentPublishedVersionHistoryID
		  , VHFHAA3.Value
		  , VHFHAA3.Points
		  , VHFHAA3.NodeGuid

			--ref: #47517

		  , VHFHAA3.IsEnabled
		  , VHFHAA3.CodeName
		  , VHFHAA3.UOM

			--,VHFHAA3.NodeAliasPath

		  , VHFHAA3.DocumentPublishedVersionHistoryID
		  , CASE
				WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HA.DocumentCreatedWhen
		  , HA.DocumentModifiedWhen
		  , HA.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014

		  , HA.NodeGUID AS HANodeGUID
		  , NULL AS SiteLastModified
		  , NULL AS Account_ItemModifiedWhen

			--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen

		  , NULL AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
		  , HAMCQ.AllowMultiSelect
		  , 'SID03' AS LocID
	   FROM

	 --dbo.View_CMS_Tree_Joined AS VCTJ
	 --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	 --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
	 --Campaign links Client which links to Assessment
	 --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

	 View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
		 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
			 ON HA.NodeID = VHFHAMJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
			 ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
			 ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
			 ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
			 ON VHFHAQ.NodeID = VHFHAA.NodeParentID

	 --matrix level 1 questiongroup
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	 --Branching Level 1 Question 

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
			 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
			 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
		 LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
			 ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
	   WHERE VHFHAQ.DocumentCulture = 'en-us'
		 AND (VHFHAA.DocumentCulture = 'en-us'
		   OR VHFHAA.DocumentCulture IS NULL) 

			 --WDM 08.12.2014		

		 AND VHFHARCJ.DocumentCulture = 'en-us'
		 AND VHFHARAJ.DocumentCulture = 'en-us'
		 AND VHFHAMJ.DocumentCulture = 'en-us'

			 --WDM 08.12.2014	

		 AND HA.DocumentCulture = 'en-us'

			 --WDM 08.12.2014		

		 AND VHFHAA3.NodeGuid IS NOT NULL

	 --ref: #47517

	 UNION ALL

	 --UNION
	 --WDM Retrieve Branching Level 1 Question and Matrix Level 2 Question Group

	 SELECT DISTINCT
			NULL AS SiteGUID

			--cs.SiteGUID		--WDM 08.12.2014

		  , NULL AS AccountCD

			--, HFA.AccountCD												--WDM 08.07.2014

		  , HA.NodeID

			--WDM 08.07.2014

		  , HA.NodeName

			--WDM 08.07.2014

		  , NULL AS HADocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID

			--WDM 08.07.2014
			--,VCTJ.NodeAliasPath

		  , HA.DocumentPublishedVersionHistoryID

			--WDM 08.07.2014

		  , dbo.udf_StripHTML (VHFHAMJ.Title) 
		  , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
		  , VHFHAMJ.NodeGuid
		  , VHFHAMJ.Weight
		  , VHFHAMJ.IsEnabled
		  , VHFHAMJ.CodeName

			--,VHFHAMJ.NodeAliasPath

		  , VHFHAMJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARCJ.Title) 
		  , VHFHARCJ.Weight
		  , VHFHARCJ.NodeGuid
		  , VHFHARCJ.IsEnabled
		  , VHFHARCJ.CodeName

			--,VHFHARCJ.NodeAliasPath

		  , VHFHARCJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARAJ.Title) 
		  , VHFHARAJ.Weight
		  , VHFHARAJ.NodeGuid
		  , VHFHARAJ.IsEnabled
		  , VHFHARAJ.CodeName

			--,VHFHARAJ.NodeAliasPath

		  , VHFHARAJ.ScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID
		  , VHFHAQ7.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ7.Title, 4000)) AS QuesTitle
		  , VHFHAQ7.Weight
		  , VHFHAQ7.IsRequired
		  , VHFHAQ7.NodeGuid
		  , VHFHAQ7.IsEnabled
		  , LEFT (VHFHAQ7.IsVisible, 4000) 
		  , VHFHAQ7.IsStaging
		  , VHFHAQ7.CodeName AS QuestionCodeName

			--,VHFHAQ7.NodeAliasPath

		  , VHFHAQ7.DocumentPublishedVersionHistoryID
		  , VHFHAA7.Value
		  , VHFHAA7.Points
		  , VHFHAA7.NodeGuid

			--ref: #47517

		  , VHFHAA7.IsEnabled
		  , VHFHAA7.CodeName
		  , VHFHAA7.UOM

			--,VHFHAA7.NodeAliasPath

		  , VHFHAA7.DocumentPublishedVersionHistoryID
		  , CASE
				WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HA.DocumentCreatedWhen
		  , HA.DocumentModifiedWhen
		  , HA.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014

		  , HA.NodeGUID AS HANodeGUID
		  , NULL AS SiteLastModified
		  , NULL AS Account_ItemModifiedWhen

			--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen

		  , NULL AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
		  , HAMCQ.AllowMultiSelect
		  , 'SID04' AS LocID
	   FROM

	 --dbo.View_CMS_Tree_Joined AS VCTJ
	 --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	 --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
	 --Campaign links Client which links to Assessment
	 --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

	 View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
		 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
			 ON HA.NodeID = VHFHAMJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
			 ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
			 ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
			 ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
			 ON VHFHAQ.NodeID = VHFHAA.NodeParentID

	 --matrix level 1 questiongroup
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	 --Branching Level 1 Question 

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
			 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID

	 --LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
	 --Matrix Level 2 Question Group

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7
			 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7
			 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
		 LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
			 ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
	   WHERE VHFHAQ.DocumentCulture = 'en-us'
		 AND (VHFHAA.DocumentCulture = 'en-us'
		   OR VHFHAA.DocumentCulture IS NULL) 

			 --WDM 08.12.2014		

		 AND VHFHARCJ.DocumentCulture = 'en-us'
		 AND VHFHARAJ.DocumentCulture = 'en-us'
		 AND VHFHAMJ.DocumentCulture = 'en-us'

			 --WDM 08.12.2014	

		 AND HA.DocumentCulture = 'en-us'

			 --WDM 08.12.2014		

		 AND VHFHAA7.NodeGuid IS NOT NULL

	 --ref: #47517

	 UNION ALL

	 --UNION
	 --****************************************************
	 --WDM 6/25/2014 Retrieve the Branching level 1 Question Group
	 --THE PROBLEM LIES HERE in this part of query : 1:40 minute
	 -- Added two perf indexes to the first query: 25 Sec
	 --****************************************************

	 SELECT DISTINCT
			NULL AS SiteGUID

			--cs.SiteGUID		--WDM 08.12.2014

		  , NULL AS AccountCD

			--, HFA.AccountCD												--WDM 08.07.2014

		  , HA.NodeID

			--WDM 08.07.2014

		  , HA.NodeName

			--WDM 08.07.2014

		  , NULL AS HADocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID

			--WDM 08.07.2014
			--,VCTJ.NodeAliasPath

		  , HA.DocumentPublishedVersionHistoryID

			--WDM 08.07.2014

		  , dbo.udf_StripHTML (VHFHAMJ.Title) 
		  , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
		  , VHFHAMJ.NodeGuid
		  , VHFHAMJ.Weight
		  , VHFHAMJ.IsEnabled
		  , VHFHAMJ.CodeName

			--,VHFHAMJ.NodeAliasPath

		  , VHFHAMJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARCJ.Title) 
		  , VHFHARCJ.Weight
		  , VHFHARCJ.NodeGuid
		  , VHFHARCJ.IsEnabled
		  , VHFHARCJ.CodeName

			--,VHFHARCJ.NodeAliasPath

		  , VHFHARCJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARAJ.Title) 
		  , VHFHARAJ.Weight
		  , VHFHARAJ.NodeGuid
		  , VHFHARAJ.IsEnabled
		  , VHFHARAJ.CodeName

			--,VHFHARAJ.NodeAliasPath

		  , VHFHARAJ.ScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID
		  , VHFHAQ8.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ8.Title, 4000)) AS QuesTitle
		  , VHFHAQ8.Weight
		  , VHFHAQ8.IsRequired
		  , VHFHAQ8.NodeGuid
		  , VHFHAQ8.IsEnabled
		  , LEFT (VHFHAQ8.IsVisible, 4000) 
		  , VHFHAQ8.IsStaging
		  , VHFHAQ8.CodeName AS QuestionCodeName

			--,VHFHAQ8.NodeAliasPath

		  , VHFHAQ8.DocumentPublishedVersionHistoryID
		  , VHFHAA8.Value
		  , VHFHAA8.Points
		  , VHFHAA8.NodeGuid

			--ref: #47517

		  , VHFHAA8.IsEnabled
		  , VHFHAA8.CodeName
		  , VHFHAA8.UOM

			--,VHFHAA8.NodeAliasPath

		  , VHFHAA8.DocumentPublishedVersionHistoryID
		  , CASE
				WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HA.DocumentCreatedWhen
		  , HA.DocumentModifiedWhen
		  , HA.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014

		  , HA.NodeGUID AS HANodeGUID
		  , NULL AS SiteLastModified
		  , NULL AS Account_ItemModifiedWhen

			--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen

		  , NULL AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
		  , HAMCQ.AllowMultiSelect
		  , 'SID05' AS LocID
	   FROM

	 --dbo.View_CMS_Tree_Joined AS VCTJ
	 --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	 --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
	 --Campaign links Client which links to Assessment
	 --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

	 View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
		 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
			 ON HA.NodeID = VHFHAMJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
			 ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
			 ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
			 ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
			 ON VHFHAQ.NodeID = VHFHAA.NodeParentID

	 --matrix level 1 questiongroup
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	 --Branching Level 1 Question 

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
			 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID

	 --LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
	 --Matrix Level 2 Question Group

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7
			 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7
			 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

	 --Matrix branching level 1 question group

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8
			 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8
			 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
		 LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
			 ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
	   WHERE VHFHAQ.DocumentCulture = 'en-us'
		 AND (VHFHAA.DocumentCulture = 'en-us'
		   OR VHFHAA.DocumentCulture IS NULL) 

			 --WDM 08.12.2014		

		 AND VHFHARCJ.DocumentCulture = 'en-us'
		 AND VHFHARAJ.DocumentCulture = 'en-us'
		 AND VHFHAMJ.DocumentCulture = 'en-us'

			 --WDM 08.12.2014	

		 AND HA.DocumentCulture = 'en-us'

			 --WDM 08.12.2014		

		 AND VHFHAA8.NodeGuid IS NOT NULL

	 --ref: #47517

	 UNION ALL

	 --UNION
	 --****************************************************
	 --WDM 6/25/2014 Retrieve the Branching level 2 Question Group
	 --THE PROBLEM LIES HERE in this part of query : 1:48  minutes
	 --With the new indexes: 29 Secs
	 --****************************************************

	 SELECT DISTINCT
			NULL AS SiteGUID

			--cs.SiteGUID		--WDM 08.12.2014

		  , NULL AS AccountCD

			--, HFA.AccountCD												--WDM 08.07.2014

		  , HA.NodeID

			--WDM 08.07.2014

		  , HA.NodeName

			--WDM 08.07.2014

		  , NULL AS HADocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID

			--WDM 08.07.2014
			--,VCTJ.NodeAliasPath

		  , HA.DocumentPublishedVersionHistoryID

			--WDM 08.07.2014

		  , dbo.udf_StripHTML (VHFHAMJ.Title) 
		  , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
		  , VHFHAMJ.NodeGuid
		  , VHFHAMJ.Weight
		  , VHFHAMJ.IsEnabled
		  , VHFHAMJ.CodeName

			--,VHFHAMJ.NodeAliasPath

		  , VHFHAMJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARCJ.Title) 
		  , VHFHARCJ.Weight
		  , VHFHARCJ.NodeGuid
		  , VHFHARCJ.IsEnabled
		  , VHFHARCJ.CodeName

			--,VHFHARCJ.NodeAliasPath

		  , VHFHARCJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARAJ.Title) 
		  , VHFHARAJ.Weight
		  , VHFHARAJ.NodeGuid
		  , VHFHARAJ.IsEnabled
		  , VHFHARAJ.CodeName

			--,VHFHARAJ.NodeAliasPath

		  , VHFHARAJ.ScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID
		  , VHFHAQ4.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ4.Title, 4000)) AS QuesTitle
		  , VHFHAQ4.Weight
		  , VHFHAQ4.IsRequired
		  , VHFHAQ4.NodeGuid
		  , VHFHAQ4.IsEnabled
		  , LEFT (VHFHAQ4.IsVisible, 4000) 
		  , VHFHAQ4.IsStaging
		  , VHFHAQ4.CodeName AS QuestionCodeName

			--,VHFHAQ4.NodeAliasPath

		  , VHFHAQ4.DocumentPublishedVersionHistoryID
		  , VHFHAA4.Value
		  , VHFHAA4.Points
		  , VHFHAA4.NodeGuid

			--ref: #47517

		  , VHFHAA4.IsEnabled
		  , VHFHAA4.CodeName
		  , VHFHAA4.UOM

			--,VHFHAA4.NodeAliasPath

		  , VHFHAA4.DocumentPublishedVersionHistoryID
		  , CASE
				WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HA.DocumentCreatedWhen
		  , HA.DocumentModifiedWhen
		  , HA.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014

		  , HA.NodeGUID AS HANodeGUID
		  , NULL AS SiteLastModified
		  , NULL AS Account_ItemModifiedWhen

			--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen

		  , NULL AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
		  , HAMCQ.AllowMultiSelect
		  , 'SID06' AS LocID
	   FROM

	 --dbo.View_CMS_Tree_Joined AS VCTJ
	 --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	 --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
	 --Campaign links Client which links to Assessment
	 --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

	 View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
		 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
			 ON HA.NodeID = VHFHAMJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
			 ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
			 ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
			 ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
			 ON VHFHAQ.NodeID = VHFHAA.NodeParentID

	 --matrix level 1 questiongroup
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	 --Branching Level 1 Question 

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
			 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
			 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

	 --Matrix Level 2 Question Group
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
	 --Matrix branching level 1 question group
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
	 --Branching level 2 Question Group

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4
			 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
			 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID
		 LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
			 ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
	   WHERE VHFHAQ.DocumentCulture = 'en-us'
		 AND (VHFHAA.DocumentCulture = 'en-us'
		   OR VHFHAA.DocumentCulture IS NULL) 

			 --WDM 08.12.2014		

		 AND VHFHARCJ.DocumentCulture = 'en-us'
		 AND VHFHARAJ.DocumentCulture = 'en-us'
		 AND VHFHAMJ.DocumentCulture = 'en-us'

			 --WDM 08.12.2014	

		 AND HA.DocumentCulture = 'en-us'

			 --WDM 08.12.2014		

		 AND VHFHAA4.NodeGuid IS NOT NULL

	 --ref: #47517

	 UNION ALL

	 --UNION
	 --WDM 6/25/2014 Retrieve the Branching level 3 Question Group

	 SELECT DISTINCT
			NULL AS SiteGUID

			--cs.SiteGUID		--WDM 08.12.2014

		  , NULL AS AccountCD

			--, HFA.AccountCD												--WDM 08.07.2014

		  , HA.NodeID

			--WDM 08.07.2014

		  , HA.NodeName

			--WDM 08.07.2014

		  , NULL AS HADocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID

			--WDM 08.07.2014
			--,VCTJ.NodeAliasPath

		  , HA.DocumentPublishedVersionHistoryID

			--WDM 08.07.2014

		  , dbo.udf_StripHTML (VHFHAMJ.Title) 
		  , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
		  , VHFHAMJ.NodeGuid
		  , VHFHAMJ.Weight
		  , VHFHAMJ.IsEnabled
		  , VHFHAMJ.CodeName

			--,VHFHAMJ.NodeAliasPath

		  , VHFHAMJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARCJ.Title) 
		  , VHFHARCJ.Weight
		  , VHFHARCJ.NodeGuid
		  , VHFHARCJ.IsEnabled
		  , VHFHARCJ.CodeName

			--,VHFHARCJ.NodeAliasPath

		  , VHFHARCJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARAJ.Title) 
		  , VHFHARAJ.Weight
		  , VHFHARAJ.NodeGuid
		  , VHFHARAJ.IsEnabled
		  , VHFHARAJ.CodeName

			--,VHFHARAJ.NodeAliasPath

		  , VHFHARAJ.ScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID
		  , VHFHAQ5.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ5.Title, 4000)) AS QuesTitle
		  , VHFHAQ5.Weight
		  , VHFHAQ5.IsRequired
		  , VHFHAQ5.NodeGuid
		  , VHFHAQ5.IsEnabled
		  , LEFT (VHFHAQ5.IsVisible, 4000) 
		  , VHFHAQ5.IsStaging
		  , VHFHAQ5.CodeName AS QuestionCodeName

			--,VHFHAQ5.NodeAliasPath

		  , VHFHAQ5.DocumentPublishedVersionHistoryID
		  , VHFHAA5.Value
		  , VHFHAA5.Points
		  , VHFHAA5.NodeGuid

			--ref: #47517

		  , VHFHAA5.IsEnabled
		  , VHFHAA5.CodeName
		  , VHFHAA5.UOM

			--,VHFHAA5.NodeAliasPath

		  , VHFHAA5.DocumentPublishedVersionHistoryID
		  , CASE
				WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HA.DocumentCreatedWhen
		  , HA.DocumentModifiedWhen
		  , HA.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014

		  , HA.NodeGUID AS HANodeGUID
		  , NULL AS SiteLastModified
		  , NULL AS Account_ItemModifiedWhen

			--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen

		  , NULL AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
		  , HAMCQ.AllowMultiSelect
		  , 'SID07' AS LocID
	   FROM

	 --dbo.View_CMS_Tree_Joined AS VCTJ
	 --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	 --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
	 --Campaign links Client which links to Assessment
	 --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

	 View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
		 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
			 ON HA.NodeID = VHFHAMJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
			 ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
			 ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
			 ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
			 ON VHFHAQ.NodeID = VHFHAA.NodeParentID

	 --matrix level 1 questiongroup
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	 --Branching Level 1 Question 

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
			 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
			 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

	 --Matrix Level 2 Question Group
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
	 --Matrix branching level 1 question group
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
	 --Branching level 2 Question Group

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4
			 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
			 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

	 --Branching level 3 Question Group

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5
			 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5
			 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID
		 LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
			 ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
	   WHERE VHFHAQ.DocumentCulture = 'en-us'
		 AND (VHFHAA.DocumentCulture = 'en-us'
		   OR VHFHAA.DocumentCulture IS NULL) 

			 --WDM 08.12.2014		

		 AND VHFHARCJ.DocumentCulture = 'en-us'
		 AND VHFHARAJ.DocumentCulture = 'en-us'
		 AND VHFHAMJ.DocumentCulture = 'en-us'

			 --WDM 08.12.2014	

		 AND HA.DocumentCulture = 'en-us'

			 --WDM 08.12.2014		

		 AND VHFHAA5.NodeGuid IS NOT NULL

	 --ref: #47517

	 UNION ALL

	 --UNION
	 --WDM 6/25/2014 Retrieve the Branching level 4 Question Group

	 SELECT DISTINCT
			NULL AS SiteGUID

			--cs.SiteGUID		--WDM 08.12.2014

		  , NULL AS AccountCD

			--, HFA.AccountCD												--WDM 08.07.2014

		  , HA.NodeID

			--WDM 08.07.2014

		  , HA.NodeName

			--WDM 08.07.2014

		  , NULL AS HADocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID

			--WDM 08.07.2014
			--,VCTJ.NodeAliasPath

		  , HA.DocumentPublishedVersionHistoryID

			--WDM 08.07.2014

		  , dbo.udf_StripHTML (VHFHAMJ.Title) 
		  , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
		  , VHFHAMJ.NodeGuid
		  , VHFHAMJ.Weight
		  , VHFHAMJ.IsEnabled
		  , VHFHAMJ.CodeName

			--,VHFHAMJ.NodeAliasPath

		  , VHFHAMJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARCJ.Title) 
		  , VHFHARCJ.Weight
		  , VHFHARCJ.NodeGuid
		  , VHFHARCJ.IsEnabled
		  , VHFHARCJ.CodeName

			--,VHFHARCJ.NodeAliasPath

		  , VHFHARCJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARAJ.Title) 
		  , VHFHARAJ.Weight
		  , VHFHARAJ.NodeGuid
		  , VHFHARAJ.IsEnabled
		  , VHFHARAJ.CodeName

			--,VHFHARAJ.NodeAliasPath

		  , VHFHARAJ.ScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID
		  , VHFHAQ6.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ6.Title, 4000)) AS QuesTitle
		  , VHFHAQ6.Weight
		  , VHFHAQ6.IsRequired
		  , VHFHAQ6.NodeGuid
		  , VHFHAQ6.IsEnabled
		  , LEFT (VHFHAQ6.IsVisible, 4000) 
		  , VHFHAQ6.IsStaging
		  , VHFHAQ6.CodeName AS QuestionCodeName

			--,VHFHAQ6.NodeAliasPath

		  , VHFHAQ6.DocumentPublishedVersionHistoryID
		  , VHFHAA6.Value
		  , VHFHAA6.Points
		  , VHFHAA6.NodeGuid

			--ref: #47517

		  , VHFHAA6.IsEnabled
		  , VHFHAA6.CodeName
		  , VHFHAA6.UOM

			--,VHFHAA6.NodeAliasPath

		  , VHFHAA6.DocumentPublishedVersionHistoryID
		  , CASE
				WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HA.DocumentCreatedWhen
		  , HA.DocumentModifiedWhen
		  , HA.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014

		  , HA.NodeGUID AS HANodeGUID
		  , NULL AS SiteLastModified
		  , NULL AS Account_ItemModifiedWhen

			--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen

		  , NULL AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
		  , HAMCQ.AllowMultiSelect
		  , 'SID08' AS LocID
	   FROM

	 --dbo.View_CMS_Tree_Joined AS VCTJ
	 --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	 --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
	 --Campaign links Client which links to Assessment
	 --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

	 View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
		 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
			 ON HA.NodeID = VHFHAMJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
			 ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
			 ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
			 ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
			 ON VHFHAQ.NodeID = VHFHAA.NodeParentID

	 --matrix level 1 questiongroup
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	 --Branching Level 1 Question 

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
			 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
			 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

	 --Matrix Level 2 Question Group
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
	 --Matrix branching level 1 question group
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
	 --Branching level 2 Question Group

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4
			 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
			 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

	 --Branching level 3 Question Group
	 --select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5
			 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5
			 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

	 --Branching level 4 Question Group

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6
			 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6
			 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID
		 LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
			 ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
	   WHERE VHFHAQ.DocumentCulture = 'en-us'
		 AND (VHFHAA.DocumentCulture = 'en-us'
		   OR VHFHAA.DocumentCulture IS NULL) 

			 --WDM 08.12.2014		

		 AND VHFHARCJ.DocumentCulture = 'en-us'
		 AND VHFHARAJ.DocumentCulture = 'en-us'
		 AND VHFHAMJ.DocumentCulture = 'en-us'

			 --WDM 08.12.2014	

		 AND HA.DocumentCulture = 'en-us'

			 --WDM 08.12.2014		

		 AND VHFHAA6.NodeGuid IS NOT NULL

	 --ref: #47517

	 UNION ALL

	 --UNION
	 --WDM 6/25/2014 Retrieve the Branching level 5 Question Group

	 SELECT DISTINCT
			NULL AS SiteGUID

			--cs.SiteGUID		--WDM 08.12.2014

		  , NULL AS AccountCD

			--, HFA.AccountCD												--WDM 08.07.2014

		  , HA.NodeID

			--WDM 08.07.2014

		  , HA.NodeName

			--WDM 08.07.2014

		  , NULL AS HADocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID

			--WDM 08.07.2014
			--,VCTJ.NodeAliasPath

		  , HA.DocumentPublishedVersionHistoryID

			--WDM 08.07.2014

		  , dbo.udf_StripHTML (VHFHAMJ.Title) 
		  , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
		  , VHFHAMJ.NodeGuid
		  , VHFHAMJ.Weight
		  , VHFHAMJ.IsEnabled
		  , VHFHAMJ.CodeName

			--,VHFHAMJ.NodeAliasPath

		  , VHFHAMJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARCJ.Title) 
		  , VHFHARCJ.Weight
		  , VHFHARCJ.NodeGuid
		  , VHFHARCJ.IsEnabled
		  , VHFHARCJ.CodeName

			--,VHFHARCJ.NodeAliasPath

		  , VHFHARCJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARAJ.Title) 
		  , VHFHARAJ.Weight
		  , VHFHARAJ.NodeGuid
		  , VHFHARAJ.IsEnabled
		  , VHFHARAJ.CodeName

			--,VHFHARAJ.NodeAliasPath

		  , VHFHARAJ.ScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID
		  , VHFHAQ9.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ9.Title, 4000)) AS QuesTitle
		  , VHFHAQ9.Weight
		  , VHFHAQ9.IsRequired
		  , VHFHAQ9.NodeGuid
		  , VHFHAQ9.IsEnabled
		  , LEFT (VHFHAQ9.IsVisible, 4000) 
		  , VHFHAQ9.IsStaging
		  , VHFHAQ9.CodeName AS QuestionCodeName

			--,VHFHAQ9.NodeAliasPath

		  , VHFHAQ9.DocumentPublishedVersionHistoryID
		  , VHFHAA9.Value
		  , VHFHAA9.Points
		  , VHFHAA9.NodeGuid

			--ref: #47517

		  , VHFHAA9.IsEnabled
		  , VHFHAA9.CodeName
		  , VHFHAA9.UOM

			--,VHFHAA9.NodeAliasPath

		  , VHFHAA9.DocumentPublishedVersionHistoryID
		  , CASE
				WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HA.DocumentCreatedWhen
		  , HA.DocumentModifiedWhen
		  , HA.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014

		  , HA.NodeGUID AS HANodeGUID
		  , NULL AS SiteLastModified
		  , NULL AS Account_ItemModifiedWhen

			--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen

		  , NULL AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
		  , HAMCQ.AllowMultiSelect
		  , 'SID09' AS LocID
	   FROM

	 --dbo.View_CMS_Tree_Joined AS VCTJ
	 --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	 --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
	 --Campaign links Client which links to Assessment
	 --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

	 View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
		 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
			 ON HA.NodeID = VHFHAMJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
			 ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
			 ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
			 ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
			 ON VHFHAQ.NodeID = VHFHAA.NodeParentID

	 --matrix level 1 questiongroup
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	 --Branching Level 1 Question 

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
			 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
			 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

	 --Matrix Level 2 Question Group
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
	 --Matrix branching level 1 question group
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
	 --Branching level 2 Question Group

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4
			 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
			 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

	 --Branching level 3 Question Group
	 --select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5
			 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5
			 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

	 --Branching level 4 Question Group

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6
			 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6
			 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID

	 --Branching level 5 Question Group

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ9
			 ON VHFHAA6.NodeID = VHFHAQ9.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA9
			 ON VHFHAQ9.NodeID = VHFHAA9.NodeParentID
		 LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
			 ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
	   WHERE VHFHAQ.DocumentCulture = 'en-us'
		 AND (VHFHAA.DocumentCulture = 'en-us'
		   OR VHFHAA.DocumentCulture IS NULL) 

			 --WDM 08.12.2014		

		 AND VHFHARCJ.DocumentCulture = 'en-us'
		 AND VHFHARAJ.DocumentCulture = 'en-us'
		 AND VHFHAMJ.DocumentCulture = 'en-us'

			 --WDM 08.12.2014	

		 AND HA.DocumentCulture = 'en-us'

			 --WDM 08.12.2014		

		 AND VHFHAA9.NodeGuid IS NOT NULL;

--ref: #47517

GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO

-- Create Procedure [dbo].[Proc_EDW_HealthAssessmentDefinition]

PRINT 'Create Procedure [dbo].[Proc_EDW_HealthAssessmentDefinition]';
GO
CREATE PROC dbo.Proc_EDW_HealthAssessmentDefinition (@StartDate AS datetime
												   , @EndDate AS datetime
												   , @TrackPerf AS nvarchar (1)) 
AS
	 BEGIN
		 BEGIN

			 --*********************************************************************************************************************
			 --Action: This proc creates table EDW_HealthAssessmentDefinition and a view to access the table view_EDW_HADefinition.
			 --			Select on the view is granted to PUBLIC. This provides EDW with instant access to data.
			 --		Creates a staging table EDW_HealthAssessmentDefinition.
			 --USE:	exec Proc_EDW_HealthAssessmentDefinition NULL, NULL
			 --		exec Proc_EDW_HealthAssessmentDefinition '2013-11-14', '2013-11-15', 'Y'
			 --exec Proc_EDW_HealthAssessmentDefinition NULL, NULL, 'Y'
			 --exec Proc_EDW_HealthAssessmentDefinition '2010-11-14', '2014-11-15', 'Y'
			 --exec Proc_EDW_HealthAssessmentDefinition '2014-06-10', '2014-08-30', NULL
			 --*********************************************************************************************************************
			 --exec Proc_EDW_HealthAssessmentDefinition '2010-11-14', '2014-11-15', 'Y'
			 --08/12/2014 - ProdStaging 00:00:12 @ 2442
			 --*********************************************************************************************************************
			 --USE: exec Proc_EDW_HealthAssessmentDefinition '2001-04-08', '2015-07-02'	--This causes one between dates to be pulled
			 --     exec Proc_EDW_HealthAssessmentDefinition NULL, NULL					--This causes one day's previous data to be pulled
			 --Auth:	GRANT EXECUTE ON dbo.Proc_EDW_HealthAssessmentDefinition TO <UserID>;
			 -- ----FOR DEBUG PURPOSES, UNCOMMENT
			 --declare @TrackPerf as nvarchar(1);
			 --declare @StartDate as datetime;
			 --declare @EndDate as datetime;
			 --set @StartDate = '2010-11-14';
			 --set @EndDate = '2014-11-15';
			 ----set @StartDate = NULL ;
			 ----set @EndDate = NULL ;
			 --set @TrackPerf = 'Y' ;

			 IF EXISTS (SELECT
							   name
						  FROM sys.tables
						  WHERE name = 'EDW_HealthAssessmentDefinition') 
				 BEGIN
					 truncate TABLE EDW_HealthAssessmentDefinition;
				 END;
			 ELSE
				 BEGIN
					 CREATE TABLE dbo.EDW_HealthAssessmentDefinition (
								  SiteGuid int NULL
								, AccountCD int NULL
								, HANodeID int NOT NULL
								, HANodeName nvarchar (100) NOT NULL
								, HADocumentID int NOT NULL
								, HANodeSiteID int NOT NULL
								, HADocPubVerID int NULL
								, ModTitle nvarchar (150) NOT NULL
								, IntroText varchar (4000) NULL
								, ModDocGuid uniqueidentifier NULL
								, ModWeight int NOT NULL
								, ModIsEnabled bit NOT NULL
								, ModCodeName nvarchar (100) NOT NULL
								, ModDocPubVerID int NULL
								, RCTitle nvarchar (150) NOT NULL
								, RCWeight int NOT NULL
								, RCDocumentGUID uniqueidentifier NULL
								, RCIsEnabled bit NOT NULL
								, RCCodeName nvarchar (100) NOT NULL
								, RCDocPubVerID int NULL
								, RATytle nvarchar (150) NOT NULL
								, RAWeight int NOT NULL
								, RADocumentGuid uniqueidentifier NULL
								, RAIsEnabled bit NOT NULL
								, RACodeName nvarchar (100) NOT NULL
								, RAScoringStrategyID int NOT NULL
								, RADocPubVerID int NULL
								, QuestionType nvarchar (100) NOT NULL
								, QuesTitle varchar (max) NULL
								, QuesWeight int NOT NULL
								, QuesIsRequired bit NOT NULL
								, QuesDocumentGuid uniqueidentifier NULL
								, QuesIsEnabled bit NOT NULL
								, QuesIsVisible nvarchar (max) NULL
								, QuesIsSTaging bit NOT NULL
								, QuestionCodeName nvarchar (100) NOT NULL
								, QuesDocPubVerID int NULL
								, AnsValue nvarchar (150) NULL
								, AnsPoints int NULL
								, AnsDocumentGuid uniqueidentifier NULL
								, AnsIsEnabled bit NULL
								, AnsCodeName nvarchar (100) NULL
								, AnsUOM nvarchar (5) NULL
								, AnsDocPUbVerID int NULL
								, ChangeType varchar (1) NOT NULL
								, DocumentCreatedWhen datetime2 (7) NULL
								, DocumentModifiedWhen datetime2 (7) NULL
								, CmsTreeNodeGuid uniqueidentifier NOT NULL
								, HANodeGUID uniqueidentifier NOT NULL) ;
				 END;
			 DECLARE @SQL AS varchar (2000) ;
			 IF NOT EXISTS (SELECT
								   name
							  FROM sys.views
							  WHERE name = 'view_EDW_HADefinition') 
				 BEGIN
					 SET @SQL = 'create view [view_EDW_HADefinition]
	as
	SELECT [SiteGuid]
		  ,[AccountCD]
		  ,[HANodeID]
		  ,[HANodeName]
		  ,[HADocumentID]
		  ,[HANodeSiteID]
		  ,[HADocPubVerID]
		  ,[ModTitle]
		  ,[IntroText]
		  ,[ModDocGuid]
		  ,[ModWeight]
		  ,[ModIsEnabled]
		  ,[ModCodeName]
		  ,[ModDocPubVerID]
		  ,[RCTitle]
		  ,[RCWeight]
		  ,[RCDocumentGUID]
		  ,[RCIsEnabled]
		  ,[RCCodeName]
		  ,[RCDocPubVerID]
		  ,[RATytle]
		  ,[RAWeight]
		  ,[RADocumentGuid]
		  ,[RAIsEnabled]
		  ,[RACodeName]
		  ,[RAScoringStrategyID]
		  ,[RADocPubVerID]
		  ,[QuestionType]
		  ,[QuesTitle]
		  ,[QuesWeight]
		  ,[QuesIsRequired]
		  ,[QuesDocumentGuid]
		  ,[QuesIsEnabled]
		  ,[QuesIsVisible]
		  ,[QuesIsSTaging]
		  ,[QuestionCodeName]
		  ,[QuesDocPubVerID]
		  ,[AnsValue]
		  ,[AnsPoints]
		  ,[AnsDocumentGuid]
		  ,[AnsIsEnabled]
		  ,[AnsCodeName]
		  ,[AnsUOM]
		  ,[AnsDocPUbVerID]
		  ,[ChangeType]
		  ,[DocumentCreatedWhen]
		  ,[DocumentModifiedWhen]
		  ,[CmsTreeNodeGuid]
		  ,[HANodeGUID]
	  FROM [dbo].[EDW_HealthAssessmentDefinition]';
					 EXEC (@SQL) ;
					 GRANT SELECT ON view_EDW_HADefinition TO public;
				 END;
			 DECLARE @P0Start AS datetime;
			 DECLARE @P0End AS datetime;
			 DECLARE @P1Start AS datetime;
			 DECLARE @P1End AS datetime;
			 DECLARE @P2Start AS datetime;
			 DECLARE @P2End AS datetime;
			 DECLARE @P3Start AS datetime;
			 DECLARE @P3End AS datetime;
			 DECLARE @P4Start AS datetime;
			 DECLARE @P4End AS datetime;
			 DECLARE @P5Start AS datetime;
			 DECLARE @P5End AS datetime;
			 DECLARE @P6Start AS datetime;
			 DECLARE @P6End AS datetime;
			 DECLARE @P7Start AS datetime;
			 DECLARE @P7End AS datetime;
			 DECLARE @P8Start AS datetime;
			 DECLARE @P8End AS datetime;
			 SET @P0Start = GETDATE () ;
			 IF @StartDate IS NULL
				 BEGIN
					 SET @StartDate = DATEADD (Day, 0, DATEDIFF (Day, 0, GETDATE ())) ;

					 --Midnight yesterday;	

					 SET @StartDate = @StartDate - 1;
				 END;
			 IF @EndDate IS NULL
				 BEGIN
					 SET @EndDate = CAST (GETDATE () AS date) ;
				 END;
			 PRINT 'Start Date: ' + CAST (@StartDate AS nvarchar (50)) ;
			 PRINT 'End Date: ' + CAST (@EndDate AS nvarchar (50)) ;

/*************************************************************************************
**************************************************************************************
*************************************************************************************/

			 --Build the temporary tables. This should take under 10 seconds as a general rule.

/*************************************************************************************
**************************************************************************************
*************************************************************************************/

			 IF EXISTS (SELECT
							   name
						  FROM tempdb.dbo.sysobjects
						  WHERE ID = OBJECT_ID (N'tempdb..#Temp_View_HFit_HealthAssessment_Joined')) 
				 BEGIN
					 DROP TABLE
						  #Temp_View_HFit_HealthAssessment_Joined;
				 END;

			 --GO

			 SELECT
					DocumentGUID
				  , NodeGuid
				  , NodeID
				  , DocumentID
				  , NodeName
				  , NodeSiteID
				  , DocumentPublishedVersionHistoryID INTO
														   #Temp_View_HFit_HealthAssessment_Joined
			   FROM View_HFit_HealthAssessment_Joined
			   WHERE View_HFit_HealthAssessment_Joined.DocumentCulture = 'en-us';

			 --GO

			 CREATE CLUSTERED INDEX PI_Temp_View_HFit_HealthAssessment_Joined ON #Temp_View_HFit_HealthAssessment_Joined (DocumentGUID, NodeGuid) ;

			 --GO 

			 IF EXISTS (SELECT
							   name
						  FROM tempdb.dbo.sysobjects
						  WHERE ID = OBJECT_ID (N'tempdb..#Temp_View_HFit_HACampaign_Joined')) 
				 BEGIN
					 DROP TABLE
						  #Temp_View_HFit_HACampaign_Joined;
				 END;

			 --GO

			 SELECT DISTINCT
					NodeParentID
				  , HealthAssessmentID INTO
											#Temp_View_HFit_HACampaign_Joined
			   FROM View_HFit_HACampaign_Joined;

			 --GO

			 CREATE CLUSTERED INDEX PI_Temp_View_HFit_HACampaign_Joined ON #Temp_View_HFit_HACampaign_Joined (NodeParentID ASC, HealthAssessmentID) ;

			 --GO

			 IF EXISTS (SELECT
							   name
						  FROM tempdb.dbo.sysobjects
						  WHERE ID = OBJECT_ID (N'tempdb..#Temp_View_CMS_Tree_Joined')) 
				 BEGIN
					 DROP TABLE
						  #Temp_View_CMS_Tree_Joined;
				 END;

			 --GO

			 SELECT DISTINCT
					VCTJ.NodeGuid
				  , VCTJ.NodeID
				  , VCTJ.NodeName
				  , VCTJ.DocumentGUID
				  , VCTJ.NodeSiteID
				  , VCTJ.DocumentPublishedVersionHistoryID
				  , CASE
						WHEN CAST (VCTJ.DocumentCreatedWhen AS date) = CAST (vctj.DocumentModifiedWhen AS date) 
						THEN 'I'
						ELSE 'U'
					END AS ChangeType
				  , VCTJ.DocumentCreatedWhen
				  , VCTJ.DocumentModifiedWhen
				  , VCTJ.DocumentCulture INTO
											  #Temp_View_CMS_Tree_Joined
			   FROM View_CMS_Tree_Joined AS VCTJ;

			 --where VCTJ.DocumentCulture = 'en-us'
			 --GO 

			 CREATE CLUSTERED INDEX PI_Temp_View_CMS_Tree_Joined ON dbo.#Temp_View_CMS_Tree_Joined (NodeID, NodeSiteID, NodeName, DocumentGUID, DocumentPublishedVersionHistoryID, DocumentCreatedWhen, DocumentModifiedWhen) ;

			 --GO 

			 IF EXISTS (SELECT
							   name
						  FROM tempdb.dbo.sysobjects
						  WHERE ID = OBJECT_ID (N'tempdb..#Temp_View_HFit_HealthAssesmentModule_Joined')) 
				 BEGIN
					 DROP TABLE
						  #Temp_View_HFit_HealthAssesmentModule_Joined;
				 END;

			 --GO

			 SELECT
					VHFHAMJ.Title AS ModTitle
				  , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
				  , VHFHAMJ.DocumentGUID
				  , VHFHAMJ.Weight
				  , VHFHAMJ.IsEnabled
				  , VHFHAMJ.CodeName AS ModCodeName
				  , VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
				  , VHFHAMJ.NodeParentID
				  , VHFHAMJ.DocumentNodeID
				  , VHFHAMJ.Title
				  , VHFHAMJ.CodeName
				  , VHFHAMJ.DocumentPublishedVersionHistoryID
				  , VHFHAMJ.DocumentCulture INTO
												 #Temp_View_HFit_HealthAssesmentModule_Joined
			   FROM View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ;

			 --where VHFHAMJ.DocumentCulture = 'en-us'
			 --GO

			 CREATE CLUSTERED INDEX PI_Temp_View_HFit_HealthAssesmentModule_Joined ON #Temp_View_HFit_HealthAssesmentModule_Joined (NodeParentID, DocumentNodeID, DocumentGUID, Weight, IsEnabled, Title, CodeName, DocumentPublishedVersionHistoryID) ;

			 --GO

			 IF EXISTS (SELECT
							   name
						  FROM tempdb.dbo.sysobjects
						  WHERE ID = OBJECT_ID (N'tempdb..#Temp_View_HFit_HealthAssesmentRiskCategory_Joined')) 
				 BEGIN
					 DROP TABLE
						  #Temp_View_HFit_HealthAssesmentRiskCategory_Joined;
				 END;

			 --GO

			 SELECT
					VHFHARCJ.Title
				  , VHFHARCJ.Weight
				  , VHFHARCJ.DocumentGUID
				  , VHFHARCJ.IsEnabled
				  , VHFHARCJ.CodeName
				  , VHFHARCJ.DocumentPublishedVersionHistoryID
				  , VHFHARCJ.NodeParentID
				  , VHFHARCJ.DocumentNodeID
				  , VHFHARCJ.DocumentCulture INTO
												  #Temp_View_HFit_HealthAssesmentRiskCategory_Joined
			   FROM View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ;

			 --where VHFHARCJ.DocumentCulture = 'en-us'	
			 --GO

			 CREATE CLUSTERED INDEX PI_Temp_View_HFit_HealthAssesmentRiskCategory_Joined ON #Temp_View_HFit_HealthAssesmentRiskCategory_Joined (NodeParentID, DocumentGUID, DocumentNodeID) ;
			 IF EXISTS (SELECT
							   name
						  FROM tempdb.dbo.sysobjects
						  WHERE ID = OBJECT_ID (N'tempdb..#Temp_View_HFit_HealthAssesmentRiskArea_Joined')) 
				 BEGIN
					 DROP TABLE
						  #Temp_View_HFit_HealthAssesmentRiskArea_Joined;
				 END;

			 --GO

			 SELECT
					VHFHARAJ.Title
				  , VHFHARAJ.Weight
				  , VHFHARAJ.DocumentGUID
				  , VHFHARAJ.IsEnabled
				  , VHFHARAJ.CodeName
				  , VHFHARAJ.ScoringStrategyID
				  , VHFHARAJ.DocumentPublishedVersionHistoryID
				  , VHFHARAJ.NodeParentID
				  , VHFHARAJ.DocumentNodeID
				  , VHFHARAJ.DocumentCulture INTO
												  #Temp_View_HFit_HealthAssesmentRiskArea_Joined
			   FROM View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ;

			 --where VHFHARAJ.DocumentCulture = 'en-us'
			 --GO

			 CREATE CLUSTERED INDEX PI_Temp_View_HFit_HealthAssesmentRiskArea_Joined ON #Temp_View_HFit_HealthAssesmentRiskArea_Joined (DocumentNodeID, NodeParentID, DocumentGUID) ;
			 IF EXISTS (SELECT
							   name
						  FROM tempdb.dbo.sysobjects
						  WHERE ID = OBJECT_ID (N'tempdb..#Temp_View_EDW_HealthAssesmentQuestions')) 
				 BEGIN
					 DROP TABLE
						  #Temp_View_EDW_HealthAssesmentQuestions;
				 END;

			 --GO

			 SELECT
					VHFHAQ.QuestionType
				  , dbo.udf_StripHTML (LEFT (VHFHAQ.Title, 4000)) AS Title
				  , VHFHAQ.Weight
				  , VHFHAQ.IsRequired
				  , VHFHAQ.DocumentGUID
				  , VHFHAQ.IsEnabled

					--, VHFHAQ.IsVisible

				  , LEFT (VHFHAQ.IsVisible, 4000) AS IsVisible
				  , VHFHAQ.IsStaging
				  , VHFHAQ.CodeName
				  , VHFHAQ.DocumentPublishedVersionHistoryID
				  , VHFHAQ.NodeParentID
				  , VHFHAQ.NodeGuid
				  , VHFHAQ.NodeID
				  , VHFHAQ.DocumentCulture INTO
												#Temp_View_EDW_HealthAssesmentQuestions
			   FROM View_EDW_HealthAssesmentQuestions AS VHFHAQ;

			 --where VHFHAQ.DocumentCulture = 'en-us'
			 --GO

			 CREATE CLUSTERED INDEX PI_Temp_View_HFit_HealthAssesmentQuestions ON #Temp_View_EDW_HealthAssesmentQuestions (NodeGuid, NodeParentID) ;

			 --GO

			 IF EXISTS (SELECT
							   name
						  FROM tempdb.dbo.sysobjects
						  WHERE ID = OBJECT_ID (N'tempdb..#Temp_View_EDW_HealthAssesmentAnswers')) 
				 BEGIN
					 DROP TABLE
						  #Temp_View_EDW_HealthAssesmentAnswers;
				 END;

			 --GO

			 SELECT
					VHFHAA.Value
				  , VHFHAA.Points
				  , VHFHAA.DocumentGUID
				  , VHFHAA.IsEnabled
				  , VHFHAA.CodeName
				  , VHFHAA.UOM
				  , VHFHAA.DocumentPublishedVersionHistoryID
				  , VHFHAA.NodeParentID
				  , VHFHAA.NodeGuid
				  , VHFHAA.NodeID
				  , VHFHAA.DocumentCulture INTO
												#Temp_View_EDW_HealthAssesmentAnswers
			   FROM View_EDW_HealthAssesmentAnswers AS VHFHAA;

			 --where VHFHAA.DocumentCulture = 'en-us'
			 --GO 

			 CREATE CLUSTERED INDEX PI_Temp_View_HFit_HealthAssesmentAnswers ON #Temp_View_EDW_HealthAssesmentAnswers (NodeParentID, DocumentGUID, DocumentPublishedVersionHistoryID, Value, Points, IsEnabled, CodeName, UOM) ;

			 --GO  

			 IF NOT EXISTS (SELECT
								   name
							  FROM sys.indexes
							  WHERE name = N'PI04_View_CMS_Tree_Joined_Linked') 
				 BEGIN
					 CREATE NONCLUSTERED INDEX PI04_View_CMS_Tree_Joined_Linked ON dbo.View_CMS_Tree_Joined_Linked (ClassName) INCLUDE (
							NodeParentID
						  , DocumentGUID
						  , DocumentForeignKeyValue
						  , DocumentPublishedVersionHistoryID
						  , DocumentNodeID) ;

				 --GO 

				 END;
			 IF NOT EXISTS (SELECT
								   name
							  FROM sys.indexes
							  WHERE name = N'PI_Temp_View_HFit_HealthAssesmentModule_Joined') 
				 BEGIN
					 DROP INDEX #Temp_View_HFit_HealthAssesmentModule_Joined.PI_Temp_View_HFit_HealthAssesmentModule_Joined;
				 END;
			 IF NOT EXISTS (SELECT
								   name
							  FROM sys.indexes
							  WHERE name = N'PI_Temp_View_HFit_HealthAssesmentModule_Joined') 
				 BEGIN
					 CREATE CLUSTERED INDEX PI_Temp_View_HFit_HealthAssesmentModule_Joined ON #Temp_View_HFit_HealthAssesmentModule_Joined (DocumentGUID, Weight, IsEnabled, Title, CodeName, DocumentPublishedVersionHistoryID) ;
				 END;
			 IF NOT EXISTS (SELECT
								   name
							  FROM sys.indexes
							  WHERE name = N'PI01_HFit_Account') 
				 BEGIN
					 CREATE INDEX PI01_HFit_Account ON HFit_Account (SiteID) ;
				 END;
			 IF NOT EXISTS (SELECT
								   name
							  FROM sys.indexes
							  WHERE name = N'CI01_View_CMS_Tree_Joined_Linked') 
				 BEGIN
					 CREATE NONCLUSTERED INDEX CI01_View_CMS_Tree_Joined_Linked ON dbo.View_CMS_Tree_Joined_Linked (ClassName) INCLUDE (
							NodeGuid
						  , DocumentGUID
						  , DocumentForeignKeyValue) ;
				 END;

			 --GO 

			 IF @TrackPerf IS NOT NULL
				 BEGIN
					 SET @P0End = GETDATE () ;
					 EXEC proc_EDW_MeasurePerf 'ElapsedTime', 'HADef-P0', 0, @P0Start, @P0End;
				 END;
			 SET @P1Start = GETDATE () ;

/*************************************************************************************
**************************************************************************************
*************************************************************************************/

			 --Begin the view using the TEMP tables

/*************************************************************************************
**************************************************************************************
*************************************************************************************/

			 INSERT INTO EDW_HealthAssessmentDefinition (
						 SiteGuid
					   , AccountCD
					   , HANodeID
					   , HANodeName
					   , HADocumentID
					   , HANodeSiteID
					   , HADocPubVerID
					   , ModTitle
					   , IntroText
					   , ModDocGuid
					   , ModWeight
					   , ModIsEnabled
					   , ModCodeName
					   , ModDocPubVerID
					   , RCTitle
					   , RCWeight
					   , RCDocumentGUID
					   , RCIsEnabled
					   , RCCodeName
					   , RCDocPubVerID
					   , RATytle
					   , RAWeight
					   , RADocumentGuid
					   , RAIsEnabled
					   , RACodeName
					   , RAScoringStrategyID
					   , RADocPubVerID
					   , QuestionType
					   , QuesTitle
					   , QuesWeight
					   , QuesIsRequired
					   , QuesDocumentGuid
					   , QuesIsEnabled
					   , QuesIsVisible
					   , QuesIsSTaging
					   , QuestionCodeName
					   , QuesDocPubVerID
					   , AnsValue
					   , AnsPoints
					   , AnsDocumentGuid
					   , AnsIsEnabled
					   , AnsCodeName
					   , AnsUOM
					   , AnsDocPUbVerID
					   , ChangeType
					   , DocumentCreatedWhen
					   , DocumentModifiedWhen
					   , CmsTreeNodeGuid
					   , HANodeGUID) 
			 SELECT DISTINCT
					NULL AS SiteGuid

					--cs.SiteGUID		--WDM 08.07.2014 per conversation with John Croft

				  , NULL AS AccountCD

					--, HFA.AccountCD		--WDM 08.07.2014 per conversation with John Croft

				  , HA.NodeID AS HANodeID

					--WDM 08.07.2014

				  , HA.NodeName AS HANodeName

					--WDM 08.07.2014

				  , HA.DocumentID AS HADocumentID

					--WDM 08.07.2014

				  , HA.NodeSiteID AS HANodeSiteID

					--WDM 08.07.2014

				  , HA.DocumentPublishedVersionHistoryID AS HADocPubVerID

					--WDM 08.07.2014

				  , VHFHAMJ.Title AS ModTitle

					--Per EDW Team, HTML text is truncated to 4000 bytes - we'll just do it here
					--, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText

				  , VHFHAMJ.IntroText
				  , VHFHAMJ.DocumentGuid AS ModDocGuid

					--, VHFHAMJ.DocumentID AS ModDocID	--WDM 08.07.2014

				  , VHFHAMJ.Weight AS ModWeight
				  , VHFHAMJ.IsEnabled AS ModIsEnabled
				  , VHFHAMJ.CodeName AS ModCodeName
				  , VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
				  , VHFHARCJ.Title AS RCTitle
				  , VHFHARCJ.Weight AS RCWeight
				  , VHFHARCJ.DocumentGuid AS RCDocumentGUID

					--, VHFHARCJ.DocumentID AS RCDocumentID	--WDM 08.07.2014

				  , VHFHARCJ.IsEnabled AS RCIsEnabled
				  , VHFHARCJ.CodeName AS RCCodeName
				  , VHFHARCJ.DocumentPublishedVersionHistoryID AS RCDocPubVerID
				  , VHFHARAJ.Title AS RATytle
				  , VHFHARAJ.Weight AS RAWeight
				  , VHFHARAJ.DocumentGuid AS RADocumentGuid

					--, VHFHARAJ.DocumentID AS RADocumentID	--WDM 08.07.2014

				  , VHFHARAJ.IsEnabled AS RAIsEnabled
				  , VHFHARAJ.CodeName AS RACodeName
				  , VHFHARAJ.ScoringStrategyID AS RAScoringStrategyID
				  , VHFHARAJ.DocumentPublishedVersionHistoryID AS RADocPubVerID
				  , VHFHAQ.QuestionType

					--, dbo.udf_StripHTML(left(VHFHAQ.Title,4000)) AS QuesTitle

				  , VHFHAQ.Title AS QuesTitle
				  , VHFHAQ.Weight AS QuesWeight
				  , VHFHAQ.IsRequired AS QuesIsRequired
				  , VHFHAQ.DocumentGuid AS QuesDocumentGuid

					--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014

				  , VHFHAQ.IsEnabled AS QuesIsEnabled
				  , LEFT (VHFHAQ.IsVisible, 4000) AS QuesIsVisible
				  , VHFHAQ.IsStaging AS QuesIsSTaging
				  , VHFHAQ.CodeName AS QuestionCodeName
				  , VHFHAQ.DocumentPublishedVersionHistoryID AS QuesDocPubVerID
				  , VHFHAA.Value AS AnsValue
				  , VHFHAA.Points AS AnsPoints
				  , VHFHAA.DocumentGuid AS AnsDocumentGuid

					--, VHFHAA.DocumentID AS AnsDocumentID	--WDM 08.07.2014

				  , VHFHAA.IsEnabled AS AnsIsEnabled
				  , VHFHAA.CodeName AS AnsCodeName
				  , VHFHAA.UOM AS AnsUOM
				  , VHFHAA.DocumentPublishedVersionHistoryID AS AnsDocPUbVerID
				  , CASE
						WHEN CAST (VCTJ.DocumentCreatedWhen AS date) = CAST (vctj.DocumentModifiedWhen AS date) 
						THEN 'I'
						ELSE 'U'
					END AS ChangeType
				  , VCTJ.DocumentCreatedWhen
				  , VCTJ.DocumentModifiedWhen
				  , VCTJ.NodeGuid AS CmsTreeNodeGuid

					--WDM 08.07.2014 ADDED TO the returned Columns

				  , HA.NodeGUID AS HANodeGUID
			   FROM dbo.#Temp_View_CMS_Tree_Joined AS VCTJ
						INNER JOIN dbo.CMS_Site AS CS
							ON VCTJ.NodeSiteID = cs.SiteID
						INNER JOIN HFit_Account AS hfa WITH (NOLOCK) 
							ON cs.SiteID = hfa.SiteID

			 --Campaign links Client which links to Assessment

						INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined AS c WITH (NOLOCK) 
							ON VCTJ.NodeID = c.NodeParentID
						INNER JOIN #Temp_View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
							ON c.HealthAssessmentID = HA.DocumentID

			 --WDM 08.07.2014

						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
							ON HA.NodeID = VHFHAMJ.NodeParentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
							ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
							ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ
							ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
						LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA
							ON VHFHAQ.NodeID = VHFHAA.NodeParentID
			   WHERE VCTJ.DocumentCulture = 'en-us'

					 --WDM 08.07.2014

				 AND VHFHAQ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014	

				 AND (VHFHAA.DocumentCulture = 'en-us'
				   OR VHFHAA.DocumentCulture IS NULL) 

					 --WDM 08.12.2014		

				 AND VHFHARCJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND VHFHARAJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014	

				 AND VHFHAMJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND (VCTJ.DocumentCreatedWhen BETWEEN @StartDate AND @EndDate
				   OR VCTJ.DocumentModifiedWhen BETWEEN @StartDate AND @EndDate) 
			 UNION ALL

			 --WDM Retrieve Matrix Level 1 Question Group

			 SELECT DISTINCT
					NULL AS SiteGuid

					--cs.SiteGUID

				  , NULL AS AccountCD

					--, HFA.AccountCD

				  , HA.NodeID

					--WDM 08.07.2014

				  , HA.NodeName

					--WDM 08.07.2014

				  , HA.DocumentID

					--WDM 08.07.2014

				  , HA.NodeSiteID

					--WDM 08.07.2014
					--,VCTJ.NodeAliasPath

				  , HA.DocumentPublishedVersionHistoryID

					--WDM 08.07.2014

				  , VHFHAMJ.Title

					--, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText

				  , VHFHAMJ.IntroText
				  , VHFHAMJ.DocumentGUID
				  , VHFHAMJ.Weight
				  , VHFHAMJ.IsEnabled
				  , VHFHAMJ.CodeName

					--,VHFHAMJ.NodeAliasPath

				  , VHFHAMJ.DocumentPublishedVersionHistoryID
				  , VHFHARCJ.Title
				  , VHFHARCJ.Weight
				  , VHFHARCJ.DocumentGUID
				  , VHFHARCJ.IsEnabled
				  , VHFHARCJ.CodeName

					--,VHFHARCJ.NodeAliasPath

				  , VHFHARCJ.DocumentPublishedVersionHistoryID
				  , VHFHARAJ.Title
				  , VHFHARAJ.Weight
				  , VHFHARAJ.DocumentGUID
				  , VHFHARAJ.IsEnabled
				  , VHFHARAJ.CodeName

					--,VHFHARAJ.NodeAliasPath

				  , VHFHARAJ.ScoringStrategyID
				  , VHFHARAJ.DocumentPublishedVersionHistoryID
				  , VHFHAQ2.QuestionType

					--, dbo.udf_StripHTML(left(VHFHAQ2.Title,4000)) AS QuesTitle

				  , VHFHAQ2.Title AS QuesTitle
				  , VHFHAQ2.Weight
				  , VHFHAQ2.IsRequired
				  , VHFHAQ2.DocumentGUID
				  , VHFHAQ2.IsEnabled
				  , LEFT (VHFHAQ2.IsVisible, 4000) 
				  , VHFHAQ2.IsStaging
				  , VHFHAQ2.CodeName AS QuestionCodeName

					--,VHFHAQ2.NodeAliasPath

				  , VHFHAQ2.DocumentPublishedVersionHistoryID
				  , VHFHAA2.Value
				  , VHFHAA2.Points
				  , VHFHAA2.DocumentGUID
				  , VHFHAA2.IsEnabled
				  , VHFHAA2.CodeName
				  , VHFHAA2.UOM

					--,VHFHAA2.NodeAliasPath

				  , VHFHAA2.DocumentPublishedVersionHistoryID
				  , CASE
						WHEN CAST (VCTJ.DocumentCreatedWhen AS date) = CAST (vctj.DocumentModifiedWhen AS date) 
						THEN 'I'
						ELSE 'U'
					END AS ChangeType
				  , VCTJ.DocumentCreatedWhen
				  , VCTJ.DocumentModifiedWhen
				  , VCTJ.NodeGuid AS CmsTreeNodeGuid

					--WDM 08.07.2014

				  , HA.NodeGUID AS HANodeGUID
			   FROM dbo.#Temp_View_CMS_Tree_Joined AS VCTJ
						INNER JOIN dbo.CMS_Site AS CS
							ON VCTJ.NodeSiteID = cs.SiteID
						INNER JOIN HFit_Account AS hfa WITH (NOLOCK) 
							ON cs.SiteID = hfa.SiteID
						INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined AS c WITH (NOLOCK) 
							ON VCTJ.NodeID = c.NodeParentID
						INNER JOIN #Temp_View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
							ON c.HealthAssessmentID = HA.DocumentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
							ON HA.NodeID = VHFHAMJ.NodeParentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
							ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
							ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ
							ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
						LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA
							ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			 --matrix level 1 questiongroup

						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ2
							ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA2
							ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
			   WHERE VCTJ.DocumentCulture = 'en-us'

					 --WDM 08.07.2014

				 AND VHFHAQ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014	

				 AND (VHFHAA.DocumentCulture = 'en-us'
				   OR VHFHAA.DocumentCulture IS NULL) 

					 --WDM 08.12.2014		

				 AND VHFHARCJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND VHFHARAJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND VHFHAMJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND (VCTJ.DocumentCreatedWhen BETWEEN @StartDate AND @EndDate
				   OR VCTJ.DocumentModifiedWhen BETWEEN @StartDate AND @EndDate) 
			 UNION ALL

			 --WDM Retrieve Branching Level 1 Question and Matrix Level 1 Question Group

			 SELECT DISTINCT
					NULL AS SiteGuid

					--cs.SiteGUID

				  , NULL AS AccountCD

					--, HFA.AccountCD

				  , HA.NodeID

					--WDM 08.07.2014

				  , HA.NodeName

					--WDM 08.07.2014

				  , HA.DocumentID

					--WDM 08.07.2014

				  , HA.NodeSiteID

					--WDM 08.07.2014
					--,VCTJ.NodeAliasPath

				  , HA.DocumentPublishedVersionHistoryID

					--WDM 08.07.2014

				  , VHFHAMJ.Title

					--, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText

				  , VHFHAMJ.IntroText
				  , VHFHAMJ.DocumentGUID
				  , VHFHAMJ.Weight
				  , VHFHAMJ.IsEnabled
				  , VHFHAMJ.CodeName

					--,VHFHAMJ.NodeAliasPath

				  , VHFHAMJ.DocumentPublishedVersionHistoryID
				  , VHFHARCJ.Title
				  , VHFHARCJ.Weight
				  , VHFHARCJ.DocumentGUID
				  , VHFHARCJ.IsEnabled
				  , VHFHARCJ.CodeName

					--,VHFHARCJ.NodeAliasPath

				  , VHFHARCJ.DocumentPublishedVersionHistoryID
				  , VHFHARAJ.Title
				  , VHFHARAJ.Weight
				  , VHFHARAJ.DocumentGUID
				  , VHFHARAJ.IsEnabled
				  , VHFHARAJ.CodeName

					--,VHFHARAJ.NodeAliasPath

				  , VHFHARAJ.ScoringStrategyID
				  , VHFHARAJ.DocumentPublishedVersionHistoryID
				  , VHFHAQ3.QuestionType

					--, dbo.udf_StripHTML(left(VHFHAQ3.Title,4000)) AS QuesTitle

				  , VHFHAQ3.Title AS QuesTitle
				  , VHFHAQ3.Weight
				  , VHFHAQ3.IsRequired
				  , VHFHAQ3.DocumentGUID
				  , VHFHAQ3.IsEnabled
				  , LEFT (VHFHAQ3.IsVisible, 4000) 
				  , VHFHAQ3.IsStaging
				  , VHFHAQ3.CodeName AS QuestionCodeName

					--,VHFHAQ3.NodeAliasPath

				  , VHFHAQ3.DocumentPublishedVersionHistoryID
				  , VHFHAA3.Value
				  , VHFHAA3.Points
				  , VHFHAA3.DocumentGUID
				  , VHFHAA3.IsEnabled
				  , VHFHAA3.CodeName
				  , VHFHAA3.UOM

					--,VHFHAA3.NodeAliasPath

				  , VHFHAA3.DocumentPublishedVersionHistoryID
				  , CASE
						WHEN CAST (VCTJ.DocumentCreatedWhen AS date) = CAST (vctj.DocumentModifiedWhen AS date) 
						THEN 'I'
						ELSE 'U'
					END AS ChangeType
				  , VCTJ.DocumentCreatedWhen
				  , VCTJ.DocumentModifiedWhen
				  , VCTJ.NodeGuid AS CmsTreeNodeGuid

					--WDM 08.07.2014

				  , HA.NodeGUID AS HANodeGUID
			   FROM dbo.#Temp_View_CMS_Tree_Joined AS VCTJ
						INNER JOIN dbo.CMS_Site AS CS
							ON VCTJ.NodeSiteID = cs.SiteID
						INNER JOIN HFit_Account AS hfa WITH (NOLOCK) 
							ON cs.SiteID = hfa.SiteID
						INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined AS c WITH (NOLOCK) 
							ON VCTJ.NodeID = c.NodeParentID
						INNER JOIN #Temp_View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
							ON c.HealthAssessmentID = HA.DocumentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
							ON HA.NodeID = VHFHAMJ.NodeParentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
							ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
							ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ
							ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
						LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA
							ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			 --matrix level 1 questiongroup
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
			 --Branching Level 1 Question 

						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ3
							ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
						LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA3
							ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
			   WHERE VCTJ.DocumentCulture = 'en-us'

					 --WDM 08.07.2014

				 AND VHFHAQ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014	

				 AND (VHFHAA.DocumentCulture = 'en-us'
				   OR VHFHAA.DocumentCulture IS NULL) 

					 --WDM 08.12.2014		

				 AND VHFHARCJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND VHFHARAJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND VHFHAMJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND (VCTJ.DocumentCreatedWhen BETWEEN @StartDate AND @EndDate
				   OR VCTJ.DocumentModifiedWhen BETWEEN @StartDate AND @EndDate) 
			 UNION ALL

			 --WDM Retrieve Branching Level 1 Question and Matrix Level 2 Question Group

			 SELECT DISTINCT
					NULL AS SiteGuid

					--cs.SiteGUID

				  , NULL AS AccountCD

					--, HFA.AccountCD

				  , HA.NodeID

					--WDM 08.07.2014

				  , HA.NodeName

					--WDM 08.07.2014

				  , HA.DocumentID

					--WDM 08.07.2014

				  , HA.NodeSiteID

					--WDM 08.07.2014
					--,VCTJ.NodeAliasPath

				  , HA.DocumentPublishedVersionHistoryID

					--WDM 08.07.2014

				  , VHFHAMJ.Title

					--, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText

				  , VHFHAMJ.IntroText
				  , VHFHAMJ.DocumentGUID
				  , VHFHAMJ.Weight
				  , VHFHAMJ.IsEnabled
				  , VHFHAMJ.CodeName

					--,VHFHAMJ.NodeAliasPath

				  , VHFHAMJ.DocumentPublishedVersionHistoryID
				  , VHFHARCJ.Title
				  , VHFHARCJ.Weight
				  , VHFHARCJ.DocumentGUID
				  , VHFHARCJ.IsEnabled
				  , VHFHARCJ.CodeName

					--,VHFHARCJ.NodeAliasPath

				  , VHFHARCJ.DocumentPublishedVersionHistoryID
				  , VHFHARAJ.Title
				  , VHFHARAJ.Weight
				  , VHFHARAJ.DocumentGUID
				  , VHFHARAJ.IsEnabled
				  , VHFHARAJ.CodeName

					--,VHFHARAJ.NodeAliasPath

				  , VHFHARAJ.ScoringStrategyID
				  , VHFHARAJ.DocumentPublishedVersionHistoryID
				  , VHFHAQ7.QuestionType

					--, dbo.udf_StripHTML(left(VHFHAQ7.Title,4000)) AS QuesTitle

				  , VHFHAQ7.Title AS QuesTitle
				  , VHFHAQ7.Weight
				  , VHFHAQ7.IsRequired
				  , VHFHAQ7.DocumentGUID
				  , VHFHAQ7.IsEnabled
				  , LEFT (VHFHAQ7.IsVisible, 4000) 
				  , VHFHAQ7.IsStaging
				  , VHFHAQ7.CodeName AS QuestionCodeName

					--,VHFHAQ7.NodeAliasPath

				  , VHFHAQ7.DocumentPublishedVersionHistoryID
				  , VHFHAA7.Value
				  , VHFHAA7.Points
				  , VHFHAA7.DocumentGUID
				  , VHFHAA7.IsEnabled
				  , VHFHAA7.CodeName
				  , VHFHAA7.UOM

					--,VHFHAA7.NodeAliasPath

				  , VHFHAA7.DocumentPublishedVersionHistoryID
				  , CASE
						WHEN CAST (VCTJ.DocumentCreatedWhen AS date) = CAST (vctj.DocumentModifiedWhen AS date) 
						THEN 'I'
						ELSE 'U'
					END AS ChangeType
				  , VCTJ.DocumentCreatedWhen
				  , VCTJ.DocumentModifiedWhen
				  , VCTJ.NodeGuid AS CmsTreeNodeGuid

					--WDM 08.07.2014

				  , HA.NodeGUID AS HANodeGUID
			   FROM dbo.#Temp_View_CMS_Tree_Joined AS VCTJ
						INNER JOIN dbo.CMS_Site AS CS
							ON VCTJ.NodeSiteID = cs.SiteID
						INNER JOIN HFit_Account AS hfa WITH (NOLOCK) 
							ON cs.SiteID = hfa.SiteID
						INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined AS c WITH (NOLOCK) 
							ON VCTJ.NodeID = c.NodeParentID
						INNER JOIN #Temp_View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
							ON c.HealthAssessmentID = HA.DocumentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
							ON HA.NodeID = VHFHAMJ.NodeParentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
							ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
							ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ
							ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
						LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA
							ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			 --matrix level 1 questiongroup
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
			 --Branching Level 1 Question 

						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ3
							ON VHFHAA.NodeID = VHFHAQ3.NodeParentID

			 --LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
			 --Matrix Level 2 Question Group

						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ7
							ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA7
							ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
			   WHERE VCTJ.DocumentCulture = 'en-us'

					 --WDM 08.07.2014

				 AND VHFHAQ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014	

				 AND (VHFHAA.DocumentCulture = 'en-us'
				   OR VHFHAA.DocumentCulture IS NULL) 

					 --WDM 08.12.2014		

				 AND VHFHARCJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND VHFHARAJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND VHFHAMJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND (VCTJ.DocumentCreatedWhen BETWEEN @StartDate AND @EndDate
				   OR VCTJ.DocumentModifiedWhen BETWEEN @StartDate AND @EndDate) 
			 UNION ALL

			 --****************************************************
			 --WDM 6/25/2014 Retrieve the Branching level 1 Question Group
			 --THE PROBLEM LIES HERE in this part of query : 1:40 minute
			 -- Added two perf indexes to the first query: 25 Sec
			 --****************************************************

			 SELECT DISTINCT
					NULL AS SiteGuid

					--cs.SiteGUID

				  , NULL AS AccountCD

					--, HFA.AccountCD

				  , HA.NodeID

					--WDM 08.07.2014

				  , HA.NodeName

					--WDM 08.07.2014

				  , HA.DocumentID

					--WDM 08.07.2014

				  , HA.NodeSiteID

					--WDM 08.07.2014
					--,VCTJ.NodeAliasPath

				  , HA.DocumentPublishedVersionHistoryID

					--WDM 08.07.2014

				  , VHFHAMJ.Title

					--, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText

				  , VHFHAMJ.IntroText
				  , VHFHAMJ.DocumentGUID
				  , VHFHAMJ.Weight
				  , VHFHAMJ.IsEnabled
				  , VHFHAMJ.CodeName

					--,VHFHAMJ.NodeAliasPath

				  , VHFHAMJ.DocumentPublishedVersionHistoryID
				  , VHFHARCJ.Title
				  , VHFHARCJ.Weight
				  , VHFHARCJ.DocumentGUID
				  , VHFHARCJ.IsEnabled
				  , VHFHARCJ.CodeName

					--,VHFHARCJ.NodeAliasPath

				  , VHFHARCJ.DocumentPublishedVersionHistoryID
				  , VHFHARAJ.Title
				  , VHFHARAJ.Weight
				  , VHFHARAJ.DocumentGUID
				  , VHFHARAJ.IsEnabled
				  , VHFHARAJ.CodeName

					--,VHFHARAJ.NodeAliasPath

				  , VHFHARAJ.ScoringStrategyID
				  , VHFHARAJ.DocumentPublishedVersionHistoryID
				  , VHFHAQ8.QuestionType

					--, dbo.udf_StripHTML(left(VHFHAQ8.Title,4000)) AS QuesTitle

				  , VHFHAQ8.Title AS QuesTitle
				  , VHFHAQ8.Weight
				  , VHFHAQ8.IsRequired
				  , VHFHAQ8.DocumentGUID
				  , VHFHAQ8.IsEnabled
				  , LEFT (VHFHAQ8.IsVisible, 4000) 
				  , VHFHAQ8.IsStaging
				  , VHFHAQ8.CodeName AS QuestionCodeName

					--,VHFHAQ8.NodeAliasPath

				  , VHFHAQ8.DocumentPublishedVersionHistoryID
				  , VHFHAA8.Value
				  , VHFHAA8.Points
				  , VHFHAA8.DocumentGUID
				  , VHFHAA8.IsEnabled
				  , VHFHAA8.CodeName
				  , VHFHAA8.UOM

					--,VHFHAA8.NodeAliasPath

				  , VHFHAA8.DocumentPublishedVersionHistoryID
				  , CASE
						WHEN CAST (VCTJ.DocumentCreatedWhen AS date) = CAST (vctj.DocumentModifiedWhen AS date) 
						THEN 'I'
						ELSE 'U'
					END AS ChangeType
				  , VCTJ.DocumentCreatedWhen
				  , VCTJ.DocumentModifiedWhen
				  , VCTJ.NodeGuid AS CmsTreeNodeGuid

					--WDM 08.07.2014

				  , HA.NodeGUID AS HANodeGUID
			   FROM dbo.#Temp_View_CMS_Tree_Joined AS VCTJ
						INNER JOIN dbo.CMS_Site AS CS
							ON VCTJ.NodeSiteID = cs.SiteID
						INNER JOIN HFit_Account AS hfa WITH (NOLOCK) 
							ON cs.SiteID = hfa.SiteID
						INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined AS c WITH (NOLOCK) 
							ON VCTJ.NodeID = c.NodeParentID
						INNER JOIN #Temp_View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
							ON c.HealthAssessmentID = HA.DocumentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
							ON HA.NodeID = VHFHAMJ.NodeParentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
							ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
							ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ
							ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
						LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA
							ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			 --matrix level 1 questiongroup
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
			 --Branching Level 1 Question 

						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ3
							ON VHFHAA.NodeID = VHFHAQ3.NodeParentID

			 --LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
			 --Matrix Level 2 Question Group

						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ7
							ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA7
							ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

			 --Matrix branching level 1 question group

						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ8
							ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA8
							ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
			   WHERE VCTJ.DocumentCulture = 'en-us'

					 --WDM 08.07.2014

				 AND VHFHAQ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014	

				 AND (VHFHAA.DocumentCulture = 'en-us'
				   OR VHFHAA.DocumentCulture IS NULL) 

					 --WDM 08.12.2014		

				 AND VHFHARCJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND VHFHARAJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND VHFHAMJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND (VCTJ.DocumentCreatedWhen BETWEEN @StartDate AND @EndDate
				   OR VCTJ.DocumentModifiedWhen BETWEEN @StartDate AND @EndDate) 
			 UNION ALL

			 --****************************************************
			 --WDM 6/25/2014 Retrieve the Branching level 2 Question Group
			 --THE PROBLEM LIES HERE in this part of query : 1:48  minutes
			 --With the new indexes: 29 Secs
			 --****************************************************

			 SELECT DISTINCT
					NULL AS SiteGuid

					--cs.SiteGUID

				  , NULL AS AccountCD

					--, HFA.AccountCD

				  , HA.NodeID

					--WDM 08.07.2014

				  , HA.NodeName

					--WDM 08.07.2014

				  , HA.DocumentID

					--WDM 08.07.2014

				  , HA.NodeSiteID

					--WDM 08.07.2014
					--,VCTJ.NodeAliasPath

				  , HA.DocumentPublishedVersionHistoryID

					--WDM 08.07.2014

				  , VHFHAMJ.Title

					--, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText

				  , VHFHAMJ.IntroText
				  , VHFHAMJ.DocumentGUID
				  , VHFHAMJ.Weight
				  , VHFHAMJ.IsEnabled
				  , VHFHAMJ.CodeName

					--,VHFHAMJ.NodeAliasPath

				  , VHFHAMJ.DocumentPublishedVersionHistoryID
				  , VHFHARCJ.Title
				  , VHFHARCJ.Weight
				  , VHFHARCJ.DocumentGUID
				  , VHFHARCJ.IsEnabled
				  , VHFHARCJ.CodeName

					--,VHFHARCJ.NodeAliasPath

				  , VHFHARCJ.DocumentPublishedVersionHistoryID
				  , VHFHARAJ.Title
				  , VHFHARAJ.Weight
				  , VHFHARAJ.DocumentGUID
				  , VHFHARAJ.IsEnabled
				  , VHFHARAJ.CodeName

					--,VHFHARAJ.NodeAliasPath

				  , VHFHARAJ.ScoringStrategyID
				  , VHFHARAJ.DocumentPublishedVersionHistoryID
				  , VHFHAQ4.QuestionType

					--, dbo.udf_StripHTML(left(VHFHAQ4.Title,4000)) AS QuesTitle

				  , VHFHAQ4.Title AS QuesTitle
				  , VHFHAQ4.Weight
				  , VHFHAQ4.IsRequired
				  , VHFHAQ4.DocumentGUID
				  , VHFHAQ4.IsEnabled
				  , LEFT (VHFHAQ4.IsVisible, 4000) 
				  , VHFHAQ4.IsStaging
				  , VHFHAQ4.CodeName AS QuestionCodeName

					--,VHFHAQ4.NodeAliasPath

				  , VHFHAQ4.DocumentPublishedVersionHistoryID
				  , VHFHAA4.Value
				  , VHFHAA4.Points
				  , VHFHAA4.DocumentGUID
				  , VHFHAA4.IsEnabled
				  , VHFHAA4.CodeName
				  , VHFHAA4.UOM

					--,VHFHAA4.NodeAliasPath

				  , VHFHAA4.DocumentPublishedVersionHistoryID
				  , CASE
						WHEN CAST (VCTJ.DocumentCreatedWhen AS date) = CAST (vctj.DocumentModifiedWhen AS date) 
						THEN 'I'
						ELSE 'U'
					END AS ChangeType
				  , VCTJ.DocumentCreatedWhen
				  , VCTJ.DocumentModifiedWhen
				  , VCTJ.NodeGuid AS CmsTreeNodeGuid

					--WDM 08.07.2014

				  , HA.NodeGUID AS HANodeGUID
			   FROM dbo.#Temp_View_CMS_Tree_Joined AS VCTJ
						INNER JOIN dbo.CMS_Site AS CS
							ON VCTJ.NodeSiteID = cs.SiteID
						INNER JOIN HFit_Account AS hfa WITH (NOLOCK) 
							ON cs.SiteID = hfa.SiteID
						INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined AS c WITH (NOLOCK) 
							ON VCTJ.NodeID = c.NodeParentID
						INNER JOIN #Temp_View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
							ON c.HealthAssessmentID = HA.DocumentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
							ON HA.NodeID = VHFHAMJ.NodeParentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
							ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
							ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ
							ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
						LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA
							ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			 --matrix level 1 questiongroup
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
			 --Branching Level 1 Question 

						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ3
							ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
						LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA3
							ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			 --Matrix Level 2 Question Group
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
			 --Matrix branching level 1 question group
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
			 --Branching level 2 Question Group

						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ4
							ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA4
							ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID
			   WHERE VCTJ.DocumentCulture = 'en-us'

					 --WDM 08.07.2014

				 AND VHFHAQ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014	

				 AND (VHFHAA.DocumentCulture = 'en-us'
				   OR VHFHAA.DocumentCulture IS NULL) 

					 --WDM 08.12.2014		

				 AND VHFHARCJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND VHFHARAJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND VHFHAMJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND (VCTJ.DocumentCreatedWhen BETWEEN @StartDate AND @EndDate
				   OR VCTJ.DocumentModifiedWhen BETWEEN @StartDate AND @EndDate) 
			 UNION ALL

			 --WDM 6/25/2014 Retrieve the Branching level 3 Question Group

			 SELECT DISTINCT
					NULL AS SiteGuid

					--cs.SiteGUID

				  , NULL AS AccountCD

					--, HFA.AccountCD

				  , HA.NodeID

					--WDM 08.07.2014

				  , HA.NodeName

					--WDM 08.07.2014

				  , HA.DocumentID

					--WDM 08.07.2014

				  , HA.NodeSiteID

					--WDM 08.07.2014
					--,VCTJ.NodeAliasPath

				  , HA.DocumentPublishedVersionHistoryID

					--WDM 08.07.2014

				  , VHFHAMJ.Title

					--, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText

				  , VHFHAMJ.IntroText
				  , VHFHAMJ.DocumentGUID
				  , VHFHAMJ.Weight
				  , VHFHAMJ.IsEnabled
				  , VHFHAMJ.CodeName

					--,VHFHAMJ.NodeAliasPath

				  , VHFHAMJ.DocumentPublishedVersionHistoryID
				  , VHFHARCJ.Title
				  , VHFHARCJ.Weight
				  , VHFHARCJ.DocumentGUID
				  , VHFHARCJ.IsEnabled
				  , VHFHARCJ.CodeName

					--,VHFHARCJ.NodeAliasPath

				  , VHFHARCJ.DocumentPublishedVersionHistoryID
				  , VHFHARAJ.Title
				  , VHFHARAJ.Weight
				  , VHFHARAJ.DocumentGUID
				  , VHFHARAJ.IsEnabled
				  , VHFHARAJ.CodeName

					--,VHFHARAJ.NodeAliasPath

				  , VHFHARAJ.ScoringStrategyID
				  , VHFHARAJ.DocumentPublishedVersionHistoryID
				  , VHFHAQ5.QuestionType
				  , VHFHAQ5.Title AS QuesTitle
				  , VHFHAQ5.Weight
				  , VHFHAQ5.IsRequired
				  , VHFHAQ5.DocumentGUID
				  , VHFHAQ5.IsEnabled
				  , LEFT (VHFHAQ5.IsVisible, 4000) 
				  , VHFHAQ5.IsStaging
				  , VHFHAQ5.CodeName AS QuestionCodeName

					--,VHFHAQ5.NodeAliasPath

				  , VHFHAQ5.DocumentPublishedVersionHistoryID
				  , VHFHAA5.Value
				  , VHFHAA5.Points
				  , VHFHAA5.DocumentGUID
				  , VHFHAA5.IsEnabled
				  , VHFHAA5.CodeName
				  , VHFHAA5.UOM

					--,VHFHAA5.NodeAliasPath

				  , VHFHAA5.DocumentPublishedVersionHistoryID
				  , CASE
						WHEN CAST (VCTJ.DocumentCreatedWhen AS date) = CAST (vctj.DocumentModifiedWhen AS date) 
						THEN 'I'
						ELSE 'U'
					END AS ChangeType
				  , VCTJ.DocumentCreatedWhen
				  , VCTJ.DocumentModifiedWhen
				  , VCTJ.NodeGuid AS CmsTreeNodeGuid

					--WDM 08.07.2014

				  , HA.NodeGUID AS HANodeGUID
			   FROM dbo.#Temp_View_CMS_Tree_Joined AS VCTJ
						INNER JOIN dbo.CMS_Site AS CS
							ON VCTJ.NodeSiteID = cs.SiteID
						INNER JOIN HFit_Account AS hfa WITH (NOLOCK) 
							ON cs.SiteID = hfa.SiteID
						INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined AS c WITH (NOLOCK) 
							ON VCTJ.NodeID = c.NodeParentID
						INNER JOIN #Temp_View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
							ON c.HealthAssessmentID = HA.DocumentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
							ON HA.NodeID = VHFHAMJ.NodeParentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
							ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
							ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ
							ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
						LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA
							ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			 --matrix level 1 questiongroup
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
			 --Branching Level 1 Question 

						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ3
							ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
						LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA3
							ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			 --Matrix Level 2 Question Group
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
			 --Matrix branching level 1 question group
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
			 --Branching level 2 Question Group

						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ4
							ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA4
							ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

			 --Branching level 3 Question Group

						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ5
							ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA5
							ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID
			   WHERE VCTJ.DocumentCulture = 'en-us'

					 --WDM 08.07.2014

				 AND VHFHAQ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014	

				 AND (VHFHAA.DocumentCulture = 'en-us'
				   OR VHFHAA.DocumentCulture IS NULL) 

					 --WDM 08.12.2014		

				 AND VHFHARCJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND VHFHARAJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND VHFHAMJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND (VCTJ.DocumentCreatedWhen BETWEEN @StartDate AND @EndDate
				   OR VCTJ.DocumentModifiedWhen BETWEEN @StartDate AND @EndDate) 
			 UNION ALL

			 --WDM 6/25/2014 Retrieve the Branching level 4 Question Group

			 SELECT DISTINCT
					NULL AS SiteGuid

					--cs.SiteGUID

				  , NULL AS AccountCD

					--, HFA.AccountCD

				  , HA.NodeID

					--WDM 08.07.2014

				  , HA.NodeName

					--WDM 08.07.2014

				  , HA.DocumentID

					--WDM 08.07.2014

				  , HA.NodeSiteID

					--WDM 08.07.2014
					--,VCTJ.NodeAliasPath

				  , HA.DocumentPublishedVersionHistoryID

					--WDM 08.07.2014

				  , VHFHAMJ.Title

					--, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText

				  , VHFHAMJ.IntroText
				  , VHFHAMJ.DocumentGUID
				  , VHFHAMJ.Weight
				  , VHFHAMJ.IsEnabled
				  , VHFHAMJ.CodeName

					--,VHFHAMJ.NodeAliasPath

				  , VHFHAMJ.DocumentPublishedVersionHistoryID
				  , VHFHARCJ.Title
				  , VHFHARCJ.Weight
				  , VHFHARCJ.DocumentGUID
				  , VHFHARCJ.IsEnabled
				  , VHFHARCJ.CodeName

					--,VHFHARCJ.NodeAliasPath

				  , VHFHARCJ.DocumentPublishedVersionHistoryID
				  , VHFHARAJ.Title
				  , VHFHARAJ.Weight
				  , VHFHARAJ.DocumentGUID
				  , VHFHARAJ.IsEnabled
				  , VHFHARAJ.CodeName

					--,VHFHARAJ.NodeAliasPath

				  , VHFHARAJ.ScoringStrategyID
				  , VHFHARAJ.DocumentPublishedVersionHistoryID
				  , VHFHAQ6.QuestionType

					--, dbo.udf_StripHTML(left(VHFHAQ6.Title,4000)) AS QuesTitle

				  , VHFHAQ6.Title AS QuesTitle
				  , VHFHAQ6.Weight
				  , VHFHAQ6.IsRequired
				  , VHFHAQ6.DocumentGUID
				  , VHFHAQ6.IsEnabled
				  , LEFT (VHFHAQ6.IsVisible, 4000) 
				  , VHFHAQ6.IsStaging
				  , VHFHAQ6.CodeName AS QuestionCodeName

					--,VHFHAQ6.NodeAliasPath

				  , VHFHAQ6.DocumentPublishedVersionHistoryID
				  , VHFHAA6.Value
				  , VHFHAA6.Points
				  , VHFHAA6.DocumentGUID
				  , VHFHAA6.IsEnabled
				  , VHFHAA6.CodeName
				  , VHFHAA6.UOM

					--,VHFHAA6.NodeAliasPath

				  , VHFHAA6.DocumentPublishedVersionHistoryID
				  , CASE
						WHEN CAST (VCTJ.DocumentCreatedWhen AS date) = CAST (vctj.DocumentModifiedWhen AS date) 
						THEN 'I'
						ELSE 'U'
					END AS ChangeType
				  , VCTJ.DocumentCreatedWhen
				  , VCTJ.DocumentModifiedWhen
				  , VCTJ.NodeGuid AS CmsTreeNodeGuid

					--WDM 08.07.2014

				  , HA.NodeGUID AS HANodeGUID
			   FROM dbo.#Temp_View_CMS_Tree_Joined AS VCTJ
						INNER JOIN dbo.CMS_Site AS CS
							ON VCTJ.NodeSiteID = cs.SiteID
						INNER JOIN HFit_Account AS hfa WITH (NOLOCK) 
							ON cs.SiteID = hfa.SiteID
						INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined AS c WITH (NOLOCK) 
							ON VCTJ.NodeID = c.NodeParentID
						INNER JOIN #Temp_View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
							ON c.HealthAssessmentID = HA.DocumentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
							ON HA.NodeID = VHFHAMJ.NodeParentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
							ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
							ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ
							ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
						LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA
							ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			 --matrix level 1 questiongroup
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
			 --Branching Level 1 Question 

						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ3
							ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
						LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA3
							ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			 --Matrix Level 2 Question Group
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
			 --Matrix branching level 1 question group
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
			 --Branching level 2 Question Group

						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ4
							ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA4
							ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

			 --Branching level 3 Question Group
			 --select count(*) from dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA4

						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ5
							ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA5
							ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

			 --Branching level 4 Question Group

						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ6
							ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA6
							ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID
			   WHERE VCTJ.DocumentCulture = 'en-us'

					 --WDM 08.07.2014

				 AND VHFHAQ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014	

				 AND (VHFHAA.DocumentCulture = 'en-us'
				   OR VHFHAA.DocumentCulture IS NULL) 

					 --WDM 08.12.2014		

				 AND VHFHARCJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND VHFHARAJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND VHFHAMJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND (VCTJ.DocumentCreatedWhen BETWEEN @StartDate AND @EndDate
				   OR VCTJ.DocumentModifiedWhen BETWEEN @StartDate AND @EndDate) 
			 UNION ALL

			 --WDM 6/25/2014 Retrieve the Branching level 5 Question Group

			 SELECT DISTINCT
					NULL AS SiteGuid

					--cs.SiteGUID

				  , NULL AS AccountCD

					--, HFA.AccountCD

				  , HA.NodeID

					--WDM 08.07.2014

				  , HA.NodeName

					--WDM 08.07.2014

				  , HA.DocumentID

					--WDM 08.07.2014

				  , HA.NodeSiteID

					--WDM 08.07.2014
					--,VCTJ.NodeAliasPath

				  , HA.DocumentPublishedVersionHistoryID

					--WDM 08.07.2014

				  , VHFHAMJ.Title

					--, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText

				  , VHFHAMJ.IntroText
				  , VHFHAMJ.DocumentGUID
				  , VHFHAMJ.Weight
				  , VHFHAMJ.IsEnabled
				  , VHFHAMJ.CodeName

					--,VHFHAMJ.NodeAliasPath

				  , VHFHAMJ.DocumentPublishedVersionHistoryID
				  , VHFHARCJ.Title
				  , VHFHARCJ.Weight
				  , VHFHARCJ.DocumentGUID
				  , VHFHARCJ.IsEnabled
				  , VHFHARCJ.CodeName

					--,VHFHARCJ.NodeAliasPath

				  , VHFHARCJ.DocumentPublishedVersionHistoryID
				  , VHFHARAJ.Title
				  , VHFHARAJ.Weight
				  , VHFHARAJ.DocumentGUID
				  , VHFHARAJ.IsEnabled
				  , VHFHARAJ.CodeName

					--,VHFHARAJ.NodeAliasPath

				  , VHFHARAJ.ScoringStrategyID
				  , VHFHARAJ.DocumentPublishedVersionHistoryID
				  , VHFHAQ9.QuestionType

					--, dbo.udf_StripHTML(left(VHFHAQ9.Title,4000)) AS QuesTitle

				  , VHFHAQ9.Title AS QuesTitle
				  , VHFHAQ9.Weight
				  , VHFHAQ9.IsRequired
				  , VHFHAQ9.DocumentGUID
				  , VHFHAQ9.IsEnabled
				  , LEFT (VHFHAQ9.IsVisible, 4000) 
				  , VHFHAQ9.IsStaging
				  , VHFHAQ9.CodeName AS QuestionCodeName

					--,VHFHAQ9.NodeAliasPath

				  , VHFHAQ9.DocumentPublishedVersionHistoryID
				  , VHFHAA9.Value
				  , VHFHAA9.Points
				  , VHFHAA9.DocumentGUID
				  , VHFHAA9.IsEnabled
				  , VHFHAA9.CodeName
				  , VHFHAA9.UOM

					--,VHFHAA9.NodeAliasPath

				  , VHFHAA9.DocumentPublishedVersionHistoryID
				  , CASE
						WHEN CAST (VCTJ.DocumentCreatedWhen AS date) = CAST (vctj.DocumentModifiedWhen AS date) 
						THEN 'I'
						ELSE 'U'
					END AS ChangeType
				  , VCTJ.DocumentCreatedWhen
				  , VCTJ.DocumentModifiedWhen
				  , VCTJ.NodeGuid AS CmsTreeNodeGuid

					--WDM 08.07.2014

				  , HA.NodeGUID AS HANodeGUID
			   FROM dbo.#Temp_View_CMS_Tree_Joined AS VCTJ
						INNER JOIN dbo.CMS_Site AS CS
							ON VCTJ.NodeSiteID = cs.SiteID
						INNER JOIN HFit_Account AS hfa WITH (NOLOCK) 
							ON cs.SiteID = hfa.SiteID
						INNER JOIN dbo.#Temp_View_HFit_HACampaign_Joined AS c WITH (NOLOCK) 
							ON VCTJ.NodeID = c.NodeParentID
						INNER JOIN #Temp_View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
							ON c.HealthAssessmentID = HA.DocumentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
							ON HA.NodeID = VHFHAMJ.NodeParentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
							ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
						INNER JOIN dbo.#Temp_View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
							ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ
							ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
						LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA
							ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			 --matrix level 1 questiongroup
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
			 --Branching Level 1 Question 

						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ3
							ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
						LEFT OUTER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA3
							ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			 --Matrix Level 2 Question Group
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
			 --Matrix branching level 1 question group
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			 --INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
			 --Branching level 2 Question Group

						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ4
							ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA4
							ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

			 --Branching level 3 Question Group
			 --select count(*) from dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA4

						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ5
							ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA5
							ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

			 --Branching level 4 Question Group

						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ6
							ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA6
							ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID

			 --Branching level 5 Question Group

						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentQuestions AS VHFHAQ9
							ON VHFHAA6.NodeID = VHFHAQ9.NodeParentID
						INNER JOIN dbo.#Temp_View_EDW_HealthAssesmentAnswers AS VHFHAA9
							ON VHFHAQ9.NodeID = VHFHAA9.NodeParentID
			   WHERE VCTJ.DocumentCulture = 'en-us'

					 --WDM 08.07.2014

				 AND VHFHAQ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014	

				 AND (VHFHAA.DocumentCulture = 'en-us'
				   OR VHFHAA.DocumentCulture IS NULL) 

					 --WDM 08.12.2014		

				 AND VHFHARCJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND VHFHARAJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND VHFHAMJ.DocumentCulture = 'en-us'

					 --WDM 08.12.2014		

				 AND (VCTJ.DocumentCreatedWhen BETWEEN @StartDate AND @EndDate
				   OR VCTJ.DocumentModifiedWhen BETWEEN @StartDate AND @EndDate) ;

			 --GO 

			 DROP INDEX View_CMS_Tree_Joined_Linked.PI04_View_CMS_Tree_Joined_Linked;

			 --GO

			 DROP INDEX HFit_Account.PI01_HFit_Account;

			 --GO

			 DROP INDEX View_CMS_Tree_Joined_Linked.CI01_View_CMS_Tree_Joined_Linked;
			 DECLARE @cnt AS int = (SELECT
										   COUNT (*) 
									  FROM EDW_HealthAssessmentDefinition) ;
			 PRINT 'Processed Recs: ' + CAST (@cnt AS nvarchar (50)) ;
			 IF @TrackPerf IS NOT NULL
				 BEGIN
					 SET @P1End = GETDATE () ;
					 EXEC proc_EDW_MeasurePerf 'ElapsedTime', 'HADef-P1', 0, @P1Start, @P1End;
				 END;
			 ELSE
				 BEGIN
					 PRINT 'No Perf details requested';
				 END;
		 END;
		 PRINT 'Processing: proc_EDW_MeasurePerf';
	 END;
GO
IF @@ERROR <> 0
OR @@TRANCOUNT = 0
	BEGIN
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK
			END;
		SET NOEXEC ON;
	END;
GO
IF @@TRANCOUNT > 0
	BEGIN
		COMMIT
	END;
SET NOEXEC OFF;
GO

