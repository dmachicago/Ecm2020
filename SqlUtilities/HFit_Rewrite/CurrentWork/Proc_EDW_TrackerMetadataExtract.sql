PRINT 'Processing: Proc_EDW_TrackerMetadataExtract';
GO
IF EXISTS (SELECT
				  *
				  FROM sysobjects
				  WHERE name = 'Proc_EDW_TrackerMetadataExtract'
					AND Xtype = 'P') 
	BEGIN
		DROP PROCEDURE
			 Proc_EDW_TrackerMetadataExtract;
	END;
GO

--exec Proc_EDW_TrackerMetadataExtract 'HFit.TrackerWater'
--select * from #Temp_TrackerMetaData
--select * from Tracker_EDW_Metadata
--truncate table Tracker_EDW_Metadata

CREATE PROCEDURE dbo.Proc_EDW_TrackerMetadataExtract (
	   @TrackerClassName AS nvarchar (250)) 
AS
BEGIN
	IF EXISTS (SELECT
					  name
					  FROM tempdb.dbo.sysobjects
					  WHERE ID = OBJECT_ID (N'tempdb..#Temp_TrackerMetaData')) 
		BEGIN
			DROP TABLE
				 #Temp_TrackerMetaData;
		END;
	DECLARE @MetaDataLastLoadDate datetime;
	DECLARE @ClassLastModified datetime;
	DECLARE @Xml xml;
	DECLARE @docHandle int;
	DECLARE @form nvarchar (250) ;
	DECLARE @dbForm nvarchar (250) ;
	DECLARE @id int;
	DECLARE @parent int;
	DECLARE @nodetype int;
	DECLARE @localname nvarchar (250) ;
	DECLARE @prefix nvarchar (250) ;
	DECLARE @namespaceuri nvarchar (250) ;
	DECLARE @datatype nvarchar (250) ;
	DECLARE @prev nvarchar (250) ;
	DECLARE @dbText nvarchar (250) ;
	DECLARE @ParentName nvarchar (250) ;
	DECLARE @TableName nvarchar (100) ;
	DECLARE @ColName nvarchar (100) ;
	DECLARE @AttrName nvarchar (100) ;
	DECLARE @AttrVal nvarchar (250) ;
	DECLARE @CurrName nvarchar (250) ;
	DECLARE @SkipIfNoChange bit;

		--alter table [Tracker_EDW_Metadata] add ClassLastModified datetime null
	--drop table Tracker_EDW_Metadata; 
	IF NOT EXISTS (SELECT
						  name
						  FROM sysobjects
						  WHERE ID = OBJECT_ID (N'Tracker_EDW_Metadata')) 
		BEGIN
			CREATE TABLE dbo.Tracker_EDW_Metadata (
						 TableName nvarchar (100) NOT NULL
					   , ColName nvarchar (100) NOT NULL
					   , AttrName nvarchar (100) NOT NULL
					   , AttrVal nvarchar (250) NULL
					   , CreatedDate datetime2 (7) NULL
					   , LastModifiedDate datetime2 (7) NULL
					   , ID int IDENTITY (1, 1) 
								NOT NULL
					   , ClassLastModified datetime2 (7) NULL) ;
			ALTER TABLE dbo.Tracker_EDW_Metadata
			ADD
						CONSTRAINT DF_Tracker_EDW_Metadata_CreatedDate DEFAULT GETDATE () FOR CreatedDate;
			ALTER TABLE dbo.Tracker_EDW_Metadata
			ADD
						CONSTRAINT DF_Tracker_EDW_Metadata_LastModifiedDate DEFAULT GETDATE () FOR LastModifiedDate;
			CREATE UNIQUE CLUSTERED INDEX PK_Tracker_EDW_Metadata ON dbo.Tracker_EDW_Metadata (TableName ASC, ColName ASC, AttrName ASC) ;
		END;
	IF NOT EXISTS (SELECT
						  column_name
						  FROM information_schema.columns
						  WHERE column_name = 'ClassLastModified'
							AND table_name = 'Tracker_EDW_Metadata') 
		BEGIN
			PRINT 'MISSING: Tracker_EDW_Metadata ClassLastModified, added to table.';
			ALTER TABLE Tracker_EDW_Metadata
			ADD
						ClassLastModified datetime NULL;
		END;
	ELSE
		BEGIN
			PRINT 'FOUND: Tracker_EDW_Metadata ClassLastModified';
		END;

	SELECT
		   @form = @TrackerClassName;

	--select * from information_schema.columns where column_name = 'ClassLastModified'

	IF EXISTS (SELECT
					  column_name
					  FROM information_schema.columns
					  WHERE column_name = 'ClassLastModified'
						AND table_name = 'Tracker_EDW_Metadata') 
		BEGIN
			SELECT
				   @MetaDataLastLoadDate = (
											SELECT TOP 1
												   ClassLastModified
												   FROM Tracker_EDW_Metadata
												   WHERE TableName = @form) ;
			SELECT
				   @ClassLastModified = (
										 SELECT TOP 1
												ClassLastModified
												FROM CMS_CLASS
												WHERE ClassName = @form) ;
			SET @SkipIfNoChange = 1;
			IF @SkipIfNoChange = 1
				BEGIN
					IF @MetaDataLastLoadDate = @ClassLastModified
						BEGIN
							PRINT 'No Change in ' + @form + ', no updates needed.';
							RETURN;
						END;
					ELSE
						BEGIN
							PRINT 'Changes found in ' + @form + ', processing.';
						END;
				END;
			PRINT '@MetaDataLastLoadDate: ' + CAST (@MetaDataLastLoadDate AS varchar (50)) ;
			PRINT '@ClassLastModified: ' + CAST (@ClassLastModified AS varchar (50)) ;
		END;
	SELECT
		   @Xml = (
				   SELECT
						  ClassFormDefinition
						  FROM CMS_Class
						  WHERE ClassName LIKE @form) ;

	--print (cast( @Xml as varchar(max)));

	EXEC sp_xml_preparedocument @docHandle OUTPUT, @Xml;


	IF NOT EXISTS (SELECT
						  name
						  FROM tempdb.dbo.sysobjects
						  WHERE ID = OBJECT_ID (N'tempdb..#Temp_TrackerMetaData')) 
		BEGIN
			SELECT
				   @form AS form
				 , id
				 , parentid
				 , nodetype
				 , localname
				 , prefix
				 , namespaceuri
				 , datatype
				 , prev
				 , text INTO
							 #Temp_TrackerMetaData
				   FROM OPENXML (@docHandle, N'/form/field') AS XMLDATA;

			--WHERE localname not in ('isPK');		

			CREATE INDEX TMPPI_HealthAssesmentUserQuestion ON #Temp_TrackerMetaData (parentid) ;
			CREATE INDEX TMPPI2_HealthAssesmentUserQuestion ON #Temp_TrackerMetaData (id) ;
		END;
	ELSE
		BEGIN
			truncate TABLE #Temp_TrackerMetaData;
			INSERT INTO #Temp_TrackerMetaData
			SELECT
				   @form AS form
				 , id
				 , parentid
				 , nodetype
				 , localname
				 , prefix
				 , namespaceuri
				 , datatype
				 , prev
				 , text
				   FROM OPENXML (@docHandle, N'/form/field') AS XMLDATA;
		END;
	DELETE FROM Tracker_EDW_Metadata
	WHERE
		  TableName = @form;
	SET @ClassLastModified = (SELECT
									 ClassLastModified
									 FROM CMS_CLASS
									 WHERE ClassName = @Form) ;
	PRINT '@ClassLastModified: ' + CAST (@ClassLastModified AS varchar (250)) ;
	DECLARE C CURSOR
		FOR SELECT
				   @form AS form
				 , id
				 , parentid
				 , nodetype
				 , localname
				 , prefix
				 , namespaceuri
				 , datatype
				 , prev
				 , text
				   FROM #Temp_TrackerMetaData AS XMLDATA;
	OPEN C;
	FETCH NEXT FROM C INTO @dbForm, @id, @parent, @nodetype, @localname, @prefix, @namespaceuri, @datatype, @prev, @dbText;
	WHILE @@FETCH_STATUS = 0
		BEGIN

			--print ('* @localname :' + @localname) ;
			--print ('* @ColName :' + isnull(@ColName, 'XX') + ':') ;
			--print ('* @dbText :' + @dbText + ':') ;

			IF @localname = 'column'
				BEGIN

					--print ('** START COLUMN DEF: ') ;

					SET @ColName = (SELECT
										   text
										   FROM #Temp_TrackerMetaData
										   WHERE parentid = @id) ;

				--print ('** COLUMN DEF: ' + @form + ' : ' + @colname) ;

				END;
			IF @dbText IS NOT NULL
				BEGIN

					--print ('* ENTER @dbText :' + @dbText + ':' + cast(@parent as varchar(10))) ;

					SET @AttrName = (SELECT
											localname
											FROM #Temp_TrackerMetaData
											WHERE id = @parent) ;

					--set @ParentName = (select [localname] FROM OPENXML(@docHandle, N'/form/field') where id = @parent);	
					--print ('1 - @AttrName: ' + @form +' : ' + isnull(@ColName, 'NA') + ' : ' + @AttrName + ' : ' + @dbText) ;	

					IF EXISTS (SELECT
									  TableName
									  FROM Tracker_EDW_Metadata
									  WHERE Tablename = @form
										AND ColName = @ColName
										AND AttrName = @dbText) 
						BEGIN

							--print('Update Tracker_EDW_Metadata set AttrVal = ' + @dbText + ' Where Tablename = ' + @form + ' and ColName = ' + @ColName + ' and AttrName = ' + @AttrName + ';');

							UPDATE Tracker_EDW_Metadata
							SET
								AttrVal = @dbText
							  ,
								ClassLastModified = @ClassLastModified
							WHERE
								  Tablename = @form
							  AND ColName = @ColName
							  AND AttrName = @dbText;
						END;
					ELSE
						BEGIN

							--print ('insert into Tracker_EDW_Metadata (TableName, ColName, AttrName, AttrVal, ClassLastModified) values ('+@form+', '+@ColName+', '+@AttrName+', '+@dbText +', ' + cast(@ClassLastModified as varchar(50))+ ') ') ;

							INSERT INTO Tracker_EDW_Metadata (
										TableName
									  , ColName
									  , AttrName
									  , AttrVal
									  , ClassLastModified) 
							VALUES
								 (@form, @ColName, @AttrName, @dbText, @ClassLastModified) ;
							UPDATE Tracker_EDW_Metadata
							SET
								ClassLastModified = @ClassLastModified
							WHERE
								  Tablename = @form
							  AND ColName = @ColName
							  AND AttrName = @dbText;
						END;
				END;
			IF @localname = 'columntype'
		   AND @ColName IS NOT NULL
				BEGIN
					PRINT '---- COLUMN TYPE DEF: ' + @form + ' : ' + @colname + ' : ' + @dbText;
				END;
			IF @localname = 'field'
				BEGIN
					SET @ParentName = NULL;
					SET @ColName = NULL;

				--print ('***** field @ParentName: ' + @ParentName) ;

				END;
			FETCH NEXT FROM C INTO @dbForm, @id, @parent, @nodetype, @localname, @prefix, @namespaceuri, @datatype, @prev, @dbText;
		END;
	CLOSE C;
	DEALLOCATE C;
END;

--Clean up the EDW Tracker MetaData
--delete from Tracker_EDW_Metadata where colname in ('ItemID','ItemCreatedBy','ItemCreatedWhen','ItemModifiedBy','ItemModifiedWhen','EventDate','IsProfessionally Collected','TrackerCollectionSourceId','UserID','Notes','IsProcessedForHA');

GO
PRINT 'ProcessED and created : Proc_EDW_TrackerMetadataExtract';
GO
PRINT '***** FROM: Proc_EDW_TrackerMetadataExtract.sql';
GO 
