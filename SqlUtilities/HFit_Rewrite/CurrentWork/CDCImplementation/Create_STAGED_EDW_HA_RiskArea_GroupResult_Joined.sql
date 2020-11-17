
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'FACT_EDW_HA_RiskArea_GroupResult_Joined') 
    BEGIN
        CREATE TABLE dbo.FACT_EDW_HA_RiskArea_GroupResult_Joined (
                     UserRiskAreaItemID INT NULL
                   , HARISKCATEGORYITEMID INT NULL
                   , HAUserRiskArea_CodeName NVARCHAR (100) NOT NULL
                   , HARISKAREANODEGUID UNIQUEIDENTIFIER NOT NULL
                   , HARISKAREASCORE FLOAT NULL
                   , RISKAREAPREWEIGHTEDSCORE FLOAT NULL
                   , RISKAREA_ITEMMODIFIEDWHEN DATETIME2 (7) NULL
                   , RISKAREA_LASTMODIFIED DATETIME NOT NULL
                   , HARISKAREAITEMID INT NULL
                   , POINTRESULTS INT NULL
                   , QUESTIONGROUPCODENAME NVARCHAR (100) NULL
                   , GRPRESULT_LASTMODIFIED DATETIME NULL
                   , LASTUPDATEID INT NULL
                   , LASTLOADEDDATE DATETIME NULL
        ) 
        ON [PRIMARY];
        EXEC proc_Add_EDW_CT_StdCols '[FACT_EDW_HA_RiskArea_GroupResult_Joined]';
    END;

DECLARE @iRows AS BIGINT = 0;
EXEC @iRows = proc_QuickRowCount 'FACT_EDW_HA_RiskArea_GroupResult_Joined';
--drop table FACT_EDW_HA_RiskArea_GroupResult_Joined
IF @irows = 0
    BEGIN
        INSERT INTO FACT_EDW_HA_RiskArea_GroupResult_Joined
        (
               UserRiskAreaItemID
             , HARISKCATEGORYITEMID
             , HAUserRiskArea_CodeName
             , HARISKAREANODEGUID
             , HARISKAREASCORE
             , RISKAREAPREWEIGHTEDSCORE
             , RISKAREA_ITEMMODIFIEDWHEN
             , RISKAREA_LASTMODIFIED
             , HARISKAREAITEMID
             , POINTRESULTS
             , QUESTIONGROUPCODENAME
             , GRPRESULT_LASTMODIFIED) 
        SELECT
        --HAUSERRISKAREA.ITEMID
               HAUserRiskArea.ITEMID AS UserRiskAreaItemID
      , HAUserRiskArea.HARISKCATEGORYITEMID
      , HAUserRiskArea.CODENAME AS HAUserRiskArea_CodeName
      , HAUserRiskArea.HARISKAREANODEGUID
      , HAUserRiskArea.HARISKAREASCORE
      , HAUserRiskArea.PREWEIGHTEDSCORE AS RISKAREAPREWEIGHTEDSCORE
      , HAUserRiskArea.ITEMMODIFIEDWHEN AS RISKAREA_ITEMMODIFIEDWHEN
      , HAUserRiskArea.LASTLOADEDDATE AS RISKAREA_LASTMODIFIED

      , HAUserQestionGroupResults.HARISKAREAITEMID
      , HAUserQestionGroupResults.POINTRESULTS
      , HAUserQestionGroupResults.CODENAME AS QUESTIONGROUPCODENAME
      , HAUserQestionGroupResults.LASTLOADEDDATE AS GRPRESULT_LASTMODIFIED
               FROM
        FACT_EDW_HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea
            LEFT JOIN DBO.FACT_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS AS HAUserQestionGroupResults
                ON HAUserRiskArea.ITEMID = HAUserQestionGroupResults.HARISKAREAITEMID;

        CREATE NONCLUSTERED INDEX PI_HEALTHASSESMENTUSERRISKAREA_Category_Joined ON dbo.FACT_EDW_HA_RiskArea_GroupResult_Joined
        (
        HARISKCATEGORYITEMID ASC
        ) 
        INCLUDE ( 	HAUserRiskArea_CodeName,
        HARISKAREANODEGUID,
        HARISKAREASCORE,
        RISKAREAPREWEIGHTEDSCORE,
        RISKAREA_ITEMMODIFIEDWHEN,
        LASTUPDATEID,
        LASTLOADEDDATE,
        SVR,
        DBNAME,
        DeletedFlg) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

        CREATE NONCLUSTERED INDEX PI_HealthAssesmentUserQuestionGroupResults_Joined ON dbo.FACT_EDW_HA_RiskArea_GroupResult_Joined
        (
        HARISKAREAITEMID ASC
        ) 
        INCLUDE ( 	POINTRESULTS,
        HAUserRiskArea_CodeName) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

    --CREATE NONCLUSTERED INDEX PI_Staged_HAUserQuestionGroupResults_Joined ON dbo.FACT_EDW_HA_RiskArea_GroupResult_Joined
    --(
    --HARISKAREAITEMID ASC
    --) 
    --INCLUDE ( 	ITEMID,
    --POINTRESULTS,
    --CODENAME) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

    END;