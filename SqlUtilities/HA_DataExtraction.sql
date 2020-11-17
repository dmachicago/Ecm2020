--Select count(*) from KenticoCMS_1..view_EDW_HealthAssesment   --14279998
--Select count(*) from KenticoCMS_2..view_EDW_HealthAssesment   --10801230
--Select count(*) from KenticoCMS_3..view_EDW_HealthAssesment   --16963538

--Select count(*) from KenticoCMS_1..view_EDW_HealthAssesment   --454503
--where AccountCD = 'bcbsne'
--Select count(*) from KenticoCMS_2..view_EDW_HealthAssesment   --0
--where AccountCD = 'bcbsne'
--Select count(*) from KenticoCMS_3..view_EDW_HealthAssesment   --0
--where AccountCD = 'bcbsne'

--******************************************************************
USE KenticoCMS_1;
IF NOT EXISTS (SELECT name
                 FROM sys.procedures
                 WHERE name = 'ADD_TEMP_HA_PERF') 
    BEGIN
        PRINT 'KenticoCMS_1, proc ADD_TEMP_HA_PERF missing, aborting.';
    END;
ELSE
    BEGIN EXEC ADD_TEMP_HA_PERF;
    END;

go
--******************************************************************
USE KenticoCMS_2;
IF NOT EXISTS (SELECT name
                 FROM sys.procedures
                 WHERE name = 'ADD_TEMP_HA_PERF') 
    BEGIN
        PRINT 'KenticoCMS_2, proc ADD_TEMP_HA_PERF missing, aborting.';
    END;
ELSE
    BEGIN EXEC ADD_TEMP_HA_PERF;
    END;

go
--******************************************************************
USE KenticoCMS_3;
IF NOT EXISTS (SELECT name
                 FROM sys.procedures
                 WHERE name = 'ADD_TEMP_HA_PERF') 
    BEGIN
        PRINT 'KenticoCMS_3, proc ADD_TEMP_HA_PERF missing, aborting.';
    END;
ELSE
    BEGIN EXEC ADD_TEMP_HA_PERF;
    END;

go

--******************************************************************
USE DataMartPlatform;
EXEC PULL_HA_DATA @AccountCD = 'bcbsne';
GO

--******************************************************************
CREATE PROCEDURE PULL_HA_DATA (@AccountCD AS nvarchar (50)) 
AS
BEGIN
    --USE:
    --EXEC PULL_HA_DATA @AccountCD = 'bcbsne';
    BEGIN
        IF EXISTS (SELECT name
                     FROM sys.tables
                     WHERE name = 'TEMP_HA') 
            BEGIN
                DROP TABLE TEMP_HA;
            END;

        SELECT HA.* INTO TEMP_HA
          FROM (
               SELECT 'CMS_1' AS DBNAME
                    , *
                 FROM KenticoCMS_1..view_EDW_HealthAssesment
                 WHERE AccountCD = @AccountCD
               UNION
               SELECT 'CMS_2' AS DBNAME
                    , *
                 FROM KenticoCMS_2..view_EDW_HealthAssesment
                 WHERE AccountCD = @AccountCD
               UNION
               SELECT 'CMS_3' AS DBNAME
                    , *
                 FROM KenticoCMS_3..view_EDW_HealthAssesment
                 WHERE AccountCD = @AccountCD) HA;

        PRINT 'Pulled ' + CAST (@@ROWCOUNT AS nvarchar (50)) + ' records, availalbe in TEMP_HA.';
    END;

--Key lookups occur when you have an index seek against a table, but your query requires additional columns that are not in that index. 

END;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
