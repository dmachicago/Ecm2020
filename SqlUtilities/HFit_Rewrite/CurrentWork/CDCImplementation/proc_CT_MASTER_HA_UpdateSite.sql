
GO
PRINT 'Executing proc_CT_MASTER_HA_UpdateSite.sql';
GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_CT_MASTER_HA_UpdateSite') 
    BEGIN
        DROP PROCEDURE proc_CT_MASTER_HA_UpdateSite
    END;
GO

CREATE PROCEDURE proc_CT_MASTER_HA_UpdateSite (@ModDate datetime)
AS
BEGIN
    
    BEGIN TRY
        DROP TABLE ##TEMP_HA_SiteData;
    END TRY
    BEGIN CATCH 
	   PRINT 'REPLACED ##TEMP_HA_SiteData' ;
    END CATCH
    
    DECLARE
           @LastFullUpdateDate datetime,
		 @iCnt bigint = 9 ;

    SET @LastFullUpdateDate = (SELECT MAX (LastUpdate)
                                 FROM CT_MASTER_HA_UpdateHistory) ;

    IF @LastFullUpdateDate IS NULL
        BEGIN
            SET @LastFullUpdateDate = CAST ('01-01-1800' AS datetime) ;
            INSERT INTO CT_MASTER_HA_UpdateHistory (LastUpdate) 
            VALUES
                   (@LastFullUpdateDate) ;
        END;

    SELECT U.SVR
         , U.DBNAME
         , U.UserID
         , CMSSite.SiteGuid
         , U.SiteID
         , CMSSite.CT_SiteGuid
         , CMSSite.CT_SiteID
         , CMSSite.LastModifiedDate AS Site_LastModifiedDate
         , U.LastModifiedDate AS User_LastModifiedDate 
	 INTO ##TEMP_HA_SiteData
      FROM dbo.BASE_CMS_UserSite AS U
           INNER JOIN
           dbo.BASE_CMS_Site AS CMSSite
           ON U.SiteID = CMSSite.SiteID
          --AND U.SVR = CMSSite.SVR
          AND U.DBNAME = CMSSite.DBNAME
      --WHERE (U.CT_UserID = 1
      --  AND U.LastModifiedDate > @LastFullUpdateDate)
      --   OR (CMSSite.CT_SiteGuid = 1
      --  AND CMSSite.LastModifiedDate > @LastFullUpdateDate);

    CREATE INDEX PI_TempSiteData ON ##TEMP_HA_SiteData (SVR, DBNAME, SiteID, UserID) INCLUDE (SiteGuid, Site_LastModifiedDate, User_LastModifiedDate) ;

    UPDATE BASEHA
      SET BASEHA.SiteGUID = S.SiteGUID
        , BASEHA.SiteID = S.SiteID
	   , BASEHA.LastModified = @ModDate
      FROM BASE_MART_EDW_HealthAssesment AS BASEHA
          -- INNER JOIN
          -- TEMP_HA_Changes AS TD
          ---- ON BASEHA.SVR = TD.SVR
          --on BASEHA.DBNAME = TD.DBNAME
          --AND BASEHA.UserStartedItemID = TD.ItemID
           INNER JOIN
           ##TEMP_HA_SiteData AS S
           ON BASEHA.UserID = S.UserID
          --AND BASEHA.SVR = S.SVR
          AND BASEHA.DBNAME = S.DBNAME
		and Site_LastModifiedDate > @LastFullUpdateDate;

		SET @iCnt = @@ROWCOUNT;
		return @iCnt;
END;

GO
PRINT 'Executed proc_CT_MASTER_HA_UpdateSite.sql';
GO
