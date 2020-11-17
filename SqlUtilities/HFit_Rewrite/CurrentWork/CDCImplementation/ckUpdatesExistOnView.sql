
CREATE FUNCTION [udf_CkUserTrackerHasChanged] (@TF bit )
RETURNS INT
AS
begin

declare @UpdatesFOund as nvarchar(10) = '' ; 
declare @b as bit = 0 ;

set @UpdatesFOund = 
(
SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_UserTracker , NULL) AS [CT]
union 
SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES CMS_Site , NULL) AS [CT]
union 
SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES CMS_UserSettings , NULL) AS [CT]
union 
SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES CMS_UserSettings , NULL) AS [CT]
union 
SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_Account , NULL) AS [CT]
union 
SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_TrackerCollectionSource , NULL) AS [CT]
)

if (@UpdatesFOund is null)
    set @b = 0;
else 
    set @b = 1;

return @b;

end 