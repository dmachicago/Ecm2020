
--exec sp_FindDependencies 'Schema.TableName' ;
--EXEC sp_FindDependencies 'HumanResources.Department';

select 'EXEC sp_FindDependencies ''' + TABLE_SCHEMA+'.'+TABLE_NAME + ''';' + char(10) +  'GO' + char(10) as stmt from INFORMATION_SCHEMA.TABLES

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_finddependencies'
)
    DROP PROCEDURE sp_finddependencies;
GO
CREATE PROCEDURE sp_finddependencies @Objname NVARCHAR(776)
AS
    BEGIN
 SET NOCOUNT ON;
 DECLARE @Objid INT;

 -- the id of the object we wantype

 DECLARE @Found_Some BIT;

 -- flag for dependencies found

 DECLARE @Dbname SYSNAME;

 --  Make sure the @objname is local to the current database.

 SELECT @Dbname = PARSENAME(@Objname, 3);
 IF @Dbname IS NOT NULL
    AND @Dbname <> DB_NAME()
     BEGIN
  RAISERROR(15250, -1, -1);
  RETURN 1;
 END;

 --  See if @objname exists.

 SELECT @Objid = OBJECT_ID(@Objname);
 IF @Objid IS NULL
     BEGIN
  SELECT @Dbname = DB_NAME();
  RAISERROR(15009, -1, -1, @Objname, @Dbname);
  RETURN 1;
 END;

 --  Initialize @found_some to indicate that we haven't seen any dependencies.

 SELECT @Found_Some = 0;

 --  Print out the particulars about the local dependencies.

/**********************************
Create the TEMP View Columns table 
**********************************/

 IF EXISTS
 (
     SELECT name
     FROM tempdb.dbo.sysobjects
     WHERE id = OBJECT_ID(N'tempdb..#CalledObjects')
 )
     BEGIN
  PRINT 'Dropping #ViewCols';
  DROP TABLE #viewcols;
 END;
 CREATE TABLE #calledobjects
 (parent_obj NVARCHAR(101), 
  obj_name   NVARCHAR(101), 
  obj_type   NVARCHAR(101), 
  updated    NVARCHAR(101), 
  selected   NVARCHAR(101), 
  col_name   NVARCHAR(101)
 );
 IF EXISTS
 (
     SELECT *
     FROM sysdepends
     WHERE id = @Objid
 )
     BEGIN
  RAISERROR(15459, -1, -1);
  INSERT INTO #calledobjects
    SELECT @Objname, 
    'CalledObj' = s6.name + '.' + o1.name, 
    type = SUBSTRING(v2.name, 5, 66), 
    updated = SUBSTRING(u4.name, 1, 7), 
    selected = SUBSTRING(w5.name, 1, 8), 
    'column' = COL_NAME(d3.depid, d3.depnumber)
    FROM sys.objects AS o1, 
  dbo.spt_values AS v2, 
  sysdepends AS d3, 
  dbo.spt_values AS u4, 
  dbo.spt_values AS w5
  ,

  --11667 
  sys.schemas AS s6
    WHERE o1.object_id = d3.depid
   AND o1.type = SUBSTRING(v2.name, 1, 2) COLLATE catalog_default
   AND v2.type = 'O9T'
   AND u4.type = 'B'
   AND u4.number = d3.resultobj
   AND w5.type = 'B'
   AND w5.number = d3.readobj|d3.selall
   AND d3.id = @Objid
   AND o1.schema_id = s6.schema_id
   AND deptype < 2;
  SELECT @Found_Some = 1;
  SELECT *
  FROM #calledobjects;
 END;

 --  Build the TEMP Depends Obj Table

 IF EXISTS
 (
     SELECT name
     FROM tempdb.dbo.sysobjects
     WHERE id = OBJECT_ID(N'tempdb..#RefObjects')
 )
     BEGIN
  PRINT 'Dropping #RefObjects';
  DROP TABLE #viewcols;
 END;
 CREATE TABLE #refobjects
 (CalledObj  NVARCHAR(101), 
  CallingObj NVARCHAR(101), 
  type  NVARCHAR(101)
 );

 --  Now check for things that depend on the object.

 IF EXISTS
 (
     SELECT *
     FROM sysdepends
     WHERE depid = @Objid
 )
     BEGIN
  RAISERROR(15460, -1, -1);
  INSERT INTO #refobjects
    SELECT DISTINCT 
    @Objname, 
    'ReferencedObj' = s.name + '.' + o.name, 
    type = SUBSTRING(v.name, 5, 66)
    FROM sys.objects AS o, 
  dbo.spt_values AS v, 
  sysdepends AS d, 
  sys.schemas AS s
    WHERE o.object_id = d.id
   AND o.type = SUBSTRING(v.name, 1, 2) COLLATE catalog_default
   AND v.type = 'O9T'
   AND d.depid = @Objid
   AND o.schema_id = s.schema_id
   AND deptype < 2;
  SELECT @Found_Some = 1;
  SELECT *
  FROM #refobjects;
 END;

 --  Did we find anything in sysdepends?

 IF @Found_Some = 0
     BEGIN
  RAISERROR(15461, -1, -1);
 END;
 SET NOCOUNT OFF;
 RETURN 0;
    END;
 -- W. Dale Miller
 -- DMA, Limited
 -- Offered under GNU License
 -- July 26, 2016
 -- W. Dale Miller
 -- DMA, Limited
 -- Offered under GNU License
 -- July 26, 2016
