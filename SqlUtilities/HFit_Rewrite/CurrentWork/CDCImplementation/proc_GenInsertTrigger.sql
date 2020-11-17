
GO
PRINT 'Executing proc_GenInsertTrigger.sql';
GO

IF NOT EXISTS (SELECT name
                 FROM sys.tables
                 WHERE name = 'MART_InsertTriggerTables') 
    BEGIN
        CREATE TABLE MART_InsertTriggerTables (Table_Name nvarchar (254) NOT NULL
                                             , CreateDate datetime DEFAULT GETDATE () 
                                                                   NOT NULL) ;
    END;
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_GenInsertTrigger') 
    BEGIN
        DROP PROCEDURE proc_GenInsertTrigger;
    END;
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_CreateInsertTrigger') 
    BEGIN
        DROP PROCEDURE proc_CreateInsertTrigger;
    END;
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_InsertTriggerDrop') 
    BEGIN
        DROP PROCEDURE proc_InsertTriggerDrop;
    END;
GO

-- exec proc_GenInsertTrigger BASE_Board_Board
CREATE PROCEDURE proc_GenInsertTrigger (@TableName nvarchar (254) 
                                      , @UpdtTrigName nvarchar (254) = null) 
AS
BEGIN

    if @UpdtTrigName is null
    begin
	   set @UpdtTrigName = 'TRIG_UPDT_' + @TableName
    end
    IF NOT EXISTS (SELECT *
                 FROM sys.triggers
                 WHERE sys.triggers.object_id = OBJECT_ID (@UpdtTrigName)) 
        BEGIN
            print'ERROR: TRIGGER does not exist: ' + @UpdtTrigName;
		  return ;
        END;

    print 'FROM INSIDE proc_GenInsertTrigger ' + @TableName + ',' + @UpdtTrigName ;
    DECLARE
           @MySql nvarchar (max) = ''
         , @TrigNewName nvarchar (max) = ''
         , @TrigDLL nvarchar (max) = '';

    SET @TrigNewName = REPLACE (@UpdtTrigName, '_UPDT_', '_INS_') ;
    SET @TrigDLL = (SELECT OBJECT_DEFINITION (OBJECT_ID (@UpdtTrigName)) AS [Trigger Definition]) ;
    SET @TrigDLL = REPLACE (@TrigDLL, @UpdtTrigName, @TrigNewName) ;
    SET @TrigDLL = REPLACE (@TrigDLL, '''U''', '''I''') ;
    SET @TrigDLL = REPLACE (@TrigDLL, 'AFTER UPDATE', 'AFTER INSERT') ;

    IF EXISTS (SELECT *
                 FROM sys.triggers
                 WHERE sys.triggers.object_id = OBJECT_ID (@TrigNewName)) 
        BEGIN
            SET @MySql = 'DROP TRIGGER ' + @TrigNewName;
		  print @MySql ;
            EXEC (@MySql) ;
        END;

    DELETE FROM MART_InsertTriggerTables
    WHERE Table_Name = @TableName;

    INSERT INTO MART_InsertTriggerTables (Table_Name) 
    VALUES
           (@TableName) ;

    exec (@TrigDLL) ;
    PRINT 'Created TRIGGER ' + @TrigNewName ;
    --SELECT @TrigDLL;
END;
GO
PRINT 'Created proc_GenInsertTrigger.sql';
GO

CREATE PROCEDURE proc_InsertTriggerDrop (@TableName nvarchar (254)) 
AS
BEGIN
    DECLARE
           @TrigName nvarchar (254) = 'TRIG_INS_' + @TableName
         , @MySql nvarchar (max) = '';

    IF EXISTS (SELECT *
                 FROM sys.triggers
                 WHERE sys.triggers.object_id = OBJECT_ID (@TrigName)) 
        BEGIN
            SET @MySql = 'DROP TRIGGER ' + @TrigName;
            EXEC (@MySql) ;
            DELETE FROM MART_InsertTriggerTables
            WHERE Table_Name = @TableName;
            PRINT 'Trigger ' + @TrigName + ', DROPPED.';
        END;
END;
GO
PRINT 'Created proc_InsertTriggerDrop.sql';
GO

--exec proc_CreateInsertTrigger BASE_CMS_MembershipUser
CREATE PROCEDURE proc_CreateInsertTrigger (@TableName nvarchar (254)) 
AS
BEGIN
    DECLARE
           @TrigName nvarchar (254) = 'TRIG_UPDT_' + @TableName
         , @TrigNewName nvarchar (254) = 'TRIG_INS_' + @TableName
         , @MySql nvarchar (max) = '';

    IF NOT EXISTS (SELECT *
                     FROM sys.triggers
                     WHERE sys.triggers.object_id = OBJECT_ID (@TrigName)) 
        BEGIN
            PRINT 'ERROR: ' + @TrigName + ' is required to generate an INSERT trigger and is missing, aborting.';
            RETURN;
        END;
    print 'Calling proc_GenInsertTrigger ' + @TableName + ',' + @TrigName ;
    EXEC proc_GenInsertTrigger @TableName, @TrigName;
END;
GO
PRINT 'Created proc_CreateInsertTrigger.sql';
GO
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_CheckInsertTriggers') 
    BEGIN
        DROP PROCEDURE proc_CheckInsertTriggers;
    END;

GO
-- exec proc_CheckInsertTriggers @PreviewOnly = 1
CREATE PROCEDURE proc_CheckInsertTriggers (@PreviewOnly int = 0) 
AS
BEGIN
    DECLARE
           @MySql AS nvarchar (max) 
         , @TriggerName AS nvarchar (250) = ''
         , @Table_Name AS nvarchar (250) = '';

    DECLARE C CURSOR
        FOR SELECT table_name
              FROM MART_InsertTriggerTables;

    OPEN C;

    FETCH NEXT FROM C INTO @Table_Name;

    WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @TriggerName = 'TRIG_INS_' + @Table_Name;
		  Print 'validating : ' + @TriggerName ;
            IF NOT EXISTS (SELECT *
                             FROM sys.triggers
                             WHERE sys.triggers.object_id = OBJECT_ID (@TriggerName)) 
                BEGIN
                    IF @PreviewOnly = 0
                        BEGIN 
					   print 'EXEC proc_CreateInsertTrigger ' + @Table_Name ;
					   EXEC proc_CreateInsertTrigger @Table_Name
                        END;
                    PRINT 'ADDED Insert Trigger: ' + @TriggerName;
				PRINT 'Constantly verified by job: JOB_proc_CheckInsertTriggers' ;
                END;
		  else 
			 Print 'FOUND : ' + @TriggerName ;
            FETCH NEXT FROM C INTO @Table_Name;
        END;

    CLOSE C;
    DEALLOCATE C;
END;
GO
PRINT 'Created proc_CheckInsertTriggers.sql';
PRINT 'Executed proc_GenInsertTrigger.sql';
GO

-- select * from sys.triggers where name like '%[_]ins[_]%'
/*
insert into MART_InsertTriggerTables (table_name) values ('BASE_CMS_MembershipUser');
insert into MART_InsertTriggerTables (table_name) values ('exec proc_CreateInsertTrigger BASE_CMS_UserRole');
insert into MART_InsertTriggerTables (table_name) values ('exec proc_CreateInsertTrigger BASE_Hfit_CoachingUserCMCondition');
insert into MART_InsertTriggerTables (table_name) values ('exec proc_CreateInsertTrigger BASE_HFit_CoachingUserServiceLevel');

exec proc_CreateInsertTrigger BASE_CMS_User;
exec proc_CreateInsertTrigger BASE_CMS_MembershipUser;
exec proc_CreateInsertTrigger BASE_CMS_UserRole;
exec proc_CreateInsertTrigger BASE_Hfit_CoachingUserCMCondition;
exec proc_CreateInsertTrigger BASE_HFit_CoachingUserServiceLevel;
*/