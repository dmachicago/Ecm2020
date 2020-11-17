use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_EligibilityHistory' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_EligibilityHistory
END
GO


--****************************************************
Select DISTINCT top 100 
     GroupName
    ,UserMpiNumber
    ,StartedDate
    ,EndedDate
    ,RowNbr
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_EligibilityHistory
FROM
view_EDW_EligibilityHistory where UserMpiNumber > 0;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_EligibilityHistory' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_EligibilityHistory
END
GO


--****************************************************
Select DISTINCT top 100 
     GroupName
    ,UserMpiNumber
    ,StartedDate
    ,EndedDate
    ,RowNbr
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_EligibilityHistory
FROM
view_EDW_EligibilityHistory  where UserMpiNumber > 0;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_EligibilityHistory order by UserMpiNumber;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_EligibilityHistory order by UserMpiNumber;

--update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_EligibilityHistory'; 