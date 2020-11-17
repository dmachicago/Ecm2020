
-- use KenticoCMS_PRD_1
GO
PRINT 'Executing proc_HFIT_PPTEligibility_AddDeletedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_HFIT_PPTEligibility_AddDeletedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_HFIT_PPTEligibility_AddDeletedRecs;
    END;
GO
-- delete from HFIT_PPTEligibility where PPTID = 1 
-- EXEC proc_HFIT_PPTEligibility_AddDeletedRecs
CREATE PROCEDURE proc_HFIT_PPTEligibility_AddDeletedRecs  (@SVR as nvarchar(100), @DBNAME as nvarchar(100))
AS
BEGIN

    UPDATE STAGING_HFIT_PPTEligibility
           SET
               DeletedFlg = 1
             ,LastModifiedDate = GETDATE () 
    WHERE
          PPTID IN
          (SELECT
                  PPTID
                  FROM CHANGETABLE (CHANGES HFIT_PPTEligibility, NULL) AS CT
                  WHERE SYS_CHANGE_OPERATION = 'D') 
      AND DeletedFlg IS NULL;

    DECLARE
    @iCnt AS int = @@ROWCOUNT;
    PRINT 'Deleted Count: ' + CAST ( @iCnt AS nvarchar (50)) ;

	exec proc_CT_HFIT_PPTEligibility_History 'D' ;

    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_HFIT_PPTEligibility_AddDeletedRecs.sql';
GO
