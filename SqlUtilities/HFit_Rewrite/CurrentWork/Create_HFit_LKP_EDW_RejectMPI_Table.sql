GO
print ('FROM Create_HFit_LKP_EDW_RejectMPI_Table.sql') ;
PRINT 'Creating table HFit_LKP_EDW_RejectMPI for CR47516';
GO

-- 01.02.2014 (WDM) added column HFUG.CloseReasonLKPID in order to satisfy Story #47923

IF EXISTS (SELECT name
			 FROM sys.tables
			 WHERE name = 'HFit_LKP_EDW_RejectMPI') 
	BEGIN
		PRINT 'Dropping table HFit_LKP_EDW_RejectMPI';
		DROP TABLE dbo.HFit_LKP_EDW_RejectMPI;
	END;
GO

CREATE TABLE dbo.HFit_LKP_EDW_RejectMPI (
	ItemID int IDENTITY (1, 1) NOT NULL, 
	RejectMPICode int NOT NULL,
	RejectUserGUID uniqueidentifier NULL, 
	ItemCreatedBy int NULL, 
	ItemCreatedWhen datetime2  (7) NULL, 
	ItemModifiedBy int NULL, 
	ItemModifiedWhen datetime2 (7) NULL, 
	ItemOrder int NULL, 
	ItemGUID uniqueidentifier NOT NULL, 
	CONSTRAINT PK_HFit_LKP_EDW_RejectMPI PRIMARY KEY CLUSTERED (ItemID) 
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
		ON [PRIMARY]) 
ON [PRIMARY];
GO
SET ANSI_PADDING OFF;
GO
ALTER TABLE dbo.HFit_LKP_EDW_RejectMPI
ADD CONSTRAINT DEFAULT_HFit_LKP_EDW_RejectMPI_ItemGUID DEFAULT newid() FOR ItemGUID;
GO

IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'PI_HFit_LKP_EDW_RejectMPI_MPI_GUID') 
	BEGIN
		PRINT 'Creating index [PI_HFit_LKP_EDW_RejectMPI_MPI_GUID]';
		CREATE UNIQUE NONCLUSTERED INDEX [PI_HFit_LKP_EDW_RejectMPI_MPI_GUID] ON [dbo].[HFit_LKP_EDW_RejectMPI]
			(
				[RejectMPICode] ASC,
				[RejectUserGUID] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	END;
GO

if exists (select name from sys.objects where name = 'proc_AddRejectMPI')
begin 
	DROP PROCEDURE proc_AddRejectMPI ;
END
go
PRINT 'CREATING proc_AddRejectMPI ';
go

create proc proc_AddRejectMPI  (@MpiToReject as int)
as 
BEGIN	
	INSERT INTO [dbo].[HFit_LKP_EDW_RejectMPI]
           (
				[RejectMPICode],ItemCreatedWhen, ItemModifiedWhen
           )
     VALUES
           (
				@MpiToReject, getdate(),getdate()
		   );
END
go
PRINT 'INSERTING ROW proc_AddRejectMPI ';
exec proc_AddRejectMPI -991100
GO
--select * from [HFit_LKP_EDW_RejectMPI]
--GO
PRINT 'CREATING proc_DelRejectMPI ';
go
if exists (select name from sys.objects where name = 'proc_DelRejectMPI')
begin 
	DROP PROCEDURE proc_DelRejectMPI ;
END
go

create proc proc_DelRejectMPI  (@MpiToReject as int)
as 
BEGIN	
	delete from [dbo].[HFit_LKP_EDW_RejectMPI] where RejectMPICode = @MpiToReject ;
END
go
PRINT 'DELETING ROW proc_DelRejectMPI ';
exec proc_DelRejectMPI -991100
GO
--select * from [HFit_LKP_EDW_RejectMPI]
--GO

PRINT 'CREATED PROC proc_AddRejectMPI';
PRINT 'CREATED PROC proc_DelRejectMPI';
PRINT 'CREATED table HFit_LKP_EDW_RejectMPI for CR47516 ';
GO
