
GO
PRINT 'Creating view_EDW_BioMetrics_STAGED';
PRINT 'FROM: view_EDW_BioMetrics_STAGE.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.views
                  WHERE
                        name = 'view_EDW_BioMetrics_STAGED') 
    BEGIN
        DROP VIEW
             view_EDW_BioMetrics_STAGED
    END;

GO
CREATE VIEW view_EDW_BioMetrics_STAGED
AS SELECT
          [UserID]
      ,[UserGUID]
      ,[HFitUserMpiNumber]
      ,[SiteID]
      ,[SiteGUID]
      ,[CreatedDate]
      ,[ModifiedDate]
      ,[Notes]
      ,[IsProfessionallyCollected]
      ,[EventDate]
      ,[EventName]
      ,[PPTWeight]
      ,[PPTHbA1C]
      ,[Fasting]
      ,[HDL]
      ,[LDL]
      ,[Ratio]
      ,[Total]
      ,[Triglycerides]
      ,[Glucose]
      ,[FastingState]
      ,[Systolic]
      ,[Diastolic]
      ,[PPTBodyFatPCT]
      ,[BMI]
      ,[WaistInches]
      ,[HipInches]
      ,[ThighInches]
      ,[ArmInches]
      ,[ChestInches]
      ,[CalfInches]
      ,[NeckInches]
      ,[Height]
      ,[HeartRate]
      ,[FluShot]
      ,[PneumoniaShot]
      ,[PSATest]
      ,[OtherExam]
      ,[TScore]
      ,[DRA]
      ,[CotinineTest]
      ,[ColoCareKit]
      ,[CustomTest]
      ,[CustomDesc]
      ,[CollectionSource]
      ,[AccountID]
      ,[AccountCD]
      ,[ChangeType]
      ,[ItemCreatedWhen]
      ,[ItemModifiedWhen]
      ,[TrackerCollectionSourceID]
      ,[itemid]
      ,[TBL]
      ,[VendorID]
      ,[VendorName]
          FROM dbo.STAGING_EDW_BioMetrics;
GO
PRINT 'CREATED view_EDW_BioMetrics_STAGE.sql';
GO


