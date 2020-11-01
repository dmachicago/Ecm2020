EXEC sp_help_fulltext_system_components 'filter'; 

EXEC sp_fulltext_service 'load_os_resources', 1;
EXEC sp_fulltext_service 'verify_signature', 0;
exec sp_fulltext_service 'update_languages';   
EXEC sp_fulltext_service 'restart_all_fdhosts';
