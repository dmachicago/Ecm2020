
declare @Action nvarchar(256) = 'ENABLE' ;
declare @TriggerStateDisabled char(1) = '' ;

SELECT @Action + ' TRIGGER dbo.' + sysobjects.name + ' ON dbo.' + OBJECT_NAME (parent_obj) + CHAR (10) + 'GO' , 
	   OBJECT_NAME (parent_obj) AS table_name , 
       sysobjects.name AS trigger_name , 
       USER_NAME (sysobjects.uid) AS trigger_owner , 
       s.name AS table_schema ,        
       OBJECTPROPERTY (id , 'ExecIsUpdateTrigger') AS isupdate , 
       OBJECTPROPERTY (id , 'ExecIsDeleteTrigger') AS isdelete , 
       OBJECTPROPERTY (id , 'ExecIsInsertTrigger') AS isinsert , 
       OBJECTPROPERTY (id , 'ExecIsAfterTrigger') AS isafter , 
       OBJECTPROPERTY (id , 'ExecIsInsteadOfTrigger') AS isinsteadof , 
       OBJECTPROPERTY (id , 'ExecIsTriggerDisabled') AS disabled
  FROM
       sysobjects
       INNER JOIN sysusers
       ON sysobjects.uid = sysusers.uid
       INNER JOIN sys.tables AS t
       ON sysobjects.parent_obj = t.object_id
       INNER JOIN sys.schemas AS s
       ON t.schema_id = s.schema_id
  WHERE sysobjects.type = 'TR'
    --AND OBJECTPROPERTY (id , 'ExecIsTriggerDisabled') = @TriggerStateDisabled
    AND sysobjects.name LIKE 'TRIG[_]DEL[_]%'
    OR sysobjects.name LIKE 'TRIG[_]UPDT[_]%'
order by OBJECT_NAME (parent_obj) , sysobjects.name
