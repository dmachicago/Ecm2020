

if exists (select 1 from sys.tables where name = 'FulltextSUpportedFileExtension')
	drop table FulltextSUpportedFileExtension
go

select document_type, version, manufacturer 
into FulltextSUpportedFileExtension
from sys.fulltext_document_types;

create index PI_FulltextSUpportedFileExtension on FulltextSUpportedFileExtension (document_type)