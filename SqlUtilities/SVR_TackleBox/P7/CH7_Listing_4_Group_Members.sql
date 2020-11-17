SET NoCount ON   
SET quoted_identifier OFF  
  
DECLARE @groupname VARCHAR(100)  

IF EXISTS (SELECT     *
                        FROM         tempdb.dbo.sysobjects
                        WHERE     id = OBJECT_ID(N'[tempdb].[dbo].[RESULT_STRING]'))
 DROP TABLE [tempdb].[dbo].[RESULT_STRING]; 

CREATE TABLE [tempdb].[dbo].[RESULT_STRING] 
( Account_Name VARCHAR(2500),
type varchar(10),
Privilege varchar(10),
Mapped_Login_Name varchar(60),
Group_Name varchar(100) )

DECLARE Get_Groups CURSOR
    FOR Select 
name from master..syslogins 
where 
isntgroup = 1 and status >= 9 or Name= 'BUILTIN\ADMINISTRATORS' 

-- Open cursor and loop through group names  
OPEN Get_Groups 
FETCH NEXT FROM Get_Groups INTO @groupname  


WHILE ( @@fetch_status <> -1 )  
    BEGIN 
        IF ( @@fetch_status = -2 ) 
            BEGIN  
                FETCH NEXT FROM Get_Groups INTO @groupname  
                CONTINUE  
            END

--Insert SQL Commands Here:      
Insert into [tempdb].[dbo].[RESULT_STRING]
Exec master..xp_logininfo @Groupname, 'members'

        FETCH NEXT FROM Get_groups INTO @groupname 
    END  

DEALLOCATE Get_Groups  

Alter TABLE [tempdb].[dbo].[RESULT_STRING] Add Server varchar(100) NULL;

GO

Update [tempdb].[dbo].[RESULT_STRING] Set Server = CONVERT(varchar(100), SERVERPROPERTY('Servername'))

-- Now Query the temp table for users.

SET NoCount OFF  
SELECT [Account_Name]
      ,[type]
      ,[Privilege]
      ,[Mapped_Login_Name]
      ,[Group_Name]
      ,[Server]
  FROM [tempdb].[dbo].[RESULT_STRING]
