
PRINT 'Building up missing FQNs';
UPDATE DataSource
  SET 
      FQN = (LTRIM(RTRIM(FileDirectory)) + '\' + LTRIM(RTRIM(SourceName)))
WHERE SourceGuid IN
(
    SELECT sourceguid
    FROM DataSource
    WHERE(fqn IS NULL
          OR LTRIM(RTRIM(FQN)) = '')
         AND NOT(SourceName IS NULL
                 OR LTRIM(RTRIM(SourceName)) = '')
         AND NOT(FileDirectory IS NULL
                 OR LTRIM(RTRIM(FileDirectory)) = '')
);
GO
PRINT 'Cleaning up missing FQNs';
DELETE FROM DataSource
WHERE SourceGuid IN
(
    SELECT SourceGuid
    FROM DataSource
    WHERE FQN IS NULL
          OR LTRIM(RTRIM(FQN)) = ''
);
go
PRINT 'Cleaning up missing FILE Extensions';
go
UPDATE DataSource
  SET 
      OriginalFileType = '.' + RIGHT(OriginalFileType, CHARINDEX('.', REVERSE(OriginalFileType) + '.') - 1)
WHERE SourceGuid IN
(
    SELECT SourceGuid
    FROM DataSource
    WHERE OriginalFileType IS NULL
          OR LTRIM(RTRIM(OriginalFileType)) = ''
          OR DATALENGTH(OriginalFileType) <= 1
);
go
PRINT 'Cleaning up Process As Extensions';
go
UPDATE DataSource
  SET 
      SourceTypeCode = OriginalFileType
WHERE SourceGuid IN
(
    SELECT SourceGuid
    FROM DataSource
    WHERE OriginalFileType <> SourceTypeCode
          AND OriginalFileType IN
    (
        SELECT ExtCode
        FROM ProcessFileAs
    )
          AND SourceTypeCode <>
    (
        SELECT ProcessExtCode
        FROM ProcessFileAs
        WHERE ExtCode = OriginalFileType
    )
);
go
PRINT 'Cleaning up Last Modified Date';
go
UPDATE DataSource
  SET 
      RowLastModDate = LastWriteTime
WHERE RowLastModDate IS NULL;
PRINT 'Cleaning up RowLastModDate';
UPDATE DataSource
  SET 
      RowLastModDate = LastWriteTime
WHERE RowLastModDate IS NULL;
go

delete from DataSource where fqn IS NULL OR LTRIM(RTRIM(FQN)) = '';