

GO
PRINT 'executing proc_AllTblConstraintsDrop.sql';
GO
IF EXISTS(SELECT name
            FROM sys.procedures
            WHERE name = 'proc_AllTblConstraintsDrop')
    BEGIN
        DROP PROCEDURE proc_AllTblConstraintsDrop;
    END;
GO
-- use KenticoCMS_1
-- exec proc_AllTblConstraintsDrop COM_InternalStatus
-- exec proc_AllTblConstraintsDrop CMS_User
-- exec proc_AllTblConstraintsDrop EDW_RoleMembership
-- exec proc_AllTblConstraintsDrop HFit_UserTracker

CREATE PROCEDURE proc_AllTblConstraintsDrop(
       @TblName AS nvarchar(25))
AS
BEGIN
    BEGIN TRY
/*
AUTHOR:	  W. Dale Miller
CONTACT:	  WDaleMiller@gmail.com
DATE:	  12/19/2015
USE:		  
*/
        BEGIN TRANSACTION TXAllTblConstraintsDrop;
        -- select * from TEMP_SingleTblConstraints
        BEGIN TRY
            DROP TABLE TEMP_SingleTblConstraints;
        END TRY
        BEGIN CATCH
            PRINT 'Init TEMP_SingleTblConstraints';
        END CATCH;

        IF EXISTS(SELECT name
                    FROM sys.indexes
                    WHERE name = 'IX_HFIT_HEALTHASSESMENTUSERQUESTION_INC_ITEMID,HARISKAREAITEMID')
            BEGIN
                DROP INDEX [IX_HFIT_HEALTHASSESMENTUSERQUESTION_INC_ITEMID,HARISKAREAITEMID] ON HFit_HealthAssesmentUserQuestion
            END;

        DECLARE
               @TableName nvarchar(250)
             , @ColumnName nvarchar(250)
             , @Name nvarchar(250)
             , @definition nvarchar(250)
             , @CreateDDl nvarchar(2500)
             , @DropDDl nvarchar(2500)
             , @CMD nvarchar(2500);

        SELECT TableName = t.Name
             , ColumnName = c.Name
             , dc.Name
             , dc.definition INTO TEMP_SingleTblConstraints
          FROM
               sys.tables AS t
               INNER JOIN information_schema.tables AS IST
                    ON
                       T.name = IST.TABLE_NAME
                   AND IST.table_schema = 'dbo'
               INNER JOIN sys.default_constraints AS dc
                    ON t.object_id = dc.parent_object_id
               INNER JOIN sys.columns AS c
                    ON
                       dc.parent_object_id = c.object_id
                   AND c.column_id = dc.parent_column_id
          WHERE t.name = @TblName
          ORDER BY t.Name;

        ALTER TABLE TEMP_SingleTblConstraints
        ADD DropDDl nvarchar(max)NULL;
        ALTER TABLE TEMP_SingleTblConstraints
        ADD CreateDDl nvarchar(max)NULL;
        UPDATE TEMP_SingleTblConstraints
               SET TEMP_SingleTblConstraints.CreateDDl = 'ALTER TABLE [dbo].[' + TEMP_SingleTblConstraints.TableName + '] ADD  CONSTRAINT [' + TEMP_SingleTblConstraints.name + ']  DEFAULT (' + TEMP_SingleTblConstraints.definition + ') FOR [' + TEMP_SingleTblConstraints.ColumnName + ']';
        UPDATE TEMP_SingleTblConstraints
               SET TEMP_SingleTblConstraints.DropDDl = 'ALTER TABLE [dbo].[' + TEMP_SingleTblConstraints.TableName + '] DROP CONSTRAINT [' + TEMP_SingleTblConstraints.Name + '] ';

        DECLARE
               @i AS int = 0;
        SET @i = (SELECT COUNT(*)
                    FROM TEMP_SingleTblConstraints);

	   if not exists (select name from sys.tables where name = 'MART_SingleTblConstraints') 
	   begin 
		  -- select * from TEMP_SingleTblConstraints
		  -- drop table MART_SingleTblConstraints
		  -- Select * from MART_SingleTblConstraints order by Name
		  select * into MART_SingleTblConstraints from TEMP_SingleTblConstraints ;
		  create clustered index PI_MART_SingleTblConstraints on MART_SingleTblConstraints (TableNAme, ColumnName, NAme);
	   end

	   if @i > 0 and exists (select name from sys.tables where name = 'MART_SingleTblConstraints') 
	   begin 
		  -- use KenticoCMS_1
		  with CTE (TableNAme, ColumnName, NAme) AS (
			 select TableNAme, ColumnName, NAme from TEMP_SingleTblConstraints
			 except 
			 select TableNAme, ColumnName, NAme from MART_SingleTblConstraints
		  )
		  insert into MART_SingleTblConstraints 
		  select T.TableNAme, T.ColumnName, T.NAme, T.[definition], T.DropDDL, T.CreateDDL 
		  from TEMP_SingleTblConstraints T
		  join CTE C on
		  T.TableNAme = C.TableNAme
		  and T.ColumnName = C.ColumnName
		  and T.NAme = C.NAme
	   end 

        DECLARE
               @msg AS nvarchar(2000) = '';
        IF OBJECT_ID('TEMP_SingleTblConstraints')IS NULL
            BEGIN
                SET @msg = 'ERROR: TEMP_SingleTblConstraints missing for "' + @TblName + '".';
                EXEC PrintImmediate @msg;
                RETURN -1;
            END;

        DECLARE CUR_SingleTblConstraints CURSOR
            FOR SELECT TEMP_SingleTblConstraints.DropDDL
                  FROM TEMP_SingleTblConstraints;
        OPEN CUR_SingleTblConstraints;
        FETCH NEXT FROM CUR_SingleTblConstraints INTO @DropDDL;
        WHILE @@Fetch_Status = 0
            BEGIN
                SET @msg = 'DROP AllTblConstraints: ' + @DropDDL;
                EXEC PrintImmediate @msg;
                EXEC (@DropDDL);
                FETCH NEXT FROM CUR_SingleTblConstraints INTO @DropDDL;
            END;
        CLOSE CUR_SingleTblConstraints;
        DEALLOCATE CUR_SingleTblConstraints;
        COMMIT TRANSACTION TXAllTblConstraintsDrop;
    END TRY
    BEGIN CATCH
        SET @msg = 'FAILURE: proc_AllTblConstraintsDrop: ' + @DropDDL;
        EXEC PrintImmediate @msg;
        ROLLBACK TRANSACTION TXAllTblConstraintsDrop;
    END CATCH;
END;
GO
PRINT 'executed proc_AllTblConstraintsDrop.sql';
GO
