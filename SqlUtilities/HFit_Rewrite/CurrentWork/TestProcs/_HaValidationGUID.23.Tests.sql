--********************************************************************************************
--******* CREATE THE TEMP TABLES FOR SPEED IN THE REST of the SCRIPT *************************
--********************************************************************************************
--drop table tempdb..#HA_DEF ;
PRINT 'I - Building The needed temp tables: ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
PRINT '**NOTE: It can take 20 to 40 minutes to build the data.';
GO

IF OBJECT_ID ('tempdb..#HA_DEF') IS NULL
    BEGIN
	   SELECT DISTINCT
			[HADEF].[RCDocumentGUID]
		   , [HADEF].[RADocumentGuid]
		   , [HADEF].[HANodeGUID]
		   , [HADEF].[ModDocGuid]
		   , [HADEF].[QuesDocumentGuid]
		   , [HADEF].[AnsDocumentGuid]
	   INTO
		   [#HA_DEF]
		FROM [dbo].[view_EDW_HealthAssesmentDeffinition] AS [HADEF];

	   CREATE NONCLUSTERED INDEX [idxTempHA0] ON [#HA_DEF]
	   (
	   [RCDocumentGUID] ,
	   [RADocumentGuid] ,
	   [HANodeGUID] ,
	   [ModDocGuid] ,
	   [QuesDocumentGuid] ,
	   [AnsDocumentGuid]
	   );
	   CREATE NONCLUSTERED INDEX [idxTempHA1] ON [#HA_DEF]
	   (
	   [QuesDocumentGuid]
	   );
	   CREATE NONCLUSTERED INDEX [idxTempHA2] ON [#HA_DEF]
	   (
	   [AnsDocumentGuid]
	   );

    END;
GO
PRINT 'II - Building The needed temp tables: ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
GO

IF OBJECT_ID ('tempdb..#HA') IS NULL
    BEGIN
	   SELECT
			[HealthAssesmentUserStartedNodeGUID]
		   , [HARiskCategoryNodeGUID]
		   , [HAModuleNodeGUID]
		   , [HARiskAreaNodeGUID]
		   , [HAQuestionGuid]
		   , [HAAnswerNodeGUID]
	   INTO
		   [#HA]
		FROM [view_EDW_HealthAssesment];

	   CREATE NONCLUSTERED INDEX [idxTemp13a] ON [#HA]
	   (
	   [HealthAssesmentUserStartedNodeGUID] ,
	   [HARiskCategoryNodeGUID] ,
	   [HAModuleNodeGUID] ,
	   [HARiskAreaNodeGUID] ,
	   [HAQuestionGuid] ,
	   [HAAnswerNodeGUID]
	   );
	   CREATE NONCLUSTERED INDEX [idxTemp13e] ON [#HA]
	   (
	   [HealthAssesmentUserStartedNodeGUID]
	   );
	   CREATE NONCLUSTERED INDEX [idxTemp13b] ON [#HA]
	   (
	   [HARiskCategoryNodeGUID]
	   );
	   CREATE NONCLUSTERED INDEX [idxTemp13c] ON [#HA]
	   (
	   [HAModuleNodeGUID]
	   );
	   CREATE NONCLUSTERED INDEX [idxTemp14d] ON [#HA]
	   (
	   [HARiskAreaNodeGUID]
	   );
	   CREATE NONCLUSTERED INDEX [idxTemp14e] ON [#HA]
	   (
	   [HAQuestionGuid]
	   );
	   CREATE NONCLUSTERED INDEX [idxTemp14f] ON [#HA]
	   (
	   [HAAnswerNodeGUID]
	   );
    END;
GO

PRINT 'Temp tables built: ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
--********************************************************************************************
GO
--  HA VIEW Validation 11/6/2014
--- NOTE   THESE TESTS are DEVELOPED FOR THE PROD 5 Database ENVIRONMENT.
---        THE TESTING APPROACH IS CUMMULATIVE AND EACH TEST MUST BE PASSED BEFORE PRCEEDING WITH THE NEXT TEST
--  For all tests involving data from [view_EDW_HealthAssesment] Negative MPI codes should be eliminated 
--  since this is test data and is excluded from the EDW load.
-----   HA DOCUMENT LEVEL TESTS
--  For all tests assume that the HA Document Node GUIDs are the same across all Platform DB Instances
--  Zero counts and No data should be retruned form either of the next three selects if the three platform Database values for HANodeGUID(s) are the same

PRINT CHAR (10) + CHAR (13) + 'Start Test 01 of 23 : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
GO
DECLARE @icnt AS int = 0;
SET @icnt = (SELECT
				COUNT (*) 
		   --FROM [dbo].[view_EDW_HealthAssesmentDeffinition]
			FROM [#HA_DEF]
			WHERE [HANodeGUID] IS NULL
			   OR [HANodeGUID] = '00000000-0000-0000-0000-000000000000') ;
IF @icnt > 0
    BEGIN
	   PRINT '=====>>>  ERROR: Test #1 FAILED - view_EDW_HealthAssesmentDeffinition.';
    END;
ELSE
    BEGIN
	   PRINT 'Test #1 Passed - view_EDW_HealthAssesmentDeffinition.';
    END;
GO

PRINT CHAR (10) + CHAR (13) + 'Start Test 02 of 23 : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
GO
DECLARE @icnt AS int = 0;

--set @icnt = (SELECT  'TEST2', LTRIM (HANodeGUID) 
--  FROM KenticoCMS_PRD_2.dbo.view_EDW_HealthAssesmentDeffinition WHERE HANodeGUID IS NOT NULL AND HANodeGUID <> '00000000-0000-0000-0000-000000000000'
--EXCEPT
--SELECT DISTINCT 'TEST2', LTRIM (HANodeGUID) 
--  FROM KenticoCMS_PRD_3.dbo.view_EDW_HealthAssesmentDeffinition) ;

SET @icnt = (SELECT
				COUNT (*) 
			FROM [KenticoCMS_PRD_2].[dbo].[view_EDW_HealthAssesmentDeffinition]
			WHERE [HANodeGUID] IS NOT NULL
			  AND [HANodeGUID] <> '00000000-0000-0000-0000-000000000000'
			  AND [HANodeGUID] NOT IN (SELECT DISTINCT
									    LTRIM ([HANodeGUID]) 
								    FROM [KenticoCMS_PRD_3].[dbo].[view_EDW_HealthAssesmentDeffinition])) ;

IF @icnt > 0
    BEGIN
	   PRINT '=====>>>  ERROR: Test #2 FAILED - Validate Prod 2 Against PROD 3.';
    END;
ELSE
    BEGIN
	   PRINT 'Test #2 Passed - Validate Prod 2 Against PROD 3.';
    END;

PRINT CHAR (10) + CHAR (13) + 'Start Test 03 of 23 : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
GO

DECLARE @icnt AS int = 0;
--  Validate Prod 3 Against PROD 1
SET @icnt = (SELECT
				COUNT (*) 
			FROM [KenticoCMS_PRD_3].[dbo].[view_EDW_HealthAssesmentDeffinition]
			WHERE [HANodeGUID] IS NOT NULL
			  AND [HANodeGUID] <> '00000000-0000-0000-0000-000000000000'
			  AND [HANodeGUID] NOT IN (SELECT DISTINCT
									    LTRIM ([HANodeGUID]) 
								    FROM [dbo].[view_EDW_HealthAssesmentDeffinition])) ;

IF @icnt > 0
    BEGIN
	   PRINT '=====>>>  ERROR: Test #3 FAILED - Validate Prod 3 Against PROD 1.';
    END;
ELSE
    BEGIN
	   PRINT 'Test #3 Passed - Validate Prod 3 Against PROD 1.';
    END;

--  Validate the HA Document Version GUIDs match between the Health Assessment (Fact) data and the HA Definition data (Dimension)
--  the test will compare the HA fact data and report any GUIDs for the HA Document version that are not a match
--  Assumption there should only be one value retruned from the Definition data table
--  Results:  If any data is retruned then data in fact table is suspect and tests should cease the mismatch is resolved

PRINT CHAR (10) + CHAR (13) + 'Start Test 04 of 23 NULL or Blank Values in the GUID are not allowed : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
GO
DECLARE @icnt AS int = 0;
-- Check for NULLs in GUID

SET @icnt = (
		  SELECT
			    COUNT (*) 
		    FROM [dbo].[view_EDW_HealthAssesment]
		    --FROM #HA
		    WHERE [HealthAssesmentUserStartedNodeGUID] IS NULL) ;

IF @icnt > 0
    BEGIN
	   PRINT '=====>>>  ERROR: Test #4 FAILED - NULL or Blank Values in the GUID are not allowed .';
    END;
ELSE
    BEGIN
	   PRINT 'Test #4 Passed - NULL or Blank Values in the GUID are not allowed .';
    END;
GO

PRINT CHAR (10) + CHAR (13) + 'Start Test 05 of 23 : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
PRINT 'NULL or Blank Values in the GUID are not allowed';
PRINT 'Any value other than zero means NULLs or blanks exist and must be eliminated.';
GO
DECLARE @icnt AS int = 0;
SET @icnt = (SELECT
				COUNT (*) 
			FROM [dbo].[view_EDW_HealthAssesmentDeffinition]
			WHERE [HANodeGUID] IS NULL) ;

IF @icnt > 0
    BEGIN
	   PRINT '=====>>>  ERROR: Test #5 FAILED - NULL or Blank Values in the GUID are not allowed .';
    END;
ELSE
    BEGIN
	   PRINT 'Test #5 Passed - NULL or Blank Values in the GUID are not allowed .';
    END;
GO

PRINT CHAR (10) + CHAR (13) + 'Start Test 06 of 23 : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
PRINT 'Return Distinct values not matching to definition data value';
GO
DECLARE @icnt AS int = 0;
SET @icnt = (SELECT
				COUNT (*) 
			FROM [#HA]
			WHERE [HealthAssesmentUserStartedNodeGUID] != 'ECBECCC1-14BF-4CCB-88A6-65FC640C5871'
			  AND [HealthAssesmentUserStartedNodeGUID] IS NOT NULL) ;

IF @icnt > 0
    BEGIN
	   PRINT '=====>>>  ERROR: Test #6 FAILED - Return Distinct values not matching to definition data value.';
    END;
ELSE
    BEGIN
	   PRINT 'Test #6 Passed - Return Distinct values not matching to definition data value.';
    END;
GO

PRINT CHAR (10) + CHAR (13) + 'Start Test 07 of 23 : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
PRINT 'Return Distinct values not matching to definition data value';
GO

DECLARE @icnt AS int = 0;
SET @icnt = (SELECT
				COUNT (*) 
			FROM [#HA]
			WHERE [HealthAssesmentUserStartedNodeGUID] IS NOT NULL
				 --AND [HealthAssesmentUserStartedNodeGUID] NOT IN (SELECT DISTINCT [HANodeGUID] FROM [dbo].[view_EDW_HealthAssesmentDeffinition])) ;
			  AND [HealthAssesmentUserStartedNodeGUID] NOT IN (SELECT
														   [HANodeGUID]
													   FROM [#HA_DEF])) ;

IF @icnt > 0
    BEGIN
	   PRINT '=====>>>  ERROR: Test #7 FAILED - Return Distinct values not matching to definition data value.';
    END;
ELSE
    BEGIN
	   PRINT 'Test #7 Passed - Distinct values not matching to definition data value.';
    END;
GO

-- Above Tests Can be repeated for each Database on PROD 5
---
----  HA MODULE LEVEL TESTS 
--  Validate that the Module GUIDs match for both t he Health Assessment and Definitional data
--  the test will not need to include the HA Node GUID is the prior test completes succesfully and no data is returned
--  NOT ALL Module GUIDs may exist is a single Platform Database and therefore Each may produce diffenet results
--  However within a single instance the definitions should match the fact data GUID values 

PRINT CHAR (10) + CHAR (13) + 'Start Test 08 of 23 : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
PRINT 'NULL or Blank Values in the GUID are not allowed';
GO
DECLARE @icnt AS int = 0;
SET @icnt = (SELECT
				COUNT (*) 
		   --FROM [dbo].[view_EDW_HealthAssesment]
			FROM [#HA]
			WHERE [HAModuleNodeGUID] IS NULL) ;
IF @icnt > 0
    BEGIN
	   PRINT '=====>>>  ERROR: Test #8 FAILED - NULL or Blank Values in the GUID are not allowed.';
    END;
ELSE
    BEGIN
	   PRINT 'Test #8 Passed - NULL or Blank Values in the GUID are not allowed.';
    END;
GO

PRINT CHAR (10) + CHAR (13) + 'Start Test 09 of 23 : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
PRINT '-- NULL or Blank Values in the GUID are not allowed';
GO
DECLARE @icnt AS int = 0;
SET @icnt = (SELECT
				COUNT (*) 
		   --FROM [dbo].[view_EDW_HealthAssesmentDeffinition]
			FROM [#HA_DEF]
			WHERE [ModDocGuid] IS NULL) ;
IF @icnt > 0
    BEGIN
	   PRINT '=====>>>  ERROR: Test #9 FAILED - NULL or Blank Values in the GUID are not allowed.';
    END;
ELSE
    BEGIN
	   PRINT 'Test #9 Passed - NULL or Blank Values in the GUID are not allowed.';
    END;
GO
--  Any value other than zero means NULLs or blanks exist and must be eliminated.

PRINT CHAR (10) + CHAR (13) + 'Start Test 10 of 23 : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
PRINT 'Return Distinct values not matching to definition data value';
GO

DECLARE @icnt AS int = 0;
SET @icnt = (SELECT
				COUNT (*) 
		   --FROM [dbo].[view_EDW_HealthAssesment]
			FROM [#HA]
			WHERE [HAModuleNodeGUID] IS NOT NULL
				 --AND [HAModuleNodeGUID] NOT IN (SELECT DISTINCT [ModDocGuid] FROM [dbo].[view_EDW_HealthAssesmentDeffinition])) ;
			  AND [HAModuleNodeGUID] NOT IN (SELECT
											[ModDocGuid]
										FROM [#HA_DEF])) ;
IF @icnt > 0
    BEGIN
	   PRINT '=====>>>  ERROR: Test #10 FAILED - Return Distinct values not matching to definition data value.';
    END;
ELSE
    BEGIN
	   PRINT 'Test #10 Passed - NULL or Return Distinct values not matching to definition data value.';
    END;
GO

-- Above Tests Can be repeated for each Database on PROD 5
----  HA RISK CATEGORY LEVEL TESTS 
--  Validate that the Risk Category GUIDs match for both the Health Assessment and Definitional data and the specified MODULES
--  The MODULE and HA Document Version tests must be completed before executing this test
--  the test will need to include the HA Module GUID if the prior test completes succesfully and no data is returned
--  NOT ALL Risk Category GUIDs may exist is a single Platform Database and therefore Each may produce diffenet results
--  However within a single instance the definitions should match the fact data GUID values 

PRINT CHAR (10) + CHAR (13) + 'Start Test 11 of 23 : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
PRINT 'NULL or Blank Values in the GUID are not allowed';
GO
DECLARE @icnt AS int = 0;

-- Check for NULLs in GUID

SET @icnt = (SELECT
				COUNT (*) 
		   --FROM [dbo].[view_EDW_HealthAssesment]
			FROM [#HA]
			WHERE [HARiskCategoryNodeGUID] IS NULL
			  AND [HAModuleNodeGUID] IS NOT NULL) ;
IF @icnt > 0
    BEGIN
	   PRINT '=====>>>  ERROR: Test #11 FAILED';
    END;
ELSE
    BEGIN
	   PRINT 'Test #11 Passed';
    END;

PRINT CHAR (10) + CHAR (13) + 'Start Test 12 of 23 : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
PRINT 'NULL or Blank Values in the GUID are not allowed';
GO
DECLARE @icnt AS int = 0;
SET @icnt = (SELECT
				COUNT (*) 
		   --FROM [dbo].[view_EDW_HealthAssesmentDeffinition]
			FROM [#HA_DEF]
			WHERE [RCDocumentGUID] IS NULL
			  AND [ModDocGuid] IS NOT NULL) ;
IF @icnt > 0
    BEGIN
	   PRINT '=====>>>  ERROR: Test #12 FAILED';
    END;
ELSE
    BEGIN
	   PRINT 'Test #12 Passed';
    END;

GO
PRINT CHAR (10) + CHAR (13) + 'Start Test 13 of 23 : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
PRINT 'Return values not matching to definition data value';
GO
DECLARE @icnt AS int = 0;
PRINT 'Executing TEST 13';
SET @icnt = (SELECT
				COUNT (*) 
			FROM [#HA] AS [HAFACT]
			WHERE [HAFACT].[HARiskCategoryNodeGUID] IS NOT NULL
			  AND NOT EXISTS (
				 --SELECT [RCDocumentGUID] from #Temp13)
				 SELECT
					   [HADEF].[RCDocumentGUID]
				   FROM [#HA_DEF] AS [HADEF]
				   WHERE [HADEF].[HANodeGUID] = [HAFACT].[HealthAssesmentUserStartedNodeGUID]
					AND [HADEF].[ModDocGuid] = [HAFACT].[HAModuleNodeGUID]
					AND [HADEF].[RCDocumentGUID] = [HAFACT].[HARiskCategoryNodeGUID])) ;

IF @icnt > 0
    BEGIN
	   PRINT '=====>>>  ERROR: Test #13 FAILED';
    END;
ELSE
    BEGIN
	   PRINT 'Test #13 Passed';
    END;

--SELECT [HAFACT].[HAModuleNodeGUID], [HAFACT].[HARiskCategoryNodeGUID]
--  FROM [dbo].[view_EDW_HealthAssesment] AS [HAFACT]
--  WHERE [HAFACT].[HARiskCategoryNodeGUID] IS NOT NULL
--    AND NOT EXISTS (
--	   SELECT [HADEF].[RCDocumentGUID]
--		FROM [dbo].[view_EDW_HealthAssesmentDeffinition] AS [HADEF]
--		WHERE [HADEF].[HANodeGUID] = [HAFACT].[HealthAssesmentUserStartedNodeGUID]
--		  AND [HADEF].[ModDocGuid] = [HAFACT].[HAModuleNodeGUID]
--		  AND [HADEF].[RCDocumentGUID] = [HAFACT].[HARiskCategoryNodeGUID]) ;

--  Any values returned is a failed test
-- Above Tests Can be repeated for each Database on PROD 5
----  HA RISK AREA LEVEL TESTS 
--  Validate that the Risk Area GUIDs match for both the Health Assessment and Definitional data and the specified MODULE, 
--       RISK CATEGORY and RISK AREA Combination
--  The RISK CATEGORY, MODULE and HA Document Version tests must be completed before executing this test
--  the test will need to include the HA Module GUID if the prior test completes succesfully and no data is returned
--  NOT ALL Risk Area GUIDs may exist is a single Platform Database and therefore Each may produce different results
--  However within a single instance the definitions should match the fact data GUID values 

PRINT CHAR (10) + CHAR (13) + 'Start Test 14 of 23 : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
PRINT 'NULL or Blank Values in the GUID are not allowed';
GO
DECLARE @icnt AS int = 0;
-- Check for NULLs in GUID

SET @icnt = (SELECT
				COUNT (*) 
		   --FROM [dbo].[view_EDW_HealthAssesment]
			FROM [#HA]
			WHERE [HARiskAreaNodeGUID] IS NULL
			  AND [HARiskCategoryNodeGUID] IS NOT NULL
			  AND [HAModuleNodeGUID] IS NOT NULL) ;

IF @icnt > 0
    BEGIN
	   PRINT '=====>>>  ERROR: Test #14 FAILED';
    END;
ELSE
    BEGIN
	   PRINT 'Test #14 Passed';
    END;

GO
PRINT CHAR (10) + CHAR (13) + 'Start Test 15 of 23 : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
PRINT 'NULL or Blank Values in the GUID are not allowed';
GO
DECLARE @icnt AS int = 0;
SET @icnt = (SELECT
				COUNT (*) 
		   --FROM [dbo].[view_EDW_HealthAssesmentDeffinition]
			FROM [#HA_DEF]
			WHERE [RADocumentGuid] IS NULL
			  AND [RCDocumentGUID] IS NOT NULL
			  AND [ModDocGuid] IS NOT NULL) ;

IF @icnt > 0
    BEGIN
	   PRINT '=====>>>  ERROR: Test #15 FAILED';
    END;
ELSE
    BEGIN
	   PRINT 'Test #15 Passed';
    END;

--  Any value other than zero means NULLs or blanks exist and must be eliminated.
--  Validate that the Combination of Document Version, Module and Risk Category is valid and matches an entry in the Definition table

PRINT CHAR (10) + CHAR (13) + 'Start Test 16 of 23 : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
PRINT 'Return values not matching to definition data value';
GO

DECLARE @icnt AS int = 0;
--!PASSED

--WITH CTE (EmailAddr,CouponID, DuplicateCount)
--AS
--(
--SELECT EmailAddr,CouponID,
--ROW_NUMBER() OVER(PARTITION BY EmailAddr,CouponID ORDER BY EmailAddr) AS DuplicateCount
--FROM CouponPromoAssignment
--)
--DELETE
--FROM CTE
--WHERE DuplicateCount > 1
--GO

SET @icnt = (SELECT
				COUNT (*) 
		   --FROM [dbo].[view_EDW_HealthAssesment] AS [#HA]
			FROM [#HA]
			WHERE [#HA].[HARiskAreaNodeGUID] IS NOT NULL
			  AND NOT EXISTS (
				 SELECT
					   [#HA_DEF].[RADocumentGUID]
				   --FROM [dbo].[view_EDW_HealthAssesmentDeffinition] AS [#HA_DEF]
				   FROM [#HA_DEF]
				   WHERE [#HA_DEF].[HANodeGUID] = [#HA].[HealthAssesmentUserStartedNodeGUID]
					AND [#HA_DEF].[ModDocGuid] = [#HA].[HAModuleNodeGUID]
					AND [#HA_DEF].[RCDocumentGUID] = [#HA].[HARiskCategoryNodeGUID]
					AND [#HA_DEF].[RADocumentGuid] = [#HA].[HARiskAreaNodeGUID])) ;
IF @icnt > 0
    BEGIN
	   PRINT '=====>>>  ERROR: Test #16 FAILED';
    END;
ELSE
    BEGIN
	   PRINT 'Test #16 Passed';
    END;

--SELECT [HAFACT].[HealthAssesmentUserStartedNodeGUID]
--	, [HAFACT].[HAModuleNodeGUID]
--	, [HAFACT].[HARiskCategoryNodeGUID]
--	, [HAFACT].[HARiskAreaNodeGUID]
--  FROM [dbo].[view_EDW_HealthAssesment] AS [HAFACT]
--  WHERE [HAFACT].[HARiskAreaNodeGUID] IS NOT NULL
--    AND NOT EXISTS (
--	   SELECT [HADEF].[RADocumentGUID]
--		FROM [dbo].[view_EDW_HealthAssesmentDeffinition] AS [HADEF]
--		WHERE [HADEF].[HANodeGUID] = [HAFACT].[HealthAssesmentUserStartedNodeGUID]
--		  AND [HADEF].[ModDocGuid] = [HAFACT].[HAModuleNodeGUID]
--		  AND [HADEF].[RCDocumentGUID] = [HAFACT].[HARiskCategoryNodeGUID]
--		  AND [HADEF].[RADocumentGuid] = [HAFACT].[HARiskAreaNodeGUID]) ;

--  Any values returned is a failed test
-- Above Tests Can be repeated for each Database on PROD 5
----  HA QUESTION LEVEL TESTS 
--  Validate that the Question GUIDs match for both the Health Assessment and Definitional data and the specified MODULE, 
--       RISK CATEGORY, RISK AREA and Question Combination
--  The RISK AREA, RISK CATEGORY, MODULE and HA Document Version tests must be completed before executing this test
--  the test will need to include the HA Module GUID if the prior test completes succesfully and no data is returned
--  NOT ALL Question GUIDs may exist is a single Platform Database and therefore Each may produce different results
--  However within a single instance the definitions should match the fact data GUID values 

PRINT CHAR (10) + CHAR (13) + 'Start Test 17 of 23 : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
PRINT 'NULL or Blank Values in the GUID are not allowed';
GO
DECLARE @icnt AS int = 0;
-- Check for NULLs in GUID

SET @icnt = (SELECT
				COUNT (*) 
		   --FROM [dbo].[view_EDW_HealthAssesment]
			FROM [#HA]
			WHERE [HAQuestionGuid] IS NULL
			  AND [HARiskAreaNodeGUID] IS NOT NULL
			  AND [HARiskCategoryNodeGUID] IS NOT NULL
			  AND [HAModuleNodeGUID] IS NOT NULL) ;

IF @icnt > 0
    BEGIN
	   PRINT '=====>>>  ERROR: Test #17 FAILED';
    END;
ELSE
    BEGIN
	   PRINT 'Test #17 Passed';
    END;

GO
PRINT CHAR (10) + CHAR (13) + 'Start Test 18 of 23 : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
PRINT 'NULL or Blank Values in the GUID are not allowed';
GO
DECLARE @icnt AS int = 0;
SET @icnt = (SELECT
				COUNT (*) 
		   --FROM [dbo].[view_EDW_HealthAssesmentDeffinition]
			FROM [#HA_DEF]
			WHERE [QuesDocumentGuid] IS NULL
			  AND [RADocumentGuid] IS NOT NULL
			  AND [RCDocumentGUID] IS NOT NULL
			  AND [ModDocGuid] IS NOT NULL) ;

IF @icnt > 0
    BEGIN
	   PRINT '=====>>>  ERROR: Test #18 FAILED';
    END;
ELSE
    BEGIN
	   PRINT 'Test #18 Passed';
    END;
--  Any value other than zero means NULLs or blanks exist and must be eliminated.
--  Validate that the Combination of Document Version, Module and Risk Category is valid and matches an entry in the Definition table

PRINT CHAR (10) + CHAR (13) + 'Start Test 19 of 23 : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
GO
DECLARE @icnt AS int = 0;

IF OBJECT_ID ('tempdb..#TEMP_EDW_QuesValidation') IS NULL
    BEGIN
	   SELECT DISTINCT
			[#HA_DEF].[QuesDocumentGuid]
	   INTO
		   [#TEMP_EDW_QuesValidation]
		FROM
			--[dbo].[view_EDW_HealthAssesmentDeffinition] AS #HA_DEF
			[#HA_DEF] --JOIN [dbo].[view_EDW_HealthAssesment] AS [#HA]
			    JOIN [#HA]
				   ON [#HA_DEF].[HANodeGUID] = [#HA].[HealthAssesmentUserStartedNodeGUID]
				  AND [#HA_DEF].[ModDocGuid] = [#HA].[HAModuleNodeGUID]
				  AND [#HA_DEF].[RCDocumentGUID] = [#HA].[HARiskCategoryNodeGUID]
				  AND [#HA_DEF].[RADocumentGuid] = [#HA].[HARiskAreaNodeGUID]
				  AND [#HA_DEF].[QuesDocumentGuid] = [#HA].[HAQuestionGuid];

	   CREATE CLUSTERED INDEX [PK_TEMP_EDW_QuesValidation]
	   ON [#TEMP_EDW_QuesValidation] ([QuesDocumentGuid] ASC) ;
    END;

--Return values not matching to definition data value
DECLARE @icnt2 AS int;
--SELECT [#HA].[HealthAssesmentUserStartedNodeGUID], [#HA].[HAModuleNodeGUID], [#HA].[HARiskCategoryNodeGUID], [#HA].[HARiskAreaNodeGUID], [#HA].[HAQuestionGuid] FROM [dbo].[view_EDW_HealthAssesment] AS [HAFACT]
SET @icnt2 = (SELECT
				 COUNT (*) 
			 FROM [#HA]
			 WHERE [#HA].[HAQuestionGuid] IS NOT NULL
			   AND NOT EXISTS (
				  SELECT
					    [QuesDocumentGuid]
				    FROM [#TEMP_EDW_QuesValidation])) ;

--  Any value other than four means Unexpected NULLs or blanks exist and must be eliminated.
--  NULLs exist for Matrix Questions and will flow in to the views until they are eliminated   
--  Matrix Questions and their GUIDs should not exist in the Fact table        
IF @icnt2 > 0
    BEGIN
	   PRINT 'Test 19 FAILED (Return values not matching to definition data value) : FAILED returning ' + CAST (@icnt2 AS nvarchar (20)) + ' bad data items.';
    END;
ELSE
    BEGIN
	   PRINT 'Test 19 PASSED (Return values not matching to definition data value) : PASSED returning ZERO bad data items.';
    END;
PRINT 'END Test 19 of 23 : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;

-- Above Tests Can be repeated for each Database on PROD 5
----  HA ANSWER LEVEL TESTS 
--  Validate that the Answer GUIDs match for both the Health Assessment and Definitional data and the specified MODULE, 
--       RISK CATEGORY, RISK AREA, Question and Answer Combination
--  The QUESTION, RISK AREA, RISK CATEGORY, MODULE and HA Document Version tests must be completed before executing this test
--  the test will need to include the HA Module GUID if the prior test completes succesfully and no data is returned
--  NOT ALL Answer GUIDs may exist is a single Platform Database and therefore Each may produce different results
--  However within a single instance the definitions should match the fact data GUID values 

PRINT CHAR (10) + CHAR (13) + 'Start Test 20 of 23 : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
GO
DECLARE @icnt AS int = 0;
-- Check for NULLs in GUID

-- NULL or Blank Values in the GUID are not allowed
DECLARE @icnt4 AS int = 0;
SET @icnt4 = (SELECT
				 COUNT (*) 
			 FROM [dbo].[view_EDW_HealthAssesment]
			 WHERE [HAAnswerNodeGUID] IS NULL
			   AND [HAQuestionGuid] IS NOT NULL
			   AND [HARiskAreaNodeGUID] IS NOT NULL
			   AND [HARiskCategoryNodeGUID] IS NOT NULL
			   AND [HAModuleNodeGUID] IS NOT NULL) ;
IF @icnt4 > 0

    --  Any value other than four means Unexpected NULLs or blanks exist and must be eliminated.

    BEGIN

	   --  NULLs exist for Matrix Questions and will flow in to the views until they are eliminated   

	   PRINT 'Test 20 FAILED (NULL or Blank Values in the GUID are not allowed in Health Assessment) : FAILED returning ' + CAST (@icnt4 AS nvarchar (20)) + ' bad data items.';

    --  Matrix Questions and their GUIDs should not exist in the Fact table        

    END;
ELSE
    BEGIN
	   PRINT 'Test 20 PASSED (NULL or Blank Values in the GUID are not allowed in Health Assessment) : PASSED returning ZERO bad data items.';
    END;

PRINT CHAR (10) + CHAR (13) + 'Start Test 21 of 23 : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
GO
DECLARE @icnt AS int = 0;
DECLARE @icnt3 AS int = 0;

-- NULL or Blank Values in the GUID are not allowed
SET @icnt3 = (SELECT
				 COUNT (*) 
		    --FROM [dbo].[view_EDW_HealthAssesmentDeffinition]
			 FROM [#HA_DEF]
			 WHERE [AnsDocumentGuid] IS NULL
			   AND [QuesDocumentGuid] IS NOT NULL
			   AND [RADocumentGuid] IS NOT NULL
			   AND [RCDocumentGUID] IS NOT NULL
			   AND [ModDocGuid] IS NOT NULL) ;

--  Any value other than four means Unexpected NULLs or blanks exist and must be eliminated.
--  Matrix Questions and their GUIDs should not exist in the Fact table        
IF @icnt3 = 4
    BEGIN
	   PRINT 'Test 21 PASSED (NULL or Blank Values in the GUID are not allowed in Definition) : PASSED returning ' + CAST (@icnt3 AS nvarchar (20)) + ' bad data items.';
    END;

--  Any value other than four means Unexpected NULLs or blanks exist and must be eliminated.
--  NULLs exist for Matrix Questions and will flow in to the views until they are eliminated   
--  Matrix Questions and their GUIDs should not exist in the Fact table        
-- NULL or Blank Values in the GUID are not allowed
IF @icnt3 > 4
    BEGIN
	   PRINT 'Test 21 FAILED (NULL or Blank Values in the GUID are not allowed in Definition) : FAILED returning ' + CAST (@icnt3 AS nvarchar (20)) + ' bad data items.';
	   SELECT
			[AnsDocumentGuid]
		   , [QuesDocumentGuid]
		   , [RADocumentGuid]
		   , [RCDocumentGUID]
		   , [ModDocGuid]
	   --FROM [dbo].[view_EDW_HealthAssesmentDeffinition]
		FROM [#HA_DEF]
		WHERE [AnsDocumentGuid] IS NULL
		  AND [QuesDocumentGuid] IS NOT NULL
		  AND [RADocumentGuid] IS NOT NULL
		  AND [RCDocumentGUID] IS NOT NULL
		  AND [ModDocGuid] IS NOT NULL;
    END;

--IF NOT EXISTS (SELECT [name]
--			  FROM [sys].[indexes]
--			  WHERE [name] = 'PI_HAUserStart') 
--    BEGIN
--	   CREATE NONCLUSTERED INDEX [PI_HAUserStart] ON [dbo].[HFit_HealthAssesmentUserStarted] ([HACampaignNodeGUID]) INCLUDE ([ItemID] , [UserID]) ;
--    END;

--  Validate that the Combination of Document Version, Module, Risk Category, Risk Area, Question and Answer is valid and matches an entry in the Definition table

PRINT CHAR (10) + CHAR (13) + 'Start Test 22 of 23 : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
GO
DECLARE @icnt AS int = 0;

PRINT 'Step 22-1';
SET @icnt = (SELECT
				COUNT (*) AS [Cnt_TEMP_EDW_FACT]
			FROM [#HA]) ;

PRINT CHAR (10) + CHAR (13) + '*****************************************************************';
PRINT 'Total HA records: ' + CAST (@icnt AS nvarchar (50)) ;
SET @icnt = (SELECT
				COUNT (*) AS [TEMP_EDW_DEFF]
			FROM [#HA_DEF]) ;

PRINT 'Total Definition records: ' + CAST (@icnt AS nvarchar (50)) ;
PRINT '*****************************************************************';
PRINT CHAR (10) + CHAR (13) + 'Step 22-6';
PRINT  SYSDATETIME() ;

--select * from #HA

SET @icnt = (SELECT
				COUNT (*) AS [ErrCNT]
			FROM [#HA] AS [HADEF]
			WHERE [HADEF].[HAQuestionGuid] IS NOT NULL
			  AND NOT EXISTS (
				 SELECT
					   [AnsDocumentGuid]
				   FROM [#HA_DEF])) ;
PRINT 'Total ErrCNT records for test 22: ' + CAST (@icnt AS nvarchar (50)) ;

--  Any values returned is a failed test
PRINT 'ENDED Test 22 of 23 : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;

-- Above Tests Can be repeated for each Database on PROD 5
-----   GENERAL FACT DATA VALUE TESTS

PRINT CHAR (10) + CHAR (13) + 'Start Test 23 of 23 : ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
GO
DECLARE @icnt AS int = 0;
-- Check Started Date is present

SET @icnt = (SELECT
				COUNT (*) AS [HA Rows Missing Start Date]
			FROM [dbo].[view_EDW_HealthAssesment]
			WHERE [HAStartedDt] IS NULL) ;

PRINT 'TEST 23 returned ' + CAST (@icnt AS nvarchar (50)) + ' rows. (other than 0 rows fails)';

--   The ideal row count for this data is zero
GO

PRINT CHAR (10) + CHAR (13) + '*****************************************************************';
PRINT 'ALL TEST COMPELTE: ' + CAST (SYSDATETIME () AS nvarchar (50)) ;
PRINT '*****************************************************************';