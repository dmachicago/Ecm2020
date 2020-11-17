


alter VIEW [dbo].[View_Hfit_GoalTracker]
AS
select DISTINCT g.DocumentID,g.TrackerNodeGuid,t.Type,t.NodeSiteID As SiteID, g.NodeID
  from view_HFit_Goal_Joined g 
  inner join View_HFit_TrackerDocument_Joined t on g.TrackerNodeGuid = t.NodeGuid

UNION ALL

select DISTINCT g.DocumentID,g.TrackerNodeGuid,t.Type,t.NodeSiteID As SiteID, g.NodeID
  from view_HFit_Tobacco_Goal_Joined g 
  inner join View_HFit_TrackerDocument_Joined t on g.TrackerNodeGuid = t.NodeGuid


GO

  --  
  --  
GO 
print('***** FROM: View_Hfit_GoalTracker.sql'); 
GO 
