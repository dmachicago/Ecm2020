
/*
	IF object_id('tempdb..#spPrintImmediate') IS NOT NULL
		DROP PROCEDURE #spPrintImmediate ;
go
*/
	CREATE PROCEDURE #spPrintImmediate (@MSG AS NVARCHAR(MAX))
	AS
    BEGIN
        RAISERROR(@MSG, 10, 1) WITH NOWAIT;
    END;
