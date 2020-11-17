

SELECT
	   'if exists ( select name from sys.tables where name = ''' + 'TEMPCOMPARE_' + TABLE_NAME + ''') BEGIN ' + CHAR (13) + CHAR (10) + ' DROP TABLE ' + 'TEMPCOMPARE_' + TABLE_NAME + CHAR (13) + CHAR (10) + ' END ;' + CHAR (13) + CHAR (10) + 'select * into TEMPCOMPARE_' + TABLE_NAME + ' FROM ' + TABLE_NAME + ';' + CHAR (13) + CHAR (10)  + CHAR (13) + CHAR (10) AS MySql
	   FROM information_schema.tables
	   WHERE table_name LIKE '%EDW%'
		 AND table_name NOT LIKE '%_CT'
		 AND table_name NOT LIKE '%_CT_%'
		 AND table_name NOT LIKE '%_EDW_EDW_%'
		 AND table_name NOT LIKE '%_STAGE%'
		 AND table_type = 'VIEW'
	   ORDER BY
				TABLE_NAME;
