use KenticoCMS_Datamart_2
go

--NOTE: Depending upon what is wanted, use either the ENABLE or DISABLE commands as needed.


insert into MIGRATE_DataMart_Commands
SELECT
    'DISABLE TRIGGER dbo.'+sysobjects.name+' ON dbo.'+OBJECT_NAME(parent_obj)+ char(10) + 'GO' as DisableTriggersCMD
--    'ENABLE TRIGGER dbo.'+sysobjects.name+' ON dbo.'+OBJECT_NAME(parent_obj)+ char(10) + 'GO' as EnableTriggersCMD
FROM sysobjects 
INNER JOIN sysusers 
    ON sysobjects.uid = sysusers.uid 
INNER JOIN sys.tables t 
    ON sysobjects.parent_obj = t.object_id 
INNER JOIN sys.schemas s 
    ON t.schema_id = s.schema_id 
WHERE sysobjects.type = 'TR' 
and OBJECT_NAME(parent_obj) like 'BASE_%'
 or OBJECT_NAME(parent_obj) like 'FACT_%'


insert into MIGRATE_DataMart_Commands
SELECT
--    'DISABLE TRIGGER dbo.'+sysobjects.name+' ON dbo.'+OBJECT_NAME(parent_obj)+ char(10) + 'GO' as DisableTriggersCMD
    'ENABLE TRIGGER dbo.'+sysobjects.name+' ON dbo.'+OBJECT_NAME(parent_obj)+ char(10) + 'GO' as EnableTriggersCMD
FROM sysobjects 
INNER JOIN sysusers 
    ON sysobjects.uid = sysusers.uid 
INNER JOIN sys.tables t 
    ON sysobjects.parent_obj = t.object_id 
INNER JOIN sys.schemas s 
    ON t.schema_id = s.schema_id 
WHERE sysobjects.type = 'TR' 
and OBJECT_NAME(parent_obj) like 'BASE_%'
 or OBJECT_NAME(parent_obj) like 'FACT_%'


