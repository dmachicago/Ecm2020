DECLARE @Debug BIT 

SET @Debug = 0

SET NOCOUNT ON
DECLARE CUSR CURSOR LOCAL STATIC FOR
SELECT u.name
FROM sysusers u
JOIN dbo.syslogins l ON l.name=u.name
WHERE u.sid!=l.sid AND u.issqluser=1
ORDER BY u.name

OPEN CUSR 
DECLARE @user SYSNAME
WHILE 1=1 BEGIN
FETCH NEXT FROM CUSR INTO @user
IF @@FETCH_STATUS!=0 BREAK

PRINT CHAR(13)+'*** Fixing User '+@user+' ...'
IF @debug=0 EXEC sp_change_users_login 'auto_fix', @user
END
CLOSE CUSR DEALLOCATE CUSR
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
