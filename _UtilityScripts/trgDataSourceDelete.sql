select 'if not exists (select 1 from sysindexes where name = ''PI_'+table_name+ '_' +column_name+''') 
Begin
    create index PI_'+table_name+ '_' +column_name + ' on ' + table_name +' ('+column_name+');
end'
from information_schema.columns
where (column_name = 'ContentGuid' or column_name = 'SourceGuid') and table_name not like 'gv_%' and table_name not like 'v_%'
go
drop TRIGGER trgDataSourceDelete
go
CREATE TRIGGER trgDataSourceDelete
    ON dbo.DataSource
    FOR DELETE
AS
begin
	DELETE FROM CLC_Download where ContentGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM CLC_Preview where ContentGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM ContentUser where ContentGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM DataOwners where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM DataSource where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM DataSourceCheckOut where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM DataSourceOwner where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM DataSourceRestoreHistory where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM FileKey where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM GlobalSeachResults where ContentGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM gv_DataOwners where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM gv_DataSourceCheckOut where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM gv_DataSourceRestoreHistory where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM gv_GlobalSeachResults where ContentGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM gv_LibraryItems where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM gv_Machine where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM gv_QuickRefItems where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM gv_RestorationHistory where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM gv_RetentionTemp where ContentGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM gv_SourceAttribute where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM gv_WebSource where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM gv_ZippedFiles where ContentGUID IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM gv_ZippedFiles where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM LibraryItems where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM Machine where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM QuickRefItems where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM RestorationHistory where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM RestoreQueue where ContentGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM RestoreQueueHistory where ContentGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM RetentionTemp where ContentGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM RSSChildren where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM SearchGuids where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM SourceAttribute where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM StructuredData where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM TempUserLibItems where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM WebSource where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM ZippedFiles where ContentGUID IN(SELECT SourceGuid FROM deleted) ; 
	DELETE FROM ZippedFiles where SourceGuid IN(SELECT SourceGuid FROM deleted) ; 
end
GO


select 'DELETE FROM ' + table_name + ' where ' + COLUMN_NAME + ' IN(SELECT SourceGuid FROM deleted) ; ' as stmt
from INFORMATION_SCHEMA.columns 
where (column_name like 'sourceguid%' or  column_name like 'contentguid%') --and TABLE_NAME not like 'gv_%'
order by TABLE_NAME

delete from DataSource where SourceGuid = '0931ba83-adba-49f3-9636-937e12440f11'
select SourceGuid from DataSource where CreateDate > getdate() -1

SELECT top 10 FQN, CRC, ImageHash from DataSource

SELECT top 10 FQN, CONVERT(varbinary, CRC) as CRC, CONVERT(varbinary, ImageHash) as ImageHash from DataSource

SELECT top 10 FQN, CONVERT(VARBINARY(MAX), CRC), CONVERT(varbinary(MAX), ImageHash) as ImageHash from DataSource

SELECT * from DataSource 
where ImageHash = 
CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), '7AFBA9768D9800934C89889D4FF441574B9D3699A2E6AA31AD30C15FDBB74E7AD8342F0077ABF005DAB1076A1EC0D0DD796F4AF177EEB1E161C4AAA29CCA27E1', 2)) -- Assumes 0x string, no 0x wanted, returns 'Help'
 
select top 10  CRC, ImageHash from DataSource order by RowID
update datasource set CRC = convert (varbinary, CRC), ImageHash = convert (varbinary, ImageHash) from DataSource

update datasource set CRC = CONVERT(varbinary(100),ImageHash) 
SELECT top 10 CONVERT(varbinary(100),ImageHash) as ImageHash from dataSource order by RowID
SELECT top 10 CONVERT(varbinary(100),CRC) as CRC from dataSource order by RowID
select top 10 HASHBYTES('SHA2_512', SourceImage) from dataSource order by RowID

select convert(nvarchar(100), 0x066A7CAC9D29E8B316AAB6A06359A2CADA36FF726560831FE07724B54E470BB96E48F3ADFD4F3F0CE18FFE905DFEDD7BCD84E26EFB70BB575D9CF9E3A0A82589)

select count(*)
from DataSource
where ImageHash = 0x066A7CAC9D29E8B316AAB6A06359A2CADA36FF726560831FE07724B54E470BB96E48F3ADFD4F3F0CE18FFE905DFEDD7BCD84E26EFB70BB575D9CF9E3A0A82589
or ImageHash = 0x7B685B64C95C73A49D2F26DABD9C7DB9801C357B7EACBC7209A380ED2BC402179E8798BE61B6E36059D49B1F50826D664D72CCA152870BE93FB78E796F21182E



SELECT top 10  CONVERT(VARBINARY(MAX), CONVERT(NVARCHAR(MAX), ImageHash, 1)) as HASH from DataSource -- Requires 0x, returns 'Help'
SELECT CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), '48656c70', 2)) -- Assumes 0x string, no 0x wanted, returns 'Help'
 

select count(*) from DataSource
where ImageHash = 0xB35633ECD4B832F095307015832F0BFA59ECBD871D80DE656EB89B38CB7273AD58990AC2D5F275C78268D61622061B2020DFBF4450F9139E2893AA1495D521EF

select top 10 * from DataSource 
where CONVERT(varbinary(MAX), ImageHash) = 0x7AFBA9768D9800934C89889D4FF441574B9D3699A2E6AA31AD30C15FDBB74E7AD8342F0077ABF005DAB1076A1EC0D0DD796F4AF177EEB1E161C4AAA29CCA27E1

declare @iLen int = (select datalength (SourceImage) 
from DataSource 
where FQN = 'C:\temp\Channels.txt')

print @iLen;


select HASHBYTES('SHA2_512', SourceImage) as Hash
from DataSource 
where FQN = 'C:\temp\Channels.txt'

select CONVERT(varbinary(MAX), ImageHash) as HASH, * 
from DataSource 
where FQN = 'C:\temp\Channels.txt'
--C:\EcmTrace\ECMLibrary.Archive.Client.Installation.Log.7.1.2020.txt

--0xC989F725DC4A5EC1EA7C88F7E12977F6BAC2C1B40D31D9541A0A24526C57975300D0C77D7CE9EC59811E14AA977A568E706F3EE3532B145F94F2D89B2E6F1B22
--  C989F725DC4A5EC1EA7C88F7E12977F6BAC2C1B40D31D9541A0A24526C57975300D0C77D7CE9EC59811E14AA977A568E706F3EE3532B145F94F2D89B2E6F1B22
--0x5F35CBE902CF2658C49FD56108F5247150987027644F9AFB592152C75DCA3CBF
--  514980D95BC376AA9A34D8079E0D4872D22BE1043E58703941BBA313D6703EA2

--   770061006C007400650072002000640061006C00650020006D0069006C006C0065007200 
-- 0x770061006C007400650072002000640061006C00650020006D0069006C006C0065007200
declare @xvar nvarchar(100) = 'walter dale miller'
select CONVERT(varbinary(MAX), @xvar) 


Select count(*) FROM DataSource where SourceName = 'ECMLibrary.Archive.Client.Installation.Log.7.1.2020.txt' and CRC = 0xD2B65F42FB795C71BEBAF759DEE497D661AD3B30A7B158C18221EE8133D94C0C79A05901B3C54A150D27DE1AFAC589AE811A5FEC42BEA3C2AAB20818EC033B6E; 

Update DataSource set FileAttached = 0, CRC = 0x5346F43FF7ED4495858F3BCF278C17A508A2246B8624D006BC83D6131D47ADD05B54E0167FA0652F95509B01A4D7156031E6E1474749A3D1C5189093E32249CC where SourceGuid = 'e00bd459-31f7-42fb-ad93-9a73bbd81507'

select * from DataSource where FQN = 'C:\temp\t.txt'