

CREATE PROCEDURE proc_ckChangeTracking (
       @SchemaName AS NVARCHAR (250) 
     , @TBL AS NVARCHAR (250)) 
AS
BEGIN
    IF EXISTS (
    SELECT
           sys.tables.name
    FROM
         sys.change_tracking_tables
         JOIN sys.tables
         ON
           sys.tables.object_id = sys.change_tracking_tables.object_id
         JOIN sys.schemas
         ON
           sys.schemas.schema_id = sys.tables.schema_id
    WHERE
           sys.tables.name = @TBL AND
           sys.schemas.name = @SchemaName) 
        BEGIN
            RETURN 1;
        END
    ELSE
        BEGIN
            RETURN 0;
        END;
END; 