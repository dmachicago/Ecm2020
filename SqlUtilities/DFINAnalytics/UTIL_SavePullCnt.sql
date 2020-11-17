
/*

--drop TABLE [dbo].[DFS_PullCounts]
select * from DFS_PullCounts where PulledCount > 0 order by PulledBy, Svr, DB, PullDate, RowNbr desc
--alter TABLE [dbo].[DFS_PullCounts] add RowNbr int identity (1,1) not null

*/

if not exists (select name from sys.tables where name = 'DFS_PullCounts')
	begin
		CREATE TABLE [dbo].[DFS_PullCounts](
			[svr] [nvarchar](150) NULL,
			[DB] [nvarchar](150) NULL,
			PulledBy [nvarchar](150) NULL,
			PullDate datetime default getdate(),
			PulledCount bigint null, 
			RowNbr int identity (1,1) not null
		) ON [PRIMARY]

	end
go
if exists (select 1 from sys.procedures where name = 'UTIL_SavePullCnt')
begin 
	drop procedure UTIL_SavePullCnt;
end

go

/*
exec procedure UTIL_SavePullCnt @svr,@DB,@PulledBy,@PulledCount;
*/

create procedure UTIL_SavePullCnt (@svr nvarchar(150),
			@DB nvarchar(150) ,
			@PulledBy nvarchar(150),			
			@PulledCount bigint null)
as
begin 
	declare @PullDate datetime = getdate();

	insert into [DFS_PullCounts] (
		[svr],
		[DB],
		PulledBy,
		PullDate,
		PulledCount
	)
	values (
		@svr,
		@DB,
		@PulledBy,
		@PullDate,
		@PulledCount
	)
	OPTION (MAXDOP 1);  
end