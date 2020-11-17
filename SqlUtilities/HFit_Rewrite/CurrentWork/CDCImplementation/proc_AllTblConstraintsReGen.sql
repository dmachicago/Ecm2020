
-- USE KenticoCMS_1
GO
PRINT 'executing proc_AllTblConstraintsReGen.sql';
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_AllTblConstraintsReGen') 
    BEGIN
        DROP PROCEDURE proc_AllTblConstraintsReGen;
    END;
GO
-- exec proc_AllTblConstraintsReGen HFit_HealthAssessmentPaperException
CREATE PROCEDURE proc_AllTblConstraintsReGen (@TblName AS nvarchar (25) = NULL) 
AS
BEGIN

/*
AUTHOR:	  W. Dale Miller
CONTACT:	  WDaleMiller@gmail.com
DATE:	  12/19/2015
USE:		  
*/

    BEGIN TRANSACTION TXAllTblConstraintRegen;
    BEGIN TRY
        DECLARE
              @CreateDDL nvarchar (2500) = '' , 
              @TgtTblName nvarchar (250) = '' , 
		    @TgtColName nvarchar (250) = '' , 
              @FkName nvarchar (1000) = '' , 
              @msg nvarchar (2500) = '';

        IF @TblName IS NULL
            BEGIN
                DECLARE CUR_SingleTblConstraints CURSOR
                    FOR SELECT  TableName , ColumnName ,
                               Name , 
                               CreateDDL
                          FROM MART_SingleTblConstraints;                
            END;
        ELSE
	   
            BEGIN
                DECLARE CUR_SingleTblConstraints CURSOR
                    FOR SELECT TableName , ColumnName ,
                               Name , 
                               CreateDDL
                          FROM TEMP_SingleTblConstraints
                          WHERE TableName = @TblName;
            END;

        OPEN CUR_SingleTblConstraints;
        FETCH NEXT FROM CUR_SingleTblConstraints INTO @TgtTblName ,@TgtColName , @FkName , @CreateDDL;
        WHILE @@Fetch_Status = 0
            BEGIN
                BEGIN TRY
				    if not exists (
						  select t.name
						    from sys.all_columns c
						    join sys.tables t on t.object_id = c.object_id
						    join sys.schemas s on s.schema_id = t.schema_id
						    join sys.default_constraints d on c.default_object_id = d.object_id
						  where t.name = @TgtTblName
						    and c.name = @TgtColName
						    and s.name = 'dbo')
                        BEGIN 
				                    SET @msg = 'REGEN Constraints: ' + @CreateDDL;
							 EXEC PrintImmediate @msg;
					   EXEC (@CreateDDL) 
                        END;
				    else 
					   print @FkName + ' DEFAULT VALUE already exists, skipping.'
                END TRY
                BEGIN CATCH
                    PRINT 'Already exists, skipping: ' + @CreateDDL;
                END CATCH;
                FETCH NEXT FROM CUR_SingleTblConstraints INTO @TgtTblName ,@TgtColName , @FkName , @CreateDDL;
            END;
        CLOSE CUR_SingleTblConstraints;
        DEALLOCATE CUR_SingleTblConstraints;
        COMMIT TRANSACTION TXAllTblConstraintRegen;
    END TRY
    BEGIN CATCH
        SET @msg = 'FAILURE: proc_AllTblConstraintsReGen: ' + @CreateDDL;
        EXEC PrintImmediate @msg;
        ROLLBACK TRANSACTION TXAllTblConstraintRegen;
    END CATCH;
END;
GO
PRINT 'executed proc_AllTblConstraintsReGen.sql';
GO
