
/*
delete from DataSource where OriginalFileType = '.zip';
delete from DataSource where ParentGuid is not null
*/

-- delete from DataSource where SourceGuid= 'a6ed898a-42bd-4149-8315-236488c5fa14'
-- declare @G nvarchar(50) = '718ac9b0-8dba-45b0-a6cd-ad61b70b04fb';

declare @G nvarchar(50) = 'caf573f6-b38e-4b66-852a-c58357d2662c';
select ParentGuid, * from DataSource where SourceGuid = @G;
select * from DataSource where ParentGuid = @G;

/* Get each zip file contained in the ECM Repository*/
select SourceName, ZipExploded, SourceGuid, [ZipExploded] from DataSource where OriginalFileType = '.zip' or OriginalFileType = '.rar';

/* Get the count of files contained within each zip file*/
select DSP.FileDirectory, DSP.SourceName, count(*) as MemberCount
from DataSource DSP
join DataSOurce DSC
on DSP.SourceGuid = DSC.ParentGuid
group by DSP.FileDirectory,DSP.SourceName;

/* Get the details of each file contained within each zip file*/
select dsp.SourceName as Parent, dsc.SourceName as Child, dsp.SourceGuid as ParentSourceGuid, dsc.SourceGuid as ChildSourceGuid
from DataSource DSP
join DataSOurce DSC
on DSP.SourceGuid = DSC.ParentGuid
order by dsp.SourceName


/* Verify the ZipExploded flag is set */
select count(*) from DataSource where ZipExploded = 'Y';

/* Set all ZipExploded flags to true where the ZIP's Children are in the repository */
update datasource set ZipExploded = 'Y' 
where SourceGuid in (
select distinct dsp.SourceGuid 
from DataSource DSP
join DataSOurce DSC
on DSP.SourceGuid = DSC.ParentGuid
) 
AND ZipExploded is null;

/* Count ALL orphan zip file children */
select count(*)from DataSOurce 
where ParentGuid is not null and ParentGuid <> '' and ParentGuid <> 'NA' 
and ParentGuid not in (Select SourceGuid from DataSource) ;

/***************************************************************************/
/* Delete ALL orphan zip file children */
delete from DataSource where ParentGuid != '' and ParentGuid != 'NA'  ;

/* Delete ALL zip files */
Delete from DataSOurce where OriginalFileType = '.zip'
/***************************************************************************/

/* Find ALL orphaned zip file children */
select SourceName, SourceguID from DataSource 
where ParentGuid is not null and ParentGuid <> '' and ParentGuid <> 'NA' 
and ParentGuid not in (Select SourceGuid from DataSource) ;
