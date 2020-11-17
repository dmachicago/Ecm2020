

GO
PRINT 'Executing proc_SaveCTVerHist.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_SaveCTVerHist') 
    BEGIN
        DROP PROCEDURE
             proc_SaveCTVerHist;
    END;

GO

/*------------------------------------------------------------------------
select * from BASE_HFit_HealthAssesmentUserAnswers_CTVerHIST
Select count(*) from BASE_HFit_HealthAssesmentUserAnswers_CTVerHIST 
    where DBMS = 'XXXX' and SYS_CHANGE_VERSION = 200
select count(*) from BASE_HFit_HealthAssesmentUserAnswers

exec proc_SaveCTVerHist 'KenticoCMS_1', 'BASE_HFit_HealthAssesmentUserAnswers', 3
exec proc_SaveCTVerHist 'KenticoCMS_1', 'BASE_HFit_HealthAssesmentUserAnswers', -1
*/

/*------------------------------------------------------------------------------------------------------------
PROC: proc_SaveCTVerHist
    @DBNAME -	  The Instance name
    @Tbl	   -	  The Table to have change version tracking 
    @VerNO  -	  The version number to be entered into the tracking table. Use a -1 to get the current version.
			  NOTE: Execution using a -1 can take up to 5 minutes.
*/
CREATE PROCEDURE proc_SaveCTVerHist (@DBNAME AS NVARCHAR (100) , @Tbl NVARCHAR (100) , @VerNO AS BIGINT) 
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
           @iCnt AS BIGINT = 0;
    DECLARE
           @MySql  AS NVARCHAR (MAX) = '';
    DECLARE
           @HistTBL AS NVARCHAR (100) = '';
    DECLARE
           @T TABLE (
                    i INT) ;

    IF @VerNO = -1
        BEGIN
            SET @MySql = 'select max(SYS_CHANGE_VERSION) FROM CHANGETABLE (CHANGES ' + @tbl + ' , null) AS CTE_temp ';
            PRINT @MySql;
            INSERT INTO @T
            EXEC (@MySql) ;
            SELECT
                   @iCnt = i
                   FROM @T;
            SET @VerNO = @iCnt;
        END;

    SET @HistTBL = @Tbl + '_CTVerHIST';
    SET @MySql = 'Select count(*) from ' + @HistTBL + ' where DBMS = ''' + @DBNAME + ''' and SYS_CHANGE_VERSION = ' + CAST (@VerNO AS NVARCHAR (50)) ;
    --print @MySql ;

    INSERT INTO @T
    EXEC (@MySql) ;
    SELECT
           @iCnt = i
           FROM @T;

    IF @iCnt > 0
        BEGIN
            SET NOCOUNT OFF;
            --PRINT @HistTBL + ' already contains ver# ' + CAST (@VerNO AS NVARCHAR (50)) ;
            RETURN -1;
        END;
    SET @MySql = ' insert into ' + @HistTBL + ' (SYS_CHANGE_VERSION,DBMS) values (' + CAST (@VerNO AS NVARCHAR (50)) + ',''' + @DBNAME + ''')';
    --PRINT @MySql;
    EXEC (@MySql) ;
    RETURN 1;
    SET NOCOUNT OFF;
END;

GO
PRINT 'Executing proc_SaveCTVerHist.sql';
GO
