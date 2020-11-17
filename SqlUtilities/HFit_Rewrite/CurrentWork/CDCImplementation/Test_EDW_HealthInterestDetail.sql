

print 'TEST of exec proc_EDW_HealthInterestDetail';

exec proc_EDW_HealthInterestDetail 1;
exec proc_EDW_HealthInterestDetail 0;

IF EXISTS ( SELECT
                           table_name
                           FROM tempdb.information_schema.tables
                           WHERE table_name = '##Temp_HealthInterestDetail'
        ) 
            BEGIN
                PRINT 'Dropping ##Temp_HealthInterestDetail';
                DROP TABLE
                     ##Temp_HealthInterestDetail;
            END;

        SELECT
               * INTO
                      ##Temp_HealthInterestDetail
               FROM view_EDW_HealthInterestDetail_CT;

 EXEC proc_Add_EDW_CT_StdCols '##Temp_HealthInterestDetail';

-- select * from ##Temp_HealthInterestDetail

update ##Temp_HealthInterestDetail SET
ThirdHealthAreaName = upper(ThirdHealthAreaName) 
where UserID in (select top 1 UserID from ##Temp_HealthInterestDetail order by UserID desc);

update ##Temp_HealthInterestDetail SET
hashcode =  HASHBYTES ('sha1',
				    isNull(ThirdHealthAreaName,'-'))
where UserID in (select top 1 UserID from ##Temp_HealthInterestDetail order by UserID desc);

declare @iupdt as int = 0 ;
exec @iupdt = proc_CT_HealthInterestDetail_AddUpdatedRecs;

delete from ##Temp_HealthInterestDetail 
where UserID in (select top 1 UserID from ##Temp_HealthInterestDetail order by UserID) ;
declare @idels as int = 0 ;
exec @idels = proc_CT_HealthInterestDetail_AddDeletedRecs;

delete from DIM_EDW_HealthInterestDetail
where UserGUID in (select top 1 UserGUID from ##Temp_HealthInterestDetail order by UserGUID desc) ;
declare @inew as int = 0 ;
exec @inew = proc_CT_HealthInterestDetail_AddNewRecs;

print '**********************************************' ;
print '# of UPDATES: ' + cast( @iupdt as nvarchar(50));
print '# of INSERTS: ' + cast( @inew as nvarchar(50));
print '# of DELETES: ' + cast( @idels as nvarchar(50));
print '**********************************************' ;
