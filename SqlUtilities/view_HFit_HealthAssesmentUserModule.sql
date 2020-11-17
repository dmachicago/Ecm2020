
/****** Object:  View [dbo].[view_HFit_HealthAssesmentUserModule]    Script Date: 8/20/2014 7:46:39 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

alter view [dbo].[view_HFit_HealthAssesmentUserModule]
as
--*****************************************************************************
--8.16.2014 (wdm) - This view was created as a stopgap methofd until the 
--			required GUID fields are contained within all tables and 
--			populated correctly. Once those fields are accessable,
--			this view should go awway and the base table use in its place.
--*****************************************************************************
SELECT [ItemID]
      ,[UserID]
      ,[HAModuleDocumentID]
      ,[HAModuleVersionID]
      ,[HAModuleWeight]
      ,[ItemCreatedBy]
      ,[ItemCreatedWhen]
      ,[ItemModifiedBy]
      ,[ItemModifiedWhen]
      ,[ItemOrder]
      ,[ItemGUID]
      ,[HAModuleScore]
      ,[HADocumentID]
      ,[HAStartedItemID]
      ,[CodeName]
      ,[PreWeightedScore]
  FROM [dbo].[HFit_HealthAssesmentUserModule]
   
GO



-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
