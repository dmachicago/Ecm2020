

GO
PRINT 'EXecuting proc_CkSmallStepsHasChanged.sql';
GO

IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_CkSmallStepsHasChanged' )
    BEGIN
        DROP PROCEDURE
             proc_CkSmallStepsHasChanged
    END;

GO
--exec [proc_CkSmallStepsHasChanged]
CREATE PROCEDURE proc_CkSmallStepsHasChanged
AS
BEGIN
/*
Author:	  W. Dale Miller
RETURNS:	  Integer -   0 = no changes
				    1 = updates or inserts, no deletes
				    2 = DELETES and possibly updates or inserts
*/
    DECLARE
       @b AS int = 0,
       @dels AS int = 0,
       @ins AS int = 0,
       @updt AS int = 0;

    DECLARE
       @TempSmallSteps AS TABLE
       (
                                SYS_CHANGE_OPERATION nvarchar( 10 )
       );

    INSERT INTO @TempSmallSteps
    (
           SYS_CHANGE_OPERATION
    )
    SELECT
           SYS_CHANGE_OPERATION
      FROM CHANGETABLE( CHANGES CMS_Class , NULL )AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
      FROM CHANGETABLE( CHANGES CMS_Document , NULL )AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
      FROM CHANGETABLE( CHANGES CMS_Site , NULL )AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
      FROM CHANGETABLE( CHANGES CMS_Tree , NULL )AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
      FROM CHANGETABLE( CHANGES CMS_User , NULL )AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
      FROM CHANGETABLE( CHANGES CMS_UserSettings , NULL )AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
      FROM CHANGETABLE( CHANGES CMS_UserSite , NULL )AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
      FROM CHANGETABLE( CHANGES COM_SKU , NULL )AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
      FROM CHANGETABLE( CHANGES HFit_Account , NULL )AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
      FROM CHANGETABLE( CHANGES HFit_HACampaign , NULL )AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
      FROM CHANGETABLE( CHANGES HFit_HealthAssesmentUserStarted , NULL )AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
      FROM CHANGETABLE( CHANGES HFit_OutComeMessages , NULL )AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
      FROM CHANGETABLE( CHANGES Hfit_SmallStepResponses , NULL )AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
      FROM CHANGETABLE( CHANGES HFit_ToDoSmallSteps , NULL )AS CT;

    SET @b = ( SELECT
                      COUNT( * )
                 FROM @TempSmallSteps );
    PRINT 'Number of changes found: ' + CAST( @b AS nvarchar( 50 ));


    IF @b > 0
        BEGIN

            SET @dels = ( SELECT
                                 COUNT( * )
                            FROM @TempSmallSteps
                            WHERE SYS_CHANGE_OPERATION = 'D' );
            SET @ins = ( SELECT
                                COUNT( * )
                           FROM @TempSmallSteps
                           WHERE SYS_CHANGE_OPERATION = 'I' );
            SET @updt = ( SELECT
                                 COUNT( * )
                            FROM @TempSmallSteps
                            WHERE SYS_CHANGE_OPERATION = 'U' );

            PRINT 'Number of inserts: ' + CAST( @ins AS nvarchar( 50 ));
            PRINT 'Number of updates: ' + CAST( @updt AS nvarchar( 50 ));
            PRINT 'Number of deletes: ' + CAST( @dels AS nvarchar( 50 ));

            IF @dels > 0
                BEGIN
                    SET @b = 2 ;
                END
            ELSE
                BEGIN
                    SET @b = 1;
                END;
        END;
    print 'Returned Value: ' + cast(@b as nvarchar(50)) ;
    RETURN @b;

END;

GO
PRINT 'EXecuted proc_CkSmallStepsHasChanged.sql';
GO
