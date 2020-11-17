USE [DataMartPlatform];
GO

/****** Object:  Trigger [dbo].[TRIG_DEL_BASE_view_SIEBEL_ClinicalIndicators]    Script Date: 11/22/2016 2:43:48 PM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

create TRIGGER dbo.TRIG_DEL_BASE_view_SIEBEL_ClinicalIndicators ON dbo.BASE_view_SIEBEL_ClinicalIndicators
    FOR DELETE
AS
BEGIN 
    -- Generated on: Jul 20 2016  2:09AM
    DECLARE
           @ACTION AS char (1) = 'D';
    INSERT INTO BASE_view_SIEBEL_ClinicalIndicators_DEL (HBA1C
                                                       , CHOLESTEROL
                                                       , MICROALBUMINDATE
                                                       , FOOTEXAMDATE
                                                       , LST2WKSDEPRESSEDHOPELESS
                                                       , LST2WKSINTERESTPLEASURE
                                                       , LST2WKSNERVOUSANXIOUS
                                                       , LST2WKSSTOPCONTROLLWORRY
                                                       , AVERAGEPAINLEVEL
                                                       , HEIGHT
                                                       , WEIGHT
                                                       , LAST_UPD
                                                       , ROW_ID
                                                       , MPI
                                                       , CAREPLANCOMPLIANCE
                                                       , FLUSHOTDATE
                                                       , EYE_EXAM_DATE
                                                       , SurrogateKey_view_SIEBEL_ClinicalIndicators
                                                       , ACTION
                                                       , FtpFileSource
                                                       , HashCode) 
    SELECT HBA1C
         , CHOLESTEROL
         , MICROALBUMINDATE
         , FOOTEXAMDATE
         , LST2WKSDEPRESSEDHOPELESS
         , LST2WKSINTERESTPLEASURE
         , LST2WKSNERVOUSANXIOUS
         , LST2WKSSTOPCONTROLLWORRY
         , AVERAGEPAINLEVEL
         , HEIGHT
         , WEIGHT
         , LAST_UPD
         , ROW_ID
         , MPI
         , CAREPLANCOMPLIANCE
         , FLUSHOTDATE
         , EYE_EXAM_DATE
         , SurrogateKey_view_SIEBEL_ClinicalIndicators
         , @Action
         , FtpFileSource
         , HashCode
      FROM deleted;
END; 

GO


