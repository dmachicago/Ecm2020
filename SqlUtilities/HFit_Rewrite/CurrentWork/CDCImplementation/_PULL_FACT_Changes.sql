
declare @PriKey as nvarchar(2000) = ''
declare @PK as nvarchar(2000) = ''
exec @PriKey = procGetTablePK 'KenticoCMS_1', 'CMS_UserSite', @PK OUT
set @PriKey = @PK ;
print @PriKey ;

delete from KenticoCMS_1.dbo.CMS_USER 
where UserID in (Select top 1 UserID from KenticoCMS_1.dbo.CMS_USER )

update KenticoCMS_1.dbo.CMS_USER 
set UserPasswordFormat = upper(UserPasswordFormat)
where UserPasswordFormat = 'SHA1'

update KenticoCMS_1.dbo.CMS_USER 
set PreferredCultureCode = 'en-us'
where PreferredCultureCode = 'en-US'
and UserID in (Select top 10 UserID from KenticoCMS_1.dbo.CMS_USER )

update KenticoCMS_1.dbo.CMS_USER 
set FullName = FirstName + ' ' + MiddleName + ' ' + LastName 
where LastName = 'McDonald'



--The following shows how to obtain data for an initial synchronization of the table data. 
--The query returns all row data and their associated versions. You can then insert or add 
--this data to the system that will contain the synchronized data. In this case, the MART.
SELECT CT.SYS_CHANGE_VERSION, FT.*
FROM KenticoCMS_1.dbo.CMS_USER AS FT
CROSS APPLY CHANGETABLE 
    (VERSION KenticoCMS_1.dbo.CMS_USER, ([UserID]), (FT.[UserID])) AS CT
where CT.SYS_CHANGE_VERSION >= 21

--The following example lists all changes that were made in a table since the specified 
--version (@last_sync_version). [CMS_USER] is column(s) in the composite primary key.
DECLARE @last_sync_version bigint;
SET @last_sync_version = 20;
SELECT SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION,
    SYS_CHANGE_COLUMNS, SYS_CHANGE_CONTEXT, FT.*
FROM CHANGETABLE (CHANGES KenticoCMS_1.dbo.CMS_USER, @last_sync_version) AS CT
right join KenticoCMS_1.dbo.CMS_USER as FT
on FT.UserID = CT.UserID 
where SYS_CHANGE_VERSION is not null


--The following example shows how you can obtain all data that has changed. This query 
--joins the change tracking information with the user table so that user table information 
--is returned. A LEFT OUTER JOIN is used so that a row is returned for deleted rows.
-- Get all changes (inserts, updates, deletes)

DECLARE @last_sync_version bigint;
SET @last_sync_version = 20;

INSERT INTO #BASE_HFit_HealthAssessment
(
     HealthAssessmentID
      , QuestionTransformUrl 
      , ReviewText 
      , SubmitButtonText 
      , ReviewTitle 
      , SubmitRedirectUrl 
      , ReviewUrl 
      , ConfirmationTitle 
      , ConfirmationText 
      , ConfirmationUrl 
      , ConfirmationSubTitle 
      , ConfirmationEditButtonText 
      , SmallStepTitle 
      , SmallStepText 
      , SmallStepUrl 
      , MinimumOptOut 
      , MinimumSteps 
      , MaximumSteps 
      , IntroText 
      , Revision 
      , MyProfileConfirmationUrl 
      , MyProfileConfirmationTitle 
      , MyProfileConfirmationText 
      , HealthAssessmentConfigurationID 
      , DisplayName 
      , ReviewEditButtonText 
      , SmallStepOptoutText 
      , MinimumStepsError 
      , MaximumStepsError 
      , WaitMessage 
      , ErrorMessage 
      , ErrorTitle 
      , SYS_CHANGE_VERSION 
      , LASTMODIFIEDDATE 
      , SVR 
      , DBNAME )
 
DECLARE @last_sync_version bigint;
SET @last_sync_version = 20;
SELECT FT.HealthAssessmentID
      , FT.QuestionTransformUrl 
      , FT.ReviewText 
      , FT.SubmitButtonText 
      , FT.ReviewTitle 
      , FT.SubmitRedirectUrl 
      , FT.ReviewUrl 
      , FT.ConfirmationTitle 
      , FT.ConfirmationText 
      , FT.ConfirmationUrl 
      , FT.ConfirmationSubTitle 
      , FT.ConfirmationEditButtonText 
      , FT.SmallStepTitle 
      , FT.SmallStepText 
      , FT.SmallStepUrl 
      , FT.MinimumOptOut 
      , FT.MinimumSteps 
      , FT.MaximumSteps 
      , FT.IntroText 
      , FT.Revision 
      , FT.MyProfileConfirmationUrl 
      , FT.MyProfileConfirmationTitle 
      , FT.MyProfileConfirmationText 
      , FT.HealthAssessmentConfigurationID 
      , FT.DisplayName 
      , FT.ReviewEditButtonText 
      , FT.SmallStepOptoutText 
      , FT.MinimumStepsError 
      , FT.MaximumStepsError 
      , FT.WaitMessage 
      , FT.ErrorMessage 
      , FT.ErrorTitle 
      , CT.SYS_CHANGE_VERSION 
      , getdate() as LASTMODIFIEDDATE 
      , @@servername AS SVR 
      , 'KenticoCMS_1' AS DBNAME
FROM CHANGETABLE (CHANGES KenticoCMS_1.dbo.HFit_HealthAssessment, null) AS CT
    right OUTER JOIN KenticoCMS_1.dbo.HFit_HealthAssessment AS FT
        ON FT.[HealthAssessmentID] = CT.[HealthAssessmentID]
where SYS_CHANGE_OPERATION = 'I'
order by CT.SYS_CHANGE_VERSION desc

select top 100 * from KenticoCMS_1.dbo.HFit_HealthAssessment

update KenticoCMS_1.dbo.HFit_HealthAssessment set HealthAssessmentConfigurationID = -1 where HealthAssessmentConfigurationID is NULL