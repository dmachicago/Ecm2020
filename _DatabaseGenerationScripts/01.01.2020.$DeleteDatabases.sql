USE master;
GO

IF DB_ID (N'TDR') IS NULL
DROP DATABASE [TDR];
GO

IF DB_ID (N'EcmGateway') IS NULL
DROP DATABASE [EcmGateway];
GO

IF DB_ID (N'ECM.Init') IS NULL
DROP DATABASE [ECM.Init];
GO

IF DB_ID (N'DMA.UD.License') IS NULL
DROP DATABASE [DMA.UD.License];
GO

IF DB_ID (N'ECM.Library.FS') IS NULL
DROP DATABASE [ECM.Library.FS];
GO

IF DB_ID (N'ECM.SecureLogin') IS NULL
DROP DATABASE [ECM.SecureLogin];
GO

IF DB_ID (N'ECM.Thesaurus') IS NULL
DROP DATABASE [ECM.Thesaurus]
GO

IF DB_ID (N'ECM.Admin') IS NULL
DROP DATABASE [ECM.Admin]
GO

IF DB_ID (N'ECM.Hive') IS NULL
DROP DATABASE [ECM.Hive]
GO

IF DB_ID (N'ECM.Language') IS NULL
DROP DATABASE [ECM.Language];
GO

IF DB_ID (N'ECM.Admin') IS NULL
DROP DATABASE [ECM.Admin];
GO

exec sp_PrintImmediate 'Databases Removed / Deleted ... ' ;
go


