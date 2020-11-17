
GO
PRINT 'Executing proc_CT_MASTER_HA_UserSettingsUpdate.sql';
GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_CT_MASTER_HA_UserSettingsUpdate') 
    BEGIN
        DROP PROCEDURE proc_CT_MASTER_HA_UserSettingsUpdate;
    END;
GO

CREATE PROCEDURE proc_CT_MASTER_HA_UserSettingsUpdate (@ModDate datetime) 
AS
BEGIN

    DECLARE
           @LastFullUpdateDate datetime
         , @iCnt bigint = 9;

    SET @LastFullUpdateDate = (SELECT MAX (LastUpdate)
                                 FROM CT_MASTER_HA_UpdateHistory) ;

    IF @LastFullUpdateDate IS NULL
        BEGIN
            SET @LastFullUpdateDate = CAST ('01-01-1800' AS datetime) ;
            INSERT INTO CT_MASTER_HA_UpdateHistory (LastUpdate) 
            VALUES
                   (@LastFullUpdateDate) ;
        END;

    --*************************************************************

    UPDATE BASEHA
      SET BASEHA.UserGUID = CMSUser.UserGUID
        , BASEHA.HFitUserMpiNumber = UserSettings.HFitUserMpiNumber
	   , BASEHA.LastModifiedDate = @ModDate
      FROM BASE_MART_EDW_HealthAssesment AS BASEHA 
	 -- INNER JOIN
      -- TEMP_HA_Changes AS TD
      -- --ON BASEHA.SVR = TD.SVR
      -- ON BASEHA.DBNAME = TD.DBNAME
      --AND BASEHA.UserStartedItemID = TD.ItemID
           INNER JOIN
           dbo.BASE_CMS_User AS CMSUser
           ON BASEHA.UserID = CMSUser.UserID
              --AND BASEHA.SVR = CMSUser.SVR
          AND BASEHA.DBNAME = CMSUser.DBNAME
           INNER JOIN
           dbo.BASE_CMS_UserSettings AS UserSettings
           -- ON UserSettings.SVR = CMSUser.SVR
           ON UserSettings.DBNAME = CMSUser.DBNAME
          AND UserSettings.UserSettingsUserID = CMSUser.UserID
          AND UserSettings.HFitUserMpiNumber >= 0
          AND UserSettings.HFitUserMpiNumber IS NOT NULL
      WHERE (CT_UserGUID = 1 OR UserSettings.CT_HFitUserMpiNumber = 1)        
	   AND UserSettings.LastModifiedDate > @LastFullUpdateDate;
    --*************************************************************


    SET @iCnt = @@ROWCOUNT;
    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CT_MASTER_HA_UserSettingsUpdate.sql';
GO
