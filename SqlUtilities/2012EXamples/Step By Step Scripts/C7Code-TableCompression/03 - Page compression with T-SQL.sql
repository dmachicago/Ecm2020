USE AdventureWorks2012;
exec sp_estimate_data_compression_savings
	@schema_name = 'Production',
	@object_name = 'TransactionHistory',
	@index_id = 1,
	@partition_number = NULL,
	@data_compression = 'row'