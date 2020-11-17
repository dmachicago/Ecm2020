
CREATE TABLE [dbo].[FileProcessControlFlow](
	[RunID] [uniqueidentifier] NOT NULL,
	[FileState] [char](1) NOT NULL,
	[FileName] [nvarchar](250) NOT NULL,
	[FileID] [int] NULL,
	[ClientID] [int] NULL,
	[RunStartDate] [datetime] NOT NULL,
	[RunEndDate] [datetime] NOT NULL,
	[FileSize] [bigint] NULL,
	[NumberOfRowsInFile] [int] NULL,
	[MPIProcessActiveFLG] [bit] NULL,
	[MPIProcessCompleteFLG] [bit] NULL,
	[MPIStartDate] [datetime] NULL,
	[MPIEndDate] [datetime] NULL,
	[MPIElapsedTimeSecs] [bigint] NULL,
	[NbrGoodMpi] [int] NULL,
	[NbrBadMpi] [int] NULL,
	[ValidationProcessActiveFLG] [bit] NULL,
	[ValidationProcessCompleteFLG] [bit] NULL,
	[ValidationStartDate] [datetime] NULL,
	[ValidationEndDate] [datetime] NULL,
	[ValidationElapsedTimeSecs] [bigint] NULL,
	[NbrGoodValidations] [int] NULL,
	[NbrBadValidations] [int] NULL,
	[ErrorLoadProcessActiveFLG] [bit] NULL,
	[ErrorLoadProcessCompleteFLG] [bit] NULL,
	[ErrorLoadStartDate] [datetime] NULL,
	[ErrorLoadEndDate] [datetime] NULL,
	[ErrorLoadElapsedTimeSecs] [bigint] NULL,
	[NbrErrorsLoaded] [int] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
go
create unique index PI_RunID on [FileProcessControlFlow] ([RunID]) ;
GO

SET ANSI_PADDING OFF
GO

--Level 0: sysname with a default of NULL - Schema,,FILEGROUP, USER
--Level 1: Valid inputs are AGGREGATE, DEFAULT, FUNCTION, LOGICAL FILE NAME, PROCEDURE, QUEUE, RULE, SYNONYM, TABLE, TABLE_TYPE, TYPE, VIEW, XML SCHEMA COLLECTION, and NULL.
EXEC sp_addextendedproperty 
@name = N'Purpose', 
@value = 'Track the current state of an FTP file as it flows thru the system.',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'FileProcessControlFlow'
GO

--Level 2: COLUMN, CONSTRAINT, EVENT NOTIFICATION, INDEX, PARAMETER, TRIGGER, and NULL.
EXEC sp_addextendedproperty  
@name = N'Purpose', 
@value = 'The same RuleID used in FileProcessHistory. It is assigned and tracked by filename and createdate',
@level0type = N'Schema', @level0name = dbo, 
@level1type = N'Table',  @level1name = [FileProcessControlFlow], 
@level2type = N'Column', @level2name = [RunID];

EXEC sp_addextendedproperty  
@name = N'Purpose', @value = 'R=Registered, C=Completed, P=Pending, M=MPI processing active, V=Validation processing active, E=Error Load processing active, ',
@level0type = N'Schema', @level0name = dbo, 
@level1type = N'Table',  @level1name = [FileProcessControlFlow], 
@level2type = N'Column', @level2name = [FileState];

