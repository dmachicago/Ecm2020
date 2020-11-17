use DataMartPlatform;
go

create procedure proc_TABLE_GROWTH_HISTORY
as
begin
if not exists(select name from sys.tables where name = 'TABLE_GROWTH_HISTORY')
begin 
    create table TABLE_GROWTH_HISTORY
    (
	   Table_name nvarchar(250) not null,
	   NbrRows int not null,
	   EntryDate datetime default getdate()
    )
end 

declare @i int = 0 ;
declare @itot int = 0 ;
declare @icnt int = 0 ;
declare @irecs int = 0 ;
declare @msg nvarchar(1000) = '' ;
declare @mysql nvarchar(2000) = '' ;

SET NOCOUNT ON  ;

set @itot = (select count(*) from information_schema.tables T
	join information_schema.columns C
	on T.table_name = C.table_name
	where column_name = 'dbname'
	and table_type <> 'view' and T.table_name like 'BASE[_]%' and t.table_name not like  'VIEW[_]%'
);
DECLARE @rowcount TABLE (Value int);

DECLARE db_cursor CURSOR FOR  
	select T.table_name from information_schema.tables T
	join information_schema.columns C
	on T.table_name = C.table_name
	where column_name = 'dbname'
	and table_type <> 'view' and T.table_name like 'BASE[_]%' and t.table_name not like  'VIEW[_]%'
	and t.table_name not like  'BASE_HFit_GoalOutcome%'
	order by T.TABLE_NAME ;

declare @name nvarchar(254) = null ;

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @name   

WHILE @@FETCH_STATUS = 0   
BEGIN   
	set @i = @i + 1 ;

    exec PrintImmediate '-------------------------------' ;
    set @msg = 'Processing '+@name+' : ' + cast(@i as nvarchar(50)) + ' of ' + cast(@itot as nvarchar(50)) ;
    exec PrintImmediate @msg ;

    exec @irecs = proc_quickRowCount @name ;
    insert into TABLE_GROWTH_HISTORY (Table_name,NbrRows) values (@name, @irecs) ;
	
    FETCH NEXT FROM db_cursor INTO @name   ;
END 

CLOSE db_cursor   
DEALLOCATE db_cursor
end 