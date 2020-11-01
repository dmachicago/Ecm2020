USE [ECM.Library.FS];
GO

/****** Object:  UserDefinedFunction [dbo].[getAdmin]    Script Date: 6/2/2020 4:12:52 PM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE FUNCTION [dbo].[getAdmin]
(@userLoginID NVARCHAR(MAX)
)
RETURNS NVARCHAR(MAX)
AS
     BEGIN
         DECLARE @UserAdmin NVARCHAR(MAX)= '';
         SET @UserAdmin =
         (
             SELECT TOP 1 admin
             FROM Users
             WHERE UserLoginID = @userLoginID
         );
         RETURN @UserAdmin;
     END;
GO

/****** Object:  UserDefinedFunction [dbo].[getUserID]    Script Date: 6/2/2020 4:12:46 PM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE FUNCTION [dbo].[getUserID]
(@userLoginID NVARCHAR(MAX)
)
RETURNS NVARCHAR(MAX)
AS
     BEGIN
         DECLARE @UserID NVARCHAR(MAX)= '';
         SET @UserID =
         (
             SELECT TOP 1 userid
             FROM Users
             WHERE UserLoginID = @userLoginID
         );
         RETURN @UserID;
     END;
GO

/****** Object:  StoredProcedure [dbo].[_searchDocs_31]    Script Date: 6/2/2020 2:01:40 PM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

-- _searchDocs_31: ECM Query Stored Procedure for CMDR V 3.1
--      2012.02.28 - ECM Fix 3:         Replace DataSource join with temp table
-- 2013.05.23 - PCR 467 BLS:    Remove \\PICAA0200900743\ from Path column
-- 2013.07.01 - PCR 467 BLS:  use REPLACE() instead of SUBSTRING()     
-- USE [ECM.Library]

if exists (select 1 from sys.procedures where name = '_searchDocs_31')
	drop procedure [_searchDocs_31]
go
CREATE PROCEDURE [dbo].[_searchDocs_31]
(@P1_keyword    NVARCHAR(MAX), 
 @P2_ecmLoginID NVARCHAR(MAX) = ''
)
AS
    BEGIN
        DECLARE @sql NVARCHAR(MAX);
        DECLARE @uid NVARCHAR(MAX);
        DECLARE @admin NVARCHAR;
        BEGIN
            SET @uid = dbo.getUserID(@P2_ecmLoginID);
            SET @admin = dbo.getAdmin(@P2_ecmLoginID);
			IF(@uid IS NULL
               OR @uid = '')
                RETURN;
            IF(@admin IS NULL
               OR @admin = '')
                RETURN;
        END;

        -- jlc: moved join of library tables from DataSource join into #tmpSourceGuids table

        SELECT LibraryItems.SourceGuid
        INTO #tmpSourceGuids
        FROM LibraryItems
             INNER JOIN Library ON LibraryItems.LibraryName = Library.LibraryName
             INNER JOIN LibraryUsers ON Library.LibraryName = LibraryUsers.LibraryName
             INNER JOIN GroupLibraryAccess ON Library.LibraryName = GroupLibraryAccess.LibraryName
             INNER JOIN GroupUsers ON GroupLibraryAccess.GroupName = GroupUsers.GroupName
        WHERE LibraryUsers.userid = @uid
        UNION
        SELECT LI.SourceGuid
        FROM LibraryItems AS LI
             INNER JOIN LibraryUsers AS LU ON LI.LibraryName = LU.LibraryName
        WHERE LU.UserID = @uid;
        SET @sql = 'SELECT      SourceGuid,
                        SourceName AS Document,
                        OriginalFileType AS Type,
                        FileLength AS Size,

                        REPLACE ( FileDirectory, ''\\PICAA0200900743\'', '''' )   AS  Path

        FROM    DataSource

        WHERE CONTAINS (*, ''' + @P1_keyword + ''')
        AND
        SourceGuid IN 
        (
                SELECT SourceGuid       
                FROM   #tmpSourceGuids  )

        ORDER BY SourceName';
        EXEC (@sql);
    END;
        DROP TABLE #tmpSourceGuids;

--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  -- 

/*

EXEC _searchDocs_31_V2 'tolerance', 'prashant.savalia', GeneratedSQL --as nvarchar

*/
go
if exists (select 1 from sys.procedures where name = '_searchDocs_31_V2')
	drop procedure [_searchDocs_31_V2]
go
GO
CREATE PROCEDURE [dbo].[_searchDocs_31_V2]
(@P1_keyword    NVARCHAR(MAX), 
 @P2_ecmLoginID NVARCHAR(MAX) = '', 
 @sql           NVARCHAR(MAX)
)
AS
    BEGIN   
        --DECLARE @sql    nvarchar(max)
        DECLARE @uid NVARCHAR(MAX);
        DECLARE @admin NVARCHAR;
        BEGIN
            SET @uid = dbo.getUserID(@P2_ecmLoginID);
            SET @admin = dbo.getAdmin(@P2_ecmLoginID);
			IF(@uid IS NULL
               OR @uid = '')
                RETURN;
            IF(@admin IS NULL
               OR @admin = '')
                RETURN;
        END;

        -- jlc: moved join of library tables from DataSource join into #tmpSourceGuids table

        SELECT LibraryItems.SourceGuid
        INTO #tmpSourceGuids
        FROM LibraryItems
             INNER JOIN Library ON LibraryItems.LibraryName = Library.LibraryName
             INNER JOIN LibraryUsers ON Library.LibraryName = LibraryUsers.LibraryName
             INNER JOIN GroupLibraryAccess ON Library.LibraryName = GroupLibraryAccess.LibraryName
             INNER JOIN GroupUsers ON GroupLibraryAccess.GroupName = GroupUsers.GroupName
        WHERE LibraryUsers.userid = @uid
        UNION
        SELECT LI.SourceGuid
        FROM LibraryItems AS LI
             INNER JOIN LibraryUsers AS LU ON LI.LibraryName = LU.LibraryName
        WHERE LU.UserID = @uid;

        --     SET @sql =
        --'SELECT      SourceGuid,
        --                     SourceName AS Document,
        --                     OriginalFileType AS Type,
        --                     FileLength AS Size,
        --                     REPLACE ( FileDirectory, ''\\PICAA0200900743\'', '''' )   AS  Path
        --     FROM    DataSource
        --     WHERE CONTAINS (*, ''' + @P1_keyword + ''')
        --     AND
        --     SourceGuid IN 
        --     (
        --             SELECT SourceGuid       
        --             FROM   #tmpSourceGuids  )
        --     ORDER BY SourceName'   

        EXEC (@sql);
    END;
        DROP TABLE #tmpSourceGuids;

--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  -- 

/*

EXEC _searchDocs_31 'tolerance', 'prashant.savalia'

*/

GO