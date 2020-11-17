--Use this script to create a snapshot of a database
USE master;
CREATE DATABASE SBSChp4TSQL_snapshot_42012200
ON
(
NAME = SBSChp4TSQL1,
FILENAME = 'C:\SQLDATA\SBSChp4TSQL1_snapshot_data.ss'
),
(
NAME = SBSChp4TSQL2,
FILENAME = 'C:\SQLDATA\SBSChp4TSQL2_snapshot_data.ss'
)
AS SNAPSHOT OF SBSChp4TSQL;