USE [DataMartPlatform]
GO

/****** Object:  Table [dbo].[BASE_view_SIEBEL_ClinicalIndicators]    Script Date: 11/22/2016 2:14:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[STAGING_view_SIEBEL_ClinicalIndicators](
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
	FtpFileSource varchar(256) not null
	, HashCode nvarchR(100) null
) ON [PRIMARY]

GO
-- drop index UI_SIEBEL_ClinicalIndicators on STAGING_view_SIEBEL_ClinicalIndicators
create unique index UI_SIEBEL_ClinicalIndicators on 
STAGING_view_SIEBEL_ClinicalIndicators 
([ROW_ID], [MPI], [LAST_UPD],[HBA1C], [CHOLESTEROL], [MICROALBUMINDATE], [FOOTEXAMDATE], FtpFileSource)
go
create index PI_SIEBEL_ClinicalIndicators on 
STAGING_view_SIEBEL_ClinicalIndicators 
(HashCode, [ROW_ID], [MPI])
