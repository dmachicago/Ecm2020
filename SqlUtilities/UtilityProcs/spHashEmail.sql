DECLARE @SomeValue nvarchar(50);
SELECT @SomeValue = N'data type and can at the first glance give a bit different results that we might think';
SELECT HashBytes('md5', @SomeValue);
GO
--0x51FD96B1BD5CE0003370551D5498BA3C0E64BE4C
--0xD1CC76BE7F85796FAC7FBC373EE03F04
--0x18609AFB4118D3D9FBCAC325CD842253
--0x18609AFB4118D3D9FBCAC325CD842253

create Function spHashEmail (@Subject nvarchar(1000), 
					@EmailBody nvarchar(max), 
					@EmailCreateDate varchar(50), 
					@EmailAuthor  nvarchar(50), 
					@NbrAttachments varchar(50), 
					@EmailExt  varchar(50)) 
RETURNS varchar
as Begin

	declare @tHash nvarchar(500)
	set @tHash = @Subject
	set @tHash = HASHBYTES('md5', @tHash) 
	
	set @tHash = @tHash + @EmailBody
	set @tHash = HASHBYTES('md5', @tHash) 
	
	set @tHash = @tHash + @EmailCreateDate
	set @tHash = HASHBYTES('md5', @tHash) 
	
	set @tHash = @tHash + @NbrAttachments
	set @tHash = HASHBYTES('md5', @tHash) 
	
	set @tHash = @tHash + @EmailExt
	set @tHash = HASHBYTES('md5', @tHash) 
	
	return @tHash
	
end