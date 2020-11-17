IF  @@microsoftversion / power(2, 24) >= 9
BEGIN
   EXEC sp_configure 'show advanced options', 1
   RECONFIGURE WITH OVERRIDE

   EXEC sp_configure 'xp_cmdshell', 1

   RECONFIGURE WITH OVERRIDE

END

IF EXISTS ( SELECT  Name
            FROM    tempdb..sysobjects
            WHERE   name LIKE '#MyTempTable%' ) 
    DROP TABLE #MyTempTable

Create Table #MyTempTable
    (
      Big_String nvarchar(500)
    )
Insert  Into #MyTempTable
        EXEC master..xp_cmdshell 'WMIC SERVICE GET Name,StartName | findstr /I SQL'

-- show service  accounts

Select  @@ServerName as ServerName,
        Rtrim(Left(Big_String, charindex('     ', Big_String))) as Service_Name,
        RTrim(LTrim(Rtrim(Substring(Big_String, charindex('     ', Big_String),
                                    len(Big_String))))) as Service_Account
from    #MyTempTable

IF  @@microsoftversion / power(2, 24) >= 9

   EXEC sp_configure 'xp_cmdshell', 0

   RECONFIGURE WITH OVERRIDE

   EXEC sp_configure 'show advanced options', 0
   RECONFIGURE WITH OVERRIDE
