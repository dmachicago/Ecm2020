select name,lcid from sys.fulltext_languages order by name

select * from sys.syslanguages 

select name, alias, langid from sys.syslanguages order by name

EXEC sys.sp_fulltext_load_thesaurus_file 0

Select * FROM 
sys.dm_fts_parser ('FORMSOF( THESAURUS, "IE CR dale run xenon")', 0, 0, 0) 
order by display_term