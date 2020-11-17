

-- exec regen_CT_Triggers BASE_CMS_MembershipUser
alter PROCEDURE regen_CT_Triggers (@BASETable nvarchar (250)) 
AS
BEGIN
SET NOCOUNT ON;
    DECLARE
          @MySql nvarchar (max) ;

    DECLARE
          @TrigName AS nvarchar (500) = 'TRIG_DEL_' + @BASETable;

    IF EXISTS (SELECT name
                 FROM sys.triggers
                 WHERE name = @TrigName) 
        BEGIN
            SET @MySql = ' DROP TRIGGER ' + @TrigName;
            PRINT @MySql;
            EXEC (@MySql) ;
        END;

    BEGIN
        PRINT 'CREATING TRIGGER: ' + @TrigName;
        DECLARE
              @OUT AS nvarchar (max) = '' , 
              @DDL AS nvarchar (max) = '';

        --************************************************************

        EXEC proc_genBaseDelTrigger @BASETable , @DDL OUTPUT;

        --************************************************************

        SET @OUT = (SELECT @DDL) ;
        EXEC (@OUT) ;
        PRINT 'CREATED DELETE TRIGGER: ' + @TrigName;

        --************************************************************

        EXEC proc_genBaseUpdtTrigger @BASETable , @DDL OUTPUT;

        --************************************************************

        SET @OUT = (SELECT @DDL) ;
        EXEC (@OUT) ;
        PRINT 'CREATED UPDATE TRIGGER: ' + @TrigName;
    END;
    SET NOCOUNT OFF;
END;