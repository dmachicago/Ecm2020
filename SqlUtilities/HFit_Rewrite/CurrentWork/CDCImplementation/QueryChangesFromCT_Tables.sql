
DECLARE @synchronization_version AS int = 0;
SET @synchronization_version = CHANGE_TRACKING_CURRENT_VERSION () ;

--Get a list of tables that are being tracked for changes

SELECT
	   sys.schemas.name AS Schema_name
	 , sys.tables.name AS  Table_name
	   FROM sys.change_tracking_tables
				JOIN sys.tables
					ON sys.tables.object_id = sys.change_tracking_tables.object_id
				 JOIN sys.schemas
					ON sys.schemas.schema_id = sys.tables.schema_id
ORDER BY sys.tables.name ;

--set up change tracking on the table
ALTER TABLE dbo.SchemaChangeMonitor ENABLE CHANGE_TRACKING
		WITH (TRACK_COLUMNS_UPDATED = ON) ;

--select * from SchemaChangeMonitor

SELECT
	   CHANGE_TRACKING_CURRENT_VERSION () ;
SET @synchronization_version = CHANGE_TRACKING_CURRENT_VERSION () ;
SELECT
	   CT.ItemID
	 , SSR.ItemCreatedWhen
	 , SSR.ItemModifiedWhen
	 , CT.SYS_CHANGE_OPERATION
	 , CT.SYS_CHANGE_COLUMNS
	 , CT.SYS_CHANGE_CONTEXT
	   FROM SchemaChangeMonitor AS SSR
				LEFT Outer JOIN CHANGETABLE (CHANGES SchemaChangeMonitor, @synchronization_version) AS CT
					ON SSR.ItemID = CT.ItemID;
SELECT
	   CHANGE_TRACKING_CURRENT_VERSION () ;
DECLARE @last_synchronization_version AS bigint = 0;
SET @last_synchronization_version = CHANGE_TRACKING_CURRENT_VERSION () ;
SELECT
	   CT.RowNbr
	 , CT.SYS_CHANGE_OPERATION
	 , CT.SYS_CHANGE_COLUMNS
	 , CT.SYS_CHANGE_CONTEXT
	   FROM CHANGETABLE (CHANGES dbo.SchemaChangeMonitor, @last_synchronization_version) AS CT;

select ct.* from CHANGETABLE (CHANGES CMS_Class, null) as ct ;
select ct.* from CHANGETABLE (CHANGES CMS_Document, null) as ct ;
select ct.* from CHANGETABLE (CHANGES CMS_Site, null) as ct ;
select ct.* from CHANGETABLE (CHANGES CMS_Tree, null) as ct ;
select ct.* from CHANGETABLE (CHANGES CMS_User, null) as ct ;
select ct.* from CHANGETABLE (CHANGES CMS_UserSettings, null) as ct ;
select ct.* from CHANGETABLE (CHANGES CMS_UserSite, null) as ct ;
select ct.* from CHANGETABLE (CHANGES COM_SKU, null) as ct ;
select ct.* from CHANGETABLE (CHANGES HFit_Account, null) as ct ;
select ct.* from CHANGETABLE (CHANGES HFit_HACampaign, null) as ct ;
select ct.* from CHANGETABLE (CHANGES HFit_HealthAssesmentMatrixQuestion, null) as ct ;
select ct.* from CHANGETABLE (CHANGES HFit_HealthAssesmentModule, null) as ct ;
select ct.* from CHANGETABLE (CHANGES HFit_HealthAssesmentMultipleChoiceQuestion, null) as ct ;
select ct.* from CHANGETABLE (CHANGES HFit_HealthAssesmentPredefinedAnswer, null) as ct ;
select ct.* from CHANGETABLE (CHANGES HFit_HealthAssesmentRiskArea, null) as ct ;
select ct.* from CHANGETABLE (CHANGES HFit_HealthAssesmentRiskCategory, null) as ct ;
select ct.* from CHANGETABLE (CHANGES HFit_HealthAssesmentUserAnswers, null) as ct ;
select ct.* from CHANGETABLE (CHANGES HFit_HealthAssesmentUserModule, null) as ct ;
select ct.* from CHANGETABLE (CHANGES HFit_HealthAssesmentUserQuestion, null) as ct ;
select ct.* from CHANGETABLE (CHANGES HFit_HealthAssesmentUserQuestionGroupResults, null) as ct ;
select ct.* from CHANGETABLE (CHANGES HFit_HealthAssesmentUserRiskArea, null) as ct ;
select ct.* from CHANGETABLE (CHANGES HFit_HealthAssesmentUserRiskCategory, null) as ct ;
select ct.* from CHANGETABLE (CHANGES HFit_HealthAssesmentUserStarted, null) as ct ;
select ct.* from CHANGETABLE (CHANGES HFit_HealthAssessment, null) as ct ;
select ct.* from CHANGETABLE (CHANGES HFit_HealthAssessmentFreeForm, null) as ct ;
select ct.* from CHANGETABLE (CHANGES HFit_LKP_EDW_RejectMPI, null) as ct ;

/****************************************************************************************************************************************************************************************************************************************************************
CHANGETABLE(CHANGES...)
To obtain row data for new or modified rows, join the result set to the user table by using the primary key 
columns. Only one row is returned for each row in the user table that has been changed, even if there have 
been multiple changes to the same row since the last_sync_version value.

Primary key column changes are never marked as updates. If a primary key value changes, it is considered to 
be a delete of the old value and an insert of the new value.

If you delete a row and then insert a row that has the old primary key, the change is seen as an update to 
all columns in the row.

The values that are returned for the SYS_CHANGE_OPERATION and SYS_CHANGE_COLUMNS columns are relative to the 
baseline (last_sync_version) that is specified. For example, if an insert operation was made at version 10 and 
an update operation at version 15, and if the baseline last_sync_version is 12, an update will be reported. If 
the last_sync_version value is 8, an insert will be reported. SYS_CHANGE_COLUMNS will never report computed 
columns as having been updated.

Generally, all operations that insert, update, or delete of data in user tables are tracked, including the MERGE statement.

The following operations that affect user table data are not tracked:
Executing the UPDATETEXT statement
This statement is deprecated and will be removed in a future version of SQL Server. However, changes that are made by using 
the .WRITE clause of the UPDATE statement are tracked.

Deleting rows by using TRUNCATE TABLE
When a table is truncated, the change tracking version information that is associated with the table is reset as if change 
tracking has just been enabled on the table. A client application should always validate its last synchronized version. The 
validation fails if the table has been truncated.

CHANGETABLE(VERSION...)
An empty result set is returned if a nonexistent primary key is specified.
The value of SYS_CHANGE_VERSION might be NULL if a change has not been made for longer than the retention period (for example, the cleanup has removed the change information) or the row has never been changed since change tracking was enabled for the table.
****************************************************************************************************************************************************************************************************************************************************************/

SELECT
	   CHANGE_TRACKING_CURRENT_VERSION () ;
DECLARE @last_synchronization_version AS bigint = 0;
SET @last_synchronization_version = (SELECT CHANGE_TRACKING_CURRENT_VERSION () - 1) ;
SELECT
	   ct.*
	   FROM CHANGETABLE (CHANGES [CMS_Site], NULL) AS CT;
SELECT
	   CT.RowNbr
	 , CT.SYS_CHANGE_OPERATION
	 , CT.SYS_CHANGE_COLUMNS
	 , CT.SYS_CHANGE_CONTEXT
	 , ct.*
	   FROM CHANGETABLE (CHANGES dbo.SchemaChangeMonitor, @last_synchronization_version) AS CT;

/***************************************************************************************************
Usually, the EDW will want to obtain the latest data for a row instead of only the primary keys 
for the row. Therefore, we will join the results from CHANGETABLE(CHANGES …) with 
the data in the view tables. For example, the following query joins with the Schema Monitor table 
to obtain the values for some of the columns. Note the use of OUTER JOIN. This is 
required to make sure that the change information is returned for those rows that have been deleted 
from the table. However, the "DATA" cannot be returned as it has been deleted.

It will be necessary to track the SYS_CHANGE_VERSION for each pull so that only "changed" rows will
be returned. There will be considerable effort to manage changes.
***************************************************************************************************/

SELECT
	   CHANGE_TRACKING_CURRENT_VERSION () ;
DECLARE @last_synchronization_version AS bigint = 0;
SET @last_synchronization_version = (SELECT
											CHANGE_TRACKING_CURRENT_VERSION () - 1) ;
--Set the below to bring back all CT ROWS
SET @last_synchronization_version = NULL;
SELECT
	   SM.PostTime
	 , SM.DB_User
	 , SM.IP_Address
	 , SM.CUR_User
	 , SM.Event
	 , SM.OBJ
	 , CT.RowNbr
	 , CT.SYS_CHANGE_OPERATION
	 , CT.SYS_CHANGE_COLUMNS
	 , CT.SYS_CHANGE_CONTEXT
	 , CT.SYS_CHANGE_VERSION
	   FROM SchemaChangeMonitor AS SM
				RIGHT OUTER JOIN CHANGETABLE (CHANGES SchemaChangeMonitor, @last_synchronization_version) AS CT
					ON SM.RowNbr = CT.RowNbr;


SELECT
	   CHANGE_TRACKING_CURRENT_VERSION () ;
SET @last_synchronization_version = (SELECT
											CHANGE_TRACKING_CURRENT_VERSION () - 1) ;
--Set the below to bring back all CT ROWS
SET @last_synchronization_version = NULL;
SELECT
	   CT.NodeID as CT_KEY
	 , CT.SYS_CHANGE_OPERATION
	 , CT.SYS_CHANGE_COLUMNS
	 , CT.SYS_CHANGE_CONTEXT
	 , CT.SYS_CHANGE_VERSION
	 ,  SM.*
	   FROM CMS_Tree AS SM
				RIGHT OUTER JOIN CHANGETABLE (CHANGES CMS_Tree, @last_synchronization_version) AS CT
					ON SM.NodeID = CT.NodeID;