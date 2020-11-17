
 create PROCEDURE [dbo].[ECM_HivePerftestV2]
 (@MilliSeconds int output)
 AS
 BEGIN
 	declare @datetime1 datetime
 	declare @datetime2 datetime
 	declare @elapsed_seconds int
 	declare @elapsed_milliseconds int
 	declare @elapsed_time datetime
 	declare @elapsed_days int
 	declare @elapsed_hours int
 	declare @elapsed_minutes int
 	
 	declare @iCount int
 
 	select @datetime1 = GETDATE()
 
 	set @iCount = (select COUNT(*) from datasource where SourceGuid = 'xx')
 	set @iCount = (select COUNT(*) from Email where EmailGuid = 'xx')
 	set @iCount = (select COUNT(*) from EmailAttachment where EmailGuid = 'xx')
 	set @iCount = (select COUNT(*) from SourceAttribute where SourceGuid = 'xx')
 
 	select @datetime2 = GETDATE()
 
 	select @elapsed_time = @datetime2-@datetime1
 	select @elapsed_days = datediff(day,0,@elapsed_time)
 	select @elapsed_hours = datepart(hour,@elapsed_time)
 	select @elapsed_minutes = datepart(minute,@elapsed_time)
 	select @elapsed_seconds = datepart(second,@elapsed_time)
 	select @elapsed_milliseconds = datepart(millisecond,@elapsed_time)
 
 	declare @cr varchar(4), @cr2 varchar(4)
 	select @cr = char(13)+Char(10)
 	select @cr2 = @cr+@cr
 
 /*
 	print	'Elapsed Time: '+convert(varchar(30),@elapsed_time,121)+' ='+@cr+
 		'	 '+convert(varchar(30),@datetime2,121)+
 		' - '+convert(varchar(30),@datetime1,121)+@cr2
 
 	print	'Elapsed Time Parts:'+@cr+
 		' Days         = '+convert(varchar(20),@elapsed_days)+@cr+
 		' Hours        = '+convert(varchar(20),@elapsed_hours)+@cr+
 		' Minutess     = '+convert(varchar(20),@elapsed_minutes)+@cr+
 		' Secondss     = '+convert(varchar(20),@elapsed_seconds)+@cr+
 		' Milliseconds = '+convert(varchar(20), @elapsed_milliseconds)+@cr2+@cr2
 
 		SET @result = @elapsed_milliseconds
 */
 
 	SELECT @MilliSeconds = @elapsed_milliseconds 
 
 END
