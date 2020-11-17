
-- use KenticoCMS_Datamart_2
-- select Count(*) from KenticoCMS_1.dbo.view_EDW_HealthInterestDetail		  
GO
PRINT 'Executing proc_GenBaseTableFromView_MASTER.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_GenBaseTableFromView_MASTER') 
    BEGIN
        DROP PROCEDURE
             proc_GenBaseTableFromView_MASTER;
    END;
GO

CREATE PROCEDURE proc_GenBaseTableFromView_MASTER (
       @InstanceName AS NVARCHAR (100) 
     , @SkipIfExists AS INT = 1
     , @PreviewOnly AS NVARCHAR (10) = 'NO') 
AS
BEGIN

/*-----------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
Author:	  W. Dale Miller
Date:	  4-2-2013
Purpose:	  Issues calls to proc_GenBaseTableFromView passing in VIEWS as s;ecified in the 
		  select statement within this procedure's code.

		  Based on the DMA, Ltd. SQL Server Gen Utilities(tm) 

Parms:	  @InstanceName - the instance name contining the view and from which to PULL the data.
		  @SkipIfExists - Set to one to skip a view if it has been previously converted to a base table.
		  @PreviewOnly -  set to 1 if all that is wanted is to view the generated code and 
					   specifically NOT to execute it.

Usage:	  USE THIS TO CONVERT AT THE SERVER LEVEL:
		  exec proc_GenBaseTableFromView_MASTER 'KenticoCMS_1', 1, 'NO' 
		  exec proc_GenBaseTableFromView_MASTER 'KenticoCMS_2', 1, 'NO' 
		  exec proc_GenBaseTableFromView_MASTER 'KenticoCMS_3', 1, 'NO' 

		  USE THIS TO CONVERT INDIVIDUAL VIEWS:
		  exec proc_GenBaseTableFromView 'KenticoCMS_1', 'view_EDW_HealthAssesment', 'NO', @GenJobToExecute = 1, @SkipIfExists = 1 
		  exec proc_GenBaseTableFromView 'KenticoCMS_2', 'view_EDW_HealthAssesment', 'NO', @GenJobToExecute = 1, @SkipIfExists = 1
		  exec proc_GenBaseTableFromView 'KenticoCMS_3', 'view_EDW_HealthAssesment', 'NO', @GenJobToExecute = 1, @SkipIfExists = 1 

Preview:	  Select table_name from KenticoCMS_1.information_schema.tables where table_name like '%EDW%' and table_type = 'VIEW' 
*/

    DECLARE
           @MySql AS NVARCHAR (MAX) 
         , @ViewToProcess AS NVARCHAR (250) = ''
         , @BaseTable AS NVARCHAR (250) = ''
         , @Msg AS NVARCHAR (2000) = ''
         , @iCnt AS BIGINT = 0;

    IF NOT EXISTS (SELECT
                          name
                   FROM sys.tables
                   WHERE
                          name = 'MART_VIEWS_TO_CONVERT') 
        BEGIN
            -- select * from MART_VIEWS_TO_CONVERT
            -- update MART_VIEWS_TO_CONVERT set table_name = rtrim(ltrim(table_name))
            CREATE TABLE MART_VIEWS_TO_CONVERT (
                         table_name NVARCHAR (250)) ;
        END;

    --Modify this SELECT statement in order to process different views.
    SET @MySql = 'declare C cursor for' + char (10) ;
    SET @MySql = @MySql + ' SELECT ' + char (10) ;
    SET @MySql = @MySql + '    TABLE_Name ' + char (10) ;
    SET @MySql = @MySql + '    FROM ' + @InstanceName + '.information_schema.tables ' + char (10) ;
    SET @MySql = @MySql + '    WHERE ' + char (10) ;
    SET @MySql = @MySql + '    (table_name like ''%EDW%'' or table_name like ''%HealthAssesment%'') and table_type = ''VIEW'' and table_schema = ''dbo'' ' + char (10) ;
    SET @MySql = @MySql + '    OR table_name in (Select table_name from MART_VIEWS_TO_CONVERT) ' + char (10) ;

    EXEC (@MySql) ;
    OPEN C;
    FETCH NEXT FROM C INTO @ViewToProcess;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @BaseTable = 'BASE_' + @ViewToProcess;

            IF NOT EXISTS (SELECT
                                  table_name
                           FROM information_schema.tables
                           WHERE
                                  table_name = @ViewToProcess AND
                                  TABLE_TYPE = 'VIEW') 
						  SET @Msg = 'VIEW "' + @ViewToProcess + '" IS A TABLE not a View or does not exist, skipping.' ;
                            EXEC PrintImmediate @Msg;                            
                BEGIN
                    GOTO  SKIPTHIS
                END;

            IF
                   @SkipIfExists = 1
                BEGIN
                    IF EXISTS (SELECT
                                      name
                               FROM sys.tables
                               WHERE
                                      name = @BaseTable) 
                        BEGIN
                            EXEC @iCnt = proc_QuickRowCount @BaseTable;
                            SET @Msg = 'Table "' + @BaseTable + '" already exists, skipping and contains ' + cast (@iCnt AS NVARCHAR (50)) + ' records.';
                            EXEC PrintImmediate @Msg;
                            GOTO TABLEEXISTS;
                        END;
                END;
            IF
                   @SkipIfExists = 0
                BEGIN
                    IF EXISTS (SELECT
                                      name
                               FROM sys.tables
                               WHERE
                                      name = @BaseTable) 
                        BEGIN
                            SET @MySql = 'drop table ' + @BaseTable;
                            EXEC (@MySql) ;
                            PRINT 'NOTICE: Dropped table ' + @BaseTable;
                        END;
                END;
            TABLEEXISTS:
            SET @MySql = 'exec proc_GenBaseTableFromView ''' + @InstanceName + ''', ''' + @ViewToProcess + ''', ''NO'', @GenJobToExecute = 1, @SkipIfExists = 1 ';
            EXEC PrintImmediate @MySql;
            IF
                   @PreviewOnly != 'YES'
                BEGIN
                    BEGIN TRY
                        EXEC (@MySql) ;
                        SET @Msg = 'CREATED & Scheduled: ' + @ViewToProcess;
                        EXEC PrintImmediate @Msg;
                    END TRY
                    BEGIN CATCH
                        SET @Msg = '** FAILED: ' + @ViewToProcess;
                        EXEC PrintImmediate @Msg;
                        RAISERROR (@Msg , -- Message text.
                        10 , -- Severity.
                        1 -- State.
                        );
                    END CATCH;
                END;
            SKIPTHIS:

            FETCH NEXT FROM C INTO @ViewToProcess;
        END;

    CLOSE C;
    DEALLOCATE C;
END;
GO
PRINT 'Executed proc_GenBaseTableFromView_MASTER.sql';
GO

/*-----------------------------------------------------------------------------------------------------------------------------------------------------
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_Boards_BoardMessage_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_BookingSystem_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CMS_EventLog_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CMS_ObjectVersionHistoryUser_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CMS_PageTemplateCategoryPageTemplate_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CMS_Relationship_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CMS_ResourceString_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CMS_ResourceTranslated_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CMS_RoleResourcePermission_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CMS_SiteRoleResourceUIElement_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CMS_Tree_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CMS_Tree_Joined_Attachments', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CMS_Tree_Joined_Linked', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CMS_Tree_Joined_Regular', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CMS_Tree_Joined_Versions', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CMS_Tree_Joined_Versions_Attachments', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CMS_UserRole_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CMS_UserRole_MembershipRole_ValidOnly_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CMS_UserSettingsRole_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CMS_WebPartCategoryWebpart_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CMS_WidgetCategoryWidget_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_COM_SKUOptionCategory_OptionCategory_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CONTENT_Article_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CONTENT_Blog_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CONTENT_BlogMonth_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CONTENT_BlogPost_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CONTENT_BookingEvent_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CONTENT_Cellphone_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CONTENT_Event_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CONTENT_FAQ_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CONTENT_File_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CONTENT_ImageGallery_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CONTENT_Job_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CONTENT_KBArticle_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CONTENT_Laptop_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CONTENT_MenuItem_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CONTENT_News_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CONTENT_Office_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CONTENT_PressRelease_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CONTENT_Product_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CONTENT_SimpleArticle_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CONTENT_Smartphone_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_CONTENT_Wireframe_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_EDW_RewardProgram_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_Forums_GroupForumPost_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_Calculator_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_hfit_challenge_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_hfit_ChallengeAbout_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_hfit_challengeBase_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_hfit_ChallengeFAQ_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_hfit_challengeGeneralSettings_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_ChallengeNewsletter_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_hfit_challengeOffering_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_ChallengePostTemplate_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_ChallengePPTEligibleCDPostTemplate_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_hFit_ChallengePPTEligiblePostTemplate_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_ChallengePPTRegisteredPostTemplate_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_ChallengePPTRegisteredRDPostTemplate_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_ChallengeRegistrationEmail_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_ChallengeRegistrationPostTemplate_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_ChallengeRegistrationSettings_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_hfit_ChallengeTeam_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_hfit_ChallengeTeams_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_Class_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_Hfit_Client_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_ClientContact_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_CoachingCallLogTemporalContainer_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_hfit_CoachingCMTemporalContainer_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_CoachingCommitToQuit_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_CoachingEnrollmentSettings_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_CoachingEvalHAOverall_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_CoachingEvalHAQA_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_CoachingEvalHARiskArea_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_CoachingEvalHARiskCategory_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_CoachingEvalHARiskModule_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_CoachingGetStarted_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_CoachingHATemporalContainer_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_CoachingHealthActionPlan_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_CoachingHealthArea_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_CoachingLibraryHealthArea_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_CoachingLibraryResource_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_CoachingLibraryResources_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_CoachingLibrarySettings_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_CoachingLMTemporalContainer_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_CoachingMyGoalsSettings_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_CoachingMyHealthInterestsSettings_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_CoachingNotAssignedSettings_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_CoachingPrivacyPolicy_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_Hfit_CoachingSystemSettings_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_CoachingTermsAndConditionsSettings_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_CoachingWelcomeSettings_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_Configuration_CallLogCoaching_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFIT_Configuration_CMCoaching_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFIT_Configuration_HACoaching_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_Configuration_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_Configuration_LMCoaching_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFIT_Configuration_Screening_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_ConsentAndRelease_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_ContentBlock_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_CustomSettingsTemporalContainer_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_EmailTemplate_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_Event_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_Goal_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_GoalCategory_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_GoalSubCategory_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_GroupRewardLevel_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_HA_UseAndDisclosure_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_HACampaign_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_Hfit_HACampaigns_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_HAWelcomeSettings_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_HealthAssesmentMatrixQuestion_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_HealthAssesmentModule_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_HealthAssesmentPredefinedAnswer_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_HealthAssesmentRiskArea_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_HealthAssesmentRiskCategory_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_HealthAssessment_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_HealthAssessmentConfiguration_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_HealthAssessmentFreeForm_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_HealthAssessmentModuleConfiguration_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_HealthSummarySettings_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_HESChallenge_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_HRA_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_HSAbout_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_HSBiometricChart_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_HSGraphRangeSetting_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_HSHealthMeasuresSettings_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_HSLearnMoreDocument_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_LoginPageSettings_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_Hfit_MarketplaceProduct_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_Message_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_Hfit_MyHealthSettings_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_Newsletter_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_OutComeMessages_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_Pillar_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_PLPPackageContent_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_hfit_Post_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_PostChallenge_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_PostEmptyFeed_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_PostHealthEducation_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_PostMessage_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_PostQuote_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_PostReminder_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_PrivacyPolicy_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_ProgramFeedNotificationSettings_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_RegistrationWelcome_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_RewardActivity_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_RewardDefaultSettings_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_RewardGroup_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_RewardLevel_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_RewardParameterBase_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_RewardProgram_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_RewardsAboutInfoItem_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_RewardTrigger_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_RewardTriggerParameter_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_RewardTriggerTobaccoParameter_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_RightsResponsibilities_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_ScheduledNotification_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_ScreeningEvent_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_ScreeningEventCategory_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_ScreeningEventDate_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_ScreeningTemporalContainer_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_SecurityQuestion_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_Hfit_SecurityQuestionSettings_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_SmallSteps_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_hfit_SocialProof_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFIT_SsoConfiguration_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_SsoRequest_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_SsoRequestAttributes_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_hfit_TemporalConfigurationContainer_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_TermsConditions_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_Hfit_TimezoneConfiguration_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_TipOfTheDay_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_Hfit_TipOfTheDayCategory_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_Tobacco_Goal_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_TrackerCategory_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_TrackerDocument_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_UserSearch_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_WellnessGoal_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_hfit_WellnessGoalPostTemplate_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_Integration_Task_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_Membership_MembershipUser_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_Newsletter_Subscriptions_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_NewsletterSubscriberUserRole_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_OM_Account_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_OM_Account_MembershipJoined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_OM_AccountContact_AccountJoined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_OM_AccountContact_ContactJoined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_OM_ContactGroupMember_AccountJoined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_OM_ContactGroupMember_ContactJoined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_OM_ContactGroupMember_User_ContactJoined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_PM_ProjectStatus_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_PM_ProjectTaskStatus_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_Reporting_CategoryReport_Joined', 'NO', @GenJobToExecute = 1, @SkipIfExists = 0 
*/