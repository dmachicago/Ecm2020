
GO
PRINT 'Executing proc_CT_RewardUserDetail_AddDeletedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_RewardUserDetail_AddDeletedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_RewardUserDetail_AddDeletedRecs;
    END;
GO
CREATE PROCEDURE proc_CT_RewardUserDetail_AddDeletedRecs
AS
BEGIN

DECLARE
   @DELDATE AS  datetime2 ( 7 ) = GETDATE ( );
    WITH CTE_DEL (
         UserGUID
         ,AccountID
         ,AccountCD
         ,SiteGUID
         ,HFitUserMpiNumber
         ,RewardActivityGUID
         ,RewardTriggerGUID
    --, RewardGroupGUID
    )
        AS (
        SELECT
               UserGUID
               ,AccountID
               ,AccountCD
               ,SiteGUID
               ,HFitUserMpiNumber
               ,RewardActivityGUID
               ,RewardTriggerGUID
        --, RewardGroupGUID
          FROM DIM_EDW_RewardUserDetail
          WHERE DeletedFlg IS NULL
        EXCEPT
        SELECT
               UserGUID
               ,AccountID
               ,AccountCD
               ,SiteGUID
               ,HFitUserMpiNumber
               ,RewardActivityGUID
               ,RewardTriggerGUID
        --, RewardGroupGUID
          FROM ##Temp_RewardUserDetail
        )

        UPDATE S
          SET
              DeletedFlg = 1
              ,LastModifiedDate = @DELDATE
          FROM
          DIM_EDW_RewardUserDetail AS S JOIN
          CTE_DEL AS C
          ON
               S.UserGUID = C.UserGUID
           AND S.AccountID = C.AccountID
           AND S.AccountCD = C.AccountCD
           AND S.SiteGUID = C.SiteGUID
           AND S.HFitUserMpiNumber = C.HFitUserMpiNumber
               --AND S.RewardGroupGUID = C.RewardGroupGUID
           AND S.RewardActivityGUID = C.RewardActivityGUID
           AND S.RewardTriggerGUID = C.RewardTriggerGUID
	   AND isnull(DeletedFlg,0) = 0 ;

    DECLARE
    @iInserts AS int = @@ROWCOUNT;

    update DIM_EDW_RewardUserDetail set LastModifiedDate = getdate() where LastModifiedDate is null and DeletedFlg is NOT null ;

    PRINT 'Deleted Record Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_RewardUserDetail_AddDeletedRecs.sql';
GO
