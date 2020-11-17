
--CREATE VIEW [dbo].[View_EDW_ScreeningEventData] AS 
SELECT 
	SE.Name AS ScreeningEventName
	, SE.[Type] as ScreeningEventType
	, SE.[ScreeningEventID] 
	--, HFit_ScreeningEventDate.ScreeningEventDateID
	, HFit_ScreeningEventDate.Date as ScreeningEventDate
	, HFit_ScreeningEventDate.Location as ScreeningEventDateLocation
	, HFit_ScreeningEventDate.Name as ScreeningEventDateName
	, HFit_ScreeningEventDate.Room as ScreeningEventDateRoom
	, View_CMS_Tree_Joined.NodeGUID
	, View_CMS_Tree_Joined.NodeSKUID
	, View_CMS_Tree_Joined.NodeDocType
	, View_CMS_Tree_Joined.DocumentLastVersionType
	, View_CMS_Tree_Joined.DocumentGUID
	, View_CMS_Tree_Joined.SKUGUID
	, View_CMS_Tree_Joined.SKUMembershipGUID
	, View_CMS_Tree_Joined.SKUParentSKUID		
	, View_CMS_Tree_Joined.DocumentModifiedWhen
	, View_CMS_Tree_Joined.DocumentCreatedWhen
	, View_CMS_Tree_Joined.DocumentLastVersionNumber		
FROM    View_CMS_Tree_Joined 
		INNER JOIN HFit_ScreeningEventDate ON View_CMS_Tree_Joined.DocumentForeignKeyValue = HFit_ScreeningEventDate.ScreeningEventDateID 
		INNER JOIN HFit_ScreeningEvent AS SE ON SE.ScreeningEventID = HFit_ScreeningEventDate.ScreeningEventDateID
WHERE  (View_CMS_Tree_Joined.ClassName = 'HFit.ScreeningEventDate')

