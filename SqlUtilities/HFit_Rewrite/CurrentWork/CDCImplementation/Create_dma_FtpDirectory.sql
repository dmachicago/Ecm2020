
USE [DataMartPlatform]
GO

/****** Object:  Table [dbo].[dma_FtpDirectory]    Script Date: 11/25/2016 7:38:09 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
drop TABLE [dbo].[dma_FtpDirectory] ;
go
CREATE TABLE [dbo].[dma_FtpDirectory](
	[PickupLocation] [nvarchar](500) NOT NULL,
	[FileMask] [nvarchar](250) NOT NULL
) ON [PRIMARY]

GO

  truncate table  [DataMartPlatform].[dbo].[dma_FtpDirectory] ;
  insert into  [DataMartPlatform].[dbo].[dma_FtpDirectory] 
  ([PickupLocation], [FileMask]) values
  ('Z:\ImportFiles\ClinicalIndicators_Import', 'RDW_CLINICALINDICATORS') ;

  insert into  [DataMartPlatform].[dbo].[dma_FtpDirectory]
  ([PickupLocation], [FileMask]) values
  ('Z:\ImportFiles\ClinicalIndicators_Import', 'SIEBEL_CLINICALINDICATORS') ;

go
USE [DataMartPlatform]
GO

SELECT [PickupLocation]
      ,[FileMask]
  FROM [dbo].[dma_FtpDirectory]
GO

