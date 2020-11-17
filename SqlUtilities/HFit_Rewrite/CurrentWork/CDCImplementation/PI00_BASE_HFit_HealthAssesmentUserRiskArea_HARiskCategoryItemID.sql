
GO
PRINT 'Executing PI00_BASE_HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID.sql';
GO
IF NOT EXISTS (SELECT name
                 FROM sys.indexes
                 WHERE name = 'PI00_BASE_HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID') 
    BEGIN
        CREATE NONCLUSTERED INDEX PI00_BASE_HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID
		  ON [dbo].[BASE_HFit_HealthAssesmentUserRiskArea] ([HARiskCategoryItemID],[HARiskAreaNodeGUID],[DBNAME])
    END;
GO
PRINT 'Executed PI00_BASE_HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID.sql';
GO