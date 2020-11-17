
-- select * from FileProcessHistory
-- drop table FileProcessHistory
-- truncate table FileProcessHistory
CREATE TABLE FileProcessHistory (ProcessingID uniqueidentifier NOT NULL
                                                               DEFAULT NEWID () , 
                                 ProcessingIdent int IDENTITY (1 , 1) 
                                                     NOT NULL , 
                                 FileName nvarchar (250) NOT NULL , 
                                 FileCreateDate datetime NOT NULL , 
                                 FileLastModifiedDate datetime NOT NULL , 
                                 FileSize bigint NOT NULL , 
                                 ProcessDate datetime NOT NULL
                                                      DEFAULT GETDATE () , 
                                 ProcessActiveFLG bit NULL
                                                      DEFAULT 0 , 
                                 ProcessCompleteFLG bit NULL
                                                        DEFAULT 0 , 
                                 FileNotFoundFLG bit NULL
                                                     DEFAULT 0 , 
                                 RunID nvarchar (100) NULL) ;
GO
CREATE UNIQUE INDEX PKI_FileProcessHistory ON FileProcessHistory (FileName , FileCreateDate , FileLastModifiedDate , FileSize) ;
CREATE INDEX PI_FileProcessHistor_FileName ON FileProcessHistory (FileName , ProcessingID) ;