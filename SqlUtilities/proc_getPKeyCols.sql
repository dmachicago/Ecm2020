PRINT 'FROM: proc_genTableVar.sql';
PRINT 'Creating proc_getPKeyCols';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_getPKeyCols') 
    BEGIN
        DROP PROCEDURE
             proc_getPKeyCols;
    END;
GO
-- exec proc_getPKeyCols FACT_HFit_UserTracker, a
CREATE PROCEDURE proc_getPKeyCols (
     @tblname AS nvarchar (250) 
   , @pkcols nvarchar (max) OUTPUT) 
AS
BEGIN

/*****************************************************************************************************************
Author:	  W. Dale Miller
Date:	  09.22.2003
Copyright:  DMA, Ltd.
Purpose:	  Returns a list of columns used to define the PRIMARY key associated with this table if any are defined.
*****************************************************************************************************************/

    DECLARE
    @collist nvarchar ( max) 
  , @col AS nvarchar ( 250) 
  , @i AS int = 0;
    DECLARE PK_Cur CURSOR
        FOR
            SELECT
                   column_name
                   FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
                   WHERE
                   OBJECTPROPERTY ( OBJECT_ID ( constraint_name) , 'IsPrimaryKey') = 1
               AND table_name = @tblname
                   ORDER BY
                            column_name;
    OPEN PK_Cur;
    FETCH NEXT FROM PK_Cur INTO @col;
    SET @collist = '';
    WHILE @@FETCH_STATUS = 0
        BEGIN
            IF @i = 0
                BEGIN
                    SET @collist = @collist + @col;
                END;
            ELSE
                BEGIN
                    SET @collist = @collist + ', ' + @col;
                END;
            FETCH NEXT FROM PK_Cur INTO  @col;
            SET @i = @i + 1;
        END;

    --PRINT @collist;

    CLOSE PK_Cur;
    DEALLOCATE PK_Cur;
    SET @pkcols = @collist;

	   select @pkcols;

END;
GO
PRINT 'Created proc_getPKeyCols';
GO
PRINT 'Creating proc_genTableVar';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_genTableVar') 
    BEGIN
        DROP PROCEDURE
             proc_genTableVar;
    END;
GO