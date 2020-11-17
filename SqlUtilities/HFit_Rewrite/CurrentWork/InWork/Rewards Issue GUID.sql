select top 100 * from sys.views where name like '%EDW_reward%'
--view_EDW_RewardAwardDetail	--DONE
--View_EDW_RewardProgram_Joined	--DONE
--view_EDW_RewardsDefinition -- DONE
--view_EDW_RewardTriggerParameters --DONE
--view_EDW_RewardUserDetail	--DONE
--view_EDW_RewardUserLevel --DONE

--exec proc_getViewsNestedObjects 'view_EDW_RewardAwardDetail'
with XCTE (TABLE_NAME,COLUMN_NAME)
as
(
	select TABLE_NAME, COLUMN_NAME
	from information_schema.columns where column_name like '%GUID%'
)	
select * from information_schema.columns 
	where Column_name like '%ID'
	and table_name in (select table_name from XCTE)
and table_name in
(
'CMS_Class'
,'CMS_Document'
,'CMS_Site'
,'CMS_Tree'
,'CMS_User'
,'CMS_UserSettings'
,'CMS_UserSite'
,'COM_SKU'
,'HFit_Account'
,'HFit_RewardLevel'
,'HFit_RewardsAwardUserDetail'
,'View_CMS_Tree_Joined'
,'View_CMS_Tree_Joined_Linked'
,'View_CMS_Tree_Joined_Regular'
,'View_COM_SKU'
,'view_EDW_RewardAwardDetail'
,'View_HFit_RewardLevel_Joined'
)
order by Table_name, Column_name

--exec proc_getViewsNestedObjects 'View_EDW_RewardProgram_Joined'
--exec proc_getViewsNestedObjects 'view_EDW_RewardsDefinition'
with XCTE (TABLE_NAME,COLUMN_NAME)
as
(
	select TABLE_NAME, COLUMN_NAME
	from information_schema.columns where column_name like '%GUID%'
)	
select * from information_schema.columns 
	where Column_name like '%ID'
	and table_name in (select table_name from XCTE)
	and table_name in 
(
'CMS_Class'
,'CMS_Document'
,'CMS_Site'
,'CMS_Tree'
,'CMS_User'
,'CMS_UserSettings'
,'CMS_UserSite'
,'COM_SKU'
,'HFit_Account'
,'HFit_LKP_RewardLevelType'
,'HFit_LKP_RewardTrigger'
,'HFit_LKP_RewardType'
,'HFit_RewardActivity'
,'HFit_RewardException'
,'HFit_RewardGroup'
,'HFit_RewardLevel'
,'HFit_RewardProgram'
,'HFit_RewardsAwardUserDetail'
,'HFit_RewardsUserActivityDetail'
,'HFit_RewardsUserLevelDetail'
,'HFit_RewardTrigger'
,'HFit_RewardTriggerParameter'
,'View_CMS_Tree_Joined'
,'View_CMS_Tree_Joined_Linked'
,'View_CMS_Tree_Joined_Regular'
,'View_COM_SKU'
,'view_EDW_RewardAwardDetail'
,'view_EDW_RewardsDefinition'
,'view_EDW_RewardUserDetail'
,'view_EDW_RewardUserLevel'
,'View_HFit_RewardActivity_Joined'
,'View_HFit_RewardGroup_Joined'
,'View_HFit_RewardLevel_Joined'
,'View_HFit_RewardProgram_Joined'
,'View_HFit_RewardTrigger_Joined'
,'View_HFit_RewardTriggerParameter_Joined'
)
order by table_name, column_name

--exec proc_getViewsNestedObjects 'view_EDW_RewardTriggerParameters'
--exec proc_getViewsNestedObjects 'view_EDW_RewardUserDetail'
with XCTE (TABLE_NAME,COLUMN_NAME)
as
(
	select TABLE_NAME, COLUMN_NAME
	from information_schema.columns where column_name like '%GUID%'
)	
select * from information_schema.columns 
	where Column_name like '%ID'
	and table_name in (select table_name from XCTE)
	and table_name in 
(
'CMS_Class'
,'CMS_Document'
,'CMS_Site'
,'CMS_Tree'
,'CMS_User'
,'CMS_UserSettings'
,'CMS_UserSite'
,'COM_SKU'
,'HFit_Account'
,'HFit_LKP_RewardLevelType'
,'HFit_LKP_RewardTrigger'
,'HFit_LKP_RewardType'
,'HFit_RewardActivity'
,'HFit_RewardException'
,'HFit_RewardGroup'
,'HFit_RewardLevel'
,'HFit_RewardProgram'
,'HFit_RewardsAwardUserDetail'
,'HFit_RewardsUserActivityDetail'
,'HFit_RewardsUserLevelDetail'
,'HFit_RewardTrigger'
,'View_CMS_Tree_Joined'
,'View_CMS_Tree_Joined_Linked'
,'View_CMS_Tree_Joined_Regular'
,'View_COM_SKU'
,'view_EDW_RewardAwardDetail'
,'view_EDW_RewardUserDetail'
,'View_HFit_RewardActivity_Joined'
,'View_HFit_RewardGroup_Joined'
,'View_HFit_RewardLevel_Joined'
,'View_HFit_RewardProgram_Joined'
,'View_HFit_RewardTrigger_Joined'
)
order by table_name, column_name

--exec proc_getViewsNestedObjects 'view_EDW_RewardUserLevel'
with XCTE (TABLE_NAME,COLUMN_NAME)
as
(
	select TABLE_NAME, COLUMN_NAME
	from information_schema.columns where column_name like '%GUID%'
)	
select * from information_schema.columns 
	where Column_name like '%ID'
	and table_name in (select table_name from XCTE)
	and table_name in 
(
'CMS_Class'
,'CMS_Document'
,'CMS_Site'
,'CMS_Tree'
,'CMS_User'
,'CMS_UserSettings'
,'CMS_UserSite'
,'COM_SKU'
,'HFit_Account'
,'HFit_LKP_RewardLevelType'
,'HFit_LKP_RewardTrigger'
,'HFit_LKP_RewardType'
,'HFit_RewardActivity'
,'HFit_RewardException'
,'HFit_RewardGroup'
,'HFit_RewardLevel'
,'HFit_RewardProgram'
,'HFit_RewardsAwardUserDetail'
,'HFit_RewardsUserActivityDetail'
,'HFit_RewardsUserLevelDetail'
,'HFit_RewardTrigger'
,'HFit_CMS_Tree_Joined'
,'HFit_CMS_Tree_Joined_Linked'
,'HFit_CMS_Tree_Joined_Regular'
,'HFit_COM_SKU'
,'HFit_EDW_RewardAwardDetail'
,'HFit_EDW_RewardUserDetail'
,'HFit_EDW_RewardUserLevel'
,'HFit_HFit_RewardActivity_Joined'
,'HFit_HFit_RewardGroup_Joined'
,'HFit_HFit_RewardLevel_Joined'
,'HFit_HFit_RewardProgram_Joined'
,'HFit_HFit_RewardTrigger_Joined'
)
order by table_name, column_name


