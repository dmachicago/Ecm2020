create procedure spZeroToEmail @EmailGuid uniqueidentifier
as
declare @iLen int ; 
declare @iCnt int ; 
declare @stars varchar;
set @iCnt = (select count(*) from ToEmail where EmailGuid = @EmailGuid);
if @iCnt > 0 
Begin
	set @iLen = (select DATALENGTH([ToEmail]) from ToEmail where EmailGuid = @EmailGuid);
	set @stars = (SELECT REPLICATE( '*', @iLen));
	update ToEmail set [ToEmail] = @stars where EmailGuid = @EmailGuid;
	delete from ToEmail where EmailGuid = @EmailGuid;
END

go

create procedure spZeroSendTO @EmailGuid uniqueidentifier
as
declare @iLen int ; 
declare @iCnt int ; 
declare @stars varchar;
set @iCnt = (select count(*) from SendTO where EmailGuid = @EmailGuid);
if @iCnt > 0 
Begin
	set @iLen = (select DATALENGTH([ToAddr]) from SendTO where EmailGuid = @EmailGuid);
	set @stars = (SELECT REPLICATE( '*', @iLen));
	update SendTO set [ToAddr] = @stars where EmailGuid = @EmailGuid;
	delete from SendTO where EmailGuid = @EmailGuid;
END

GO

create procedure spZeroFromEmail @EmailGuid uniqueidentifier
as
declare @iLen int ; 
declare @iCnt int ; 
declare @stars varchar;
set @iCnt = (select count(*) from [FromEmail] where EmailGuid = @EmailGuid);
if @iCnt > 0 
Begin
	set @iLen = (select DATALENGTH([ToAddr]) from [FromEmail] where EmailGuid = @EmailGuid);
	set @stars = (SELECT REPLICATE( '*', @iLen));
	update [FromEmail] set [ToAddr] = @stars where EmailGuid = @EmailGuid;
	delete from [FromEmail] where EmailGuid = @EmailGuid;
END

GO

create procedure spZeroToCC @EmailGuid uniqueidentifier
as
declare @iLen int ; 
declare @iCnt int ; 
declare @stars varchar;
set @iCnt = (select count(*) from CC where EmailGuid = @EmailGuid);
if @iCnt > 0 
Begin
	set @iLen = (select DATALENGTH([ToAddr]) from CC where EmailGuid = @EmailGuid);
	set @stars = (SELECT REPLICATE( '*', @iLen));
	update CC set [ToAddr] = @stars where EmailGuid = @EmailGuid;
	delete from CC where EmailGuid = @EmailGuid;
END

GO


create procedure spZeroBCC @EmailGuid uniqueidentifier
as
declare @iLen int ; 
declare @iCnt int ; 
declare @stars varchar;
set @iCnt = (select count(*) from BCC where EmailGuid = @EmailGuid);
if @iCnt > 0 
Begin
	set @iLen = (select DATALENGTH([ToAddr]) from BCC where EmailGuid = @EmailGuid);
	set @stars = (SELECT REPLICATE( '*', @iLen));
	update BCC set [ToAddr] = @stars where EmailGuid = @EmailGuid;
	delete from BCC where EmailGuid = @EmailGuid;
END

GO 

create procedure spZeroAttachment @EmailGuid uniqueidentifier
as
declare @iLen int ; 
declare @iCnt int ; 
declare @stars varchar;
set @iCnt = (select count(*) from Attachment where EmailGuid = @EmailGuid);
if @iCnt > 0 
Begin
	set @iLen = (select DATALENGTH([FileContents]) from Attachment where EmailGuid = @EmailGuid);
	set @stars = (SELECT REPLICATE( '*', @iLen));
	update Attachment set [FileContents] = @stars where EmailGuid = @EmailGuid;
	delete from Attachment where EmailGuid = @EmailGuid;
END
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
