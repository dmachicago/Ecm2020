
USE [DMA.UD.License]

IF NOT EXISTS 
    (SELECT name  
     FROM master.sys.server_principals
     WHERE name = 'ecmuser')
BEGIN
    CREATE LOGIN [LoginName] WITH PASSWORD = N'EcmPW@01'
END

ALTER LOGIN ecmuser WITH PASSWORD = 'EcmPW@01' ;
ALTER LOGIN ecmuser ENABLE;
