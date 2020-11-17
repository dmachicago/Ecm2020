
exec sp_VerifyRetentionDates
go
/* fti Fulltext index Reorg */
ALTER FULLTEXT CATALOG ftCatalog REORGANIZE
go
ALTER FULLTEXT CATALOG ftEmailCatalog REORGANIZE
go
EXEC sp_updatestats
go