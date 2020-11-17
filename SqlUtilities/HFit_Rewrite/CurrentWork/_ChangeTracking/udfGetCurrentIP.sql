GO
PRINT 'Creating udfGetCurrentIP';
GO
IF EXISTS (SELECT
				  name
			 FROM sys.objects
			 WHERE name = 'udfGetCurrentIP') 
	BEGIN
		DROP FUNCTION
			 udfGetCurrentIP;
	END;
GO
CREATE FUNCTION dbo.udfGetCurrentIP () 
RETURNS varchar (255) 
AS
	 BEGIN

		 --*********************************************************
		 --WDM 03.21.2009 Get the IP address of the current client.
		 --Used to track a DBA/Developer IP address when change is 
		 --applied to a table or view.
		 --*********************************************************

		 DECLARE @IP_Address varchar (254) ;
		 SELECT
				@IP_Address = client_net_address
		   FROM sys.dm_exec_connections
		   WHERE Session_id = @@SPID;
		 RETURN @IP_Address;
	 END;

--Same as above
--SELECT CONVERT(char(15), CONNECTIONPROPERTY('client_net_address'))

GO
PRINT 'Created udfGetCurrentIP';
GO
