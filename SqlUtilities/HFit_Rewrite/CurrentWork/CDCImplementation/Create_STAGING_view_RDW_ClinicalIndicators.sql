USE [DataMartPlatform]
GO

/****** Object:  Table [dbo].[BASE_view_RDW_ClinicalIndicators]    Script Date: 11/22/2016 2:22:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[STAGING_view_RDW_ClinicalIndicators](
	[MeasureCode] [nvarchar](50) NULL,
	[EventDate] [datetime] NULL,
	[MPI] [int] NULL,
	[UPD_RT] [datetime] NULL,
	[SRC_FILE_DT] [datetime] NULL,
	[INS_DT] [datetime] NULL,
	FtpFileSource varchar(256) not null
	, HashCode nvarchR(100) null
) ON [PRIMARY]

GO

-- drop index UI_RDW_ClinicalIndicators on [BASE_view_RDW_ClinicalIndicators]

create unique index UI_RDW_ClinicalIndicators on [BASE_view_RDW_ClinicalIndicators]
([MPI], [MeasureCode], [UPD_RT], [EventDate], [SRC_FILE_DT], [INS_DT], FtpFileSource)
go
create index PI_RDW_ClinicalIndicators on [BASE_view_RDW_ClinicalIndicators]
(HashCode, [MPI], [MeasureCode])