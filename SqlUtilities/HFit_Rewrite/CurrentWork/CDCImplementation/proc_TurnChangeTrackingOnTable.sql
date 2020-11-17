
--************************************************************************
-- NOTES:
-- This procedure MUST be created on each server before proceeding.
--************************************************************************
USE KenticoCMS_3;
GO
PRINT 'Execute proc_TurnChangeTrackingOnTable.sql';
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_TurnChangeTrackingOnTable') 
    BEGIN
        DROP PROCEDURE proc_TurnChangeTrackingOnTable;
    END;
GO
-- 
-- HFit_PPTStatusEnum
CREATE PROCEDURE proc_TurnChangeTrackingOnTable (@InstanceName AS nvarchar (500) , 
                                                 @TblName AS nvarchar (500) , 
                                                 @SetStateTo AS nvarchar (50) = 'ENABLE') 
AS
BEGIN
    --Check to see if change tracking is turned on for  table
    --declare @InstanceName as nvarchar(500) = 'KenticoCMS_1' ;
    --declare @TblName as nvarchar(500) = 'CMS_USer' ;
    PRINT '=========================================================================';
    DECLARE
          @CountSQL AS nvarchar (max) = '' , 
          @MySQL AS nvarchar (max) = '' , 
          @i AS int = 0;

    DECLARE
          @out TABLE (out int) ;

    if not exists (Select name from sys.tables where name = @TblName)
    begin
	   print '**** ??? TABLE ' + @TblName + ' DOES NOT EXIST ON THIS SERVER ??? ****' ;
	   return ;
    end 

    IF @SetStateTo = 'DISABLE'
        BEGIN
            SET @CountSQL = 'SELECT count(*) FROM ' + @InstanceName + '.sys.change_tracking_tables tr
		  INNER JOIN ' + @InstanceName + '.sys.tables t on t.object_id = tr.object_id
		  INNER JOIN ' + @InstanceName + '.sys.schemas s on s.schema_id = t.schema_id
		  where t.name = ''' + @TblName + '''';
            -- PRINT @CountSQL;
            INSERT INTO @out
            EXEC (@CountSQL) ;
            SET @i = (SELECT * FROM @out) ;
            IF @i > 0 
                BEGIN
                    SET @MySQL = 'alter table ' + @InstanceName + '.dbo.' + @TblName + ' DISABLE change_tracking ';
                    BEGIN TRY EXEC (@MySQl) ;
                        PRINT 'CT DISABLED on: ' + @InstanceName + '.dbo.' + @TblName;
                    END TRY
                    BEGIN CATCH
                        PRINT '*************************************';
                        PRINT 'ERROR: Failed DISABLE CT on: ' + @InstanceName + '.dbo.' + @TblName;
                        PRINT @MySQl;
                        PRINT '*************************************';
                    END CATCH;
                END;
            ELSE
                BEGIN
                    PRINT 'CT ALREADY enabled: ' + @InstanceName + '.dbo.' + @TblName;
                END;
			 return ;
        END;

    SET @i = (SELECT COUNT (*)
                FROM
                     sys.indexes AS i
                     INNER JOIN sys.index_columns AS ic
                     ON i.OBJECT_ID = ic.OBJECT_ID
                    AND i.index_id = ic.index_id
                WHERE i.is_primary_key = 1
                  AND OBJECT_NAME (ic.OBJECT_ID) = @TblName) ;

    IF @i = 0
        BEGIN
            DECLARE
                  @IdentCol AS nvarchar (200) = '';
            SET @IdentCol = (SELECT c.name
                               FROM
                                    sys.objects AS o
                                    INNER JOIN sys.columns AS c
                                    ON o.object_id = c.object_id
                               WHERE c.is_identity = 1
                                 AND o.name = @TblName) ;

            IF @IdentCol IS NULL
                BEGIN
                    SET @MySql = 'Alter table ' + @TblName + ' add SurrogateKey_' + @TblName + ' bigint identity (1,1) not null ';
                    PRINT @MySql;
                    EXEC (@MySql) ;
                    SET @MySql = 'ALTER TABLE [dbo].[' + @TblName + '] ADD  CONSTRAINT [PKSKey_' + @TblName + '] PRIMARY KEY  ([SurrogateKey_' + @TblName + '] ASC) ';
                    PRINT @MySql;
                    EXEC (@MySql) ;
                END;
            ELSE
                BEGIN
                    SET @MySql = 'ALTER TABLE [dbo].[' + @TblName + '] ADD  CONSTRAINT [PKSKey_' + @TblName + '] PRIMARY KEY  ([' + @IdentCol + '] ASC) ';
                    PRINT @MySql;
                    EXEC (@MySql) ;
                END;
            PRINT 'ADDED PKEY to: ' + @TblName;
        END;


    SET @CountSQL = 'SELECT count(*) FROM ' + @InstanceName + '.sys.change_tracking_tables tr
		  INNER JOIN ' + @InstanceName + '.sys.tables t on t.object_id = tr.object_id
		  INNER JOIN ' + @InstanceName + '.sys.schemas s on s.schema_id = t.schema_id
		  where t.name = ''' + @TblName + '''';
    -- PRINT @CountSQL;
    INSERT INTO @out
    EXEC (@CountSQL) ;
    SET @i = (SELECT * FROM @out) ;
    IF @i = 0
        BEGIN
            SET @MySQL = 'alter table ' + @InstanceName + '.dbo.' + @TblName + ' enable change_tracking with (track_columns_updated = ON) ';
            BEGIN TRY EXEC (@MySQl) ;
                PRINT 'CT Enabled on: ' + @InstanceName + '.dbo.' + @TblName;
            END TRY
            BEGIN CATCH
                PRINT '*************************************';
                PRINT 'ERROR: Failed Enable CT on: ' + @InstanceName + '.dbo.' + @TblName;
                PRINT @MySQl;
                PRINT '*************************************';
            END CATCH;
        END;
    ELSE
        BEGIN
            PRINT 'CT ALREADY enabled: ' + @InstanceName + '.dbo.' + @TblName;
        END;
    RETURN @i;
END;

GO
PRINT 'Executed proc_TurnChangeTrackingOnTable.sql';
GO


--******************************************************************************************************************************

/*
select 'exec proc_TurnChangeTrackingOnTable ''KenticoCMS_1'', '''+substring(table_name,6,999) +'''' + char(10) + 'GO' from information_schema.tables
where table_name like 'BASE%'
and table_name not like '%EventLog%'
and table_name not like '%test'
and table_name not like '%DEL'
and table_name not like '%testdata%'
and table_name not like '%HIST'
and table_name not like '%view%'
and table_name not like '%staging%'
and table_name not like 'TMP%'
and table_name not like '%TEMP%'
and table_name not like '%NotMet_Step%'
and table_name not like 'MART%'
and table_name not like '%LastPullDate'
and table_name not like 'EDW%'
union 
select 'exec proc_TurnChangeTrackingOnTable ''KenticoCMS_2'', '''+substring(table_name,6,999) +'''' + char(10) + 'GO' from information_schema.tables
where table_name like 'BASE%'
and table_name not like '%EventLog%'
and table_name not like '%test'
and table_name not like '%DEL'
and table_name not like '%testdata%'
and table_name not like '%HIST'
and table_name not like '%view%'
and table_name not like '%staging%'
and table_name not like 'TMP%'
and table_name not like '%TEMP%'
and table_name not like '%NotMet_Step%'
and table_name not like 'MART%'
and table_name not like '%LastPullDate'
and table_name not like 'EDW%'
union 
select 'exec proc_TurnChangeTrackingOnTable ''KenticoCMS_3'', '''+substring(table_name,6,999) +'''' + char(10) + 'GO' from information_schema.tables
where table_name like 'BASE%'
and table_name not like '%EventLog%'
and table_name not like '%test'
and table_name not like '%DEL'
and table_name not like '%testdata%'
and table_name not like '%HIST'
and table_name not like '%view%'
and table_name not like '%staging%'
and table_name not like 'TMP%'
and table_name not like '%TEMP%'
and table_name not like '%NotMet_Step%'
and table_name not like 'MART%'
and table_name not like '%LastPullDate'
and table_name not like 'EDW%'
*/

--******************************************************************************************************************************


-- NOTES:
-- Each section KenticoCMS_1, KenticoCMS_2, and KenticoCMS_3 
--	   must be executed individually on each server.

/*
select 'exec proc_TurnChangeTrackingOnTable ''KenticoCMS_1'', ''' + sys.tables.name+ '''' + char(10) + 'GO' as CMD
from sys.change_tracking_tables
join sys.tables on sys.tables.object_id = sys.change_tracking_tables.object_id
join sys.schemas on sys.schemas.schema_id = sys.tables.schema_id
*/
--use KenticoCMS_1
--use KenticoCMS_2
use KenticoCMS_3
go
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_EventLog', 'DISABLE'
GO
--WDM
print '@@@@ - The following has caused issues on Server 3'
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_GoalOutcome'
GO
--WDM
print '@@@@ - The following has caused issues on Server 3'
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_UserGoal'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Board_Board'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Board_Message'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Chat_Message'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Chat_Room'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Chat_User'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_AbuseReport'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_ACL'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_ACLItem'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_AllowedChildClasses'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_AlternativeForm'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Attachment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_AttachmentForEmail'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_AttachmentHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_AutomationHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_AutomationState'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Avatar'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Badge'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_BannedIP'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Banner'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_BannerCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Category'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Class'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_ClassSite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Country'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_CssStylesheet'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_CssStylesheetSite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Culture'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_DeviceProfile'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_DeviceProfileLayout'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Document'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_DocumentAlias'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_DocumentCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_DocumentTag'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_DocumentTypeScope'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_DocumentTypeScopeClass'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Email'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_EmailAttachment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_EmailUser'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Form'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_FormRole'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_FormUserControl'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_HelpTopic'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_InlineControl'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_InlineControlSite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Layout'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_LicenseKey'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_MacroRule'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Membership'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_MembershipRole'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_MembershipUser'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_MetaFile'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_ObjectRelationship'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_ObjectSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_ObjectVersionHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_ObjectWorkflowTrigger'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_OpenIDUser'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Permission'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Personalization'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Query'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Relationship'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_RelationshipName'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_RelationshipNameSite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Resource'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_ResourceLibrary'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_ResourceSite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_ResourceString'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_ResourceTranslation'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Role'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_RoleApplication'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_RolePermission'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_RoleUIElement'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_ScheduledTask'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_SearchEngine'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_SearchIndex'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_SearchIndexCulture'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_SearchIndexSite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_SearchTask'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Session'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_settingkeybak'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_SettingsCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_SettingsKey'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Site'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_SiteCulture'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_SiteDomainAlias'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_SMTPServer'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_SMTPServerSite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_State'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Tag'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_TagGroup'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_TimeZone'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Transformation'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_TranslationService'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_TranslationSubmission'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_TranslationSubmissionItem'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Tree'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_UIElement'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'cms_user'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_UserCulture'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_UserRole'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'cms_usersettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'cms_usersite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_VersionAttachment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_VersionHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_WebFarmServer'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_WebFarmServerTask'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_WebFarmTask'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_WebPart'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_WebPartCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_WebPartContainer'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_WebPartContainerSite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_WebPartLayout'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Widget'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_WidgetCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_WidgetRole'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_Workflow'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_WorkflowAction'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_WorkflowHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_WorkflowScope'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_WorkflowStep'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_WorkflowStepRoles'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_WorkflowStepUser'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_WorkflowTransition'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'CMS_WorkflowUser'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'coachExclusion'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_Address'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_Bundle'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_Carrier'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_CouponCode'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_Currency'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_CurrencyExchangeRate'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_Customer'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_CustomerCreditHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_Department'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_DepartmentTaxClass'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_Discount'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_DiscountCoupon'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_ExchangeTable'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_InternalStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_Manufacturer'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_MultiBuyCouponCode'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_MultiBuyDiscount'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_MultiBuyDiscountDepartment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_MultiBuyDiscountSKU'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_OptionCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_Order'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_OrderAddress'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_OrderItem'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_OrderItemSKUFile'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_OrderStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_OrderStatusUser'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_PaymentOption'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_PaymentShipping'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_PublicStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_ShippingCost'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_ShippingOption'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_ShippingOptionTaxClass'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_ShoppingCart'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_ShoppingCartSKU'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_SKU'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_SKUAllowedOption'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_SKUDiscountCoupon'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_SKUFile'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_SKUOptionCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_SKUTaxClasses'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_Supplier'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_TaxClass'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_TaxClassCountry'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_TaxClassState'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_UserDepartment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_VariantOption'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_VolumeDiscount'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'COM_Wishlist'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Community_Friend'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Community_Group'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Community_GroupMember'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Community_GroupRolePermission'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Community_Invitation'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'EDW_GroupMemberHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'EDW_GroupMemberToday'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'EDW_HealthAssessment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'EDW_HealthAssessmentDefinition'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'EDW_PerformanceMeasure'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'EDW_RoleMemberHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'EDW_RoleMembership'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'EDW_RoleMemberToday'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFIT_Account'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_Announcements'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_BiometricData'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_Blurb'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_Calculator'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CallList'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CentralConfig'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'hfit_challenge'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'hfit_ChallengeAbout'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'hfit_challengeBase'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'hfit_ChallengeFAQ'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'hfit_challengeGeneralSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ChallengeNewsletter'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ChallengeNewsletterRelationship'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'hfit_challengeOffering'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ChallengeRegistrationEmail'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ChallengeRegistrations'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ChallengeRegistrationSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'hfit_ChallengeTeam'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'hfit_ChallengeTeams'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'hfit_challengeTypes'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ChallengeUserRegistration'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_Class'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ClassType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Hfit_Client'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ClientContact'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Hfit_ClientDeviceSuspensionLog'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ClientSecurityQuestions'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CMS_User_CHANGES'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_Coaches'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingAuditLog'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingCommitToQuit'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingEnrollmentReport'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingEnrollmentSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingEvalHAOverall'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingEvalHAQA'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingEvalHARiskArea'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingEvalHARiskCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingEvalHARiskModule'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingGetStarted'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingHealthActionPlan'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingHealthArea'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingHealthInterest'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingLibraryHealthArea'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingLibraryResource'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingLibraryResources'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingLibrarySettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingMyGoalsSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingMyHealthInterestsSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingNotAssignedSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingPrivacyPolicy'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingSessionCompleted'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Hfit_CoachingSystemSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingTermsAndConditionsSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Hfit_CoachingUserCMCondition'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Hfit_CoachingUserCMExclusion'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingUserServiceLevel'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_CoachingWelcomeSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_Company'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_configFeatures'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_configGroupToFeature'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_Configuration'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_Configuration_CallLogCoaching'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFIT_Configuration_CMCoaching'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFIT_Configuration_HACoaching'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_Configuration_LMCoaching'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFIT_Configuration_Screening'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ConsentAndRelease'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ConsentAndReleaseAgreement'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ContactGroupMembership'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ContactGroupSyncExclude'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ContentBlock'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_DataEntry_Clinical'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_EligibilityLoadTracking'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_Event'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_EventType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_FooterAdministration'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_Fulfillment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_FulfillmentCodes'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_Goal'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_GoalCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_GoalOutcome'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_GoalSubCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_GroupAddUsers'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_GroupRebuildSchedule'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_GroupRemovedUsers'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HA_IPadExceptionLog'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HA_IPadLog'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HA_UseAndDisclosure'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HAAgreement'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HACampaign'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Hfit_HACampaigns'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Hfit_HAHealthCheckCampaignData'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Hfit_HAHealthCheckCodes'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Hfit_HAHealthCheckLog'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HaScoringStrategies'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HAWelcomeSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAdvisingSessionCompleted'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentAnswerCodeNames'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentAnswers'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentMatrixQuestion'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentModule'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentModuleCodeNames'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentMultipleChoiceQuestion'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentPhysicalActivityScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentPredefinedAnswer'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentQuestionCodeNames'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentQuestionGroupCodeNames'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentRecomendationClientConfig'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentRecomendations'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentRecomendationTypes'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentRiskArea'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentRiskAreaCodeNames'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentRiskCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentRiskCategoryCodeNames'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentStarted'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentThresholdGrouping'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentThresholds'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentThresholdTypes'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentUserAnswers'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentUserModule'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentUserQuestion'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentUserQuestionGroupResults'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentUserQuestionImport'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentUserRiskArea'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentUserRiskCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssesmentUserStarted'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssessment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssessmentBmiScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssessmentCodeNamesToTrackerMapping'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssessmentConfiguration'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Hfit_HealthAssessmentDataForImport'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssessmentDataForMissingResponses'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssessmentDiasBpScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssessmentFastingGlucoseScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssessmentFreeForm'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssessmentHbA1cScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssessmentHDLScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssessmentLDLScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssessmentModuleConfiguration'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssessmentNonFastingGlucoseScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssessmentPaperException'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssessmentSysBpScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssessmentTCHDLRatioScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssessmentTCScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthAssessmentTriglyceridesScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HealthSummarySettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HES_Award'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HESChallenge'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HESChallengeTable'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HRA'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HSAbout'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HSBiometricChart'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HSGraphRangeSetting'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HSHealthMeasuresSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_HSLearnMoreDocument'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_Join_ClinicalSourceTracker'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_join_ClinicalTrackers'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_CallResult'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_CardioActivityIntensity'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_CoachingAuditLogType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_CoachingCMConditions'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_CoachingCMExclusions'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_CoachingOptOutReason'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_CoachingServiceLevel'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_CoachingServiceLevelStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_ContactGroupType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Hfit_LKP_CustomTrackerDefaultMetadata'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFIT_LKP_EDW_REJECTMPI'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_FastingState'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_Frequency'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_FulfillmentFeatures'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_GoalCloseReason'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_GoalStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_HealthAssessmentImportStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_HES_AwardType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_HES_ValueType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Hfit_LKP_NicotineAssessment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_RewardActivity'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_RewardCompleted'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_RewardCompleted_FIX'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_RewardFrequency'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_RewardGroupLevel'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_RewardLevel'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_RewardLevelType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_RewardTrigger'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_RewardTriggerParameter'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_RewardTriggerParameterOperator'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_RewardType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_ScheduledNotificationDeliveryType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_StressManagementActivity'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_TrackerCardioActivity'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_TrackerFlexibilityActivity'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_TrackerSleepPlanTechniques'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_TrackerStrengthActivity'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_TrackerTable'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_TrackerTobaccoQuitAids'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_TrackerVendor'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_UnitOfMeasure'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LKP_UserType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_LoginPageSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Hfit_MarketplaceProduct'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Hfit_MarketplaceProductTypes'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_Message'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_MockMpiData'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Hfit_MyHealthSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_Newsletter'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_OutComeMessages'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_Pillar'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_PLPPackageContent'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'hfit_Post'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_PostChallenge'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_PostHealthEducation'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_PostMessage'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_PostQuote'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_PostReminder'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_PostSubscriber'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_PostSubscriber_ContactBackup'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_PostSubscriber_ContactMap'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'hfit_PPTEligibility'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFIt_PptEligibility_mosbrun'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_PPTStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_PPTStatus_CR27070'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_PPTStatusEnum'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_PPTStatusIpadMappingCodeCleanup'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_PrivacyPolicy'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ProgramFeedNotificationSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_Ref_RewardTrackerValidation'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RegistrationWelcome'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardAboutInfoItem'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardActivity'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardDatesAggregator'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardDefaultSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardException'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardGroup'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardGroupComplete'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardGroupSummary'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardLevel'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardOverrideLog'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardParameterBase'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardProgram'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardsAboutInfoItem'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardsAwardUserDetail'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardsAwardUserDetailArchive'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardsReprocessQueue'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardsUserActivityDetail'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardsUserInterfaceState'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardsUserLevelDetail'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardsUserRepeatableTriggerDetail'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardsUserSummary'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardsUserSummaryArchive'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardsUserTrigger'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardTrigger'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardTriggerParameter'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RewardTriggerTobaccoParameter'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_RightsResponsibilities'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ScheduledNotification'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ScheduledNotificationHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ScheduledTaskHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_SchedulerEventAppointmentSlot'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_SchedulerEventType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_Screening_CNT'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_Screening_MAP'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_Screening_PPT'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_Screening_PPT_Archive'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_Screening_QST'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ScreeningEvent'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ScreeningEventCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ScreeningEventDate'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_SecurityQuestion'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Hfit_SecurityQuestionSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Hfit_SmallStepResponses'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_SmallSteps'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'hfit_SocialProof'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_SSIS_ScreeningMapping'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_SsoAttributeData'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFIT_SsoConfiguration'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_SsoData'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_SsoRequest'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_SsoRequestAttributes'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_StatbridgeFileDownload'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_SyncTaskSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TermsConditions'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Hfit_TimezoneConfiguration'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TipOfTheDay'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Hfit_TipOfTheDayCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Hfit_TipOfTheDayCategoryCT'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_Tobacco_Goal'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ToDoPersonal'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ToDoSmallSteps'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TodoSource'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFIT_Tracker'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerBloodPressure'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerBloodSugarAndGlucose'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerBMI'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerBodyFat'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerBodyMeasurements'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerCardio'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerCholesterol'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerCollectionSource'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerCotinine'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerDailySteps'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerDef_Item'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerDef_Tracker'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerDocument'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerFlexibility'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerFruits'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerHbA1c'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerHeight'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerHighFatFoods'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerHighSodiumFoods'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerInstance_Item'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerInstance_Tracker'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerMealPortions'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerMedicalCarePlan'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerPreventiveCare'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerRegularMeals'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerRestingHeartRate'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerShots'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerSitLess'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerSleepPlan'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerStrength'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerStress'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerStressManagement'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerSugaryDrinks'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerSugaryFoods'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerSummary'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerTests'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerTobaccoAttestation'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerTobaccoFree'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerVegetables'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerWater'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerWeight'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_TrackerWholeGrains'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_UnitOfMeasure'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_UserCoachingAlert_MeetNotModify'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_UserCoachingAlert_NotMet'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_UserGoal'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_UserRewardPoints'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_UserSchedulerAppointment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_UserSearch'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_UserTracker'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_UserTrackerCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ValMeasures'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ValMeasureType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_ValMeasureValues'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_WellnessGoal'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'HFit_WellnessGoals'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'MART_EDW_HealthAssesment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'Messaging_Message'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'OM_ABVariant'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'OM_Account'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'OM_AccountContact'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'OM_AccountStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'OM_Activity'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'OM_ActivityType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'OM_Contact'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'OM_ContactGroup'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'OM_ContactGroupMember'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'OM_ContactRole'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'OM_ContactStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'OM_IP'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'OM_Membership'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'OM_MVTCombination'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'OM_MVTCombinationVariation'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'OM_MVTVariant'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'OM_PageVisit'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'OM_PersonalizationVariant'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'OM_Rule'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'OM_Score'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'OM_ScoreContactRule'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'OM_Search'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'OM_UserAgent'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'PM_Project'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'PM_ProjectRolePermission'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'PM_ProjectStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'PM_ProjectTask'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'PM_ProjectTaskPriority'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'PM_ProjectTaskStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'RPT_CoachingFromPortal'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'SM_FacebookAccount'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'SM_FacebookApplication'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'SM_LinkedInAccount'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'SM_TwitterAccount'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'SM_TwitterApplication'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_1', 'tmp_HealthAssessmentData'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Board_Board'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Board_Message'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Chat_Message'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Chat_Room'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Chat_User'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_AbuseReport'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_ACL'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_ACLItem'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_AllowedChildClasses'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_AlternativeForm'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Attachment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_AttachmentForEmail'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_AttachmentHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_AutomationHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_AutomationState'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Avatar'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Badge'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_BannedIP'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Banner'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_BannerCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Category'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Class'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_ClassSite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Country'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_CssStylesheet'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_CssStylesheetSite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Culture'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_DeviceProfile'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_DeviceProfileLayout'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Document'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_DocumentAlias'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_DocumentCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_DocumentTag'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_DocumentTypeScope'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_DocumentTypeScopeClass'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Email'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_EmailAttachment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_EmailUser'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Form'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_FormRole'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_FormUserControl'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_HelpTopic'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_InlineControl'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_InlineControlSite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Layout'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_LicenseKey'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_MacroRule'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Membership'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_MembershipRole'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_MembershipUser'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_MetaFile'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_ObjectRelationship'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_ObjectSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_ObjectVersionHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_ObjectWorkflowTrigger'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_OpenIDUser'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Permission'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Personalization'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Query'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Relationship'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_RelationshipName'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_RelationshipNameSite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Resource'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_ResourceLibrary'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_ResourceSite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_ResourceString'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_ResourceTranslation'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Role'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_RoleApplication'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_RolePermission'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_RoleUIElement'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_ScheduledTask'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_SearchEngine'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_SearchIndex'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_SearchIndexCulture'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_SearchIndexSite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_SearchTask'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Session'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_settingkeybak'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_SettingsCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_SettingsKey'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Site'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_SiteCulture'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_SiteDomainAlias'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_SMTPServer'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_SMTPServerSite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_State'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Tag'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_TagGroup'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_TimeZone'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Transformation'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_TranslationService'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_TranslationSubmission'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_TranslationSubmissionItem'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Tree'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_UIElement'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'cms_user'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_UserCulture'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_UserRole'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'cms_usersettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'cms_usersite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_VersionAttachment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_VersionHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_WebFarmServer'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_WebFarmServerTask'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_WebFarmTask'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_WebPart'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_WebPartCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_WebPartContainer'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_WebPartContainerSite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_WebPartLayout'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Widget'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_WidgetCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_WidgetRole'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_Workflow'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_WorkflowAction'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_WorkflowHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_WorkflowScope'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_WorkflowStep'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_WorkflowStepRoles'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_WorkflowStepUser'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_WorkflowTransition'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'CMS_WorkflowUser'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'coachExclusion'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_Address'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_Bundle'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_Carrier'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_CouponCode'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_Currency'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_CurrencyExchangeRate'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_Customer'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_CustomerCreditHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_Department'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_DepartmentTaxClass'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_Discount'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_DiscountCoupon'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_ExchangeTable'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_InternalStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_Manufacturer'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_MultiBuyCouponCode'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_MultiBuyDiscount'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_MultiBuyDiscountDepartment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_MultiBuyDiscountSKU'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_OptionCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_Order'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_OrderAddress'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_OrderItem'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_OrderItemSKUFile'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_OrderStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_OrderStatusUser'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_PaymentOption'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_PaymentShipping'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_PublicStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_ShippingCost'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_ShippingOption'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_ShippingOptionTaxClass'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_ShoppingCart'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_ShoppingCartSKU'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_SKU'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_SKUAllowedOption'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_SKUDiscountCoupon'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_SKUFile'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_SKUOptionCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_SKUTaxClasses'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_Supplier'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_TaxClass'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_TaxClassCountry'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_TaxClassState'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_UserDepartment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_VariantOption'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_VolumeDiscount'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'COM_Wishlist'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Community_Friend'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Community_Group'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Community_GroupMember'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Community_GroupRolePermission'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Community_Invitation'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'EDW_GroupMemberHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'EDW_GroupMemberToday'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'EDW_HealthAssessment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'EDW_HealthAssessmentDefinition'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'EDW_PerformanceMeasure'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'EDW_RoleMemberHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'EDW_RoleMembership'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'EDW_RoleMemberToday'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFIT_Account'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_Announcements'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_BiometricData'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_Blurb'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_Calculator'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CallList'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CentralConfig'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'hfit_challenge'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'hfit_ChallengeAbout'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'hfit_challengeBase'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'hfit_ChallengeFAQ'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'hfit_challengeGeneralSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ChallengeNewsletter'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ChallengeNewsletterRelationship'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'hfit_challengeOffering'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ChallengeRegistrationEmail'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ChallengeRegistrations'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ChallengeRegistrationSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'hfit_ChallengeTeam'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'hfit_ChallengeTeams'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'hfit_challengeTypes'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ChallengeUserRegistration'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_Class'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ClassType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Hfit_Client'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ClientContact'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Hfit_ClientDeviceSuspensionLog'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ClientSecurityQuestions'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CMS_User_CHANGES'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_Coaches'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingAuditLog'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingCommitToQuit'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingEnrollmentReport'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingEnrollmentSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingEvalHAOverall'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingEvalHAQA'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingEvalHARiskArea'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingEvalHARiskCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingEvalHARiskModule'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingGetStarted'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingHealthActionPlan'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingHealthArea'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingHealthInterest'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingLibraryHealthArea'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingLibraryResource'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingLibraryResources'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingLibrarySettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingMyGoalsSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingMyHealthInterestsSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingNotAssignedSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingPrivacyPolicy'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingSessionCompleted'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Hfit_CoachingSystemSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingTermsAndConditionsSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Hfit_CoachingUserCMCondition'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Hfit_CoachingUserCMExclusion'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingUserServiceLevel'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_CoachingWelcomeSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_Company'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_configFeatures'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_configGroupToFeature'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_Configuration'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_Configuration_CallLogCoaching'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFIT_Configuration_CMCoaching'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFIT_Configuration_HACoaching'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_Configuration_LMCoaching'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFIT_Configuration_Screening'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ConsentAndRelease'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ConsentAndReleaseAgreement'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ContactGroupMembership'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ContactGroupSyncExclude'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ContentBlock'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_DataEntry_Clinical'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_EligibilityLoadTracking'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_Event'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_EventType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_FooterAdministration'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_Fulfillment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_FulfillmentCodes'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_Goal'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_GoalCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_GoalOutcome'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_GoalSubCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_GroupAddUsers'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_GroupRebuildSchedule'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_GroupRemovedUsers'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HA_IPadExceptionLog'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HA_IPadLog'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HA_UseAndDisclosure'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HAAgreement'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HACampaign'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Hfit_HACampaigns'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Hfit_HAHealthCheckCampaignData'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Hfit_HAHealthCheckCodes'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Hfit_HAHealthCheckLog'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HaScoringStrategies'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HAWelcomeSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAdvisingSessionCompleted'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentAnswerCodeNames'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentAnswers'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentMatrixQuestion'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentModule'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentModuleCodeNames'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentMultipleChoiceQuestion'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentPhysicalActivityScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentPredefinedAnswer'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentQuestionCodeNames'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentQuestionGroupCodeNames'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentRecomendationClientConfig'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentRecomendations'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentRecomendationTypes'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentRiskArea'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentRiskAreaCodeNames'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentRiskCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentRiskCategoryCodeNames'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentStarted'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentThresholdGrouping'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentThresholds'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentThresholdTypes'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentUserAnswers'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentUserModule'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentUserQuestion'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentUserQuestionGroupResults'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentUserQuestionImport'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentUserRiskArea'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentUserRiskCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssesmentUserStarted'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssessment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssessmentBmiScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssessmentCodeNamesToTrackerMapping'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssessmentConfiguration'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Hfit_HealthAssessmentDataForImport'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssessmentDataForMissingResponses'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssessmentDiasBpScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssessmentFastingGlucoseScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssessmentFreeForm'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssessmentHbA1cScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssessmentHDLScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssessmentLDLScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssessmentModuleConfiguration'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssessmentNonFastingGlucoseScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssessmentPaperException'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssessmentSysBpScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssessmentTCHDLRatioScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssessmentTCScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthAssessmentTriglyceridesScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HealthSummarySettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HES_Award'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HESChallenge'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HESChallengeTable'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HRA'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HSAbout'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HSBiometricChart'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HSGraphRangeSetting'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HSHealthMeasuresSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_HSLearnMoreDocument'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_Join_ClinicalSourceTracker'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_join_ClinicalTrackers'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_CallResult'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_CardioActivityIntensity'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_CoachingAuditLogType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_CoachingCMConditions'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_CoachingCMExclusions'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_CoachingOptOutReason'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_CoachingServiceLevel'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_CoachingServiceLevelStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_ContactGroupType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Hfit_LKP_CustomTrackerDefaultMetadata'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFIT_LKP_EDW_REJECTMPI'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_FastingState'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_Frequency'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_FulfillmentFeatures'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_GoalCloseReason'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_GoalStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_HealthAssessmentImportStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_HES_AwardType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_HES_ValueType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Hfit_LKP_NicotineAssessment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_RewardActivity'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_RewardCompleted'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_RewardCompleted_FIX'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_RewardFrequency'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_RewardGroupLevel'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_RewardLevel'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_RewardLevelType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_RewardTrigger'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_RewardTriggerParameter'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_RewardTriggerParameterOperator'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_RewardType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_ScheduledNotificationDeliveryType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_StressManagementActivity'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_TrackerCardioActivity'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_TrackerFlexibilityActivity'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_TrackerSleepPlanTechniques'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_TrackerStrengthActivity'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_TrackerTable'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_TrackerTobaccoQuitAids'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_TrackerVendor'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_UnitOfMeasure'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LKP_UserType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_LoginPageSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Hfit_MarketplaceProduct'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Hfit_MarketplaceProductTypes'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_Message'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_MockMpiData'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Hfit_MyHealthSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_Newsletter'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_OutComeMessages'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_Pillar'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_PLPPackageContent'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'hfit_Post'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_PostChallenge'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_PostHealthEducation'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_PostMessage'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_PostQuote'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_PostReminder'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_PostSubscriber'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_PostSubscriber_ContactBackup'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_PostSubscriber_ContactMap'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'hfit_PPTEligibility'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFIt_PptEligibility_mosbrun'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_PPTStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_PPTStatus_CR27070'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_PPTStatusEnum'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_PPTStatusIpadMappingCodeCleanup'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_PrivacyPolicy'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ProgramFeedNotificationSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_Ref_RewardTrackerValidation'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RegistrationWelcome'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardAboutInfoItem'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardActivity'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardDatesAggregator'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardDefaultSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardException'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardGroup'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardGroupComplete'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardGroupSummary'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardLevel'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardOverrideLog'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardParameterBase'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardProgram'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardsAboutInfoItem'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardsAwardUserDetail'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardsAwardUserDetailArchive'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardsReprocessQueue'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardsUserActivityDetail'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardsUserInterfaceState'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardsUserLevelDetail'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardsUserRepeatableTriggerDetail'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardsUserSummary'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardsUserSummaryArchive'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardsUserTrigger'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardTrigger'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardTriggerParameter'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RewardTriggerTobaccoParameter'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_RightsResponsibilities'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ScheduledNotification'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ScheduledNotificationHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ScheduledTaskHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_SchedulerEventAppointmentSlot'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_SchedulerEventType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_Screening_CNT'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_Screening_MAP'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_Screening_PPT'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_Screening_PPT_Archive'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_Screening_QST'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ScreeningEvent'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ScreeningEventCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ScreeningEventDate'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_SecurityQuestion'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Hfit_SecurityQuestionSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Hfit_SmallStepResponses'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_SmallSteps'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'hfit_SocialProof'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_SSIS_ScreeningMapping'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_SsoAttributeData'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFIT_SsoConfiguration'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_SsoData'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_SsoRequest'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_SsoRequestAttributes'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_StatbridgeFileDownload'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_SyncTaskSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TermsConditions'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Hfit_TimezoneConfiguration'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TipOfTheDay'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Hfit_TipOfTheDayCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Hfit_TipOfTheDayCategoryCT'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_Tobacco_Goal'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ToDoPersonal'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ToDoSmallSteps'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TodoSource'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFIT_Tracker'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerBloodPressure'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerBloodSugarAndGlucose'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerBMI'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerBodyFat'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerBodyMeasurements'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerCardio'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerCholesterol'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerCollectionSource'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerCotinine'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerDailySteps'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerDef_Item'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerDef_Tracker'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerDocument'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerFlexibility'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerFruits'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerHbA1c'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerHeight'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerHighFatFoods'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerHighSodiumFoods'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerInstance_Item'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerInstance_Tracker'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerMealPortions'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerMedicalCarePlan'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerPreventiveCare'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerRegularMeals'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerRestingHeartRate'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerShots'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerSitLess'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerSleepPlan'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerStrength'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerStress'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerStressManagement'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerSugaryDrinks'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerSugaryFoods'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerSummary'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerTests'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerTobaccoAttestation'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerTobaccoFree'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerVegetables'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerWater'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerWeight'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_TrackerWholeGrains'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_UnitOfMeasure'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_UserCoachingAlert_MeetNotModify'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_UserCoachingAlert_NotMet'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_UserGoal'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_UserRewardPoints'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_UserSchedulerAppointment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_UserSearch'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_UserTracker'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_UserTrackerCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ValMeasures'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ValMeasureType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_ValMeasureValues'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_WellnessGoal'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'HFit_WellnessGoals'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'MART_EDW_HealthAssesment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'Messaging_Message'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'OM_ABVariant'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'OM_Account'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'OM_AccountContact'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'OM_AccountStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'OM_Activity'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'OM_ActivityType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'OM_Contact'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'OM_ContactGroup'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'OM_ContactGroupMember'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'OM_ContactRole'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'OM_ContactStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'OM_IP'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'OM_Membership'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'OM_MVTCombination'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'OM_MVTCombinationVariation'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'OM_MVTVariant'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'OM_PageVisit'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'OM_PersonalizationVariant'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'OM_Rule'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'OM_Score'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'OM_ScoreContactRule'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'OM_Search'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'OM_UserAgent'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'PM_Project'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'PM_ProjectRolePermission'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'PM_ProjectStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'PM_ProjectTask'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'PM_ProjectTaskPriority'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'PM_ProjectTaskStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'RPT_CoachingFromPortal'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'SM_FacebookAccount'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'SM_FacebookApplication'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'SM_LinkedInAccount'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'SM_TwitterAccount'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'SM_TwitterApplication'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_2', 'tmp_HealthAssessmentData'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Board_Board'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Board_Message'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Chat_Message'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Chat_Room'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Chat_User'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_AbuseReport'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_ACL'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_ACLItem'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_AllowedChildClasses'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_AlternativeForm'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Attachment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_AttachmentForEmail'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_AttachmentHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_AutomationHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_AutomationState'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Avatar'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Badge'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_BannedIP'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Banner'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_BannerCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Category'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Class'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_ClassSite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Country'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_CssStylesheet'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_CssStylesheetSite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Culture'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_DeviceProfile'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_DeviceProfileLayout'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Document'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_DocumentAlias'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_DocumentCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_DocumentTag'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_DocumentTypeScope'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_DocumentTypeScopeClass'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Email'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_EmailAttachment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_EmailUser'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Form'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_FormRole'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_FormUserControl'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_HelpTopic'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_InlineControl'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_InlineControlSite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Layout'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_LicenseKey'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_MacroRule'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Membership'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_MembershipRole'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_MembershipUser'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_MetaFile'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_ObjectRelationship'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_ObjectSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_ObjectVersionHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_ObjectWorkflowTrigger'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_OpenIDUser'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Permission'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Personalization'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Query'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Relationship'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_RelationshipName'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_RelationshipNameSite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Resource'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_ResourceLibrary'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_ResourceSite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_ResourceString'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_ResourceTranslation'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Role'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_RoleApplication'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_RolePermission'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_RoleUIElement'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_ScheduledTask'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_SearchEngine'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_SearchIndex'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_SearchIndexCulture'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_SearchIndexSite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_SearchTask'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Session'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_settingkeybak'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_SettingsCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_SettingsKey'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Site'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_SiteCulture'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_SiteDomainAlias'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_SMTPServer'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_SMTPServerSite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_State'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Tag'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_TagGroup'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_TimeZone'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Transformation'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_TranslationService'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_TranslationSubmission'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_TranslationSubmissionItem'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Tree'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_UIElement'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'cms_user'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_UserCulture'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_UserRole'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'cms_usersettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'cms_usersite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_VersionAttachment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_VersionHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_WebFarmServer'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_WebFarmServerTask'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_WebFarmTask'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_WebPart'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_WebPartCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_WebPartContainer'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_WebPartContainerSite'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_WebPartLayout'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Widget'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_WidgetCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_WidgetRole'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_Workflow'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_WorkflowAction'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_WorkflowHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_WorkflowScope'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_WorkflowStep'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_WorkflowStepRoles'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_WorkflowStepUser'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_WorkflowTransition'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'CMS_WorkflowUser'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'coachExclusion'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_Address'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_Bundle'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_Carrier'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_CouponCode'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_Currency'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_CurrencyExchangeRate'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_Customer'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_CustomerCreditHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_Department'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_DepartmentTaxClass'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_Discount'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_DiscountCoupon'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_ExchangeTable'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_InternalStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_Manufacturer'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_MultiBuyCouponCode'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_MultiBuyDiscount'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_MultiBuyDiscountDepartment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_MultiBuyDiscountSKU'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_OptionCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_Order'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_OrderAddress'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_OrderItem'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_OrderItemSKUFile'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_OrderStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_OrderStatusUser'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_PaymentOption'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_PaymentShipping'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_PublicStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_ShippingCost'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_ShippingOption'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_ShippingOptionTaxClass'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_ShoppingCart'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_ShoppingCartSKU'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_SKU'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_SKUAllowedOption'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_SKUDiscountCoupon'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_SKUFile'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_SKUOptionCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_SKUTaxClasses'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_Supplier'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_TaxClass'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_TaxClassCountry'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_TaxClassState'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_UserDepartment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_VariantOption'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_VolumeDiscount'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'COM_Wishlist'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Community_Friend'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Community_Group'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Community_GroupMember'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Community_GroupRolePermission'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Community_Invitation'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'EDW_GroupMemberHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'EDW_GroupMemberToday'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'EDW_HealthAssessment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'EDW_HealthAssessmentDefinition'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'EDW_PerformanceMeasure'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'EDW_RoleMemberHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'EDW_RoleMembership'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'EDW_RoleMemberToday'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFIT_Account'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_Announcements'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_BiometricData'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_Blurb'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_Calculator'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CallList'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CentralConfig'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'hfit_challenge'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'hfit_ChallengeAbout'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'hfit_challengeBase'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'hfit_ChallengeFAQ'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'hfit_challengeGeneralSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ChallengeNewsletter'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ChallengeNewsletterRelationship'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'hfit_challengeOffering'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ChallengeRegistrationEmail'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ChallengeRegistrations'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ChallengeRegistrationSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'hfit_ChallengeTeam'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'hfit_ChallengeTeams'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'hfit_challengeTypes'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ChallengeUserRegistration'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_Class'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ClassType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Hfit_Client'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ClientContact'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Hfit_ClientDeviceSuspensionLog'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ClientSecurityQuestions'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CMS_User_CHANGES'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_Coaches'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingAuditLog'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingCommitToQuit'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingEnrollmentReport'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingEnrollmentSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingEvalHAOverall'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingEvalHAQA'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingEvalHARiskArea'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingEvalHARiskCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingEvalHARiskModule'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingGetStarted'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingHealthActionPlan'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingHealthArea'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingHealthInterest'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingLibraryHealthArea'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingLibraryResource'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingLibraryResources'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingLibrarySettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingMyGoalsSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingMyHealthInterestsSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingNotAssignedSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingPrivacyPolicy'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingSessionCompleted'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Hfit_CoachingSystemSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingTermsAndConditionsSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Hfit_CoachingUserCMCondition'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Hfit_CoachingUserCMExclusion'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingUserServiceLevel'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_CoachingWelcomeSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_Company'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_configFeatures'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_configGroupToFeature'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_Configuration'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_Configuration_CallLogCoaching'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFIT_Configuration_CMCoaching'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFIT_Configuration_HACoaching'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_Configuration_LMCoaching'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFIT_Configuration_Screening'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ConsentAndRelease'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ConsentAndReleaseAgreement'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ContactGroupMembership'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ContactGroupSyncExclude'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ContentBlock'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_DataEntry_Clinical'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_EligibilityLoadTracking'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_Event'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_EventType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_FooterAdministration'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_Fulfillment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_FulfillmentCodes'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_Goal'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_GoalCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_GoalSubCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_GroupAddUsers'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_GroupRebuildSchedule'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_GroupRemovedUsers'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HA_IPadExceptionLog'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HA_IPadLog'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HA_UseAndDisclosure'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HAAgreement'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HACampaign'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Hfit_HACampaigns'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Hfit_HAHealthCheckCampaignData'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Hfit_HAHealthCheckCodes'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Hfit_HAHealthCheckLog'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HaScoringStrategies'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HAWelcomeSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAdvisingSessionCompleted'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentAnswerCodeNames'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentAnswers'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentMatrixQuestion'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentModule'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentModuleCodeNames'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentMultipleChoiceQuestion'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentPhysicalActivityScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentPredefinedAnswer'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentQuestionCodeNames'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentQuestionGroupCodeNames'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentRecomendationClientConfig'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentRecomendations'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentRecomendationTypes'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentRiskArea'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentRiskAreaCodeNames'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentRiskCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentRiskCategoryCodeNames'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentStarted'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentThresholdGrouping'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentThresholds'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentThresholdTypes'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentUserAnswers'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentUserModule'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentUserQuestion'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentUserQuestionGroupResults'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentUserQuestionImport'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentUserRiskArea'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentUserRiskCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssesmentUserStarted'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssessment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssessmentBmiScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssessmentCodeNamesToTrackerMapping'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssessmentConfiguration'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Hfit_HealthAssessmentDataForImport'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssessmentDataForMissingResponses'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssessmentDiasBpScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssessmentFastingGlucoseScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssessmentFreeForm'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssessmentHbA1cScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssessmentHDLScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssessmentLDLScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssessmentModuleConfiguration'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssessmentNonFastingGlucoseScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssessmentPaperException'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssessmentSysBpScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssessmentTCHDLRatioScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssessmentTCScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthAssessmentTriglyceridesScoring'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HealthSummarySettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HES_Award'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HESChallenge'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HESChallengeTable'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HRA'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HSAbout'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HSBiometricChart'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HSGraphRangeSetting'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HSHealthMeasuresSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_HSLearnMoreDocument'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_Join_ClinicalSourceTracker'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_join_ClinicalTrackers'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_CallResult'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_CardioActivityIntensity'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_CoachingAuditLogType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_CoachingCMConditions'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_CoachingCMExclusions'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_CoachingOptOutReason'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_CoachingServiceLevel'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_CoachingServiceLevelStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_ContactGroupType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Hfit_LKP_CustomTrackerDefaultMetadata'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFIT_LKP_EDW_REJECTMPI'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_FastingState'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_Frequency'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_FulfillmentFeatures'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_GoalCloseReason'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_GoalStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_HealthAssessmentImportStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_HES_AwardType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_HES_ValueType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Hfit_LKP_NicotineAssessment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_RewardActivity'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_RewardCompleted'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_RewardCompleted_FIX'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_RewardFrequency'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_RewardGroupLevel'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_RewardLevel'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_RewardLevelType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_RewardTrigger'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_RewardTriggerParameter'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_RewardTriggerParameterOperator'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_RewardType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_ScheduledNotificationDeliveryType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_StressManagementActivity'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_TrackerCardioActivity'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_TrackerFlexibilityActivity'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_TrackerSleepPlanTechniques'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_TrackerStrengthActivity'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_TrackerTable'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_TrackerTobaccoQuitAids'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_TrackerVendor'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_UnitOfMeasure'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LKP_UserType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_LoginPageSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Hfit_MarketplaceProduct'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Hfit_MarketplaceProductTypes'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_Message'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_MockMpiData'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Hfit_MyHealthSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_Newsletter'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_OutComeMessages'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_Pillar'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_PLPPackageContent'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'hfit_Post'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_PostChallenge'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_PostHealthEducation'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_PostMessage'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_PostQuote'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_PostReminder'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_PostSubscriber'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_PostSubscriber_ContactBackup'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_PostSubscriber_ContactMap'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'hfit_PPTEligibility'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFIt_PptEligibility_mosbrun'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_PPTStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_PPTStatus_CR27070'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_PPTStatusEnum'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_PPTStatusIpadMappingCodeCleanup'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_PrivacyPolicy'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ProgramFeedNotificationSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_Ref_RewardTrackerValidation'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RegistrationWelcome'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardAboutInfoItem'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardActivity'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardDatesAggregator'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardDefaultSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardException'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardGroup'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardGroupComplete'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardGroupSummary'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardLevel'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardOverrideLog'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardParameterBase'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardProgram'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardsAboutInfoItem'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardsAwardUserDetail'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardsAwardUserDetailArchive'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardsReprocessQueue'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardsUserActivityDetail'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardsUserInterfaceState'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardsUserLevelDetail'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardsUserRepeatableTriggerDetail'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardsUserSummary'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardsUserSummaryArchive'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardsUserTrigger'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardTrigger'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardTriggerParameter'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RewardTriggerTobaccoParameter'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_RightsResponsibilities'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ScheduledNotification'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ScheduledNotificationHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ScheduledTaskHistory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_SchedulerEventAppointmentSlot'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_SchedulerEventType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_Screening_CNT'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_Screening_MAP'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_Screening_PPT'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_Screening_PPT_Archive'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_Screening_QST'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ScreeningEvent'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ScreeningEventCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ScreeningEventDate'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_SecurityQuestion'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Hfit_SecurityQuestionSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Hfit_SmallStepResponses'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_SmallSteps'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'hfit_SocialProof'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_SSIS_ScreeningMapping'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_SsoAttributeData'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFIT_SsoConfiguration'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_SsoData'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_SsoRequest'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_SsoRequestAttributes'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_StatbridgeFileDownload'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_SyncTaskSettings'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TermsConditions'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Hfit_TimezoneConfiguration'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TipOfTheDay'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Hfit_TipOfTheDayCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Hfit_TipOfTheDayCategoryCT'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_Tobacco_Goal'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ToDoPersonal'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ToDoSmallSteps'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TodoSource'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFIT_Tracker'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerBloodPressure'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerBloodSugarAndGlucose'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerBMI'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerBodyFat'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerBodyMeasurements'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerCardio'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerCholesterol'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerCollectionSource'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerCotinine'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerDailySteps'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerDef_Item'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerDef_Tracker'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerDocument'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerFlexibility'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerFruits'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerHbA1c'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerHeight'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerHighFatFoods'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerHighSodiumFoods'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerInstance_Item'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerInstance_Tracker'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerMealPortions'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerMedicalCarePlan'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerPreventiveCare'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerRegularMeals'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerRestingHeartRate'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerShots'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerSitLess'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerSleepPlan'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerStrength'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerStress'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerStressManagement'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerSugaryDrinks'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerSugaryFoods'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerSummary'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerTests'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerTobaccoAttestation'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerTobaccoFree'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerVegetables'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerWater'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerWeight'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_TrackerWholeGrains'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_UnitOfMeasure'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_UserCoachingAlert_MeetNotModify'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_UserCoachingAlert_NotMet'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_UserRewardPoints'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_UserSchedulerAppointment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_UserSearch'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_UserTracker'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_UserTrackerCategory'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ValMeasures'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ValMeasureType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_ValMeasureValues'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_WellnessGoal'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'HFit_WellnessGoals'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'MART_EDW_HealthAssesment'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'Messaging_Message'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'OM_ABVariant'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'OM_Account'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'OM_AccountContact'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'OM_AccountStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'OM_Activity'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'OM_ActivityType'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'OM_Contact'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'OM_ContactGroup'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'OM_ContactGroupMember'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'OM_ContactRole'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'OM_ContactStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'OM_IP'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'OM_Membership'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'OM_MVTCombination'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'OM_MVTCombinationVariation'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'OM_MVTVariant'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'OM_PageVisit'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'OM_PersonalizationVariant'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'OM_Rule'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'OM_Score'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'OM_ScoreContactRule'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'OM_Search'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'OM_UserAgent'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'PM_Project'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'PM_ProjectRolePermission'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'PM_ProjectStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'PM_ProjectTask'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'PM_ProjectTaskPriority'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'PM_ProjectTaskStatus'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'RPT_CoachingFromPortal'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'SM_FacebookAccount'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'SM_FacebookApplication'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'SM_LinkedInAccount'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'SM_TwitterAccount'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'SM_TwitterApplication'
GO
exec proc_TurnChangeTrackingOnTable 'KenticoCMS_3', 'tmp_HealthAssessmentData'
GO