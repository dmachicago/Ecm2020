
-- exec sp_FindTerms 'error' ;

alter procedure sp_FindTerms(@SearchWord NVARCHAR(100))
as 
begin

print '@SearchWord: ' + @SearchWord ;

DECLARE @SearchText NVARCHAR(2000)
SET @SearchText = ''

SELECT
   @SearchText = @SearchText + display_term + ' OR '
FROM
   sys.dm_fts_index_keywords ( DB_ID('TestXml'), object_id('dbo.Docs') )
WHERE
   display_term like '%error%';

SELECT @SearchText = LEFT (@SearchText, LEN(@SearchText) - 4);
print @SearchText;

select * from Docs 
where contains(*,@SearchText);

end
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
