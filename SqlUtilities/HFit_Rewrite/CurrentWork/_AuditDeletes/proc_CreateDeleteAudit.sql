--	select Table_NAme, Column_NAme, Data_Type, CHARACTER_MAXIMUM_LENGTH, NUMERIC_PRECISION, NUMERIC_SCALE FROM Information_Schema.Columns where CHARACTER_MAXIMUM_LENGTH < 0 Order by Data_Type
--where Table_Name = 'HFit_CoachingTermsAndConditionsSettings' ;

--	select * FROM Information_Schema.Columns where Table_Name = 'EDW_TEST_DEL' ;
--	select Column_Name, Data_Type, CHARACTER_MAXIMUM_LENGTH, NUMERIC_PRECISION, NUMERIC_SCALE FROM Information_Schema.Columns where Table_Name = 'EDW_TEST_DEL' ;
--	select Column_Name, Data_Type, CHARACTER_MAXIMUM_LENGTH, NUMERIC_PRECISION, NUMERIC_SCALE FROM Information_Schema.Columns where Table_Name = 'HFit_CoachingTermsAndConditionsSettings' ;

IF EXISTS (SELECT name
			 FROM sys.objects
			 WHERE name = 'Proc_Attach_Delete_Audit') 
	BEGIN
		DROP PROCEDURE Proc_Attach_Delete_Audit;
	END;
GO

CREATE PROCEDURE Proc_Attach_Delete_Audit (
	   @Tbl AS nvarchar (500)) 
AS
	 BEGIN

/**************************************************************
This procedure will copy a table and recreate it using only the
raw column data types to recreate the MIRROR table. No defaults, 
identities, or constraints are copied over. All columns are 
defined as NULLABLE. This new table has the parent table's name
with a suffix of "_DelAudit".

A column "RowDeletionDate" is added to the new table and is 
defaulted to getdate(). An index is applied to this column so
that max perfomance can be acheived when pulling a particular
datetime.

A trigger is added to the parent table using the parent name 
plus a suffix of "_DelTRIG". This trigger only fires when a 
delete operation is completed. It then copies the deleted rows
into the "_DelAudit" table.
**************************************************************/

/***************************
Declare the needed variables
***************************/

		 --DECLARE @Tbl AS nvarchar (500) = 'EDW_TEST_DEL';
		 DECLARE @Trktbl AS nvarchar (500) = '';
		 DECLARE @Deltriggername AS nvarchar (500) = '';
		 DECLARE @Mysql AS nvarchar (2000) = '';
		 DECLARE @CreateDDL AS nvarchar (max) = '';
		 DECLARE @SelectCOLS AS nvarchar (max) = '';

		 DECLARE @Colname AS nvarchar (254) = '';
		 DECLARE @Dtype AS nvarchar (254) = '';
		 DECLARE @CHARACTER_MAXIMUM_LENGTH AS INT;
		 DECLARE @NUMERIC_PRECISION AS INT;
		 DECLARE @NUMERIC_SCALE AS INT;

/*****************
Set initial values
*****************/

		 SET @Trktbl = @Tbl + '_DelAudit';
		 SET @Deltriggername = @Tbl + '_DelTRIG';

		 IF EXISTS (SELECT Name
					  FROM Sys.Tables
					  WHERE Name = @Trktbl) 
			 BEGIN
				 PRINT 'Dropping table ' + @Trktbl;
				 SET @Mysql = 'DROP TABLE ' + @Trktbl;
				 EXEC Sp_Executesql @Mysql;
				 PRINT 'Dropped table ' + @Trktbl;
			 END;

		 IF OBJECT_ID (@Deltriggername , 'TR') IS NOT NULL
			 BEGIN
				 PRINT 'Dropping TRIGGER ' + @Deltriggername;
				 SET @Mysql = 'DROP TRIGGER ' + @Deltriggername;
				 EXEC Sp_Executesql @Mysql;
			 END;

		 SET @CreateDDL = 'CREATE TABLE ' + @Trktbl + '(';
		 DECLARE Col_Cursor CURSOR
			 FOR SELECT Column_Name, Data_Type, CHARACTER_MAXIMUM_LENGTH, NUMERIC_PRECISION, NUMERIC_SCALE
				   FROM Information_Schema.Columns
				   WHERE Table_Name = @Tbl;
		 OPEN Col_Cursor;
		 FETCH Next FROM Col_Cursor INTO @Colname , @Dtype, @CHARACTER_MAXIMUM_LENGTH, @NUMERIC_PRECISION, @NUMERIC_SCALE ;

		 WHILE @@Fetch_Status = 0
			 BEGIN
				 SET @SelectCOLS = @SelectCOLS + QUOTENAME (@Colname) + ',' ;
				 SET @CreateDDL = @CreateDDL + QUOTENAME (@Colname) + ' ' + QUOTENAME (@Dtype) ;
				 IF (@Dtype = 'float' )
				 BEGIN
					PRINT ('FLOAT DDL: ' + @CreateDDL);		 
				 END
				 ELSE IF (@Dtype = 'int' OR @Dtype = 'bigint' OR @Dtype = 'tinyint' OR @Dtype = 'smallint')
				 BEGIN
					PRINT (@Dtype + ': INT DDL: ' + @CreateDDL);		 
				 END
				 ELSE IF (@Dtype = 'nvarchar' OR  @Dtype = 'varchar')
				 BEGIN
					PRINT (@Dtype + ' DDL: ' + @CreateDDL);		 
					IF (@CHARACTER_MAXIMUM_LENGTH = -1)	 
						SET @CreateDDL = @CreateDDL + '(max) ';
					ELSE
						SET @CreateDDL = @CreateDDL + '(' + cast(@CHARACTER_MAXIMUM_LENGTH as nvarchar(50)) + ') ';
				 END
				 ELSE IF (@Dtype = 'varbinary')
				 BEGIN
					PRINT (@Dtype + ' DDL: ' + @CreateDDL);		 
					IF (@CHARACTER_MAXIMUM_LENGTH = -1)	 
						SET @CreateDDL = @CreateDDL + '(max) ';
					ELSE
						SET @CreateDDL = @CreateDDL + '(' + cast(@CHARACTER_MAXIMUM_LENGTH as nvarchar(50)) + ') ';
				 END
				 ELSE IF (@CHARACTER_MAXIMUM_LENGTH is not null)
				 BEGIN
					PRINT ('00 - DDL: ' + @CreateDDL);		 
					SET @CreateDDL = @CreateDDL + '(' + cast(@CHARACTER_MAXIMUM_LENGTH as nvarchar(50)) + ') ' ;
				 END
				 ELSE IF (@NUMERIC_PRECISION is not null AND @NUMERIC_SCALE is not null)
				 BEGIN
					PRINT ('01 - DDL: ' + @CreateDDL);		 
					SET @CreateDDL = @CreateDDL + '(' + cast(@NUMERIC_PRECISION as nvarchar(50)) + ', ' +cast(@NUMERIC_SCALE as nvarchar(50)) + ') ' ;
				 END
				 ELSE IF (@NUMERIC_PRECISION is not null AND @NUMERIC_SCALE is null)
				 BEGIN
					PRINT ('02 - DDL: ' + @CreateDDL);		 
					SET @CreateDDL = @CreateDDL + '(' + cast(@NUMERIC_PRECISION as nvarchar(50)) + ', ' +cast(@NUMERIC_SCALE as nvarchar(50)) + ') ' ;
				 END
				 ELSE IF (@CHARACTER_MAXIMUM_LENGTH is not null)
				 BEGIN
					PRINT ('03 - DDL: ' + @CreateDDL);	
					IF (@CHARACTER_MAXIMUM_LENGTH = -1)	 
						SET @CreateDDL = @CreateDDL + '(max) ';
					ELSE
						SET @CreateDDL = @CreateDDL + '(' + cast(@CHARACTER_MAXIMUM_LENGTH as nvarchar(50)) + ') ';
				 END
				 ELSE 
				 BEGIN
					PRINT ('04 - DDL: ' + @CreateDDL);		 
				 END
				 
				 SET @CreateDDL = @CreateDDL + ' NULL, ';
				 -- PRINT ('05 - DDL: ' + @CreateDDL);		 
				 
				 FETCH Next FROM Col_Cursor INTO @Colname , @Dtype, @CHARACTER_MAXIMUM_LENGTH, @NUMERIC_PRECISION, @NUMERIC_SCALE ;
				 /*
				 --TURN On these statements when needed to track individual items.
				 print (@Colname) ;
				 print (@Dtype) ;
				 print ( @CHARACTER_MAXIMUM_LENGTH) ;
				 print ( @NUMERIC_PRECISION) ;
				 print ( @NUMERIC_SCALE ) ;
				 */
			 END;

		 CLOSE Col_Cursor;
		 DEALLOCATE Col_Cursor;

		 --Strip off the last COMMA

		 SET @SelectCOLS = RTRIM (@SelectCOLS) ;
		 SET @CreateDDL = RTRIM (@CreateDDL) ;
		 SET @CreateDDL = LEFT (@CreateDDL , LEN (@CreateDDL) - 1) ;
		 SET @CreateDDL = @CreateDDL + ')';

		 PRINT ('____________________________________________________________');		 
		 PRINT ('1 - Creating table ' + @Trktbl);		 
		 PRINT ('2- DLL: ' );
		 PRINT ('3- ' + @CreateDDL);

		 EXEC Sp_Executesql @CreateDDL;
		 PRINT ('____________________________________________________________');		 

		 IF EXISTS (SELECT Name
					  FROM Sys.Tables
					  WHERE Name = @Trktbl) 
			 BEGIN
				 SET @Mysql = 'alter table ' + @Trktbl + ' add RowDeletionDate datetime default getdate() ';
				 EXEC Sp_Executesql @Mysql;
				 PRINT 'Added RowDeletionDate: ';
			 END;

		 SET @CreateDDL = 'CREATE NONCLUSTERED INDEX [PI_' + @Trktbl + '] ON [' + @Trktbl + '] ';
		 SET @CreateDDL = @CreateDDL + '(';
		 SET @CreateDDL = @CreateDDL + '	[RowDeletionDate] ASC ';
		 SET @CreateDDL = @CreateDDL + ')';
		 EXEC Sp_Executesql @CreateDDL;
		 PRINT 'Added RowDeletionDate INDEX ';

		 SET @CreateDDL = '';
		 SET @CreateDDL = @CreateDDL + 'CREATE TRIGGER ' + @Tbl + '_DelTRIG ';
		 SET @CreateDDL = @CreateDDL + '    ON ' + @Tbl;
		 SET @CreateDDL = @CreateDDL + '    FOR DELETE ';
		 SET @CreateDDL = @CreateDDL + 'AS ';
		 SET @CreateDDL = @CreateDDL + '	INSERT INTO ' + @Trktbl + ' SELECT '+@SelectCOLS+' getdate() from deleted ';
		 EXEC Sp_Executesql @CreateDDL;
		 PRINT 'Added ' + @Tbl + ' TRIGGER';
		 print (@CreateDDL) ;

		 declare @viewname as nvarchar(250) = '' ;
		 set @viewname = 'view_EDW_' + @Tbl + '_DelAudit ';
		 if exists(Select name from sys.views where name = @viewname)
		 BEGIN
			set @Mysql = 'drop view ' + @viewname ;
			EXEC Sp_Executesql @Mysql;
			print ('Dropped existing view ' + @viewname) ;
		 END

		 SET @CreateDDL = '';
		 SET @CreateDDL = @CreateDDL + 'CREATE VIEW view_EDW_' + @Tbl + '_DelAudit ';
		 SET @CreateDDL = @CreateDDL + 'AS ';
		 SET @CreateDDL = @CreateDDL + ' SELECT * from ' + @Trktbl;
		 EXEC Sp_Executesql @CreateDDL;
		 PRINT 'Added VIEW: ' + @viewname ;
		 print (@CreateDDL) ;
	 END;

GO

--*********************************************************
--TEST THE PROC
--*********************************************************
if exists (select name from sys.tables where name = 'Edw_Test_Del')
BEGIN
	DROP TABLE Edw_Test_Del;
END
GO

CREATE TABLE Dbo.Edw_Test_Del (Todaydate datetime2 (7) NULL
							 , Rowidnbr int IDENTITY (1 , 1) 
											NOT NULL
							 , Tguid uniqueidentifier NULL
							 , DecVal decimal (10,2)
							 ,FloatVal float
							 ,charVal char(50)
							 ,nvcVal nvarchar(1000)
							 ,vcVal varchar(1000)) ;

GO

ALTER TABLE Dbo.Edw_Test_Del
ADD CONSTRAINT Df_Edw_Test_Del_Todaydate DEFAULT GETDATE () FOR Todaydate;
GO

ALTER TABLE Dbo.Edw_Test_Del
ADD CONSTRAINT Df_Edw_Test_Del_Tguid DEFAULT NEWID () FOR Tguid;
GO

EXEC Proc_Attach_Delete_Audit 'EDW_TEST_DEL';
--EXEC Proc_Attach_Delete_Audit 'HFit_CoachingTermsAndConditionsSettings';
--EXEC Proc_Attach_Delete_Audit 'HFit_CoachingHealthInterest';
--EXEC Proc_Attach_Delete_Audit 'OM_Contact';
GO

INSERT INTO Edw_Test_Del (Tguid, DecVal, charVal, nvcVal, vcVal, FloatVal) 
VALUES
	   (NEWID (), 600.238, 'DMiller', 'DMiller', 'DMiller', 126.3345 ) ;
INSERT INTO Edw_Test_Del (Tguid, DecVal, charVal, nvcVal, vcVal, FloatVal)   
VALUES
	   (NEWID (), 500.23, 'DMiller', 'DMiller', 'DMiller', 226.3345 ) ;
INSERT INTO Edw_Test_Del (Tguid, DecVal, charVal, nvcVal, vcVal, FloatVal)   
VALUES
	   (NEWID (), 400.23, 'DMiller', 'DMiller', 'DMiller', 326.3345 ) ;
INSERT INTO Edw_Test_Del (Tguid, DecVal, charVal, nvcVal, vcVal, FloatVal)   
VALUES
	   (NEWID (), 300.23, 'DMiller', 'DMiller', 'DMiller', 426.3345 ) ;
INSERT INTO Edw_Test_Del (Tguid, DecVal, charVal, nvcVal, vcVal, FloatVal)   
VALUES
	   (NEWID (), 200.23, 'DMiller', 'DMiller', 'DMiller', 526.3345 ) ;
INSERT INTO Edw_Test_Del (Tguid, DecVal, charVal, nvcVal, vcVal, FloatVal)   
VALUES
	   (NEWID (), 100.23, 'DMiller', 'DMiller', 'DMiller', 626.3345 ) ;

DELETE FROM Edw_Test_Del
  WHERE Tguid IN (SELECT TOP 1 Tguid
					FROM Edw_Test_Del
					ORDER BY Tguid DESC) ;

--DELETE FROM Edw_Test_Del WHERE DEcVal > 200

--SELECT * FROM Edw_Test_Del;
--SELECT * FROM Edw_Test_Del_DelAudit;
--select * from view_EDW_EDW_TEST_DEL_DelAudit ;

if exists (select name from sys.tables where name = 'Edw_Test_Del')
BEGIN
	print ('DROP TABLE Edw_Test_Del') ;
	DROP TABLE Edw_Test_Del;
END
GO
if exists (select name from sys.tables where name = 'Edw_Test_Del_DelAudit')
BEGIN
	print ('DROP TABLE Edw_Test_Del_DelAudit') ;
	DROP TABLE Edw_Test_Del_DelAudit;
END
GO
