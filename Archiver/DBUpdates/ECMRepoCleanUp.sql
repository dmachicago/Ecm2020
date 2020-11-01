
PRINT 'Building up missing FQNs';
go
update DataSource set FQN = (ltrim(rtrim(FileDirectory)) + '\' + ltrim(rtrim(SourceName))) where SourceGuid in
(
select sourceguid from DataSource 
where (fqn is null or ltrim(RTRIM(FQN)) = '') 
and not (SourceName is null or ltrim(RTRIM(SourceName)) = '') 
and not (FileDirectory is null or ltrim(RTRIM(FileDirectory)) = '') 
);

go
PRINT 'Cleaning up missing FQNs';
go
DELETE FROM DataSource
WHERE SourceGuid IN
(
    SELECT SourceGuid
    FROM DataSource
    WHERE FQN IS NULL
          OR LTRIM(RTRIM(FQN)) = ''
);
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

print '*** DONE ****'