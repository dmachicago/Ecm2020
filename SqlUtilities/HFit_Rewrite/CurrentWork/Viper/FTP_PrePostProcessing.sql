USE [Viper]
GO

/****** Object:  Table [dbo].[FTP_Processing_Validation_Rules]    Script Date: 8/19/2016 1:39:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
drop table [FTP_PrePostProcessing_Functions]
go
CREATE TABLE [dbo].[FTP_PrePostProcessing_Functions](
	[ProcessName] [nvarchar](50) NOT NULL,
	[ProcessDesc] [nvarchar](4000) NOT NULL,
	[CreateDate] [datetime] NULL DEFAULT (getdate()),
	[RowNumber] [bigint] IDENTITY(1,1) NOT NULL,
	[ProcessErrMsg] [nvarchar](4000) NULL,
	[SeverityLevel] [int] NULL DEFAULT ((0)),
	[ParameterDefinition] [nvarchar](2000) NULL,
	[SupportsParameter] [bit] NULL,
	ProcessType nvarchar(4) not null --Allowed values POST or PRE or BOTH
 CONSTRAINT chk_ProcessType CHECK (ProcessType IN ('POST', 'PRE', 'BOTH'))
 CONSTRAINT [PK_FTP_PrePostProcessing_Functions] PRIMARY KEY NONCLUSTERED 
(
	[ProcessName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
drop table FTP_PrePostProcessing_Associations
go
create table FTP_PrePostProcessing_Associations
(
ClientID int not null,
FileID int not null,
[ProcessName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_File_PrePostProcessing_Associations] PRIMARY KEY NONCLUSTERED 
(
	ClientID, FileID, [ProcessName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
go
drop view view_FTP_PrePostProcessing_Associations
go
Create view view_FTP_PrePostProcessing_Associations
as
select 	P.[ProcessName] ,
	ProcessType ,
	[ProcessDesc] ,
	[CreateDate] ,
	[RowNumber] ,
	[ProcessErrMsg] ,
	[SeverityLevel] ,
	[ParameterDefinition] ,
	[SupportsParameter] ,
	ClientID, 
	FileID
from [FTP_PrePostProcessing_Functions] P
join FTP_PrePostProcessing_Associations A
on P.ProcessName = A.ProcessName
