GO

--print('CHANGING to the instrument DB.');
--GO

--use instrument
--go

print('Processing trgSchemaMonitor.sql');
go

if exists(Select name from sys.tables where name = 'SchemaChangeMonitor')
BEGIN
	print('Table SchemaChangeMonitor found, continuing.');
END

if NOT exists(Select name from sys.tables where name = 'SchemaChangeMonitor')
BEGIN
	print('Creating table SchemaChangeMonitor.');
	--drop TABLE dbo.SchemaChangeMonitor 
	--go
	CREATE TABLE dbo.SchemaChangeMonitor (PostTime datetime, 
		DB_User nvarchar(100), 
		IP_Address nvarchar(50), 
		CUR_User nvarchar(80), 
		OBJ nvarchar(50), 
		Event nvarchar(100), 
		TSQL nvarchar(2000));

	CREATE NONCLUSTERED INDEX [PI_SchemaChangeMonitor] ON [dbo].[SchemaChangeMonitor]
	(
		[OBJ] ASC
	)

	--GRANT SELECT ON [dbo].[SchemaChangeMonitor] TO [platformuser_dev] ;
	--GRANT INSERT ON [dbo].[SchemaChangeMonitor] TO [platformuser_dev] ;
	--GRANT DELETE ON [dbo].[SchemaChangeMonitor] TO [platformuser_dev] ;
	--GRANT UPDATE ON [dbo].[SchemaChangeMonitor] TO [platformuser_dev] ;

END
GO

if NOT exists(Select name from sys.tables where name = 'SchemaMonitorObjectName')
BEGIN
	print('Table SchemaMonitorObjectName FOUND, continuing');
END

if NOT exists(Select name from sys.tables where name = 'SchemaMonitorObjectName')
BEGIN
	print('Creating table SchemaMonitorObjectName');
	--drop TABLE dbo.SchemaMonitorObjectName
	--go
	CREATE TABLE dbo.SchemaMonitorObjectName (ObjectName nvarchar(250), 
		ObjectType nvarchar(25));

	CREATE unique CLUSTERED INDEX [PKI_SchemaMonitorObjectName] ON [dbo].[SchemaMonitorObjectName]
	(
		[ObjectName] ASC,
		[ObjectType] ASC
	)

	--GRANT SELECT ON [dbo].SchemaMonitorObjectName TO [platformuser_dev] ;
	--GRANT INSERT ON [dbo].SchemaMonitorObjectName TO [platformuser_dev] ;
	--GRANT DELETE ON [dbo].SchemaMonitorObjectName TO [platformuser_dev] ;
	--GRANT UPDATE ON [dbo].SchemaMonitorObjectName TO [platformuser_dev] ;
END
GO

if NOT exists(Select name from sys.tables where name = 'SchemaMonitorObjectNotify')
BEGIN
	print('Table SchemaMonitorObjectNotify FOUND, continuing');
END

if NOT exists(Select name from sys.tables where name = 'SchemaMonitorObjectNotify')
BEGIN
	print('Creating table SchemaMonitorObjectNotify');
	--drop TABLE dbo.SchemaMonitorObjectNotify
	--go
	CREATE TABLE dbo.SchemaMonitorObjectNotify (EmailAddr nvarchar(250))

	CREATE unique CLUSTERED INDEX [PCI_SchemaMonitorObjectNotify] ON [dbo].SchemaMonitorObjectNotify
	(
		[EmailAddr] ASC
	)

	--GRANT SELECT ON [dbo].SchemaMonitorObjectNotify TO [platformuser_dev] ;
	--GRANT INSERT ON [dbo].SchemaMonitorObjectNotify TO [platformuser_dev] ;
	--GRANT DELETE ON [dbo].SchemaMonitorObjectNotify TO [platformuser_dev] ;
	--GRANT UPDATE ON [dbo].SchemaMonitorObjectNotify TO [platformuser_dev] ;

	insert into dbo.SchemaMonitorObjectNotify (EmailAddr) values ('wdalemiller@gmail.com') ;
	insert into dbo.SchemaMonitorObjectNotify (EmailAddr) values ('dm@dmachicago.com') ;
	insert into dbo.SchemaMonitorObjectNotify (EmailAddr) values ('wdm@dmachicago.com') ;
END
GO

print('Creating view_SchemaChangeMonitor');
go
--DROP TRIGGER trgSchemaMonitor on DATABASE
--disable TRIGGER trgSchemaMonitor on DATABASE
--enable TRIGGER trgSchemaMonitor on DATABASE

if exists(Select name from sys.views where name = 'view_SchemaChangeMonitor')
BEGIN
	print('Creating view_SchemaChangeMonitor, continuing');
	drop view view_SchemaChangeMonitor ;
END
GO

create view view_SchemaChangeMonitor
	as
		SELECT PostTime, DB_User, IP_Address, CUR_User, Event, TSQL, OBJ
		FROM     SchemaChangeMonitor ;		
GO

	--GRANT SELECT ON  [dbo].view_SchemaChangeMonitor TO [platformuser_dev] ;
	--GRANT INSERT ON  [Schema].[Table] TO [User] ;
	--GRANT DELETE ON  [Schema].[Table] TO [User] ;
	--GRANT UPDATE ON  [Schema].[Table] TO [User] ;


print('Created view_SchemaChangeMonitor');
GO

--USE KenticoCMS_DEV
--GO

if exists(select name from sys.triggers where name = 'trgSchemaMonitor')
Begin 
	print('creating trgSchemaMonitor');
	drop trigger trgSchemaMonitor ;
END
GO
print('Updating trgSchemaMonitor');
GO

CREATE TRIGGER trgSchemaMonitor
ON DATABASE 
FOR DDL_DATABASE_LEVEL_EVENTS 
AS
	DECLARE @data XML ;
	Declare @IPADDR varchar(50) ;
	DECLARE @CUR_User varchar(50);

	SET @CUR_User = SYSTEM_USER;
	set @IPADDR = (SELECT CONVERT(char(15), CONNECTIONPROPERTY('client_net_address')));
	SET @data = EVENTDATA();

	INSERT SchemaChangeMonitor 
	   (PostTime, DB_User, IP_Address , CUR_User, OBJ, Event, TSQL) 
	   VALUES 
	   (
	   GETDATE(), 
	   CONVERT(nvarchar(100), CURRENT_USER), 
	   @IPADDR,
	   @CUR_User,
	   @data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(100)'), 
	   @data.value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(100)'), 
	   @data.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(2000)') 
	   ) ;

	--THIS WILL DELETE records older than 90 days.
	--delete from SchemaChangeMonitor where PostTime < getdate() - 90 ;
GO

--grant execute on trgSchemaMonitor to PUBLIC ;
--go

--grant execute on sp_SchemaMonitorReport to platformuser_dev ; 
--GO

print('Processed trgSchemaMonitor.sql');
