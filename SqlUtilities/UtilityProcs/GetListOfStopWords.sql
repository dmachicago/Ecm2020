select * from sys.fulltext_stopwords 

truncate table Skiptoken

select * from Skiptoken

insert into Skiptoken
select DISTINCT stopword from sys.fulltext_system_stopwords where language_id = 1033

