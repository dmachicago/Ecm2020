
declare @tbl as nvarchar(100) = 'HFit_HealthAssesmentUserStarted' ;
declare @mysql as nvarchar(100) = 'SELECT * FROM CHANGETABLE (CHANGES '+@tbl+' , NULL) AS [CT]';
exec (@mysql);

