

go
print 'Executing proc_DisableAllTableTriggers.sql'
go
if exists (select name from sys.procedures where name = 'proc_DisableAllTableTriggers')
    drop procedure proc_DisableAllTableTriggers ;
go

-- exec proc_DisableAllTableTriggers 'BASE_HFit_Coaches' ;
create procedure proc_DisableAllTableTriggers (@TblName nvarchar(250) )
as
declare @CMD nvarchar(max) = '' ;
SELECT @CMD = @CMD + 'DISABLE TRIGGER dbo.' + sysobjects.name + ' ON dbo.' + OBJECT_NAME (parent_obj) + ';' + CHAR (10)
       --sysobjects.name AS trigger_name , 
       --USER_NAME (sysobjects.uid) AS trigger_owner , 
       --s.name AS table_schema , 
       --OBJECT_NAME (parent_obj) AS table_name , 
       --OBJECTPROPERTY (id , 'ExecIsUpdateTrigger') AS isupdate , 
       --OBJECTPROPERTY (id , 'ExecIsDeleteTrigger') AS isdelete , 
       --OBJECTPROPERTY (id , 'ExecIsInsertTrigger') AS isinsert , 
       --OBJECTPROPERTY (id , 'ExecIsAfterTrigger') AS isafter , 
       --OBJECTPROPERTY (id , 'ExecIsInsteadOfTrigger') AS isinsteadof , 
       --OBJECTPROPERTY (id , 'ExecIsTriggerDisabled') AS disabled
  FROM
       sysobjects
       INNER JOIN sysusers
       ON sysobjects.uid = sysusers.uid
       INNER JOIN sys.tables AS t
       ON sysobjects.parent_obj = t.object_id
       INNER JOIN sys.schemas AS s
       ON t.schema_id = s.schema_id
  WHERE sysobjects.type = 'TR'
    and OBJECT_NAME (parent_obj) = @TblName
    AND OBJECTPROPERTY (id , 'ExecIsTriggerDisabled') = 0
    --AND sysobjects.name LIKE 'TRIG[_]INS[_]%'
order by OBJECT_NAME (parent_obj) , sysobjects.name ;

print @CMD
exec (@CMD) ;

go
print 'Executed proc_DisableAllTableTriggers.sql'
go
