
GO
USE KenticoCMS_DataMart;

GO
PRINT 'Processing: view_EDW_RewardTriggerParameters_CT ';
PRINT 'FROM: view_EDW_RewardTriggerParameters_CT.sql ';
GO

IF EXISTS (SELECT
                  NAME
                  FROM sys.VIEWS
                  WHERE NAME = 'view_EDW_RewardTriggerParameters_CT') 
    BEGIN
        DROP VIEW
             view_EDW_RewardTriggerParameters_CT;
    END;
GO

--*******************************************************************************************************************
--8/7/2014  VHFRTJ.DocumentGuid		  --WDM Added in case needed
--8/7/2014  VHFRTJ.NodeGuid			  --WDM Added in case needed
--09.11.2014 : (wdm) Verified last mod date available to EDW - RewardTriggerParameter_DocumentModifiedWhen
--11.17.2014 : (wdm) John C. found that Spanish was being brought across in TriggerName and 
--				ParameterDisplayName. Found that View_HFit_RewardTrigger_Joined has no way to limit the 
--				returned data to Spanish. Created a new view, View_EDW_RewardProgram_Joined, and provided 
--				a FILTER on Document Culture. The, added Launguage fitlers as: 
--					where VHFRTJ.DocumentCulture = 'en-US' AND VHFRTPJ.DocumentCulture = 'en-US'
--				This appears to have eliminated the Spanish.
-- 03.03.2015 : (Dale/Natahn) no changes required.
-- 04.12.2015 : (WDM) In order to implement change tracking on this view, a STAGING table will simply be 
--			 dropped and recreated everytime using this view. It is too small to worry about otherwise.
-- 04.12.2015 : created view view_EDW_RewardTriggerParameters_CT so that change tracking would be consistent.
--SELECT * FROM [view_EDW_RewardTriggerParameters_CT]
--*******************************************************************************************************************
/*
select count(*), SiteGUID, RewardTriggerID, ParameterDisplayName, RewardTriggerParameterOperator, [Value], AccountID, AccountCD, DocumentGuid, NodeGuid
from [view_EDW_RewardTriggerParameters_CT]
group by SiteGUID
                    , RewardTriggerID
                    , ParameterDisplayName
                    , RewardTriggerParameterOperator
                    , [Value]
                    , AccountID
                    , AccountCD
                    , DocumentGuid
                    , NodeGuid
having count(*) > 1

select distinct count(*), SiteGUID,RewardTriggerID,AccountID,AccountCD,DocumentGuid,NodeGuid,RewardTriggerParameterOperatorLKPDisplayName
from [view_EDW_RewardTriggerParameters_CT]
group by SiteGUID,RewardTriggerID,AccountID,AccountCD,DocumentGuid,NodeGuid,RewardTriggerParameterOperatorLKPDisplayName
having count(*) > 1
go
*/

CREATE VIEW dbo.view_EDW_RewardTriggerParameters_CT
AS
--8/7/2014 - added and commented out DocumentGuid and NodeGuid in case needed later
--8/8/2014 - Generated corrected view in DEV (WDM)
SELECT DISTINCT
       cs.SiteGUID															 --CMS_Site
     , VHFRTJ.RewardTriggerID													 --HFit_RewardTrigger
     , VHFRTJ.TriggerName													 --HFit_RewardTrigger
     , HFLRTPO.RewardTriggerParameterOperatorLKPDisplayName							 --HFit_LKP_RewardTriggerParameterOperator 
     , VHFRTPJ.ParameterDisplayName											 --HFit_RewardTriggerParameter
     , VHFRTPJ.RewardTriggerParameterOperator									 --HFit_RewardTriggerParameter
     , VHFRTPJ.Value														 --HFit_RewardTriggerParameter
     , hfa.AccountID														 --HFit_Account
     , hfa.AccountCD														 --HFit_Account
     , CASE	WHEN CAST (VHFRTJ.DocumentCreatedWhen AS DATE) = CAST (VHFRTJ.DocumentModifiedWhen AS DATE) 
               THEN 'I'
           ELSE 'U'
       END AS ChangeType
     , VHFRTJ.DocumentGuid													 --CMS_Document
     , VHFRTJ.NodeGuid														 --CMS_Document
     , VHFRTJ.DocumentCreatedWhen												 --CMS_Document
     , VHFRTJ.DocumentModifiedWhen												 --CMS_Document
     , VHFRTPJ.DocumentModifiedWhen AS RewardTriggerParameter_DocumentModifiedWhen	  	 --CMS_Document
     , VHFRTPJ.documentculture AS documentculture_VHFRTPJ							 --CMS_Document
     , VHFRTJ.documentculture AS documentculture_VHFRTJ								 --CMS_Document
     , HASHBYTES ('sha1',
       ISNULL (CAST (cs.SiteGUID AS NVARCHAR (50)) , '-') + ISNULL (CAST (VHFRTJ.RewardTriggerID AS NVARCHAR (50)) , '-') + ISNULL (CAST (VHFRTJ.TriggerName AS NVARCHAR (250)) , '-') + ISNULL (CAST (HFLRTPO.RewardTriggerParameterOperatorLKPDisplayName AS NVARCHAR (250)) , '-') + ISNULL (CAST (VHFRTPJ.ParameterDisplayName AS NVARCHAR (250)) , '-') + ISNULL (CAST (VHFRTPJ.RewardTriggerParameterOperator AS NVARCHAR (50)) , '-') + ISNULL (CAST (VHFRTPJ.Value AS NVARCHAR (50)) , '-') + ISNULL (CAST (VHFRTJ.DocumentGuid AS NVARCHAR (50)) , '-') + ISNULL (CAST (VHFRTJ.NodeGuid AS NVARCHAR (50)) , '-') + ISNULL (CAST (VHFRTJ.DocumentCreatedWhen AS NVARCHAR (50)) , '-') + ISNULL (CAST (VHFRTJ.DocumentModifiedWhen AS NVARCHAR (50)) , '-') + ISNULL (CAST (VHFRTPJ.DocumentModifiedWhen AS NVARCHAR (50)) , '-') 
       ) AS HashCode

     , @@SERVERNAME AS SVR
     , DB_NAME () AS DBNAME
       FROM dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ --dbo.[View_EDW_RewardProgram_Joined] AS VHFRTJ 		
                INNER JOIN dbo.View_HFit_RewardTriggerParameter_Joined AS VHFRTPJ
                    ON vhfrtj.NodeID = VHFRTPJ.NodeParentID
                   AND vhfrtj.SVR = VHFRTPJ.SVR
                   AND vhfrtj.DBNAME = VHFRTPJ.DBNAME
                INNER JOIN dbo.BASE_HFit_LKP_RewardTriggerParameterOperator AS HFLRTPO
                    ON VHFRTPJ.RewardTriggerParameterOperator = HFLRTPO.RewardTriggerParameterOperatorLKPID
                   AND VHFRTPJ.SVR = HFLRTPO.SVR
                   AND VHFRTPJ.DBNAME = HFLRTPO.DBNAME
                INNER JOIN dbo.BASE_CMS_Site AS CS
                    ON VHFRTJ.NodeSiteID = cs.SiteID
                   AND VHFRTJ.SVR = cs.SVR
                   AND VHFRTJ.DBNAME = cs.DBNAME
                INNER JOIN dbo.BASE_HFit_Account AS HFA
                    ON cs.SiteID = HFA.SiteID
                   AND cs.SVR = HFA.SVR
                   AND cs.DBNAME = HFA.DBNAME

       WHERE VHFRTJ.DocumentCulture = 'en-US'
         AND VHFRTPJ.DocumentCulture = 'en-US';

GO

--  
--  
GO
PRINT '***** Created: view_EDW_RewardTriggerParameters_CT.sql';
GO 
