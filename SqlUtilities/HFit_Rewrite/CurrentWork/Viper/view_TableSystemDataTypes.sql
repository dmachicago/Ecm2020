

-- select * from view_TableSystemDataTypes
create view view_TableSystemDataTypes
as
select column_name, ordinal_position
, Data_Type =
    CASE 
		  WHEN data_type = 'bigint' THEN 'System.Int64'
		  WHEN data_type = 'binary' THEN 'System.Byte[]'
		  WHEN data_type = 'bit' THEN 'System.Boolean'
		  WHEN data_type = 'char' THEN 'System.String'
		  WHEN data_type = 'date' THEN 'System.DateTime'
		  WHEN data_type = 'datetime' THEN 'System.DateTime'
		  WHEN data_type = 'datetime2' THEN 'System.DateTime'
		  WHEN data_type = 'datetimeoffset' THEN 'System.DateTimeOffset'
		  WHEN data_type = 'decimal' THEN 'System.Decimal'
		  WHEN data_type = 'float' THEN 'System.Double'
		  WHEN data_type = 'image' THEN 'System.Byte[]'
		  WHEN data_type = 'int' THEN 'System.Int32'
		  WHEN data_type = 'money' THEN 'System.Decimal'
		  WHEN data_type = 'nchar' THEN 'System.String'
		  WHEN data_type = 'ntext' THEN 'System.String'
		  WHEN data_type = 'numeric' THEN 'System.Decimal'
		  WHEN data_type = 'nvarchar' THEN 'System.String'
		  WHEN data_type = 'real' THEN 'System.Single'
		  WHEN data_type = 'rowversion' THEN 'System.Byte[]'
		  WHEN data_type = 'smalldatetime' THEN 'System.DateTime'
		  WHEN data_type = 'smallint' THEN 'System.Int16'
		  WHEN data_type = 'smallmoney' THEN 'System.Decimal'
		  WHEN data_type = 'time' THEN 'System.TimeSpan'
		  WHEN data_type = 'timestamp' THEN 'System.Byte[]'
		  WHEN data_type = 'tinyint' THEN 'System.Byte'
		  WHEN data_type = 'uniqueidentifier' THEN 'System.Guid'
		  WHEN data_type = 'varbinary' THEN 'System.Byte[]'
		  WHEN data_type = 'varchar' THEN 'System.String'
		  WHEN data_type = 'xml' THEN 'System.Xml'
		  ELSE 'System.String'
    END
, character_maximum_length
from information_schema.columns where table_name = 'Eligibility' and TABLE_SCHEMA = 'dbo'

