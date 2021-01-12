declare @i integer
declare @cnt integer
set @i=0
while @i < 255
begin
  set @cnt=0
  select @cnt=COUNT(1) FROM sys.dm_fts_parser ('"word1'+CHAR(@i)+'word2"', 1033, 0, 0)
  if @cnt > 1
  begin
    print 'this char - '+char(@i)+' - char('+convert(varchar(3),@i)+') is a word breaker'
  end
  set @i=@i+1
end
print 'char 34 is a double quote and errors out... but it is a word break too.';


go

-- Display ALL characters that CANNOT be used in search strings
declare @i integer = 0 ;
declare @tc integer = 0 ;
declare @tword nvarchar(100) = '';

while @i < 255	
begin
	set @tword = 'ecm' + char(@i) + 'library' ;
	BEGIN TRY  
		set @tc = (SELECT count(*) 
		FROM DataSource 
		WHERE  CONTAINS(DataSource.*, @tword));
	END TRY  
	BEGIN CATCH  
		 print 'Char > '+char(@i)+' < char('+convert(varchar(3),@i)+') cannot be contained within a search as it is a word breaker.';
	END CATCH  

	set @i = @i + 1;
end ;