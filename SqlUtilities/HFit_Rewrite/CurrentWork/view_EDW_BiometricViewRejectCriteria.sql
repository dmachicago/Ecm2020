
go

if exists (select name from sys.views where name = 'view_EDW_BiometricViewRejectCriteria')
    drop view view_EDW_BiometricViewRejectCriteria ;
go

CREATE VIEW [dbo].[view_EDW_BiometricViewRejectCriteria]
AS
	 SELECT
			AccountCD
		  , cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
		  , SiteID
		  , RejectGUID
	   FROM dbo.EDW_BiometricViewRejectCriteria;

GO


