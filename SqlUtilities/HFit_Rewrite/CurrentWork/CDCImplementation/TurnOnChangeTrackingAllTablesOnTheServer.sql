
select KT.name
FROM
               KenticoCMS_1.sys.change_tracking_tables AS KCT
               JOIN KenticoCMS_1.sys.tables AS KT
               ON KT.object_id = KCT.object_id
               JOIN KenticoCMS_1.sys.schemas AS KS
               ON KS.schema_id = KT.schema_id
          WHERE KT.name NOT LIKE '%eventlog%'
		and KT.name NOT LIKE 'sysdiagrams'
		and KT.name NOT LIKE 'TBL_DIFF%'
		and KT.name NOT LIKE 'TMP_%'
		order by KT.name;
go


        SELECT 'if not exists (' + CHAR (10) + 'select T.name ' + CHAR (10) + 'from KenticoCMS_1.sys.change_tracking_tables CT' + CHAR (10) + 'join KenticoCMS_1.sys.tables T on T.object_id = CT.object_id ' + CHAR (10) + 'join KenticoCMS_1.sys.schemas S on S.schema_id = T.schema_id ' + CHAR (10) + 'where T.name = ''' + KT.name + ''' ' + CHAR (10) + ') ' + CHAR (10) + '    ALTER TABLE KenticoCMS_1.dbo.' + KT.name + ' ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON)' 	   
	   + CHAR (10) + 'GO'
          FROM
               KenticoCMS_1.sys.change_tracking_tables AS KCT
               JOIN KenticoCMS_1.sys.tables AS KT
               ON KT.object_id = KCT.object_id
               JOIN KenticoCMS_1.sys.schemas AS KS
               ON KS.schema_id = KT.schema_id
          WHERE KT.name NOT LIKE '%eventlog%'
		and KT.name NOT LIKE 'sysdiagrams'
		and KT.name NOT LIKE 'TBL_DIFF%'
		and KT.name NOT LIKE 'TMP_%'
		order by KT.name;