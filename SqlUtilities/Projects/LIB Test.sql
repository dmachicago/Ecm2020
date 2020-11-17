--Q1
select COUNT(*) from DataSource where FQN like 'c:\dir1%'

--Q2
SELECT     Library.LibraryName, LibraryItems.ItemTitle, DataSource.FQN, DataSource.OriginalFileType
FROM         Library INNER JOIN
                      LibraryItems ON Library.LibraryName = LibraryItems.LibraryName INNER JOIN
                      DataSource ON LibraryItems.SourceGuid = DataSource.SourceGuid
WHERE     (DataSource.FQN LIKE N'c:\dir%')
and Library.LibraryName like 'lib%'

--Q3
SELECT     distinct DataSource.FileDirectory, Library.LibraryName
FROM         Library INNER JOIN
                      LibraryItems ON Library.LibraryName = LibraryItems.LibraryName INNER JOIN
                      DataSource ON LibraryItems.SourceGuid = DataSource.SourceGuid
WHERE     (DataSource.FQN LIKE N'c:\dir%')
and Library.LibraryName like 'lib%'
group by Library.LibraryName, DataSource.FileDirectory
order by DataSource.FileDirectory


--Q4
SELECT     distinct Library.LibraryName, DataSource.FileDirectory, DataSource.SourceName
FROM         Library INNER JOIN
                      LibraryItems ON Library.LibraryName = LibraryItems.LibraryName INNER JOIN
                      DataSource ON LibraryItems.SourceGuid = DataSource.SourceGuid
WHERE     (DataSource.FQN LIKE N'c:\dir%')
and Library.LibraryName like 'lib%'
group by Library.LibraryName, DataSource.FileDirectory, DataSource.SourceName
order by Library.LibraryName, DataSource.FileDirectory, DataSource.SourceName