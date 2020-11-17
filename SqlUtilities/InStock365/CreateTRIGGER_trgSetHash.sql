Select count(*) from Admin where EmailAddr = 'dm@dmachicago.com' and EmailHash = '0a1e1a73d1d80afe5537183b4c37bbd4' and [PwHash] = 'c694eed6ffbc91edfd9409f626529b03' 
go

select PwHash, EmailHAsh from [Admin] where EmailAddr = 'dm@dmachicago.com'

GO
SELECT HASHBYTES ('SHA1', 'Junebug1') ;
SELECT SUBSTRING (DFINAnalytics.dbo.fn_varbintohexstr (HASHBYTES ('SHA1', 'Junebug1')) , 3, 32) ;
go
UPDATE admin
SET password = 'Lottieb@01'
go
UPDATE admin
SET password = 'Junebug1'
  WHERE EmailAddr = 'dm@dmachicago.com';
GO
UPDATE admin
SET pwhash = (SELECT SUBSTRING (DFINAnalytics.dbo.fn_varbintohexstr (HASHBYTES ('SHA1', 'Junebug1')) , 3, 32))
  WHERE EmailAddr = 'dm@dmachicago.com';
GO
SELECT *
  FROM Admin;	--c694eed6ffbc91edfd9409f626529b03	--04d29783152edc1628b15028d8669eec
GO

truncate table [admin]
go

INSERT INTO dbo.Admin (EmailAddr, password, bRead, bWrite, bDelete, bCreateAdmin) 
VALUES
	   ('dale@dmachicago.com', 'Lottieb@01', 1, 1, 1, 1) ;
GO
INSERT INTO dbo.Admin (EmailAddr, password, bRead, bWrite, bDelete, bCreateAdmin) 
VALUES
	   ('dm@dmachicago.com', 'Junebug1', 1, 1, 1, 1) ;
GO

drop trigger trgSetHash 
go

SELECT SUBSTRING (DFINAnalytics.dbo.fn_varbintohexstr (HASHBYTES ('SHA1', 'Junebug1')) , 3, 32)
go

exec spAddHashAdmin 'dm@dmachicago.com','Junebug1'
go
Create procedure spAddHashAdmin (@EM as nvarchar(250),@PW as nvarchar(250))
as
Begin

	declare @pwhash nvarchar(250) = '' ;
	declare @emhash nvarchar(250) = '' ;

	SET @pwhash = (SELECT SUBSTRING (DFINAnalytics.dbo.fn_varbintohexstr (HASHBYTES ('SHA1', @PW)) , 3, 32));
	SET @emhash = (SELECT SUBSTRING (DFINAnalytics.dbo.fn_varbintohexstr (HASHBYTES ('SHA1', @EM)) , 3, 32));

	print (@EM + ' : ' + @emhash) ;
	print (@PW + ' : ' + @pwhash) ;

	update [Admin] set PwHash = @pwhash where EmailAddr = @EM ;
	update [Admin] set EmailHash = @emhash where EmailAddr = @EM ;
	
End
GO

drop trigger trgHashAdmin ;
GO

CREATE TRIGGER trgHashAdmin
ON [admin]
INSTEAD OF INSERT
AS
BEGIN
  --SET NOCOUNT ON;
  INSERT [Admin](EmailAddr, [password], bRead, bWrite, bDelete, bCreateAdmin,EmailHash,PwHash)
    SELECT EmailAddr, [password], bRead, bWrite, bDelete, bCreateAdmin, 
	(SELECT SUBSTRING (DFINAnalytics.dbo.fn_varbintohexstr (HASHBYTES ('SHA1', emailaddr)) , 3, 32)),
	(SELECT SUBSTRING (DFINAnalytics.dbo.fn_varbintohexstr (HASHBYTES ('SHA1', [password])) , 3, 32))
    FROM inserted;
END
GO

GO
create TRIGGER trgSetHash ON Admin
	AFTER INSERT, UPDATE
AS
	--select * from [admin] ;					
	 UPDATE Admin 
	 SET Admin.EmailHash = (SELECT SUBSTRING (DFINAnalytics.dbo.fn_varbintohexstr (HASHBYTES ('SHA1', d.emailaddr)) , 3, 32)) , Admin.PwHash = (SELECT SUBSTRING (DFINAnalytics.dbo.fn_varbintohexstr (HASHBYTES ('SHA1', d.password)) , 3, 32))
	   FROM Admin
				JOIN deleted as d
					ON Admin.EmailAddr = d.EmailAddr;
	--select * from deleted ;					
	UPDATE Admin
	 SET Admin.EmailHash = (SELECT SUBSTRING (DFINAnalytics.dbo.fn_varbintohexstr (HASHBYTES ('SHA1', admin.emailaddr)) , 3, 32)) , Admin.PwHash = (SELECT SUBSTRING (DFINAnalytics.dbo.fn_varbintohexstr (HASHBYTES ('SHA1', admin.password)) , 3, 32))
	   FROM Admin
				JOIN inserted i
					ON Admin.EmailAddr = i.EmailAddr;

