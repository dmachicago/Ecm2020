
SELECT 'Print ''' + table_name + '''' + CHAR (10) + 'exec proc_GenBaseTableFromView ' + '@DBNAME=[KenticoCMS_1] ' + ', @ViewName=''' + SUBSTRING (table_name , 6 , 999) + '''' + ', @Preview = ''no''' + CHAR (10) + ', @GenJobToExecute = 1' + CHAR (10) + ', @SkipIfExists = 0' + CHAR (10) + 'GO'
  FROM INFORMATION_SCHEMA.TABLES
  WHERE table_name LIKE 'BASE_view_%'
    AND table_name NOT LIKE '%_DEL'
    AND table_name NOT LIKE '%_hist'
    AND table_name NOT LIKE '%_pulldate'
UNION
SELECT 'Print ''' + table_name + '''' + CHAR (10) + 'exec proc_GenBaseTableFromView ' + '@DBNAME=[KenticoCMS_2] ' + ', @ViewName=''' + SUBSTRING (table_name , 6 , 999) + '''' + ', @Preview = ''no''' + CHAR (10) + ', @GenJobToExecute = 1' + CHAR (10) + ', @SkipIfExists = 0' + CHAR (10) + 'GO'
  FROM INFORMATION_SCHEMA.TABLES
  WHERE table_name LIKE 'BASE_view_%'
    AND table_name NOT LIKE '%_DEL'
    AND table_name NOT LIKE '%_hist'
    AND table_name NOT LIKE '%_pulldate'
UNION
SELECT 'Print ''' + table_name + '''' + CHAR (10) + 'exec proc_GenBaseTableFromView ' + '@DBNAME=[KenticoCMS_3] ' + ', @ViewName=''' + SUBSTRING (table_name , 6 , 999) + '''' + ', @Preview = ''no''' + CHAR (10) + ', @GenJobToExecute = 1' + CHAR (10) + ', @SkipIfExists = 0' + CHAR (10) + 'GO'
  FROM INFORMATION_SCHEMA.TABLES
  WHERE table_name LIKE 'BASE_view_%'
    AND table_name NOT LIKE '%_DEL'
    AND table_name NOT LIKE '%_hist'
    AND table_name NOT LIKE '%_pulldate';

