
GO

PRINT '***** EXecute : DropViewCleanUp.sql';
GO

--11.03.2014 Executed against PROD with Mike K.
IF EXISTS (SELECT [name]
		   FROM [sys].[views]
		   WHERE [name] = 'View_EDW_CDC_HealthAssesmentUserAnswers') 
    BEGIN
	   DROP VIEW [View_EDW_CDC_HealthAssesmentUserAnswers]
    END;
GO
IF EXISTS (SELECT [name]
		   FROM [sys].[views]
		   WHERE [name] = 'View_EDW_HAModuleNodeGUID') 
    BEGIN
	   DROP VIEW [View_EDW_HAModuleNodeGUID]
    END;
GO
IF EXISTS (SELECT [name]
		   FROM [sys].[views]
		   WHERE [name] = 'View_EDW_HARiskCategoryNodeGUID') 
    BEGIN
	   DROP VIEW [View_EDW_HARiskCategoryNodeGUID]
    END;
GO
IF EXISTS (SELECT [name]
		   FROM [sys].[views]
		   WHERE [name] = 'View_EDW_HFit_HealthAssesmentUserAnswers') 
    BEGIN
	   DROP VIEW [View_EDW_HFit_HealthAssesmentUserAnswers]
    END;
GO
IF EXISTS (SELECT [name]
		   FROM [sys].[views]
		   WHERE [name] = 'View_EDW_HFit_HealthAssesmentUserModule') 
    BEGIN
	   DROP VIEW [View_EDW_HFit_HealthAssesmentUserModule]
    END;
GO
if exists(select name from sys.views where name = 'View_EDW_HFit_HealthAssesmentUserQuestion')
DROP VIEW View_EDW_HFit_HealthAssesmentUserQuestion
GO
IF EXISTS (SELECT [name]
		   FROM [sys].[views]
		   WHERE [name] = 'View_EDW_HFit_HealthAssesmentUserRiskArea') 
    BEGIN
	   DROP VIEW [View_EDW_HFit_HealthAssesmentUserRiskArea]
    END;
GO
IF EXISTS (SELECT [name]
		   FROM [sys].[views]
		   WHERE [name] = 'View_EDW_HFit_HealthAssesmentUserRiskCategory') 
    BEGIN
	   DROP VIEW [View_EDW_HFit_HealthAssesmentUserRiskCategory]
    END;
GO
IF EXISTS (SELECT [name]
		   FROM [sys].[views]
		   WHERE [name] = 'View_EDW_HFit_HealthAssesmentUserStarted') 
    BEGIN
	   DROP VIEW [View_EDW_HFit_HealthAssesmentUserStarted]
    END;
GO
IF EXISTS (SELECT [name]
		   FROM [sys].[views]
		   WHERE [name] = 'View_EDW_QuestionNodeGuid') 
    BEGIN
	   DROP VIEW [View_EDW_QuestionNodeGuid]
    END;
GO
IF EXISTS (SELECT [name]
		   FROM [sys].[views]
		   WHERE [name] = 'View_EDW_RiskAreaNodeGuid') 
    BEGIN
	   DROP VIEW [View_EDW_RiskAreaNodeGuid]
    END;
GO
IF EXISTS (SELECT [name]
		   FROM [sys].[views]
		   WHERE [name] = 'View_HFit_HealthAssesmentUserModule') 
    BEGIN
	   DROP VIEW [View_HFit_HealthAssesmentUserModule]
    END;
GO
--  
--  
PRINT '***** FROM: DropViewCleanUp.sql';
GO 
