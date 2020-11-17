
DECLARE
      @MySql AS nvarchar (max) = '',
      @cols AS nvarchar (max) = '',
      @DBNAME AS nvarchar (250) = 'KenticoCMS_2',
      @TBL AS nvarchar (250) = '';
DECLARE
      @T AS TABLE (stmt nvarchar (max) NULL) ;

DECLARE C CURSOR
    FOR SELECT DISTINCT table_NAME
          FROM INFORMATION_SCHEMA.tables
          WHERE table_name LIKE 'BASE[_]VIEW%'
            AND table_name NOT LIKE '%[_]DEL'
            AND table_name NOT LIKE '%[_]testdata'
		  AND table_name NOT LIKE '%EventLog%'
		  AND table_name NOT LIKE '%view_EDW_HAassessment%'		  
		  AND table_name NOT LIKE '%View_EDW_HealthAssesmentQuestions_HA_LastPullDate%'
		  AND table_name NOT LIKE '%View_HFit_Coach_Bio_HISTORY%'
		  AND table_name NOT LIKE '%View_Hierarchy%'
		  AND table_name NOT LIKE 'view_EDW_CoachingPPT'
		  AND table_name NOT LIKE 'View_HFit_RewardParameter_Joined'
		  AND table_name NOT LIKE '%[_]CTVerHIST' ;

OPEN C;

FETCH NEXT FROM C INTO @TBL;

WHILE @@FETCH_STATUS = 0
    BEGIN
	   SET @MySql = 'exec PrintImmediate ''Processing ' + substring(@TBL,6,999) +''';' ;
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
        
	   SET @MySql = 'exec proc_GenBaseTableFromView ''KenticoCMS_1'', '''+substring(@TBL,6,999)+''', ''no'', @GenJobToExecute = 0, @SkipIfExists = 1 ' ; 
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
	   INSERT INTO @T (stmt) VALUES ('GO') ;

	   SET @MySql = 'exec proc_GenBaseTableFromView ''KenticoCMS_2'', '''+substring(@TBL,6,999)+''', ''no'', @GenJobToExecute = 0, @SkipIfExists = 1 ' ; 
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
	   INSERT INTO @T (stmt) VALUES ('GO') ;

	   SET @MySql = 'exec proc_GenBaseTableFromView ''KenticoCMS_3'', '''+substring(@TBL,6,999)+''', ''no'', @GenJobToExecute = 0, @SkipIfExists = 1 ' ; 
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
	   INSERT INTO @T (stmt) VALUES ('GO') ;

        FETCH NEXT FROM C INTO @TBL;
    END;

CLOSE C;
DEALLOCATE C; 

SELECT * FROM @T;

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
