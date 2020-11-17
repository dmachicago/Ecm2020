
GO
PRINT 'Executing proc_CT_CoachingDetail_AddDeletedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_CT_CoachingDetail_AddDeletedRecs' )
    BEGIN
        DROP PROCEDURE
             proc_CT_CoachingDetail_AddDeletedRecs;
    END;
GO
CREATE PROCEDURE proc_CT_CoachingDetail_AddDeletedRecs
AS
BEGIN
    WITH CTE (
         ItemGUID
         ,GoalID
         ,UserGUID
         ,SiteGUID
         ,AccountID
         ,AccountCD
         ,WeekendDate
         ,NodeGUID )
        AS ( SELECT
                    ISNULL( ItemGUID , '00000000-0000-0000-0000-000000000000' )
                    ,ISNULL( GoalID , -1 )
                    ,ISNULL( UserGUID , '00000000-0000-0000-0000-000000000000' )
                    ,ISNULL( SiteGUID , '00000000-0000-0000-0000-000000000000' )
                    ,ISNULL( AccountID , ' ' )
                    ,ISNULL( AccountCD , ' ' )
                    ,ISNULL( WeekendDate , '01/01/1900' )
                    ,ISNULL( NodeGUID , '00000000-0000-0000-0000-000000000000' )
               FROM DIM_EDW_CoachingDetail
               WHERE DeletedFlg IS NULL -- and HFitUserMpiNumber > 0  
             EXCEPT
             SELECT
                    ISNULL( ItemGUID , '00000000-0000-0000-0000-000000000000' )
                    ,ISNULL( GoalID , -1 )
                    ,ISNULL( UserGUID , '00000000-0000-0000-0000-000000000000' )
                    ,ISNULL( SiteGUID , '00000000-0000-0000-0000-000000000000' )
                    ,ISNULL( AccountID , ' ' )
                    ,ISNULL( AccountCD , ' ' )
                    ,ISNULL( WeekendDate , '01/01/1900' )
                    ,ISNULL( NodeGUID , '00000000-0000-0000-0000-000000000000' )
               FROM ##TEMP_EDW_CoachingDetail_DATA )
        UPDATE S
          SET
              S.DeletedFlg = 1
          FROM CTE AS T JOIN
                    DIM_EDW_CoachingDetail AS S
                        ON
               ISNULL( S.ItemGUID , '00000000-0000-0000-0000-000000000000' ) = ISNULL( T.ItemGUID , '00000000-0000-0000-0000-000000000000' )
           AND ISNULL( S.GoalID , -1 ) = ISNULL( T.GoalID , -1 )
           AND ISNULL( S.UserGUID , '00000000-0000-0000-0000-000000000000' ) = ISNULL( T.UserGUID , '00000000-0000-0000-0000-000000000000' )
           AND ISNULL( S.SiteGUID , '00000000-0000-0000-0000-000000000000' ) = ISNULL( T.SiteGUID , '00000000-0000-0000-0000-000000000000' )
           AND ISNULL( S.AccountID , ' ' ) = ISNULL( T.AccountID , ' ' )
           AND ISNULL( S.AccountCD , ' ' ) = ISNULL( T.AccountCD , ' ' )
           AND ISNULL( S.WeekendDate , '01/01/1900' ) = ISNULL( T.WeekendDate , '01/01/1900' )
           AND ISNULL( S.NodeGUID , '00000000-0000-0000-0000-000000000000' ) = ISNULL( T.NodeGUID , '00000000-0000-0000-0000-000000000000' );

    DECLARE
       @iCnt AS int = @@ROWCOUNT;
    PRINT 'Updated Count: ' + CAST ( @iCnt AS nvarchar( 50 ));
    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CT_CoachingDetail_AddDeletedRecs.sql';
GO
