USE master
GO
CREATE FUNCTION sbsClassifier()
RETURNS SYSNAME WITH SCHEMABINDING
BEGIN
DECLARE @Group sysname
IF(SUSER_SNAME()) = 'jdoe'
BEGIN
SET @Group = 'sbsSSMSgroup'
END
RETURN @Group
END
GO

USE MASTER
GO
ALTER RESOURCE GOVERNOR with (CLASSIFIER_FUNCTION = dbo.sbsClassifier)
ALTER RESOURCE GOVERNOR RECONFIGURE
GO