if exists(Select name from sys.objects where name = 'sp_AddTdrCode')
BEGIN
    drop procedure sp_AddTdrCode ;
END
go

create procedure sp_AddTdrCode (@code nvarchar(50), @desc nvarchar(250))
as
BEGIN
    declare @i int = 0 ; 
    select @i = (select count(*) from dbo.TDRCode where TDRCode = @code) ;
    if (@i > 0)
    BEGIN
	   update dbo.TDRCode set CodeDescription = @desc where TDRCode = @code ;
	   print (@code + ' updated.');
    END
    else
    BEGIN
	   insert into TDRCode (TDRCode, CodeDescription) values (@code, @desc) ;
	   print (@code + ' added.');
    END
END
go

exec sp_AddTdrCode 'CLO','Clicked item for review' ;
exec sp_AddTdrCode 'MSU', 'Machine Startup' ;
exec sp_AddTdrCode 'LI', 'Successful Login' ;
exec sp_AddTdrCode 'FLI', 'Failed Login' ;
exec sp_AddTdrCode 'ASC', 'Item Add to cart' ;
exec sp_AddTdrCode 'RSC', 'Item Remove from cart' ;
exec sp_AddTdrCode 'IPUR', 'Item Purchase' ;
exec sp_AddTdrCode 'IPV', 'Item Review' ;
exec sp_AddTdrCode 'VP', 'View Page' ;
exec sp_AddTdrCode 'OS', 'Operating System' ;


SELECT [TDRCode],[CodeDescription] FROM [InStock365].[dbo].[TDRCode] ;

alter table TDR add TrkID nvarchar(50) null ;
alter table Sessions add TrkID nvarchar(50) null ;
alter table Sessions add OSName nvarchar(50) null ;