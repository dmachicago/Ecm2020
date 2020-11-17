

GO
print('Creating udfGetCurrentIP') ;
GO

if exists(select name from sys.objects where name = 'udfGetCurrentIP')
BEGIN
	drop function udfGetCurrentIP ;
END

GO

CREATE FUNCTION [dbo].[udfGetCurrentIP] ()
RETURNS varchar(255)
AS
BEGIN
	--*********************************************************
	--WDM 03.21.2009 Get the IP address of the current client.
	--Used to track a DBA/Developer IP address when change is 
	--applied to a table or view.
	--*********************************************************
    DECLARE @IP_Address varchar(255);
 
    SELECT @IP_Address = client_net_address
    FROM sys.dm_exec_connections
    WHERE Session_id = @@SPID;
 
    Return @IP_Address;
END

--Same as above
--SELECT CONVERT(char(15), CONNECTIONPROPERTY('client_net_address'))
GO
print('Created udfGetCurrentIP') ;
GO
