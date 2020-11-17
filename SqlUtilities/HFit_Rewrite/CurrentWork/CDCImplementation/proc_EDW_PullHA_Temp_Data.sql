

GO
PRINT 'Executing proc_EDW_PullHA_Temp_Data.SQL';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_EDW_PullHA_Temp_Data') 
    BEGIN
        DROP PROCEDURE
             proc_EDW_PullHA_Temp_Data;
    END;
GO
-- exec proc_EDW_PullHA_Temp_Data 3000
CREATE PROCEDURE proc_EDW_PullHA_Temp_Data
     @CTversion AS int
AS
BEGIN
/*------------------------------------------------------------------------------------------
Author	  :	 W. Dale Miller
Date		  :	 July 30. 2015
@CTversion  :	 When NULL, causes all changes to be pulled.
			 When a number is provided, only changes after that version number are processed.
			 This can save massive amounts of time and resouce if limited by last pulled version ID. 

Helpers:	  :	 Select CHANGE_TRACKING_CURRENT_VERSION () ;
			 EXEC @LastVersion = proc_MASTER_LKP_CTVersion_Fetch 'BASE_HFit_TrackerWater' , 'proc_CT_FACT_TrackerCompositeDetails_TrackerWater';

*/
    IF OBJECT_ID ( 'tempdb..##HealthAssessmentData') IS NOT NULL
        BEGIN
            DROP TABLE
                 ##HealthAssessmentData;
        END;

    PRINT 'START the count: ' + CONVERT (varchar, SYSDATETIME () , 121) ;
    DECLARE @iCnt AS int = 0;
    SET @iCnt = (
                SELECT
                       COUNT (*) 
                       FROM VIEW_EDW_PULLHADATA_NOCT
                       WHERE
                       HAUserStarted_LastUpdateID >= @CTversion
                    OR CMSUSER_LastUpdateID >= @CTversion
                    OR USERSETTINGS_LastUpdateID >= @CTversion
                    OR USERSITE_LastUpdateID >= @CTversion
                       --or  CMSSITE_LastUpdateID >= @CTversion
                       --or  ACCT_LastUpdateID >= @CTversion
                    OR HAUSERMODULE_LastUpdateID >= @CTversion
                    OR VHCJ_LastUpdateID >= @CTversion
                    --OR VHAJ_LastUpdateID >= @CTversion
                    OR HARISKCATEGORY_LastUpdateID >= @CTversion
                    OR HAUSERRISKAREA_LastUpdateID >= @CTversion
                    OR HAUSERQUESTION_LastUpdateID >= @CTversion
                    OR HAQUESTIONSVIEW_LastUpdateID >= @CTversion
                    OR HAUSERQUESTIONGROUPRESULTS_LastUpdateID >= @CTversion
                    OR HAUSERANSWERS_LastUpdateID >= @CTversion);

    PRINT 'Pending Changes: ' + CAST ( @iCnt AS nvarchar (50)) ;
    PRINT 'END the count: ' + CONVERT (varchar, SYSDATETIME () , 121) ;
    PRINT 'START the pull: ' + CONVERT (varchar, SYSDATETIME () , 121) ;

    set ROWCOUNT @iCnt;
    SELECT TOP (@iCnt) 
           *
    INTO
         ##HealthAssessmentData
           FROM VIEW_EDW_PULLHADATA_NOCT
           WHERE
           HAUserStarted_LastUpdateID >= @CTversion
        OR CMSUSER_LastUpdateID >= @CTversion
        OR USERSETTINGS_LastUpdateID >= @CTversion
        OR USERSITE_LastUpdateID >= @CTversion
           --or  CMSSITE_LastUpdateID >= @CTversion
           --or  ACCT_LastUpdateID >= @CTversion
        OR HAUSERMODULE_LastUpdateID >= @CTversion
        OR VHCJ_LastUpdateID >= @CTversion
        --OR VHAJ_LastUpdateID >= @CTversion
        OR HARISKCATEGORY_LastUpdateID >= @CTversion
        OR HAUSERRISKAREA_LastUpdateID >= @CTversion
        OR HAUSERQUESTION_LastUpdateID >= @CTversion
        OR HAQUESTIONSVIEW_LastUpdateID >= @CTversion
        OR HAUSERQUESTIONGROUPRESULTS_LastUpdateID >= @CTversion
        OR HAUSERANSWERS_LastUpdateID >= @CTversion;

    declare @pulledCnt as bigint = @@ROWCOUNT;

    PRINT 'END the pull: ' + CONVERT (varchar, SYSDATETIME () , 121) ;
    PRINT 'START the indexing: ' + CONVERT (varchar, SYSDATETIME () , 121) ;

    IF NOT EXISTS ( SELECT
                           name
                           FROM sys.indexes
                           WHERE name = 'temp_PI_EDW_HealthAssessment_ChangeType') 

        BEGIN

            CREATE INDEX temp_PI_EDW_HealthAssessment_ChangeType ON ##HealthAssessmentData ( ChangeType) 
            WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF ,
            ALLOW_ROW_LOCKS = ON ,
            ALLOW_PAGE_LOCKS = ON) ;
        END;

    IF NOT EXISTS ( SELECT
                           name
                           FROM sys.indexes
                           WHERE name = 'temp_PI_EDW_HealthAssessment_NATKEY') 

        BEGIN

            CREATE INDEX temp_PI_EDW_HealthAssessment_NATKEY ON dbo.##HealthAssessmentData ( UserStartedItemID , UserGUID , PKHashCode , HashCode , LastModifiedDate
            );
        END;
    set ROWCOUNT 0;
    PRINT 'END the indexing: ' + CONVERT (varchar, SYSDATETIME () , 121) ;
    PRINT 'Completed proc_EDW_PullHA_Temp_Data: ' + CONVERT (varchar, SYSDATETIME () , 121) ;
    return @pulledCnt ;

END;
GO
PRINT 'Executed proc_EDW_PullHA_Temp_Data.SQL';
GO 
