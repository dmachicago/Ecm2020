alter PROCEDURE sp_dependsV2
       @objname NVARCHAR (500) 
AS
BEGIN
    DECLARE
    @objid INT
    , @found_some BIT
    , @dbname SYSNAME;

    --  Make sure the @objname is local to the current database.

    SELECT
           @dbname = PARSENAME ( @objname , 3) ;
    IF
    @dbname IS NOT NULL AND
           @dbname <> DB_NAME () 
        BEGIN
            RAISERROR ( 15250 , -1 , -1) ;
            RETURN
            1;
        END;

    --  See if @objname exists.

    SELECT
           @objid = OBJECT_ID ( @objname) ;
    IF @objid IS NULL
        BEGIN
            SELECT
                   @dbname = DB_NAME () ;
            RAISERROR ( 15009 , -1 , -1 , @objname , @dbname) ;
            RETURN
            1;
        END;

    --  Initialize @found_some to indicate that we haven't seen any dependencies.

    SELECT
           @found_some = 0;
    SET NOCOUNT ON;

    --  Print out the particulars about the local dependencies.

    IF EXISTS ( SELECT
                       *
                FROM sysdepends
                WHERE id = @objid) 
        BEGIN
            RAISERROR ( 15459 , -1 , -1) ;
            SELECT 'name' = s6.name + '.' + o1.name
                 , type = SUBSTRING ( v2.name , 5 , 66) 
                 ,-- spt_values.name is nvarchar(70)

                   updated = SUBSTRING ( u4.name , 1 , 7) 
                 , selected = SUBSTRING ( w5.name , 1 , 8) 
                 , 'column' = COL_NAME ( d3.depid , d3.depnumber) 
            FROM	 sys.objects AS		o1
            , DFINAnalytics.dbo.spt_values AS	v2
            , sysdepends AS		d3
            , DFINAnalytics.dbo.spt_values AS	u4
            , DFINAnalytics.dbo.spt_values AS	w5
            , sys.schemas AS		s6
            WHERE
                   o1.object_id = d3.depid AND
                   o1.type = SUBSTRING ( v2.name , 1 , 2) COLLATE catalog_default AND v2.type = 'O9T' AND u4.type = 'B' AND
                   u4.number = d3.resultobj AND w5.type = 'B' AND
                   w5.number = d3.readobj|d3.selall AND d3.id = @objid AND
                   o1.schema_id = s6.schema_id AND deptype < 2;
            SELECT
                   @found_some = 1;
        END;

    --  Now check for things that depend on the object.

    --IF EXISTS ( SELECT
    --                   *
    --            FROM sysdepends
    --            WHERE depid = @objid) 
    --    BEGIN
    --        RAISERROR ( 15460 , -1 , -1) ;
    --        SELECT DISTINCT 'A2',
    --               'name' = s.name + '.' + o.name
    --             , type = SUBSTRING ( v.name , 5 , 66) 

    --         spt_values.name is nvarchar(70)

    --        FROM sys.objects AS o , DFINAnalytics.dbo.spt_values AS v , sysdepends AS d ,
    --        sys.schemas AS s
    --        WHERE
    --               o.object_id = d.id AND
    --               o.type = SUBSTRING ( v.name , 1 , 2) COLLATE catalog_default AND v.type = 'O9T' AND d.depid = @objid AND
    --               o.schema_id = s.schema_id AND deptype < 2;
    --        SELECT
    --               @found_some = 1;
    --    END;

    --  Did we find anything in sysdepends?

    IF @found_some = 0
        BEGIN
            RAISERROR ( 15461 , -1 , -1) ;
        END;
    SET NOCOUNT OFF;
    RETURN 0;
END;