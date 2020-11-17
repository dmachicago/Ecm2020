
/*
USE master;
-- Reverting to
RESTORE DATABASE KenticoCMSCloudtst4 from 
DATABASE_SNAPSHOT = 'KenticoCMSCloudtst4_ss20160201_1538';
GO
*/


USE master
GO
declare @kill varchar(8000) = '';
select @kill=@kill+'kill '+convert(varchar(5),spid)+';'
    from master..sysprocesses 
where dbid=db_id('KenticoCMSCloudtst4'); -- DB Name
print @kill ;
exec (@kill);
GO


--IF EXISTS (SELECT database_id FROM sys.databases
--    WHERE NAME='KenticoCMS_QA_ss20150430_2206')
--begin
--    print 'Found it' ;
--    DROP DATABASE KenticoCMS_QA_ss20150430_2206;
--end
--GO
--IF EXISTS (SELECT database_id FROM sys.databases
--    WHERE NAME='KenticoCMS_QA_ss20150430_2100')
--begin
--    print 'Found it' ;
--    DROP DATABASE KenticoCMS_QA_ss20150430_2100;
--end
--Go

IF EXISTS (SELECT database_id FROM sys.databases
    WHERE NAME='KenticoCMSCloudtst4_ss20160201_1538')
begin
    USE master;
    RESTORE DATABASE KenticoCMSCloudtst4 from 
    DATABASE_SNAPSHOT = 'KenticoCMSCloudtst4_ss20160201_1538';
end;
GO

--exec sp_who
--kill 51
--kill 52
--kill 53


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
