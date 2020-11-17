
select * from [dbo].[Member] ;
select * from [dbo].[EmailSentCnt] ;


select * from [dbo].[Email] ;
select * from [dbo].[ToEmail];
select * from [dbo].[CC];
select * from [dbo].[BCC];
select * from [dbo].[SendTO];

select * from [dbo].[K3];
select * from [dbo].[Attachment];
select * from [dbo].[AttachmentKey];

insert into SysParm (ParmName, ParmVal) values ('EmailExpireDays', 7) ;
insert into SysParm (ParmName, ParmVal) values ('CommExpireHours', 24) ;

select * from [dbo].[CommVector];
select * from [dbo].[CommVectorInit];

select table_name from information_schema.columns where column_name = 'SID'
select table_name from information_schema.columns where column_name = 'commguid'

select count(*) from [dbo].[CC] where EmailNbr = 10 ;


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
