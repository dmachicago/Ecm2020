exec Sp_spaceused

SELECT 
a.name as [DatabaseName], a.FILEID,
CONVERT(decimal(12,2),ROUND(a.size/128.000,2)) as [FileSizeInMB] ,
CONVERT(decimal(12,2),ROUND(fileproperty(a.name,'SpaceUsed')/128.000,2)) as [SpaceUsedInMB],
CONVERT(decimal(12,2),ROUND((a.size-fileproperty(a.name,'SpaceUsed'))/128.000,2)) as [FreeSpaceInMB],    
a.FILENAME as [FILENAME]
FROM
dbo.sysfiles a