

GO
PRINT 'Executing proc_GetCTVerHist.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_GetCTVerHist') 
    BEGIN
        DROP PROCEDURE
             proc_GetCTVerHist;
    END;

GO

/*----------------------------------------------------------------------------
select * from BASE_HFit_HealthAssesmentUserAnswers_CTVerHIST
Select count(*) from BASE_HFit_HealthAssesmentUserAnswers_CTVerHIST 
    where DBMS = 'XXXX' and SYS_CHANGE_VERSION = 200
select count(*) from BASE_HFit_HealthAssesmentUserAnswers

declare @i as bigint = null ;
exec @i = proc_GetCTVerHist 'KenticoCMS_1', 'BASE_HFit_HealthAssesmentUserAnswers' ;
print @i ;
*/

/*----------------------------------------------------------------------------------------------------------
PROC: proc_GetCTVerHist
    @DBNAME -	  The Instance name
    @Tbl	  -	  The Table to have change version tracking 
    RETURNS -	  The current version number for change tracking for this table.
*/

CREATE PROCEDURE proc_GetCTVerHist (@DBNAME AS NVARCHAR (100) , @Tbl NVARCHAR (100)) 
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
           @iCnt AS BIGINT = 0
         , @MySql  AS NVARCHAR (MAX) = ''
         , @HistTBL AS NVARCHAR (100) = '';

    DECLARE
           @IntTable TABLE (
                           iValue INT) ;

    SET @HistTBL = @Tbl + '_CTVerHIST';
    SET @MySql = 'Select max(SYS_CHANGE_VERSION) from  ' + @HistTBL + ' where DBMS = ''' + @DBNAME + '''';
    --print @MySql ;

    INSERT INTO @IntTable
    EXEC (@MySql) ;
    SELECT
           @iCnt = iValue
           FROM @IntTable;
    --PRINT @iCnt;
    SET NOCOUNT OFF;
    return  @iCnt ;
END;

GO
PRINT 'Executing proc_GetCTVerHist.sql';
GO
