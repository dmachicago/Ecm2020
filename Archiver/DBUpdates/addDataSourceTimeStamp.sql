if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where table_name = 'DataSource' and column_name = 'RecTimeStamp')
	ALTER TABLE DataSource ADD RecTimeStamp DATETIME NOT NULL DEFAULT GETDATE();

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where table_name = 'Email' and column_name = 'RecTimeStamp')
	ALTER TABLE Email ADD RecTimeStamp DATETIME NOT NULL DEFAULT GETDATE();

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where table_name = 'EmailAttachment' and column_name = 'RecTimeStamp')
	ALTER TABLE EmailAttachment ADD RecTimeStamp DATETIME NOT NULL DEFAULT GETDATE();
