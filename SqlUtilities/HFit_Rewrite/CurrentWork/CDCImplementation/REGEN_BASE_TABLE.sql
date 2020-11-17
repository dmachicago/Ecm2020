

--declare @TblName nvarchar(250) = 'BASE_Hfit_CoachingUserCMCondition' ;
-- exec REGEN_BASE_TABLE HFit_Account
alter PROCEDURE REGEN_BASE_TABLE (@TblName nvarchar (250)) 
AS
BEGIN
declare @BaseT nvarchar(250) = 'BASE_'+@TblName ;
    EXEC proc_genPullChangesProc 'KenticoCMS_1', @TblName, 0, 1;
    EXEC proc_genPullChangesProc 'KenticoCMS_2', @TblName, 0, 1;
    EXEC proc_genPullChangesProc 'KenticoCMS_3', @TblName, 0, 1;
    EXEC regen_CT_Triggers @BaseT;
END;

select 'EXEC REGEN_BASE_TABLE ' + substring(table_name,6,999) + CHAR(10) + 'GO' from information_schema.tables
where table_type = 'BASE TABLE'
and table_name like 'base%'
and table_name not like '%TESTDATA'
and table_name not like '%verhist'
and table_name not like '%del'
and table_name not like 'temp%'
and table_name not like 'dim%'
and table_name not like '%[_]VIEW[_]%'
order by table_name 