
GO
PRINT 'Executing proc_CT_MASTER_HA_UpdateDocumentCulture.sql';
GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_CT_MASTER_HA_UpdateDocumentCulture') 
    BEGIN
        DROP PROCEDURE proc_CT_MASTER_HA_UpdateDocumentCulture;
    END;
GO

CREATE PROCEDURE proc_CT_MASTER_HA_UpdateDocumentCulture (@ModDate datetime)
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

    BEGIN TRY
        DROP TABLE #VHCJ;
    END TRY
    BEGIN CATCH
        PRINT 'dropped #VHCJ ';
    END CATCH;
    SELECT NodeGUID
         , SVR
         , DBNAME
         , NodeSiteID
         , DocumentCulture
         , HealthAssessmentID INTO #VHCJ
      FROM View_HFit_HACampaign_Joined;
    CREATE CLUSTERED INDEX PI_VHCJ ON #VHCJ (NodeGUID, SVR, DBNAME, NodeSiteID, DocumentCulture, HealthAssessmentID) ;

    -- select * from #VHAJ 
    BEGIN TRY
        DROP TABLE #VHAJ;
    END TRY
    BEGIN CATCH
        PRINT 'dropped #VHAJ ';
    END CATCH;
    SELECT NodeGUID
         , DocumentID
         , SVR
         , DBNAME INTO #VHAJ
      FROM View_HFit_HACampaign_Joined;
    CREATE CLUSTERED INDEX PI_VHAJ ON #VHAJ (NodeGUID, DocumentID, SVR, DBNAME) ;

    UPDATE BASEHA
      SET BASEHA.DocumentCulture_VHCJ = VHCJ.DocumentCulture
	   , BASEHA.LastModifiedDate = @ModDate
      FROM BASE_MART_EDW_HealthAssesment AS BASEHA
           -- INNER JOIN
          -- TEMP_HA_Changes AS TD
          -- --ON BASEHA.SVR = TD.SVR
          --on BASEHA.DBNAME = TD.DBNAME
          --AND BASEHA.UserStartedItemID = TD.ItemID
           INNER JOIN
           #VHCJ AS VHCJ
           --View_HFit_HACampaign_Joined 
           ON VHCJ.NodeGUID = BASEHA.CampaignNodeGUID
          --AND VHCJ.SVR = BASEHA.SVR
          AND VHCJ.DBNAME = BASEHA.DBNAME
          AND VHCJ.NodeSiteID = BASEHA.SiteID
          AND VHCJ.DocumentCulture = 'en-US'
		and BASEHA.DocumentCulture_VHCJ != VHCJ.DocumentCulture;

    SET @iCnt = @@ROWCOUNT;
    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CT_MASTER_HA_UpdateDocumentCulture.sql';
GO
