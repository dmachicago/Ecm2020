
-- Use KenticoCMS_Prod1

print 'TEST of exec proc_EDW_HealthInterestList';

exec proc_EDW_HealthInterestList 1;
exec proc_EDW_HealthInterestList 0;

IF EXISTS ( SELECT
                           table_name
                           FROM tempdb.information_schema.tables
                           WHERE table_name = '##Temp_HealthInterestList'
        ) 
            BEGIN
                PRINT 'Dropping ##Temp_HealthInterestList';
                DROP TABLE
                     ##Temp_HealthInterestList;
            END;

        SELECT
               * INTO
                      ##Temp_HealthInterestList
               FROM view_EDW_HealthInterestList_CT;

 EXEC proc_Add_EDW_CT_StdCols '##Temp_HealthInterestList';

-- select * from ##Temp_HealthInterestList

update ##Temp_HealthInterestList SET
HealthAreaName = upper(HealthAreaName) 
where NodeID in (select top 1 NodeID from ##Temp_HealthInterestList order by NodeID desc);

update ##Temp_HealthInterestList SET
hashcode =  HASHBYTES ('sha1',
				    isNull(HealthAreaName,'-'))
where NodeID in (select top 1 NodeID from ##Temp_HealthInterestList order by NodeID desc);

declare @iupdt as int = 0 ;
exec @iupdt = proc_CT_HealthInterestList_AddUpdatedRecs;

delete from ##Temp_HealthInterestList 
where NodeID in (select top 1 NodeID from ##Temp_HealthInterestList order by NodeID) ;
declare @idels as int = 0 ;
exec @idels = proc_CT_HealthInterestList_AddDeletedRecs;

delete from DIM_EDW_HealthInterestList
where NodeID in (select top 1 NodeID from ##Temp_HealthInterestList order by NodeID desc) ;
declare @inew as int = 0 ;
exec @inew = proc_CT_HealthInterestList_AddNewRecs;

print '**********************************************' ;
print '# of UPDATES: ' + cast( @iupdt as nvarchar(50));
print '# of INSERTS: ' + cast( @inew as nvarchar(50));
print '# of DELETES: ' + cast( @idels as nvarchar(50));
print '**********************************************' ;
