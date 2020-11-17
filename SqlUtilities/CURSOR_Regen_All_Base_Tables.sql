--exec proc_genPullChangesProc 'KenticoCMS_1', 'BASE_HFit_TrackerTests', @DeBug=0, @GenProcOnlyDoNotPullData=1
--exec proc_genPullChangesProc 'KenticoCMS_2', 'BASE_HFit_TrackerTests', @DeBug=0, @GenProcOnlyDoNotPullData=1
--exec proc_genPullChangesProc 'KenticoCMS_3', 'BASE_HFit_TrackerTests', @DeBug=0, @GenProcOnlyDoNotPullData=1


declare @MySql as nvarchar(max) = '' ;
declare @cols as nvarchar(max) = '' ;
declare @DBNAME as nvarchar(250) = 'KenticoCMS_2' ;
declare @TBL as nvarchar(250) = '' ;
declare @T as table (stmt nvarchar(max) null) ;

declare C cursor for
    SELECT table_NAME
	   FROM INFORMATION_SCHEMA.tables
	   WHERE table_name like 'BASE%'
	   and table_name not like '%[_]DEL'
	   and table_name not like '%[_]CTVerHIST'
	   and table_name not like '%[_]testdata'
	   and table_name not like '%[_]view[_]%'
    OPEN C;

    FETCH NEXT FROM C INTO @TBL ;

 WHILE
           @@FETCH_STATUS = 0
       begin
	  
	   SET @TBL = SUBSTRING(@TBL,6,9999) ;
	   --SET @MySql = 'exec proc_genPullChangesProc ''KenticoCMS_1'', '''+@TBL+''', @DeBug=0, @GenProcOnlyDoNotPullData=1 ' + char(10) + 'GO' ;
	   --insert into @T (stmt) values (@MySQl) ;
	   --SET @MySql = 'exec proc_genPullChangesProc ''KenticoCMS_2'', '''+@TBL+''', @DeBug=0, @GenProcOnlyDoNotPullData=1 ' + char(10) + 'GO' ;
	   --insert into @T (stmt) values (@MySQl) ;
	   --SET @MySql = 'exec proc_genPullChangesProc ''KenticoCMS_3'', '''+@TBL+''', @DeBug=0, @GenProcOnlyDoNotPullData=1 ' + char(10) + 'GO' ;
	   --insert into @T (stmt) values (@MySQl) ;	   
	   SET @MySql = 'exec regen_CT_Triggers '''+@TBL+''';' + char(10) + 'GO' ;
	   insert into @T (stmt) values (@MySQl) ;
		  exec PrintImmediate @MySql
		  --exec @TBL ;
		  FETCH NEXT FROM C INTO @TBL ;
        END

close C;
deallocate C; 

select * from @T ;

go


declare @MySql as nvarchar(max) = '' ;
declare @cols as nvarchar(max) = '' ;
declare @DBNAME as nvarchar(250) = 'KenticoCMS_2' ;
declare @TBL as nvarchar(250) = '' ;
declare @T as table (stmt nvarchar(max) null) ;

declare C cursor for
    SELECT table_NAME
	   FROM INFORMATION_SCHEMA.tables
	   WHERE table_name like 'BASE_view%'
	   	   and table_name not like '%[_]DEL'
	   and table_name not like '%[_]CTVerHIST'
	   order by table_name
    OPEN C;

    FETCH NEXT FROM C INTO @TBL ;

 WHILE
           @@FETCH_STATUS = 0
       begin
	  
	   SET @TBL = SUBSTRING(@TBL,6,9999) ;
	   --SET @MySql = 'exec proc_genPullChangesProc ''KenticoCMS_1'', '''+@TBL+''', @DeBug=0, @GenProcOnlyDoNotPullData=1 ' + char(10) + 'GO' ;
	   --insert into @T (stmt) values (@MySQl) ;
	   --SET @MySql = 'exec proc_genPullChangesProc ''KenticoCMS_2'', '''+@TBL+''', @DeBug=0, @GenProcOnlyDoNotPullData=1 ' + char(10) + 'GO' ;
	   --insert into @T (stmt) values (@MySQl) ;
	   --SET @MySql = 'exec proc_genPullChangesProc ''KenticoCMS_3'', '''+@TBL+''', @DeBug=0, @GenProcOnlyDoNotPullData=1 ' + char(10) + 'GO' ;
	   --insert into @T (stmt) values (@MySQl) ;	   
	   SET @MySql = 'exec regen_CT_Triggers '''+@TBL+''';' + char(10) + 'GO' ;
	   insert into @T (stmt) values (@MySQl) ;
		  exec PrintImmediate @MySql
		  --exec @TBL ;
		  FETCH NEXT FROM C INTO @TBL ;
        END

close C;
deallocate C; 

select * from @T ;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
