
DECLARE
       @dbname varchar (255) 
     , @itemid bigint
     , @SurrogateKey bigint
     , @previtemid bigint = -1
     , @prevSurrogateKey bigint = -1
     , @SYS_CHANGE_VERSION bigint = 0
     , @PrevSYS_CHANGE_VERSION bigint = 0
     , @MySql nvarchar (max) = ''
     , @iCnt int = 0;

DECLARE mycursor CURSOR
    FOR SELECT DISTINCT dbname
                      , itemid
                      , SurrogateKey_HFit_CoachingUserServiceLevel
          FROM BASE_HFit_CoachingUserServiceLevel_DEL
          WHERE dbname = 'KenticoCMS_1'
          --AND ItemID = 2224
          ORDER BY dbname, itemid, SurrogateKey_HFit_CoachingUserServiceLevel DESC;
  
OPEN mycursor;  
  
FETCH NEXT FROM mycursor INTO @dbname, @itemid, @SurrogateKey;

--set @previtemid = @itemid
--set @prevSurrogateKey = @SurrogateKey
SET IDENTITY_INSERT dbo.BASE_HFit_CoachingUserServiceLevel ON;  

WHILE @@FETCH_STATUS = 0
    BEGIN
        --select @dbname, @itemid, @SurrogateKey

        IF @previtemid <> @itemid
            BEGIN
                PRINT '******** THE FIRST OF A NEW RECORD SET: ' + CAST (@itemid AS nvarchar (50)) ;
            END;

        IF @previtemid = @itemid
       AND @prevSurrogateKey <> @SurrogateKey
            BEGIN
                BEGIN TRY
                    BEGIN TRANSACTION;

                    SET @SYS_CHANGE_VERSION = (SELECT TOP 1 SYS_CHANGE_VERSION
                                                 FROM BASE_HFit_CoachingUserServiceLevel_DEL
                                                 WHERE itemid = @itemid
                                                   AND SurrogateKey_HFit_CoachingUserServiceLevel = @SurrogateKey
                                                 ORDER BY SYS_CHANGE_VERSION DESC) ;

                    INSERT INTO BASE_HFit_CoachingUserServiceLevel (ItemID
                                                                  , UserId
                                                                  , ServiceLevelItemID
                                                                  , ServiceLevelStatusItemID
                                                                  , ItemCreatedBy
                                                                  , ItemCreatedWhen
                                                                  , ItemModifiedBy
                                                                  , ItemModifiedWhen
                                                                  , ItemOrder
                                                                  , ItemGUID
                                                                  , HashCode
                                                                  , SVR
                                                                  , DBNAME
                                                                  , SurrogateKey_HFit_CoachingUserServiceLevel
                                                                  , LastModifiedDate
                                                                  , ACTION
                                                                  , SYS_CHANGE_VERSION
                                                                  , CT_UserId
                                                                  , CT_ServiceLevelItemID
                                                                  , CT_ServiceLevelStatusItemID
                                                                  , CT_ItemCreatedBy
                                                                  , CT_ItemCreatedWhen
                                                                  , CT_ItemModifiedBy
                                                                  , CT_ItemModifiedWhen
                                                                  , CT_ItemOrder
                                                                  , CT_ItemGUID
                                                                  , CT_RowDataUpdated) 
                    SELECT ItemID
                         , UserId
                         , ServiceLevelItemID
                         , ServiceLevelStatusItemID
                         , ItemCreatedBy
                         , ItemCreatedWhen
                         , ItemModifiedBy
                         , ItemModifiedWhen
                         , ItemOrder
                         , ItemGUID
                         , HashCode
                         , SVR
                         , DBNAME
                         , @SurrogateKey
                         , LastModifiedDate
                         , ACTION
                         , @SYS_CHANGE_VERSION
                         , CT_UserId
                         , CT_ServiceLevelItemID
                         , CT_ServiceLevelStatusItemID
                         , CT_ItemCreatedBy
                         , CT_ItemCreatedWhen
                         , CT_ItemModifiedBy
                         , CT_ItemModifiedWhen
                         , CT_ItemOrder
                         , CT_ItemGUID
                         , CT_RowDataUpdated
                      FROM BASE_HFit_CoachingUserServiceLevel
                      WHERE SurrogateKey_HFit_CoachingUserServiceLevel = @prevSurrogateKey;

                    SET @MySql = 'delete from BASE_HFit_CoachingUserServiceLevel where SurrogateKey_HFit_CoachingUserServiceLevel = ' + CAST (@prevSurrogateKey AS nvarchar (50)) ;
                    EXEC (@MySql) ;
                    SET @iCnt = @@ROWCOUNT;
                    PRINT CAST (@iCnt AS nvarchar) + ' : ' + @MySql;

                    --SET @MySql = 'Update BASE_HFit_CoachingUserServiceLevel set SYS_CHANGE_VERSION = ' + CAST (@SYS_CHANGE_VERSION AS nvarchar (50)) + ', SurrogateKey_HFit_CoachingUserServiceLevel = ' + CAST (@SurrogateKey AS nvarchar (50)) + ' where SurrogateKey_HFit_CoachingUserServiceLevel = ' + CAST (@prevSurrogateKey AS nvarchar (50)) ;
                    --PRINT '1a - Set BASE TABLE @SYS_CHANGE_VERSION =  ' + CAST (@SYS_CHANGE_VERSION AS nvarchar (50)) + ' where BASE TABLE SurrKey = ' + CAST (@prevSurrogateKey AS nvarchar (50)) ;
                    --PRINT '1b - Reset Surr Key ' + CAST (@prevSurrogateKey AS nvarchar (50)) + ' TO ' + CAST (@SurrogateKey AS nvarchar (50)) + ' in the BASE table.';
                    --EXEC (@MySql) ;
                    --SET @iCnt = @@ROWCOUNT;
                    --PRINT CAST (@iCnt AS nvarchar) + ' : ' + @MySql;

                    PRINT '2 - DELETE  ' + CAST (@prevSurrogateKey AS nvarchar (50)) + ' form the DELTA table.';
                    SET @MySql = 'delete from BASE_HFit_CoachingUserServiceLevel_DEL where SurrogateKey_HFit_CoachingUserServiceLevel = ' + CAST (@prevSurrogateKey AS nvarchar (50)) ;
                    EXEC (@MySql) ;
                    SET @iCnt = @@ROWCOUNT;
                    PRINT CAST (@iCnt AS nvarchar) + ' : ' + @MySql;

                    PRINT '3 - DELETE the deleta table "D" entry for SurrKey ' + CAST (@SurrogateKey AS nvarchar (50)) + '.';
                    SET @MySql = 'delete from BASE_HFit_CoachingUserServiceLevel_DEL where Action = ''D'' and  SurrogateKey_HFit_CoachingUserServiceLevel = ' + CAST (@SurrogateKey AS nvarchar (50)) ;
                    EXEC (@MySql) ;
                    SET @iCnt = @@ROWCOUNT;
                    PRINT CAST (@iCnt AS nvarchar) + ' : ' + @MySql;
                    -- ROLLBACK ;
                    COMMIT;
                END TRY
                BEGIN CATCH
                    PRINT 'ERROR: ' + @MySql;
                    ROLLBACK;
                END CATCH;

            END;

        SET @previtemid = @itemid;
        SET @prevSurrogateKey = @SurrogateKey;

        FETCH NEXT FROM mycursor INTO @dbname, @itemid, @SurrogateKey;

        IF @previtemid <> @itemid
            BEGIN
                SET @prevSurrogateKey = -1;
            END;

    END;

CLOSE mycursor;  
DEALLOCATE mycursor;

SET IDENTITY_INSERT dbo.BASE_HFit_CoachingUserServiceLevel OFF;  

PRINT '********* RE-ENABLE TRIGGERS!!! ';
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
