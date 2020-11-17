
--USE [KenticoCMS_DEV]
--GO

--select * from #Temp_TrackerMetaData
--select * from Tracker_EDW_Metadata
--truncate table Tracker_EDW_Metadata
create procedure Proc_EDW_TrackerMetadataExtract (@TrackerClassName as nvarchar(250))
as
IF EXISTS
	(
		SELECT name
		FROM tempdb.dbo.sysobjects
		WHERE ID = OBJECT_ID(N'tempdb..#Temp_TrackerMetaData')
	)
	BEGIN
		DROP TABLE #Temp_TrackerMetaData
	END

DECLARE @Xml XML
DECLARE @docHandle int;
DECLARE @form nvarchar(250);

declare @dbForm nvarchar(250) ;
declare @id int ;
declare @parent int;
declare @nodetype int;
declare @localname nvarchar(250);
declare @prefix nvarchar(250);
declare @namespaceuri nvarchar(250);
declare @datatype nvarchar(250);
declare @prev nvarchar(250);
declare @dbText nvarchar(250);

declare @ParentName nvarchar(250);

--declare @xdbForm nvarchar(250) ;
--declare @xid int ;
--declare @xparent int;
--declare @xnodetype int;
--declare @xlocalname nvarchar(250);
--declare @xprefix nvarchar(250);
--declare @xnamespaceuri nvarchar(250);
--declare @xdatatype nvarchar(250);
--declare @xprev nvarchar(250);
--declare @xdbText nvarchar(250);

declare @TableName nvarchar(100);
declare @ColName nvarchar(100);
declare @AttrName nvarchar(100);
declare @AttrVal nvarchar(250);

declare @CurrName nvarchar(250);

--select @form = 'HFit.TrackerWater' ;
select @form = @TrackerClassName ;

SELECT @Xml = (select ClassFormDefinition from CMS_Class where ClassName like @form);
--print (cast( @Xml as varchar(max)));

EXEC sp_xml_preparedocument @docHandle OUTPUT, @Xml;

IF NOT EXISTS (SELECT name
		FROM sysobjects
		WHERE ID = OBJECT_ID(N'Tracker_EDW_Metadata'))
	begin
		CREATE TABLE [dbo].[Tracker_EDW_Metadata](
			[TableName] [nvarchar](100) NOT NULL,
			[ColName] [nvarchar](100) NOT NULL,
			[AttrName] [nvarchar](100) NOT NULL,
			[AttrVal] [nvarchar](250) NULL
		) 
		CREATE UNIQUE CLUSTERED INDEX [PK_Tracker_EDW_Metadata] ON [dbo].[Tracker_EDW_Metadata]
		(
			[TableName] ASC,
			[ColName] ASC,
			[AttrName] ASC
		)
	end

IF NOT EXISTS (SELECT name
		FROM tempdb.dbo.sysobjects
		WHERE ID = OBJECT_ID(N'tempdb..#Temp_TrackerMetaData'))
	begin
	SELECT @form as form,id,parentid,nodetype,localname,prefix,namespaceuri,datatype,prev,[text] 	
	INTO #Temp_TrackerMetaData 
	FROM OPENXML(@docHandle, N'/form/field') as XMLDATA;
	--WHERE localname not in ('isPK');		
	CREATE INDEX TMPPI_HealthAssesmentUserQuestion 
		ON #Temp_TrackerMetaData (parentid);
	CREATE INDEX TMPPI2_HealthAssesmentUserQuestion 
		ON #Temp_TrackerMetaData (id);
	end
	else
	begin
		truncate table #Temp_TrackerMetaData;
		INSERT INTO #Temp_TrackerMetaData
		SELECT @form as form,id,parentid,nodetype,localname,prefix,namespaceuri,datatype,prev,[text]
			FROM OPENXML(@docHandle, N'/form/field') as XMLDATA;	
	end

delete from Tracker_EDW_Metadata where TableName = @form ;

declare C cursor FOR 
SELECT @form as form,id,parentid,nodetype,localname,prefix,namespaceuri,datatype,prev,[text] 	
	FROM #Temp_TrackerMetaData as XMLDATA

OPEN C
FETCH NEXT from C 
INTO @dbForm, @id, @parent, @nodetype, @localname, @prefix, @namespaceuri, @datatype, @prev, @dbText ;

WHILE @@FETCH_STATUS = 0   
BEGIN   
	--print ('* @localname :' + @localname) ;
	--print ('* @ColName :' + isnull(@ColName, 'XX') + ':') ;
	--print ('* @dbText :' + @dbText + ':') ;
	
	if @localname = 'column'
	BEGIN
		--print ('** START COLUMN DEF: ') ;
		set @ColName = (select [text] from #Temp_TrackerMetaData where parentid = @id);
		--print ('** COLUMN DEF: ' + @form + ' : ' + @colname) ;
	END

    if @dbText is not null 
	BEGIN	   
	
			--print ('* ENTER @dbText :' + @dbText + ':' + cast(@parent as varchar(10))) ;
			set @AttrName = (select [localname] FROM #Temp_TrackerMetaData where id = @parent) ;
			--set @ParentName = (select [localname] FROM OPENXML(@docHandle, N'/form/field') where id = @parent);	
			--print ('1 - @AttrName: ' + @form +' : ' + isnull(@ColName, 'NA') + ' : ' + @AttrName + ' : ' + @dbText) ;	
			if exists(Select TableName from Tracker_EDW_Metadata Where Tablename = @form and ColName = @ColName and AttrName = @dbText)
			BEGIN				
				--print('Update Tracker_EDW_Metadata set AttrVal = ' + @dbText + ' Where Tablename = ' + @form + ' and ColName = ' + @ColName + ' and AttrName = ' + @AttrName + ';');
				Update Tracker_EDW_Metadata set AttrVal = @dbText Where Tablename = @form and ColName = @ColName and AttrName = @dbText;				
			END
			ELSE
			BEGIN
				--print ('insert into Tracker_EDW_Metadata (TableName, ColName, AttrName, AttrVal) values ('+@form+', '+@ColName+', '+@AttrName+', '+@dbText +') ') ;
				insert into Tracker_EDW_Metadata (TableName, ColName, AttrName, AttrVal) values (@form, @ColName, @AttrName, @dbText) ;				
			END		
	END
	
	   if @localname = 'columntype' and @ColName is not null
	   BEGIN
			print ('---- COLUMN TYPE DEF: ' + @form + ' : ' + @colname + ' : ' + @dbText) ;
	   END
	   if @localname = 'field'
	   BEGIN
			set @ParentName = null ;
			set @ColName = null ;
			--print ('***** field @ParentName: ' + @ParentName) ;
	   END
       FETCH NEXT FROM C INTO @dbForm, @id, @parent, @nodetype, @localname, @prefix, @namespaceuri, @datatype, @prev, @dbText ;   
END   

CLOSE C   
DEALLOCATE C 

--Clean up the EDW Tracker MetaData
--delete from Tracker_EDW_Metadata where colname in ('ItemID','ItemCreatedBy','ItemCreatedWhen','ItemModifiedBy','ItemModifiedWhen','EventDate','IsProfessionally Collected','TrackerCollectionSourceId','UserID','Notes','IsProcessedForHA');  --  
  --  
GO 
print('***** FROM: XmlParse.sql'); 
GO 
