--Use this script to create a snapshot of a database
USE master;
RESTORE DATABASE SBSChp4TSQL FROM DATABASE_SNAPSHOT = 'SBSChp4TSQL_snapshot_42012400';