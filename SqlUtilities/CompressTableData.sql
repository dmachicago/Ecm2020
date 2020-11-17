Use KenticoCMS_Prod1
GO
EXEC sp_estimate_data_compression_savings 'dbo', 'STAGING_EDW_HealthAssessment', NULL, NULL, 'ROW' ;
EXEC sp_estimate_data_compression_savings 'dbo', 'TEMP_Staging_EDW_HealthAssessment_DATA', NULL, NULL, 'ROW' ;
EXEC sp_estimate_data_compression_savings 'dbo', 'STAGING_EDW_CoachingDetail', NULL, NULL, 'ROW' ;


ALTER TABLE dbo.STAGING_EDW_HealthAssessment REBUILD PARTITION = ALL
WITH (DATA_COMPRESSION = ROW); 
GO

ALTER TABLE dbo.TEMP_Staging_EDW_HealthAssessment_DATA REBUILD PARTITION = ALL
WITH (DATA_COMPRESSION = ROW); 
GO

ALTER TABLE dbo.STAGING_EDW_CoachingDetail REBUILD PARTITION = ALL
WITH (DATA_COMPRESSION = ROW); 
GO


/*************************************************************************************************************
The example first queries the sys.indexes catalog view to return the name and index_id for each 
index on the Production.TransactionHistory table. It then executes the the stored procedure 
sp_estimate_data_compression_savings to return the estimated size of the specified index ID if it 
were to use the PAGE compression setting. Finally, the example rebuilds index ID 2 
(IX_TransactionHistory_ProductID), specifying PAGE compression.
*************************************************************************************************************/
--drop index PI_Staging_EDW_HealthAssessment_IDs on STAGING_EDW_HealthAssessment
SELECT name, index_id
FROM sys.indexes
WHERE OBJECT_NAME (object_id) = N'STAGING_EDW_HealthAssessment';

EXEC sp_estimate_data_compression_savings 
    @schema_name = 'dbo', 
    @object_name = 'STAGING_EDW_HealthAssessment',
    @index_id = 2, 
    @partition_number = NULL, 
    @data_compression = 'PAGE' ; 

--ALTER INDEX IX_TransactionHistory_ProductID ON dbo.STAGING_EDW_HealthAssessment REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = PAGE);
GO

--*********************************
ALTER TABLE dbo.STAGING_EDW_HealthAssessment REBUILD PARTITION = ALL
WITH (DATA_COMPRESSION = NONE);
GO
ALTER TABLE dbo.TEMP_Staging_EDW_HealthAssessment_DATA REBUILD PARTITION = ALL
WITH (DATA_COMPRESSION = NONE);
GO

--ALTER INDEX AK_Person_rowguid ON dbo.STAGING_EDW_HealthAssessment REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = NONE);
--GO

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
