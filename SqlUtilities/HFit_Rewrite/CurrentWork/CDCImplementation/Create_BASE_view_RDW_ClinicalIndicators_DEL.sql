USE [DataMartPlatform]
GO

/****** Object:  Table [dbo].[BASE_view_RDW_ClinicalIndicators]    Script Date: 11/22/2016 2:39:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BASE_view_RDW_ClinicalIndicators_DEL](
	[MeasureCode] [nvarchar](50) NULL,
	[EventDate] [datetime] NULL,
	[MPI] [int] NULL,
	[UPD_RT] [datetime] NULL,
	[SRC_FILE_DT] [datetime] NULL,
	[INS_DT] [datetime] NULL,
	[SurrogateKey_view_RDW_ClinicalIndicators] [int] IDENTITY(1,1) NOT NULL,
	Action char(1) not null,
	ActionDate datetime default getdate(),
	FtpFileSource varchar(256) not null
	, HashCode nvarchar(100) null
) 
create index PI_SurrogateKey_view_RDW_ClinicalIndicators 
on [BASE_view_RDW_ClinicalIndicators_DEL]
([SurrogateKey_view_RDW_ClinicalIndicators]) ;
GO
create index PI_SurrogateKey_view_RDW_ClinicalIndicators_FQN
on [BASE_view_RDW_ClinicalIndicators_DEL]
(FtpFileSource) ;
GO




