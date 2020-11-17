USE [DataMartPlatform];
GO

/****** Object:  Trigger [dbo].[TRIG_INS_BASE_view_RDW_ClinicalIndicators]    Script Date: 11/22/2016 2:47:09 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

create TRIGGER dbo.TRIG_INS_BASE_view_RDW_ClinicalIndicators ON dbo.BASE_view_RDW_ClinicalIndicators
    AFTER INSERT
AS
BEGIN 
    -- Generated on: Jul 20 2016  2:09AM
    DECLARE
           @ACTION AS char (1) = 'I';
    INSERT INTO BASE_view_RDW_ClinicalIndicators_DEL (MeasureCode
                                                    , EventDate
                                                    , MPI
                                                    , UPD_RT
                                                    , SRC_FILE_DT
                                                    , INS_DT
                                                    , SurrogateKey_view_RDW_ClinicalIndicators
                                                    , ACTION
                                                    , FtpFileSource
                                                    , HashCode) 
    SELECT MeasureCode
         , EventDate
         , MPI
         , UPD_RT
         , SRC_FILE_DT
         , INS_DT
         , SurrogateKey_view_RDW_ClinicalIndicators
         , @Action
         , FtpFileSource
         , HashCode
      FROM inserted;
END; 

GO


