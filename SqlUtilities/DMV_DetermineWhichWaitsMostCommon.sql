
-- exec sp_UTIL_ListMostCommonWaits
CREATE PROC sp_UTIL_ListMostCommonWaits
AS
BEGIN
    SELECT TOP 10
           wait_type
         , wait_time_ms
         , Percentage = 100. * wait_time_ms / SUM (wait_time_ms) OVER () 
           FROM sys.dm_os_wait_stats AS wt
           WHERE wt.wait_type NOT LIKE '%SLEEP%'
           ORDER BY
                    Percentage DESC;

    --GRANT EXECUTE ON OBJECT::dbo.sp_UTIL_ListMostCommonWaits TO public;
END;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

