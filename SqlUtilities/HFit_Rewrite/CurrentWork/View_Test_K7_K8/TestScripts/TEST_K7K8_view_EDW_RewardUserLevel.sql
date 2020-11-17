-------- VIEW BEING PROCESSED -------- 
-------- view_EDW_RewardUserLevel
----------------------------------------
use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_RewardUserLevel' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_RewardUserLevel
END
GO


--****************************************************
Select DISTINCT top 1000 
     UserId
    ,LevelCompletedDt
    ,LevelName
    ,SiteName
    ,nodeguid
    ,SiteGuid
    ,LevelHeader
    ,GroupHeadingText
    ,GroupHeadingDescription
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_RewardUserLevel
FROM
KenticoCMS_PRD_prod3K7.dbo.view_EDW_RewardUserLevel order by UserID;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_RewardUserLevel' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_RewardUserLevel
END
GO


--****************************************************
Select DISTINCT top 1000 
     UserId
    ,LevelCompletedDt
    ,LevelName
    ,SiteName
    ,nodeguid
    ,SiteGuid
    ,LevelHeader
    ,GroupHeadingText
    ,GroupHeadingDescription
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_RewardUserLevel
FROM
KenticoCMS_PRD_prod3K8.dbo.view_EDW_RewardUserLevel  order by UserID;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_RewardUserLevel order by UserID;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_RewardUserLevel order by UserID;

--update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_RewardUserLevel'; 
select * from HFit_EDW_K7K8_TestDDL order by [RowNbr] desc ; 
