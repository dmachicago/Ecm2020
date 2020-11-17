
if exists (select name from sys.indexes where name = 'IDX_Hfit_HealthAssesmentUserAnswers_HAAnswerNodeGUID')
Begin
	drop index IDX_Hfit_HealthAssesmentUserAnswers_HAAnswerNodeGUID ON 'dbo'.'HFit_HealthAssesmentUserAnswers'
end
go

if not exists (select name from sys.indexes where name = 'IDX_Hfit_HealthAssesmentUserAnswers_HAAnswerNodeGUID')
Begin
CREATE NONCLUSTERED INDEX IDX_Hfit_HealthAssesmentUserAnswers_HAAnswerNodeGUID ON 'dbo'.'HFit_HealthAssesmentUserAnswers'
(
 'ItemID' ASC,
 'HAQuestionItemID' ASC,
 'HAAnswerNodeGUID' ASC
)
INCLUDE (  'HAAnswerPoints',
 'HAAnswerValue',
 'CodeName',
 'UOMCode') 
END
GO



if exists (select name from sys.indexes where name = 'ci_HFit_HealthAssesmentUserQuestion_NodeGUID')
Begin
	DROP INDEX ci_HFit_HealthAssesmentUserQuestion_NodeGUID ON 'dbo'.'HFit_HealthAssesmentUserQuestion'
END
go

if not exists (select name from sys.indexes where name = 'ci_HFit_HealthAssesmentUserQuestion_NodeGUID')
Begin
CREATE NONCLUSTERED INDEX CI_HFit_HealthAssesmentUserQuestion_NodeGUID ON 'dbo'.'HFit_HealthAssesmentUserQuestion'
(
	'HAQuestionNodeGUID' ASC
)
INCLUDE ( 	'ItemID',
	'HAQuestionScore',
	'ItemModifiedWhen',
	'HARiskAreaItemID',	
	'CodeName',
	'PreWeightedScore',
	'IsProfessionallyCollected',
	'ProfessionallyCollectedEventDate'
	)
END
GO


if exists (select name from sys.indexes where name = 'CI_HFit_HealthAssesmentUserAnswers')
Begin
	DROP INDEX CI_HFit_HealthAssesmentUserAnswers ON HFit_HealthAssesmentUserAnswers
END
GO

--NEW 12.16.24
if not exists (select name from sys.indexes where name = 'CI_HFit_HealthAssesmentUserAnswers')
Begin
CREATE INDEX CI_HFit_HealthAssesmentUserAnswers
    ON HFit_HealthAssesmentUserAnswers
 (     'ItemID' ASC )
 Include (
		'HAAnswerPoints'
		, 'HAAnswerValue'
		, 'CodeName'
		, 'UOMCode'
		, 'HAAnswerNodeGUID'
 )
 END
go

--NEW 12.16.2014

if exists (select name from sys.indexes where name = 'CI_HFit_HealthAssesmentUserRiskArea')
Begin
	drop INDEX CI_HFit_HealthAssesmentUserRiskArea ON HFit_HealthAssesmentUserRiskArea
END
GO

if NOT exists (select name from sys.indexes where name = 'CI_HFit_HealthAssesmentUserRiskArea')
Begin
CREATE INDEX CI_HFit_HealthAssesmentUserRiskArea
    ON HFit_HealthAssesmentUserRiskArea
 (     'ItemID' ASC )
 Include (
	 'HARiskAreaScore'
	, 'CodeName'
	, 'PreWeightedScore' 
	, 'HARiskAreaNodeGUID'
 )
 END 
 GO
