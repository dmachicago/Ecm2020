
--drop table [TBL_DIFF1] ;
--drop table [TBL_DIFF2] ;
--drop table [TBL_DIFF3] ;
--drop table [TBL_DIFF4] ;

GO
print('Processing Proc_EDW_Compare_Tables');
GO

if exists (Select name from sys.procedures where name = 'Proc_EDW_Compare_Tables')
BEGIN
	print('Updating Proc_EDW_Compare_Tables');
	drop procedure Proc_EDW_Compare_Tables ;
END
GO

Create procedure Proc_EDW_Compare_Tables 
(	@LinkedSVR as nvarchar(254) 
	,@LinkedDB as nvarchar(80), @LinkedTBL as nvarchar(80)
	,@CurrDB as nvarchar(80), @CurrTBL as nvarchar(80)
	,@NewRun as int
)
as
BEGIN
	print('Comparing: ' + @LinkedSVR + ' : ' + @LinkedDB + ' : ' + @LinkedTBL ); 
	print('TO: ' + @CurrDB + ' : ' + @CurrTBL ); 
	--set @LinkedSVR = 'hfit-sqlUAT.cloudapp.net,3' ;
	--set @LinkedDB = 'KenticoCMS_ProdStaging' ;
	--set @LinkedTBL = 'SchemaChangeMonitor' ;
	--set @CurrDB = 'KenticoCMS_DEV' ;
	--set @CurrTBL = 'SchemaChangeMonitor'

	--exec Proc_EDW_Compare_Tables 'hfit-sqlUAT.cloudapp.net,3', 'KenticoCMS_ProdStaging', 'HFit_HealthAssessment', 'KenticoCMS_DEV', 'HFit_HealthAssessment', 0
	--exec Proc_EDW_Compare_Tables 'hfit-sqlUAT.cloudapp.net,3', 'KenticoCMS_ProdStaging', 'SchemaChangeMonitor', 'KenticoCMS_DEV', 'HFit_HealthAssessment', 1
	--exec Proc_EDW_Compare_Tables 'hfit-sqlUAT.cloudapp.net,3', 'KenticoCMS_ProdStaging', 'SchemaChangeMonitor', 'KenticoCMS_DEV', 'SchemaChangeMonitor', 1
	--exec Proc_EDW_Compare_Tables 'hfit-sqlUAT.cloudapp.net,3', 'KenticoCMS_DEV', 'SchemaChangeMonitor', 'instrument', 'HFit_HealthAssessment', 1

	DECLARE @ParmDefinition  as nvarchar(500) ;
	DECLARE @retval int   = 0 ; 
	DECLARE @S  as nvarchar(250) = '' ;
	DECLARE @SVR as varchar(200) = @LinkedSVR ;
	DECLARE @iCnt as int ;
	DECLARE @iRetval as int = 0 ; 
	DECLARE @Note as nvarchar(1000) = '' ;
	
	set @S  = 'SELECT @retval = count(*) FROM sys.servers WHERE name = @TgtSVR ' ;
	set @ParmDefinition  = N'@TgtSVR nvarchar(100), @retval bit OUTPUT' ;
	exec sp_executesql @S, @ParmDefinition, @TgtSVR = @LinkedSVR, @retval = @iRetval OUTPUT ;
	set @iCnt = (select @iRetval) ;
	IF (@iCnt = 1)
		EXEC master.sys.sp_dropserver @LinkedSVR,'droplogins'  ;
			
	EXEC sp_addlinkedserver @LinkedSVR, 'SQL Server' ;
	
	set @S  = 'select @retval = count(*) from ['+@LinkedSVR+'].['+@LinkedDB+'].sys.tables where NAME = @TgtTBL ' ;
	set @ParmDefinition  = N'@TgtTBL nvarchar(100), @retval int OUTPUT' ;
	exec sp_executesql @S, @ParmDefinition, @TgtTBL = @LinkedTBL, @retval = @iRetval OUTPUT ;
	set @iCnt = (select @iRetval) ;
	
	--print ('Step01');
	if (@iCnt = 0)
	BEGIN
		print(@LinkedTBL + ' : Table does not exist on server ' +@LinkedSVR + ' in database ' + @LinkedDB + '.') ;
		declare @SSQL as nvarchar(2000) = '' ;
		declare @msg as nvarchar(500) = '' ;
		set @msg = @LinkedTBL + ' : Table does not exist on server ' +@LinkedSVR + ' in database ' + @LinkedDB + '.' ;
		Set @SSQL = 'INSERT INTO TBL_DIFF1 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ' ; 
		Set @SSQL = @SSQL + 'VALUES ( ';
		Set @SSQL = @SSQL + ''''+@CurrTBL+''', null, null , null, null ,null,null, null, '''+@msg+''' ' ;
		Set @SSQL = @SSQL + ')';
		
		exec (@SSQL) ;

		return ;
	END
		
	--set @S  = 'SELECT @retval = count(*) FROM sys.servers WHERE name = @TgtSVR ' ;
	--set @ParmDefinition  = N'@TgtSVR nvarchar(100), @retval bit OUTPUT' ;
	--exec sp_executesql @S, @ParmDefinition, @TgtSVR = @LinkedSVR, @retval = @iRetval OUTPUT ;
	--set @iCnt = (select @iRetval) ;
	--IF (@iCnt = 1)
	--	EXEC master.sys.sp_dropserver @LinkedSVR,'droplogins'  ;
	--print ('Step02');
	IF NOT EXISTS
	(
		SELECT name
		--FROM tempdb.dbo.sysobjects
		FROM sysobjects
		WHERE ID = OBJECT_ID(N'TBL_DIFF1')
	)
	BEGIN
		CREATE TABLE [dbo].[TBL_DIFF1](
		[table_name] [sysname] NOT NULL,
		[COLUMN_NAME] [sysname] NULL,
		[DATA_TYPE] [nvarchar](128) NULL,
		[CHARACTER_MAXIMUM_LENGTH] [nvarchar](50) NULL,
		[table_name2] [sysname] NULL,
		[DATA_TYPE2] [nvarchar](128) NULL,
		[COLUMN_NAME2] [sysname] NULL,
		[CHARACTER_MAXIMUM_LENGTH2] [int] NULL,
		[NOTE] [varchar](500) NULL,
		[CreateDate] [datetime] NULL default getdate(),
		RowNbr int identity
	)

	END

	IF NOT EXISTS
	(
		SELECT name
		--FROM tempdb.dbo.sysobjects
		FROM sysobjects
		WHERE ID = OBJECT_ID(N'TBL_DIFF2')
	)
	BEGIN

		CREATE TABLE [dbo].[TBL_DIFF2](
		[table_name] [sysname] NOT NULL,
		[COLUMN_NAME] [sysname] NULL,
		[DATA_TYPE] [nvarchar](128) NULL,
		[CHARACTER_MAXIMUM_LENGTH] [nvarchar](50) NULL,
		[table_name2] [sysname] NULL,
		[DATA_TYPE2] [nvarchar](128) NULL,
		[COLUMN_NAME2] [sysname] NULL,
		[CHARACTER_MAXIMUM_LENGTH2] [int] NULL,
		[NOTE] [varchar](500) NULL,
		[CreateDate] [datetime] NULL default getdate(),
		RowNbr int identity
	)

	END
	
		IF NOT EXISTS
	(
		SELECT name
		--FROM tempdb.dbo.sysobjects
		FROM sysobjects
		WHERE ID = OBJECT_ID(N'TBL_DIFF3')
	)
	BEGIN

		CREATE TABLE [dbo].[TBL_DIFF3](
		[table_name] [sysname] NOT NULL,
		[COLUMN_NAME] [sysname] NULL,
		[DATA_TYPE] [nvarchar](128) NULL,
		[CHARACTER_MAXIMUM_LENGTH] [nvarchar](50) NULL,
		[table_name2] [sysname] NULL,
		[DATA_TYPE2] [nvarchar](128) NULL,
		[COLUMN_NAME2] [sysname] NULL,
		[CHARACTER_MAXIMUM_LENGTH2] [int] NULL
		,[NOTE] varchar(500)
		,CreateDate datetime default getdate() ,
		RowNbr int identity
	)

	END

	IF NOT EXISTS
	(
		SELECT name
		--FROM tempdb.dbo.sysobjects
		FROM sysobjects
		WHERE ID = OBJECT_ID(N'TBL_DIFF4')
	)
	BEGIN

		CREATE TABLE [dbo].[TBL_DIFF4](
		[table_name] [sysname] NOT NULL,
		[COLUMN_NAME] [sysname] NULL,
		[DATA_TYPE] [nvarchar](128) NULL,
		[CHARACTER_MAXIMUM_LENGTH] [nvarchar](50) NULL,
		[table_name2] [sysname] NULL,
		[DATA_TYPE2] [nvarchar](128) NULL,
		[COLUMN_NAME2] [sysname] NULL,
		[CHARACTER_MAXIMUM_LENGTH2] [int] NULL
		,[NOTE] varchar(500)
		,CreateDate datetime default getdate() ,
		RowNbr int identity
	)

	END

	if (@NewRun = 1)
	BEGIN
		truncate table [TBL_DIFF1] ;
		truncate table [TBL_DIFF2] ;
		truncate table [TBL_DIFF3] ;
	END

	--DECLARE @LinkedDB as nvarchar(80), @LinkedTBL as nvarchar(80),@CurrDB as nvarchar(80), @CurrTBL as nvarchar(80) ;
	DECLARE @MySQL as nvarchar(2000) ;

	--set @LinkedDB = 'instrument' ;
	--set @LinkedTBL = 'SchemaChangeMonitor' ;
	--set @CurrDB = 'KenticoCMS_DEV' ;
	--set @CurrTBL = 'SchemaChangeMonitor'

	--select c1.table_name,c1.COLUMN_NAME,c1.DATA_TYPE , cast (c1.CHARACTER_MAXIMUM_LENGTH as nvarchar(50)) as CHARACTER_MAXIMUM_LENGTH, c2.table_name,c2.DATA_TYPE,c2.COLUMN_NAME, c2.CHARACTER_MAXIMUM_LENGTH
	--from KenticoCMS_DEV.[INFORMATION_SCHEMA].[COLUMNS] c1
	--left join instrument.[INFORMATION_SCHEMA].[COLUMNS] c2 on c1.TABLE_NAME=c2.TABLE_NAME
	--where c1.TABLE_NAME= @LinkedTBL and c2.TABLE_NAME = @CurrTBL
	--and C1.column_name = c2.column_name
	--and ((c1.data_type <> c2.DATA_TYPE) 
	--		OR (c1.data_type = c2.DATA_TYPE AND c1.CHARACTER_MAXIMUM_LENGTH <> c2.CHARACTER_MAXIMUM_LENGTH))
	
	--print ('Step04');

	Set @MySQL = 'INSERT INTO TBL_DIFF1 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ' ; 
	Set @MySQL = @MySql + 'select c1.table_name, c1.COLUMN_NAME, c1.DATA_TYPE , cast (c1.CHARACTER_MAXIMUM_LENGTH as nvarchar(50)) as CHARACTER_MAXIMUM_LENGTH, c2.table_name as table_name2 ,c2.DATA_TYPE as DATA_TYPE2 ,c2.COLUMN_NAME as COLUMN_NAME2, c2.CHARACTER_MAXIMUM_LENGTH as CHARACTER_MAXIMUM_LENGTH2, ''Data Types or Data Length Differ'' ' ;
	Set @MySQL = @MySQL + 'from ['+@LinkedSVR+'].['+@LinkedDB+'].[INFORMATION_SCHEMA].[COLUMNS] c1 ' ;
	Set @MySQL = @MySQL + 'left join ' + @CurrDB + '.[INFORMATION_SCHEMA].[COLUMNS] c2 on c1.TABLE_NAME = c2.TABLE_NAME ' ;
	Set @MySQL = @MySQL + 'where c1.TABLE_NAME= ''' + @LinkedTBL + ''' and c2.TABLE_NAME = ''' + @CurrTBL + ''' '  ;
	Set @MySQL = @MySQL + 'and C1.column_name = c2.column_name '; 
	Set @MySQL = @MySQL + 'and ((c1.data_type <> c2.DATA_TYPE) ' ;
	Set @MySQL = @MySQL + '		OR (c1.data_type = c2.DATA_TYPE AND c1.CHARACTER_MAXIMUM_LENGTH <> c2.CHARACTER_MAXIMUM_LENGTH))';
	
	exec (@MySql) ;
	
	--print ('Step05');

	set @MySQL = '' ;

	Set @MySQL = 'INSERT INTO TBL_DIFF2 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ' ;
	set @MySQL = @MySQL + 'SELECT c1.TABLE_NAME, c1.COLUMN_NAME, c1.DATA_TYPE, '''+@CurrDB+''' as DBNAME, ''MISSING'' as C1, ''NA'' as C2 , ''NA'' as C3, 0 as I1, ''Column ''+c1.COLUMN_NAME+'' Missing in: '+@CurrDB+ ' / ' + @CurrTBL + ' ''  ';
	set @MySQL = @MySQL + ' FROM  ['+@LinkedSVR+'].[' + @LinkedDB +'].INFORMATION_SCHEMA.COLUMNS AS c1 ' ; 
	set @MySQL = @MySQL + ' WHERE  C1.table_name = '''+@CurrTBL+''' ' ; 
	set @MySQL = @MySQL + ' 	AND c1.column_name not in ' ;
	set @MySQL = @MySQL + ' 	(select column_name from '+@CurrDB+'.INFORMATION_SCHEMA.columns C2 where C2.table_name = '''+@LinkedTBL+''') ' ; 
	
	exec (@MySql) ;

	--print ('Step06');

	Set @MySQL = 'INSERT INTO TBL_DIFF3 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ' ; 
	set @MySQL = @MySQL + 'SELECT c1.TABLE_NAME, c1.COLUMN_NAME, c1.DATA_TYPE, '''+@LinkedDB+''' as DBNAME, ''MISSING'' as C1, ''NA'' as C2, ''NA'' as C3, -1 as I1, ''Column ''+c1.COLUMN_NAME+'' Missing in: '+@LinkedDB+ ' / ' + @LinkedTBL + ' ''  ';
	set @MySQL = @MySQL + ' FROM ['+@CurrDB+'].INFORMATION_SCHEMA.COLUMNS as C1 ' ;
	set @MySQL = @MySQL + ' WHERE  C1.table_name = ''' + @CurrTBL + ''' '  ;
	set @MySQL = @MySQL + ' AND c1.column_name not in ' ; 
	set @MySQL = @MySQL + ' (select column_name from ['+@LinkedSVR+'].['+@LinkedDB+'].INFORMATION_SCHEMA.columns C2 where C2.table_name = '''+@LinkedTBL+''') ' ;
	exec (@MySql) ;

	--print ('Step07');

	set @S  = 'SELECT @retval = count(*) FROM sys.servers WHERE name = @TgtSVR ' ;
	set @ParmDefinition  = N'@TgtSVR nvarchar(100), @retval bit OUTPUT' ;
	exec sp_executesql @S, @ParmDefinition, @TgtSVR = @LinkedSVR, @retval = @iRetval OUTPUT ;
	set @iCnt = (select @iRetval) ;
	IF (@iCnt = 1)
		EXEC master.sys.sp_dropserver @LinkedSVR,'droplogins'  ;

	--print ('Step08');
	
	if not exists(Select name from sys.views where name = 'view_SchemaDiff')
	BEGIN
		declare @sTxt as nvarchar(2000) = '' ;
		set @sTxt = @sTxt + 'Create view view_SchemaDiff AS ' ;
		set @sTxt = @sTxt + 'Select * from TBL_DIFF1 ' ;
		set @sTxt = @sTxt + 'union ' ;
		set @sTxt = @sTxt + 'Select * from TBL_DIFF2  ' ;
		set @sTxt = @sTxt + 'union ' ;
		set @sTxt = @sTxt + 'Select * from TBL_DIFF3  ' ;
		exec (@sTxt) ;
		print ('Created view view_SchemaDiff.') ;
	END

	--Select * from TBL_DIFF1 
	--union
	--Select * from TBL_DIFF2 
	--union
	--Select * from TBL_DIFF3 

	print ('To see "deltas" - select * from view_SchemaDiff');
	print ('_________________________________________________');
END

GO

print('Created Proc_EDW_Compare_Tables');

GO

	