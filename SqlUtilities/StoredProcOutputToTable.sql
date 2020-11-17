

IF OBJECT_ID('TEMPDB..#TableFKeys') IS NOT NULL
    DROP TABLE #TableFKeys ;

create table #TableFKeys
(
    PKTable_Qualifier nvarchar(200) null,
    PKTable_Owner nvarchar(200) null,
    PKTable_Name nvarchar(200) null,
    PKColumn_Name nvarchar(200) null,
    FKTable_Qualifier nvarchar(200) null,
    FKTable_Owner nvarchar(200) null,
    FKTable_Name nvarchar(200) null,
    FKColumn_Name nvarchar(200) null,
    KEY_SEQ int null,
    UPDATE_RULE int null,
    DELETE_RULE int null,
    FK_Name nvarchar(200) null,
    pK_Name nvarchar(200) null,
    DEFERRABILITY int null
)

INSERT INTO #TableFKeys
EXEC sp_fkeys 'HFit_HealthAssesmentUserQuestion' ;

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
