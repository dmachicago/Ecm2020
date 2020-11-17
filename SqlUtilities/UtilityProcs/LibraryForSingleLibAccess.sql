    --SELECT     SourceGuid
    SELECT     GroupUsers.GroupName, Library.LibraryName, LibraryUsers.UserID, LibraryItems.SourceGuid
FROM         LibraryItems INNER JOIN
                      Library ON LibraryItems.LibraryName = Library.LibraryName INNER JOIN
                      LibraryUsers ON Library.LibraryName = LibraryUsers.LibraryName INNER JOIN
                      GroupLibraryAccess ON Library.LibraryName = GroupLibraryAccess.LibraryName INNER JOIN
                      GroupUsers ON GroupLibraryAccess.GroupName = GroupUsers.GroupName
                   
                     where 
                     --Library.LibraryName ='Art Training Archive'
                     libraryusers.userid ='dale' 
                       
                      order by 
                      GroupUsers.groupname,
                      Library.LibraryName,
                      LibraryUsers.userid
