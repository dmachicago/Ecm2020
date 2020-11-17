
--************************************************************************
declare @val varchar(max);
declare @DBName nvarchar(100) = 'master';
declare @Schema nvarchar(100) = 'dbo';
declare @PName nvarchar(100) = 'UTIL_MonitorWorkload';
declare @table table ( val varchar(max)) ;
--declare @FQN nvarchar(500) = '''' + @DBname +'.' + @Schema +'.' + @PName + '''' ;
declare @FQN nvarchar(500) = @DBname +'.' + @Schema +'.' + @PName ;
print @FQN;
insert into @table exec sp_helptext @FQN;
--insert into @table exec sp_helptext 'dbo.UTIL_MonitorWorkload';
--select @val = coalesce(@val + char(10), '') + val from @table;
select @val = coalesce(@val, '') + val from @table;
select @val;
--print @val
--************************************************************************