

go
IF SUSER_ID('ECMLibrary') IS NULL
    CREATE LOGIN ECMLibrary WITH PASSWORD = 'ECMLibrary';
IF USER_ID('ECMLibrary') IS NULL
    CREATE USER ECMLibrary FOR LOGIN ECMLibrary;
go

IF SUSER_ID('ecmocr') IS NULL
    CREATE LOGIN ecmocr WITH PASSWORD = 'ecmocr';
IF USER_ID('ecmocr') IS NULL
    CREATE USER ecmocr FOR LOGIN ecmocr;
go

IF SUSER_ID('ecmuser') IS NULL
    CREATE LOGIN ecmuser WITH PASSWORD = 'ecmuser';
IF USER_ID('ecmuser') IS NULL
    CREATE USER ecmuser FOR LOGIN ecmuser;
GO

IF SUSER_ID('ecmadmin') IS NULL
    CREATE LOGIN ecmadmin WITH PASSWORD = 'ecmadmin';
IF USER_ID('ecmadmin') IS NULL
    CREATE USER ecmadmin FOR LOGIN ecmadmin;
GO


IF SUSER_ID('ecmsys') IS NULL
    CREATE LOGIN ecmsys WITH PASSWORD = 'ecmsys';
IF USER_ID('ecmsys') IS NULL
    CREATE USER ecmsys FOR LOGIN ecmsys;
GO

