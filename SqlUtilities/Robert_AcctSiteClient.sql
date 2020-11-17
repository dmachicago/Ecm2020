	SELECT 
		A.AccountID, A.AccountCD, A.AccountName, A.SiteID, S.SiteName, CLIENT.ClientName, CLIENT.ClientID
	FROM
		  dbo.HFit_Account AS A
		  INNER JOIN dbo.CMS_Site AS S ON A.SiteID = S.SiteID
		  join View_Hfit_Client_Joined as CLIENT
	   on S.SiteName = CLIENT.SiteName
	--*****************************************************************************************************************
-- Developed 1.20.2015 for Robert S.
select C.AccountID, C.AccountCD, C.AccountName, A.SiteID, S.SiteName, CLIENT.ClientName, CLIENT.ClientID
from view_EDW_ClientCompany as C
    join HFIT_Account as A
	   on C.AccountID = A.AccountID
    join CMS_Site as S 
	   on A.SiteID = S.SiteID
    join View_Hfit_Client_Joined as CLIENT
	   on S.SiteName = CLIENT.SiteName

select * from Hfit_Client
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
