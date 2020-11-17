


go 
print 'Executing proc_CreateTriggerCMSUserSurrogateKeyUpdt.sql'
go
/*

SELECT 'exec proc_CreateTriggerCMSUserSurrogateKeyUpdt ' + OBJECT_NAME(parent_object_id) + char(10) + 'GO' as CMD ,
OBJECT_NAME(object_id) AS ConstraintName,
SCHEMA_NAME(schema_id) AS SchemaName,
OBJECT_NAME(parent_object_id) AS TableName,
type_desc AS ConstraintType
FROM sys.objects
WHERE type_desc LIKE '%CONSTRAINT'
and OBJECT_NAME(parent_object_id)  LIKE 'BASE%' 
and OBJECT_NAME(parent_object_id)  not LIKE '%DEL'   
--and OBJECT_NAME(object_id)  not LIKE 'STAGED%'
--and OBJECT_NAME(object_id) not like '%DATA'
and OBJECT_NAME(object_id) in 
(SELECT CONSTRAINT_NAME
  FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
  WHERE CONSTRAINT_NAME LIKE '%BASE_cms_user' )
*/

-- exec proc_CreateTriggerCMSUserSurrogateKeyUpdt BASE_HFit_TrackerHbA1c, 0,1

GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_CreateTriggerCMSUserSurrogateKeyUpdt') 
    BEGIN
        DROP PROCEDURE
             proc_CreateTriggerCMSUserSurrogateKeyUpdt;
    END;
GO
CREATE PROCEDURE proc_CreateTriggerCMSUserSurrogateKeyUpdt (
       @TblName AS NVARCHAR (250) , @SkipIfExists AS BIT = 1
     ,@DropConstraint AS BIT = 0
     ,@PreviewOnly AS BIT = 0) 
AS
BEGIN
    DECLARE
    @TgtTbl AS NVARCHAR (250) = ''
  ,@FKName AS NVARCHAR (250) = ''
  ,@TrigName AS NVARCHAR (250) = ''
  ,@MySql AS NVARCHAR (MAX) = '';

    SET @FKName = 'FK_' + @TblName + '_BASE_cms_user';
    SET @TrigName = 'TRIG_INS_' + @TblName + '_UserID';
    IF EXISTS (SELECT
                      *
               FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
               WHERE
                      CONSTRAINT_NAME = @FKName) 
        BEGIN
		  if @SkipIfExists = 1 
		  begin
			 print @TrigName + ' ALREADY Exists, skipping...' ;
			 return ;
		  end 
            SET @MySql = 'ALTER TABLE dbo.' + @TblName + ' DROP CONSTRAINT ' + @FKName;
            IF @PreviewOnly = 1
                BEGIN
                    PRINT @MySql;
                END;
            ELSE
                BEGIN
                    IF
                           @DropConstraint = 1
                        BEGIN EXEC (@MySql) ;
                        END;
                END;
        END;
    SET @MySql = 'IF EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(''' + @TrigName + ''')) ';
    SET @MySql = @MySql + CHAR (10) + 'DROP TRIGGER [dbo].' + @TrigName;
    IF @PreviewOnly = 1
        BEGIN
            PRINT @MySql;
        END;
    ELSE
        BEGIN 
		  EXEC (@MySql) ;
        END;
    SET @MySql = 'CREATE TRIGGER dbo.TRIG_INS_' + @TblName + '_UserID ON dbo.' + @TblName;
    SET @MySql = @MySql + CHAR (10) + 'AFTER INSERT';
    SET @MySql = @MySql + CHAR (10) + 'AS';
    SET @MySql = @MySql + CHAR (10) + 'BEGIN';
    SET @MySql = @MySql + CHAR (10) + '  UPDATE B';
    SET @MySql = @MySql + CHAR (10) + '  SET B.SurrogateKey_cms_user = ISNULL (U.SurrogateKey_cms_user , -1)';
    SET @MySql = @MySql + CHAR (10) + '  FROM ' + @TblName + ' B';
    SET @MySql = @MySql + CHAR (10) + '       JOIN INSERTED I';
    SET @MySql = @MySql + CHAR (10) + '       ON I.UserID = B.UserID';
    SET @MySql = @MySql + CHAR (10) + '      AND I.DBNAME = B.DBNAME';
    SET @MySql = @MySql + CHAR (10) + '       JOIN BASE_CMS_User U';
    SET @MySql = @MySql + CHAR (10) + '       ON I.UserID = U.UserID';
    SET @MySql = @MySql + CHAR (10) + '      AND I.DBNAME = U.DBNAME';
    SET @MySql = @MySql + CHAR (10) + 'END';
    IF @PreviewOnly = 1
        BEGIN
            PRINT @MySql;
        END;
    ELSE
	   exec PrintImmediate @MySql;
        BEGIN EXEC (@MySql) ;
	   exec PrintImmediate '**************************************************';
        END;
END;
go 
print 'Executed proc_CreateTriggerCMSUserSurrogateKeyUpdt.sql'
go
