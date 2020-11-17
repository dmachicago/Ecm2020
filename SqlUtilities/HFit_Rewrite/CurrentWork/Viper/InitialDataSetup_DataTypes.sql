/****** Script for SelectTopNRows command from SSMS  ******/
/*
truncate table ColumnTypes 
delete from ColumnTypes where ColumnTypeID = 2
delete from ColumnTypes where ColumnTypeID > 7
*/
USE [Viper]
GO

ALTER TABLE [dbo].[TableDefinitions] DROP CONSTRAINT [FK_TableDefinitions_ColumnType]
GO

truncate table [Viper].[dbo].[ColumnTypes] ;
go
-- SELECT TOP 1000 *   FROM [Viper].[dbo].[ColumnTypes]

Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('CHAR','CHAR','Maximum size of 8,000 characters. Where size is the number of characters to store. Fixed-length. Space padded on right to equal size characters. Non-Unicode data.')
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('VARCHAR','VARCHAR','Maximum size of 8,000 or max characters. Where size is the number of characters to store. Variable-length. If max is specified, the maximum number of characters is 2GB. Non-Unicode data.');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('TEXT','TEXT','Maximum size of 2GB. Variable-length. Non-Unicode data.');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('NCHAR','NCHAR', 'Maximum size of 4,000 characters. Fixed-length. Unicode data.');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('NVARCHAR','NVARCHAR','Maximum size of 4,000 or max characters. Where size is the number of characters to store. Variable-length. If max is specified, the maximum number of characters is 2GB. Non-Unicode data.');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('NTEXT','NTEXT','Maximum size of 1,073,741,823 bytes. Variable length. Unicode data.');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('BINARY','BINARY', 'Maximum size of 8,000 characters. Where size is the number of characters to store. Fixed-length. Space padded on right to equal size characters. Binary data.');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('VARBINARY','VARBINARY', 'Maximum size of 8,000 or max characters. Where size is the number of characters to store. Variable-length. If max is specified, the maximum number of characters is 2GB. Non-Binary data.');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('IMAGE','IMAGE','Maximum size of 2GB. Variable length . Binary data.');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('BIT','BIT','Integer that can be 0, 1, or NULL.');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('TINYINT','TINYINT','0 to 255');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('SMALLINT','SMALLINT','-32768 to 32767');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('INT','INT','-2,147,483,648 to 2,147,483,647');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('BIGINT','BIGINT', '-9,223,372,036,854,775,808 to 9,223,372,036,854,775,807');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('DECIMAL','DECIMAL','DECIMAL(m,d) - defaults to 18, if not specified. Where m is the total digits and d is the number of digits after the decimal.');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('DEC','DEC','DEC(m,d) - defaults to 18, if not specified - Where m is the total digits and d is the number of digits after the decimal.');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('NUMERIC','NUMERIC', 'NUMERIC (m,d) - defaults to 18, if not specified. Where m is the total digits and d is the number of digits after the decimal.');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('FLOAT','FLOAT', 'FLOAT(n) - Floating point number. Where n is the number of number of bits to store in scientific notation.');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('REAL','REAL', 'Equivalent to FLOAT(24)');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('SMALLMONEY','SMALLMONEY','- 214,748.3648 to 214,748.3647');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('MONEY','Money','-922,337,203,685,477.5808 to 922,337,203,685,477.5807');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('DATE','DATE', 'Values range from 0001-01-01 to 9999-12-31. : Displayed as YYYY-MM-DD');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('DATETIME','DATETIME', 'Date values range from 1753-01-01 00:00:00 to 9999-12-31 23:59:59. : Displayed as YYYY-MM-DD hh:mm:ss[.mmm]');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('DATETIME2','DATETIME2', 'Date values range from 0001-01-01 to 9999-12-31. Displayed as YYYY-MM-DD hh:mm:ss[.fractional seconds]');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('SMALLDATETIME','SMALLDATETIME','Date values range from 1900-01-01 to 2079-06-06. Displayed as YYYY-MM-DD hh:mm:ss and Time values range from 00:00:00 to 23:59:59.');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('TIME','TIME','Values range from 00:00:00.0000000 to 23:59:59.9999999 : Displayed as YYYY-MM-DD hh:mm:ss[.nnnnnnn]');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('DATETIMEOFFSET','DATETIMEOFFSET','Date values range from 0001-01-01 to 9999-12-31 Displayed as YYYY-MM-DD hh:mm:ss[.nnnnnnn] [{+|-}hh:mm] and Time values range from 00:00:00 to 23:59:59:9999999. Time zone offset range from -14:00 to +14:00.');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('Y/N','BIT','A single character limited to a Y or N that is boolean in its existance.');
go
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('UniqueID','UniqueIdentifier','The uniqueidentifier data type stores 16-byte binary values that operate as globally unique identifiers (GUIDs). A GUID is a unique binary number; no other computer in the world will generate a duplicate of that GUID value. The main use for a GUID is for assigning an identifier that must be unique in a network that has many computers at many sites.');
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('UniqueIdentifier','UniqueIdentifier','The uniqueidentifier data type stores 16-byte binary values that operate as globally unique identifiers (GUIDs). A GUID is a unique binary number; no other computer in the world will generate a duplicate of that GUID value. The main use for a GUID is for assigning an identifier that must be unique in a network that has many computers at many sites.');
go

Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('bfile','bfile','Maximum file size of 4GB.');
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('blob','blob','Store up to 4GB of binary data.');
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('clob','clob','Store up to 4GB of character data.');
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('nclob','nclob','Store up to 4GB of character text data.');
Insert into ColumnTypes (TypeDescription, DataType, DataTypeUse) values  ('PhoneNumber','nvarchar','Unicode text field representing a phone number - only digits and dashes allowed.');

go

ALTER TABLE [dbo].[TableDefinitions]  WITH CHECK ADD  CONSTRAINT [FK_TableDefinitions_ColumnType] FOREIGN KEY([ColumnTypeID])
REFERENCES [dbo].[ColumnTypes] ([ColumnTypeID])
GO

ALTER TABLE [dbo].[TableDefinitions] CHECK CONSTRAINT [FK_TableDefinitions_ColumnType]
GO

SELECT TOP 1000 *   FROM [Viper].[dbo].[ColumnTypes]

select TypeDescription, DataType FROM [dbo].[ColumnTypes] order by TypeDescription asc