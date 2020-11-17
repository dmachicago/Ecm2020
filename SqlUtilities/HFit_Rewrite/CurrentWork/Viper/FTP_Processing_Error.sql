
--drop table FTP_Processing_Error
-- truncate table FTP_Processing_Error
-- select * from FTP_Processing_Error
GO
CREATE TABLE FTP_Processing_Error (RunID nvarchar (50) NOT NULL , 
							FileID int NOT NULL , 
                                   ClientID int NOT NULL , 
                                   RuleName nvarchar (50) NOT NULL , 
                                   ErrorColumn nvarchar (100) NULL , 
                                   ErrorMsg nvarchar (1000) NULL , 
                                   CreateDate datetime DEFAULT GETDATE () , 
                                   SeverityLevel int DEFAULT '0'
                                                     NOT NULL , 
                                   RowNumber bigint IDENTITY (1 , 1) 
                                                    NOT NULL) ;

CREATE UNIQUE clustered INDEX PKI_FTP_Processing_Error ON FTP_Processing_Error (RowNumber) ;
CREATE INDEX PI_FTP_Processing_RunID ON FTP_Processing_Error (RunID) ;

CREATE TABLE SeverityLevel (
-- Any SeverityLevel > 50 will be considerd a FATAL ERROR.
SeverityLevel int NOT NULL , 
SeverityLevelDesc nvarchar (max) NOT NULL) ;

CREATE UNIQUE CLUSTERED INDEX PKI_SeverityLevel ON SeverityLevel (SeverityLevel) ;

INSERT INTO SeverityLevel (SeverityLevel , 
                           SeverityLevelDesc) 
VALUES (0 , 
        'Row level, non-fatal err') ;
INSERT INTO SeverityLevel (SeverityLevel , 
                           SeverityLevelDesc) 
VALUES (1 , 
        'Column , Non-fatal err') ;
INSERT INTO SeverityLevel (SeverityLevel , 
                           SeverityLevelDesc) 
VALUES (88 , 
        'Column , Fatal err') ;
INSERT INTO SeverityLevel (SeverityLevel , 
                           SeverityLevelDesc) 
VALUES (99 , 
        'Global level, fatal err') ;