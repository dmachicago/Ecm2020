USE [DataMartPlatform]
GO

/****** Object:  Trigger [dbo].[TRIG_DEL_BASE_Board_Board]    Script Date: 11/22/2016 2:43:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create TRIGGER [dbo].[TRIG_DEL_BASE_view_RDW_ClinicalIndicators]
    ON [dbo].BASE_view_RDW_ClinicalIndicators
    FOR DELETE AS 
BEGIN 
-- Generated on: Jul 20 2016  2:09AM
DECLARE @ACTION as char(1) = 'D' ; 
INSERT INTO BASE_view_RDW_ClinicalIndicators_DEL
(
  [MeasureCode],
	[EventDate] ,
	[MPI],
	[UPD_RT],
	[SRC_FILE_DT] ,
	[INS_DT],
	[SurrogateKey_view_RDW_ClinicalIndicators] ,
	Action,
	FtpFileSource
	, HashCode  )
 SELECT 
  [MeasureCode],
	[EventDate] ,
	[MPI],
	[UPD_RT],
	[SRC_FILE_DT] ,
	[INS_DT],
	[SurrogateKey_view_RDW_ClinicalIndicators] ,
	'D',
	FtpFileSource
	, HashCode 
FROM deleted 
END; 

GO


