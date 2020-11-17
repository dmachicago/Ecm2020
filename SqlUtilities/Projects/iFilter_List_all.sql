--exec sp_fulltext_service 'load_os_resources', 1"
--exec sp_fulltext_service 'verify_signature', 0"
Select document_type, path from sys.fulltext_document_types
Select * from sys.fulltext_document_types order by document_type
        