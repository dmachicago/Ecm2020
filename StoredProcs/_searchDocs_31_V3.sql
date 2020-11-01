use [ECM.Library.FS]
go
if exists(select 1 from sys.procedures where name = '_searchDocs_31_V3')
	drop procedure _searchDocs_31_V3

GO
CREATE PROCEDURE [dbo].[_searchDocs_31_V3]
   (@P1_keyword    NVARCHAR(MAX), 
    @P2_ecmLoginID NVARCHAR(MAX) = ''
   )
AS
    BEGIN

        IF OBJECT_ID('tempdb..#tmpSourceGuids') IS NOT NULL
            DROP TABLE #Results;
        SELECT LibraryItems.SourceGuid
        INTO #tmpSourceGuids
            FROM LibraryItems
                      INNER JOIN Library
                      ON LibraryItems.LibraryName = Library.LibraryName
                           INNER JOIN LibraryUsers
                      ON Library.LibraryName = LibraryUsers.LibraryName
                                INNER JOIN GroupLibraryAccess
                      ON Library.LibraryName = GroupLibraryAccess.LibraryName
                                     INNER JOIN GroupUsers
                      ON GroupLibraryAccess.GroupName = GroupUsers.GroupName
            WHERE LibraryUsers.userid = @P2_ecmLoginID
        UNION
        SELECT LI.SourceGuid
            FROM LibraryItems AS LI
                      INNER JOIN LibraryUsers AS LU
                      ON LI.LibraryName = LU.LibraryName
            WHERE LU.UserID = @P2_ecmLoginID;
        CREATE CLUSTERED INDEX TEMP_IDX_SourceGuid
        ON #tmpSourceGuids
           (SourceGuid
           );
        SELECT SourceGuid, 
               SourceName AS Document, 
               OriginalFileType AS Type, 
               FileLength AS Size, 
               REPLACE(FileDirectory, '\\PICAA0200900743\', '') AS Path
            FROM DataSource
            WHERE CONTAINS(*, @P1_keyword)
                  AND SourceGuid IN
        (
            SELECT SourceGuid
                FROM #tmpSourceGuids
        )
            ORDER BY SourceName;
        IF OBJECT_ID('tempdb..#tmpSourceGuids') IS NOT NULL
            DROP TABLE #Results;
    END;