DELETE DataMartPlatform.dbo.TEMP_SIEBEL_ClinicalIndicators;
go

BULK INSERT DataMartPlatform.dbo.TEMP_SIEBEL_ClinicalIndicators
   FROM 'Z:\ImportFiles\ClinicalIndicators_Import\SIEBEL_CLINICALINDICATORS.2016.11.22.17.18.18.csv' 
   WITH (FIRSTROW = 2, LASTROW = 100, KEEPNULLS, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a' );
   --WITH (FIRSTROW = 2, KEEPNULLS, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a' );

drop table [dbo].[TEMP_SIEBEL_ClinicalIndicators]
go
CREATE TABLE [dbo].[TEMP_SIEBEL_ClinicalIndicators](
	[ROW_ID] [nvarchar](50) NULL,
	[MPI] [nvarchar](50) NULL,
	[CAREPLANCOMPLIANCE] [nvarchar](50) NULL,
	[FLUSHOTDATE] [datetime] NULL,
	[EYE_EXAM_DATE] [datetime] NULL,
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
	[LAST_UPD] [datetime] NULL
) ON [PRIMARY]

GO

