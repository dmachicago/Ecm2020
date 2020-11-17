


--select count(*) from MART_View_OM_ContactGroupMember_HASH -- 2614057
IF EXISTS (SELECT *
             FROM sys.procedures
             WHERE name = 'proc_MART_BASE_OM_ContactGroupMember') 
    BEGIN
        DROP PROCEDURE proc_MART_BASE_OM_ContactGroupMember
    END;
GO

-- select top 1000 from BASE_OM_ContactGroupMember order by LastModifiedDate desc
-- select count(*) from MART_View_OM_ContactGroupMember_HASH
-- exec proc_MART_BASE_OM_ContactGroupMember
CREATE PROCEDURE proc_MART_BASE_OM_ContactGroupMember
AS
BEGIN
    DECLARE
           @TotRecs AS int = 0;
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'PK_BASE_OM_ContactGroupMember_HashCode') 
        BEGIN
            CREATE INDEX PK_BASE_OM_ContactGroupMember_HashCode ON BASE_OM_ContactGroupMember (DBNAME, ContactGroupMemberID, HashCode) ;
        END;

    --************************************************************
    --Find the records that need to be updated
    --************************************************************
    WITH CTE_K1 (DBNAME
               , ContactGroupMemberID
               , ContactGroupMemberType
               , ContactGroupMemberRelatedID
               , ContactGroupMemberFromCondition
               , ContactGroupMemberFromAccount
               , ContactGroupMemberFromManual
               , Hashcode) 
        AS (SELECT V.DBNAME
                 , V.ContactGroupMemberID
                 , V.ContactGroupMemberType
                 , V.ContactGroupMemberRelatedID
                 , V.ContactGroupMemberFromCondition
                 , V.ContactGroupMemberFromAccount
                 , V.ContactGroupMemberFromManual
                 , V.Hashcode
              FROM BASE_OM_ContactGroupMember B
                   JOIN
                   MART_View_OM_ContactGroupMember_HASH V
                   ON B.DBNAME = V.DBNAME
                  AND B.ContactGroupMemberID = V.ContactGroupMemberID
                  AND B.Hashcode != V.Hashcode) 
        UPDATE B
          SET b.ContactGroupMemberType = c.ContactGroupMemberType
            , b.ContactGroupMemberRelatedID = c.ContactGroupMemberRelatedID
            , b.ContactGroupMemberFromCondition = c.ContactGroupMemberFromCondition
            , b.ContactGroupMemberFromAccount = c.ContactGroupMemberFromAccount
            , b.ContactGroupMemberFromManual = c.ContactGroupMemberFromManual
            , b.LASTMODIFIEDDATE = GETDATE () 
            , b.HashCode = c.HashCode
          FROM BASE_OM_ContactGroupMember AS B
               JOIN
               CTE_K1 AS C
               ON B.DBNAME = C.DBNAME
              AND C.ContactGroupMemberID = B.ContactGroupMemberID;

    SET @TotRecs = @@ROWCOUNT;
    PRINT 'UPDATED COUNT: ' + CAST (@TotRecs AS nvarchar (50)) ; 


    --************************************************************
    --Find the NEW Records  
    --************************************************************
    WITH CTE_NEW (DBNAME
                , ContactGroupMemberID) 
        AS (SELECT DBNAME
                 , ContactGroupMemberID
              FROM MART_View_OM_ContactGroupMember_HASH
            EXCEPT
            SELECT DBNAME
                 , ContactGroupMemberID
              FROM BASE_OM_ContactGroupMember) 
        INSERT INTO BASE_OM_ContactGroupMember (ContactGroupMemberID
                                              , ContactGroupMemberContactGroupID
                                              , ContactGroupMemberType
                                              , ContactGroupMemberRelatedID
                                              , ContactGroupMemberFromCondition
                                              , ContactGroupMemberFromAccount
                                              , ContactGroupMemberFromManual
                                              , SYS_CHANGE_VERSION
                                              , LASTMODIFIEDDATE
                                              , HashCode
                                              , SVR
                                              , DBNAME
                                              , CT_RowDataUpdated) 
        SELECT V.ContactGroupMemberID
             , V.ContactGroupMemberContactGroupID
             , V.ContactGroupMemberType
             , V.ContactGroupMemberRelatedID
             , V.ContactGroupMemberFromCondition
             , V.ContactGroupMemberFromAccount
             , V.ContactGroupMemberFromManual
             , 0 AS SYS_CHANGE_VERSION  -- CT.SYS_CHANGE_VERSION
             , GETDATE () AS LASTMODIFIEDDATE
             , V.HashCode
             , @@servername AS SVR
             , V.DBNAME
             , 1         --CT_RowDataUpdated
          FROM MART_View_OM_ContactGroupMember_HASH V
               JOIN
               CTE_NEW AS C
               ON C.ContactGroupMemberID = V.ContactGroupMemberID
              AND C.DBNAME = V.DBNAME;

    SET @TotRecs = @@ROWCOUNT;
    PRINT 'INSERTED COUNT: ' + CAST (@TotRecs AS nvarchar (50)) ; 


    --************************************************************
    --Find the DELETED Records
    --************************************************************
    WITH CTE_Deleted (DBNAME
                    , ContactGroupMemberID) 
        AS (SELECT DBNAME
                 , ContactGroupMemberID
              FROM BASE_OM_ContactGroupMember
            EXCEPT
            SELECT DBNAME
                 , ContactGroupMemberID
              FROM MART_View_OM_ContactGroupMember_HASH) 
        DELETE B
          FROM BASE_OM_ContactGroupMember B
               INNER JOIN
               CTE_Deleted C
               ON B.DBNAME = C.DBNAME
              AND C.ContactGroupMemberID = B.ContactGroupMemberID;

    SET @TotRecs = @@ROWCOUNT;
    PRINT 'DELETED COUNT: ' + CAST (@TotRecs AS nvarchar (50)) ;
END;