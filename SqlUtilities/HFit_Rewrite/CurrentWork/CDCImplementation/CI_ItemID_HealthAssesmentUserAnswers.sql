
GO
PRINT 'Creating CI_ItemID_HealthAssesmentUserAnswers.sql';
GO

IF NOT EXISTS ( SELECT
                       name
                  FROM sys.indexes
                  WHERE name = 'CI_ItemID_HealthAssesmentUserAnswers' )
    BEGIN
        CREATE NONCLUSTERED INDEX CI_ItemID_HealthAssesmentUserAnswers ON dbo.BASE_HFit_HealthAssesmentUserAnswers
        ( SVR, DBNAME, ItemID , HAQuestionItemID )
        INCLUDE(
        HAAnswerNodeGUID ,
        CodeName ,
        HAAnswerValue ,
        HAAnswerPoints ,
        UOMCode ,
        ItemCreatedWhen ,
        ItemModifiedWhen
        )WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
    END;

GO
PRINT 'Created CI_ItemID_HealthAssesmentUserAnswers.sql';
GO
