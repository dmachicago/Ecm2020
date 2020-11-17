IF NOT EXISTS
(
    SELECT 1
    FROM sys.sequences
    WHERE name = 'master_seq'
)
    BEGIN
        CREATE SEQUENCE master_seq
             AS BIGINT
             START WITH 1
             INCREMENT BY 1
             MINVALUE 1
             MAXVALUE 999999999
             NO CYCLE
             CACHE 10;
END;
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

