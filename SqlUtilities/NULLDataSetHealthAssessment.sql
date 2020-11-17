	select VHFHAMJ.Title AS ModTitle
	from 
		dbo.View_CMS_Tree_Joined AS VCTJ
			INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
			INNER JOIN dbo.HFit_Account AS HFA ON cs.SiteID = hfa.SiteID
			
			--WDM This seems to be the problem child - 7/3/2014
			inner JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON VCTJ.NodeID = VHFHAMJ.NodeParentID

select distinct 'TreeJoined' as ID, count(*) as CNT, NodeSiteID from View_CMS_Tree_Joined
group by NodeSiteID
UNION ALL
select distinct 'Acct' as ID,  count(*) as CNT, SiteID from HFit_Account
group by SiteID
UNION ALL
select distinct 'Site' as ID, count(*) as CNT, SiteID from CMS_Site
group by SiteID
UNION ALL
select distinct 'TreeJoinedNodeID' as ID, count(*) as CNT, NodeID  from View_CMS_Tree_Joined
group by NodeID
UNION ALL
select distinct 'ViewHAModule' as ID, count(*) as CNT, NodeParentID from View_HFit_HealthAssesmentModule_Joined
group by NodeParentID
order by 3,1

select distinct count(*) as CNT, NodeSiteID from View_CMS_Tree_Joined
group by NodeSiteID
UNION ALL
select distinct count(*) as CNT, SiteID from HFit_Account
group by SiteID
UNION ALL
select distinct count(*) as CNT, SiteID from CMS_Site
group by SiteID
UNION ALL
select distinct count(*) as CNT, NodeID  from View_CMS_Tree_Joined
group by NodeID
UNION ALL
select distinct count(*) as CNT, NodeParentID from View_HFit_HealthAssesmentModule_Joined
group by NodeParentID
order by 2


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
