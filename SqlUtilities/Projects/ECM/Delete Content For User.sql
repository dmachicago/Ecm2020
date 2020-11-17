/*
delete from DataSource where 
(SourceName like '%png' 
or SourceName like '%gif' 
or SourceName like '%jpg'
or SourceName like '%bmp'
or SourceName like '%pdf'
or SourceName like '%zip'
or SourceName like '%tif')
and datalength(OcrText) = 0 
*/
/*
delete from DataSource where SourceName like '%zip' 
delete from DataSource where SourceName like '%zip' 
delete from email where Userid like 'WMILL%'
*/

select count(*) from DataSource where DataSourceOwnerUserID like 'W%'
select count(*) from Email where UserID like 'W%'
select count(*) from EmailAttachment where UserID like 'W%'

delete from Email where UserID like 'W%'
delete from EmailAttachment where UserID like 'W%'
delete from DataSource where DataSourceOwnerUserID like 'W%'

select * from DataSource where SourceName like 'CircuitX011a.gif'
select ocrtext, FQN, SourceName from DataSource where SourceName like 'CircuitX011a.gif'

--select ocrtext, * from DataSource where SourceName like 'CircuitX011a.gif'

select FQN, SourceName from DataSource where (SourceName like '%gif' or SourceName like '%png' or SourceName like '%JPG') 
and datalength(OcrText) > 0 

select SourceGuid from DataSource 
where OriginalFileType in (select ImageTypeCode from ImageTypeCodes)
and (OcrPending = '-') and (OcrSuccessful = 'N')
        
