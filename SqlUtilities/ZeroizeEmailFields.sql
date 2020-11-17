use K3
go
alter PROCEDURE spZeroizeEmail @EmailNbr int
AS

declare @ExpireDays int ;
declare @MO int ;
declare @DA int; 
declare @Yr int; 
DECLARE @CurrentDATE DATETIME;
SET @CurrentDATE = GETDATE();

set @ExpireDays = (select cast(ParmVal as int) from SysParm where ParmName = 'EmailExpireDays'); 

DECLARE @ExpireDATE DATETIME;
SET @ExpireDATE = GETDATE() + @ExpireDays;

set @MO = (select MONTH(@CurrentDATE)) ;
set @DA = (select DAY(@CurrentDATE)) ;
set @YR = (select YEAR(@CurrentDATE)) ;

declare @iLen int ;
declare @iCnt int ;
declare @stars varchar;
declare @EmailGuid uniqueidentifier;


set @EmailNbr = @EmailNbr ;
set @EmailGuid = (select [EmailGuid] from [Email] where EmailNbr = @EmailNbr) ;


set @iLen = (select DATALENGTH(EmailSubject) from email where EmailNbr = @EmailNbr);
set @stars = (SELECT REPLICATE( '*', @iLen));
update [Email] set EmailSubject = @stars where EmailNbr = @EmailNbr;

set @iLen = (select DATALENGTH(EmailBody) from email where EmailNbr = @EmailNbr);
set @stars = (SELECT REPLICATE( '*', @iLen));
update [Email] set EmailBody = @stars where EmailNbr = @EmailNbr;

set @iLen = (select DATALENGTH(FromEmail) from email where EmailNbr = @EmailNbr);
set @stars = (SELECT REPLICATE( '*', @iLen));
update [Email] set FromEmail = @stars where EmailNbr = @EmailNbr;

set @iLen = (select DATALENGTH(EmailGuid) from email where EmailNbr = @EmailNbr);
set @stars = (SELECT REPLICATE( '*', @iLen));
update [Email] set EmailGuid = @stars where EmailNbr = @EmailNbr;

set @iLen = (select DATALENGTH(AddrHash) from email where EmailNbr = @EmailNbr);
set @stars = (SELECT REPLICATE( '*', @iLen));
update [Email] set AddrHash = @stars where EmailNbr = @EmailNbr;

set @iLen = (select DATALENGTH(CC) from email where EmailNbr = @EmailNbr);
set @stars = (SELECT REPLICATE( '*', @iLen));
update [Email] set CC = @stars where EmailNbr = @EmailNbr;

set @iLen = (select DATALENGTH(BCC) from email where EmailNbr = @EmailNbr);
set @stars = (SELECT REPLICATE( '*', @iLen));
update [Email] set BCC = @stars where EmailNbr = @EmailNbr;

set @iLen = (select DATALENGTH(ToEmail) from email where EmailNbr = @EmailNbr);
set @stars = (SELECT REPLICATE( '*', @iLen));
update [Email] set ToEmail = @stars where EmailNbr = @EmailNbr;

exec spZeroAttachment @EmailGuid ;
exec spZeroBCC @EmailGuid ;
exec spZeroCC @EmailGuid ;
exec spZeroFromEmail @EmailGuid ;
exec spZeroSendTO @EmailGuid ;
exec spZeroToEmail @EmailGuid ;


update EmailSentCnt set MO = 1, DA=1, YR = 1960 where CreateDate <= getdate() + 2;
delete from EmailSentCnt where [CreateDate] <= getdate() + 2;

delete from [Email] where EmailNbr = @EmailNbr;

delete from [Email] where DATEDIFF(DAY, SentDate, @ExpireDATE) > @ExpireDays ;
delete from ActiveSession where DATEDIFF(DAY, CreateDate, @ExpireDATE) > @ExpireDays ;
delete from Attachment where DATEDIFF(DAY, CreateDate, @ExpireDATE) > @ExpireDays ;
delete from Attachment where DATEDIFF(DAY, CreateDate, @ExpireDATE) > @ExpireDays ;

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
