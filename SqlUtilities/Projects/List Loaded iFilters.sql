
exec sp_fulltext_service 'load_os_resources', 1
go
exec sp_fulltext_service 'verify_signature', 0;
go
select document_type, path from sys.fulltext_document_types
go