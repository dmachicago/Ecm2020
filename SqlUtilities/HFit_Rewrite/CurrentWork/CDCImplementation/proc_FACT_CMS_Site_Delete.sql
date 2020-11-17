

DECLARE @ProcName AS nvarchar (250) = 'proc_FACT_CMS_Site_Delete';
GO
DROP PROCEDURE
     proc_FACT_CMS_Site_Delete;
GO
CREATE PROCEDURE proc_FACT_CMS_Site_Delete
AS
BEGIN

    DECLARE
    @DELDATE AS  datetime2 ( 7) = GETDATE () ;
    -- select top 100 * from ##EdwHAHashkeys
    WITH CTE (
         UserID
    ) 
        AS (
        SELECT
               CT.UserID
               FROM
                   CHANGETABLE (CHANGES KenticoCMS_PRD_1.dbo.CMS_User, NULL) AS CT
                       RIGHT OUTER JOIN KenticoCMS_PRD_1.dbo.CMS_User AS BT
                           ON BT.UserID = CT.UserID
               WHERE SYS_CHANGE_OPERATION = 'D'
        ) 
        DELETE FT
               FROM FACT_CMS_User FT
                        INNER JOIN CTE CT
                            ON CT.USerID = FT.UserID;

    DECLARE
    @iDels AS int = @@ROWCOUNT;

    PRINT 'Deleted Record Count: ' + CAST ( @iDels AS nvarchar (50)) ;

END;