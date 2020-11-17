--Step 2 of Drop a database snapshot using T-SQL. Use this script to create a snapshot of a database
USE master;
CREATE DATABASE SBSChp4TSQL_snapshot_42012400
ON
(
NAME = SBSChp4TSQL1,
FILENAME = 'C:\SQLDATA\SBSChp4TSQL14_snapshot_data.ss'
),
(
NAME = SBSChp4TSQL2,
FILENAME = 'C:\SQLDATA\SBSChp4TSQL24_snapshot_data.ss'
)
AS SNAPSHOT OF SBSChp4TSQL;