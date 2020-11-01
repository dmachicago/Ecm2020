USE [ECM.Library.FS]
GO

SELECT object_name( object_id), is_enabled, property_list_id, stoplist_id FROM sys.fulltext_indexes  
    --where object_id = object_id('HumanResources.JobCandidate');   

