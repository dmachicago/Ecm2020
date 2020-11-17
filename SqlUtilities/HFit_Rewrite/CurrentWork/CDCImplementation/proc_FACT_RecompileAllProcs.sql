

drop PROCEDURE proc_FACT_RecompileAllProcs
go
-- exec proc_FACT_RecompileAllProcs
CREATE PROCEDURE proc_FACT_RecompileAllProcs
AS
BEGIN
    DECLARE @Table varchar (200) ;
    DECLARE @DBName varchar (200) ;
    DECLARE @CommandToExecute varchar (8000) ;
    DECLARE @AllSPLoop int;
    DECLARE @AllSPList TABLE
            (
                             UIDTableList int IDENTITY (1, 1) 
                           , OwnerName varchar (128) 
                           , TableName varchar (128)) ;
    INSERT INTO @AllSPList (
           OwnerName
         , TableName) 
    SELECT
           u.Name
         , o.Name
           FROM
               dbo.sysobjects AS o
                   INNER JOIN dbo.sysusers AS u
                       ON o.uid = u.uid
           WHERE o.Type = 'U'
             AND o.name LIKE 'proc_FACT%'
              OR o.name LIKE '%_CTHIST'
           ORDER BY
                    o.Name;
    SELECT
           @AllSPLoop = MAX (UIDTableList) 
           FROM @AllSPList;
    WHILE @AllSPLoop > 0
        BEGIN
            SELECT
                   @Table = TableName
                 , @DBName = OwnerName
                   FROM @AllSPList
                   WHERE UIDTableList = @AllSPLoop;

            SET @CommandToExecute = 'EXEC sp_recompile ' + '[' + @DBName + '.' + @Table + ']' + CHAR (13) ;
            BEGIN TRY
                EXEC (@CommandToExecute) ;
                --PRINT 'Compiled: ' + @Table;
            END TRY
            BEGIN CATCH
                SELECT
                       'Error In ' + '[' + @DBName + '.' + @Table + ']' + CHAR (13) ;
            END CATCH;
            SELECT
                   @AllSPLoop = @AllSPLoop - 1;
        END;
END;