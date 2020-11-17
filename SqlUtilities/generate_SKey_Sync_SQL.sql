


declare @ParentTable nvarchar(254) = 'BASE_CMS_PageTemplate' ;
declare @ParentPK nvarchar(254) = 'PageTemplateID' ;
declare @ChildTable nvarchar(254) = 'BASE_CMS_Document' ;
declare @ChildPK nvarchar(254) = 'DocumentPageTemplateID' ;

go

/*
EXEC generate_SKey_Sync_SQL @ParentTable = 'BASE_CMS_PageTemplate'
,@ParentPK = 'PageTemplateID' 
,@ChildTable = 'BASE_CMS_Document' 
,@ChildPK = 'DocumentPageTemplateID' ;
*/
create procedure generate_SKey_Sync_SQL (@ParentTable nvarchar(254) , @ParentPK nvarchar(254) , @ChildTable nvarchar(254) , @ChildPK nvarchar(254) )
as
declare @MySql nvarchar(max) = '',
	   @SKeyName nvarchar(254) = 'SurrogateKey_' + substring(@ParentTable,6,9999) ;

set @MySql = '' ;
set @MySql = @MySql  + 'UPDATE ChildTable ' + char(10) ;
set @MySql = @MySql  + '    SET '+@SKeyName+' = ParentTable.'+@SKeyName + char(10) ;
set @MySql = @MySql  + 'FROM '+@ChildTable+' as ChildTable ' + char(10) ;
set @MySql = @MySql  + '    JOIN  ' + char(10) ;
set @MySql = @MySql  + '    '+@ParentTable+' as ParentTable   ' + char(10) ;
set @MySql = @MySql  + '    ON ChildTable.DBNAME =ParentTable.DBNAME  ' + char(10) ;
set @MySql = @MySql  + '       AND ChildTable.'+@ChildPK+' = ParentTable.'+@ParentPK + char(10) ;
set @MySql = @MySql  + 'where ChildTable.'+@SKeyName+' is null ' + char(10) ;
set @MySql = @MySql  + 'or (ChildTable.DBNAME =ParentTable.DBNAME  ' + char(10) ;
set @MySql = @MySql  + '    and ChildTable.'+@ChildPK+' != ParentTable.'+@ParentPK+')' + char(10) ;

print @MySql

set @MySql = '' ;
declare @iName nvarchar(254) = 'CI_' + @ChildTable + '_ ' + @ChildPK+ char(10) ;
set @MySql = @MySql  + 'if not exists (select name from sys.indexes where name = ''' + @iName + ''') ' + char(10) ;
set @MySql = @MySql  + 'begin ' + char(10) ;
set @MySql = @MySql  + '    CREATE NONCLUSTERED INDEX '+@iName+' ' + char(10) ;
set @MySql = @MySql  + '        ON [dbo].[BASE_CMS_Document] ([DocumentPageTemplateID],[DBNAME])' + char(10) ;
set @MySql = @MySql  + '        INCLUDE ([SurrogateKey_CMS_Document],[SurrogateKey_CMS_PageTemplate])' + char(10) ;
set @MySql = @MySql  + 'end' + char(10) ;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
