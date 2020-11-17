USE [DataMartPlatform]
GO

/****** Object:  Table [dbo].[BASE_view_SIEBEL_ClinicalIndicators]    Script Date: 11/22/2016 2:54:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BASE_view_SIEBEL_ClinicalIndicators_DEL](
	[HBA1C] [datetime] NULL,
	[CHOLESTEROL] [datetime] NULL,
	[MICROALBUMINDATE] [datetime] NULL,
	[FOOTEXAMDATE] [datetime] NULL,
	[LST2WKSDEPRESSEDHOPELESS] [nvarchar](50) NULL,
	[LST2WKSINTERESTPLEASURE] [nvarchar](50) NULL,
	[LST2WKSNERVOUSANXIOUS] [nvarchar](50) NULL,
	[LST2WKSSTOPCONTROLLWORRY] [nvarchar](50) NULL,
	[AVERAGEPAINLEVEL] [int] NULL,
	[HEIGHT] [nvarchar](50) NULL,
	[WEIGHT] [int] NULL,
	[LAST_UPD] [datetime] NULL,
	[ROW_ID] [nvarchar](50) NULL,
	[MPI] [nvarchar](50) NULL,
	[CAREPLANCOMPLIANCE] [nvarchar](50) NULL,
	[FLUSHOTDATE] [datetime] NULL,
	[EYE_EXAM_DATE] [datetime] NULL,
	[SurrogateKey_view_SIEBEL_ClinicalIndicators] [int] NOT NULL,
	Action char(1) not null,
	ActionDate datetime default getdate()
	,FtpFileSource varchar(256)
	, HashCode nvarchar(100) null 
) ON [PRIMARY]

GO
create index PI_BASE_view_SIEBEL_ClinicalIndicators_DEL
on BASE_view_SIEBEL_ClinicalIndicators_DEL
(SurrogateKey_view_SIEBEL_ClinicalIndicators)
go
create index PI_BASE_view_SIEBEL_ClinicalIndicators_DEL_FTP
on BASE_view_SIEBEL_ClinicalIndicators_DEL
(FtpFileSource)
