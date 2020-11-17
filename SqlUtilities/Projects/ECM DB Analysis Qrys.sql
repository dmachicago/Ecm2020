/* ANALYZE Archive Activity */
SELECT  distinct year([ArchiveDate]) as ArchiveYR, DATEPART(week, ArchiveDate) as ArchiveWeek
      ,sum([NbrFilesArchived]      )
  FROM [ECM.Library].[dbo].[ArchiveHist]
group by year([ArchiveDate]), DATEPART(week, ArchiveDate)


SELECT  distinct year([ArchiveDate]) as ArchiveYR, DATEPART(month, ArchiveDate) as ArchiveMO
      ,sum([NbrFilesArchived]      )
  FROM [ECM.Library].[dbo].[ArchiveHist]
group by year([ArchiveDate]), DATEPART(month, ArchiveDate)

  
SELECT  [ArchiveDate]
      ,[NbrFilesArchived]      
  FROM [ECM.Library].[dbo].[ArchiveHist]
  
/* ANALYZE Email Archive Activity   */
SELECT  distinct year([RowCreationDate]) as ArchiveYR, DATEPART(week, RowCreationDate) as ArchiveWeek
      ,COUNT(*)
  FROM [dbo].[Email]
group by year([RowCreationDate]), DATEPART(week, RowCreationDate)

SELECT  distinct year([RowCreationDate]) as ArchiveYR, DATEPART(month, [RowCreationDate]) as ArchiveMO
      ,COUNT(*)
  FROM [Email]
group by year([RowCreationDate]), DATEPART(month, [RowCreationDate])

SELECT  distinct year([RowCreationDate]) as ArchiveYR, DATEPART(Quarter, [RowCreationDate]) as ArchiveMO
      ,COUNT(*)
  FROM Email
group by year([RowCreationDate]), DATEPART(Quarter, [RowCreationDate])
  
