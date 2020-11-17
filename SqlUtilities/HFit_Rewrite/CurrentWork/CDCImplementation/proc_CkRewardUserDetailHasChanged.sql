
/*
-CMS_Class
-CMS_Document
-CMS_Site
-CMS_Tree
-CMS_User
-CMS_UserSettings
-CMS_UserSite
-COM_SKU
-HFit_Account
HFit_LKP_RewardActivity
HFit_LKP_RewardLevelType
HFit_LKP_RewardTrigger
HFit_LKP_RewardType
HFit_RewardActivity
HFit_RewardException
HFit_RewardGroup
HFit_RewardLevel
HFit_RewardProgram
HFit_RewardsUserActivityDetail
HFit_RewardsUserLevelDetail
HFit_RewardTrigger
*/

GO
PRINT 'EXecuting proc_CkRewardUserDetailHasChanged.sql';
GO

IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_CkRewardUserDetailHasChanged' )
    BEGIN
        DROP PROCEDURE
             proc_CkRewardUserDetailHasChanged
    END;

GO
--exec [proc_CkRewardUserDetailHasChanged]
CREATE PROCEDURE proc_CkRewardUserDetailHasChanged
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
       @TempRewardUserDetail AS TABLE
       (
                                SYS_CHANGE_OPERATION nvarchar( 10 )
       );

    INSERT INTO @TempRewardUserDetail
    (
           SYS_CHANGE_OPERATION
    )
    SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE( CHANGES CMS_Class , NULL )AS CT
    UNION ALL
    SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE( CHANGES CMS_Document , NULL )AS CT
    UNION ALL
    SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE( CHANGES CMS_Site , NULL )AS CT
    UNION ALL
    SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE( CHANGES CMS_Tree , NULL )AS CT
    UNION ALL
    SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE( CHANGES CMS_User , NULL )AS CT
    UNION ALL
    SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE( CHANGES CMS_UserSettings , NULL )AS CT
    UNION ALL
    SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE( CHANGES CMS_UserSite , NULL )AS CT
    UNION ALL
    SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE( CHANGES COM_SKU , NULL )AS CT
    UNION ALL
    SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE( CHANGES HFit_Account , NULL )AS CT

UNION ALL
    SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE( CHANGES HFit_Account , NULL )AS CT

UNION ALL
    SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE( CHANGES HFit_LKP_RewardActivity , NULL )AS CT
UNION ALL
    SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE( CHANGES HFit_LKP_RewardLevelType , NULL )AS CT
UNION ALL
    SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE( CHANGES HFit_LKP_RewardTrigger , NULL )AS CT
UNION ALL
    SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE( CHANGES HFit_LKP_RewardType , NULL )AS CT
UNION ALL
    SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE( CHANGES HFit_RewardActivity , NULL )AS CT
UNION ALL
    SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE( CHANGES HFit_RewardException , NULL )AS CT
UNION ALL
    SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE( CHANGES HFit_RewardGroup , NULL )AS CT
UNION ALL
    SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE( CHANGES HFit_RewardLevel , NULL )AS CT
UNION ALL
    SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE( CHANGES HFit_RewardProgram , NULL )AS CT
UNION ALL
    SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE( CHANGES HFit_RewardsUserActivityDetail , NULL )AS CT
UNION ALL
    SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE( CHANGES HFit_RewardsUserLevelDetail , NULL )AS CT
UNION ALL
    SELECT SYS_CHANGE_OPERATION FROM CHANGETABLE( CHANGES HFit_RewardTrigger , NULL )AS CT
    

    SET @b = ( SELECT
                      COUNT( * )
                 FROM @TempRewardUserDetail );
    PRINT 'Number of changes found: ' + CAST( @b AS nvarchar( 50 ));


    IF @b > 0
        BEGIN

            SET @dels = ( SELECT
                                 COUNT( * )
                            FROM @TempRewardUserDetail
                            WHERE SYS_CHANGE_OPERATION = 'D' );
            SET @ins = ( SELECT
                                COUNT( * )
                           FROM @TempRewardUserDetail
                           WHERE SYS_CHANGE_OPERATION = 'I' );
            SET @updt = ( SELECT
                                 COUNT( * )
                            FROM @TempRewardUserDetail
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
PRINT 'EXecuted proc_CkRewardUserDetailHasChanged.sql';
GO
