IF EXISTS (SELECT name
                 FROM sys.views
                 WHERE name = 'MART_View_OM_ContactGroupMember_HASH') 
    drop view     MART_View_OM_ContactGroupMember_HASH
    go

create view MART_View_OM_ContactGroupMember_HASH
as
SELECT 'KenticoCMS_1' DBNAME, [ContactGroupMemberID]
      ,[ContactGroupMemberContactGroupID]
      ,[ContactGroupMemberType]
      ,[ContactGroupMemberRelatedID]
      ,[ContactGroupMemberFromCondition]
      ,[ContactGroupMemberFromAccount]
      ,[ContactGroupMemberFromManual]
	 , cast(hashbytes('SHA1',
	 (isnull(cast(ContactGroupMemberType as nvarchar(50)),'-') 
	 + isnull(cast([ContactGroupMemberRelatedID] as nvarchar(50)),'-') 
	 + isnull(cast([ContactGroupMemberFromCondition] as nvarchar(50)),'-') 
	 + isnull(cast([ContactGroupMemberFromAccount] as nvarchar(50)),'-')
	 + isnull(cast([ContactGroupMemberFromManual] as nvarchar(50)),'-'))) as nvarchar(50)) HashCode
  FROM KenticoCMS_1.[dbo].[OM_ContactGroupMember]
  union all
  SELECT 'KenticoCMS_2'  DBNAME, [ContactGroupMemberID]
      ,[ContactGroupMemberContactGroupID]
      ,[ContactGroupMemberType]
      ,[ContactGroupMemberRelatedID]
      ,[ContactGroupMemberFromCondition]
      ,[ContactGroupMemberFromAccount]
      ,[ContactGroupMemberFromManual]
	 , cast(hashbytes('SHA1',
	 (isnull(cast(ContactGroupMemberType as nvarchar(50)),'-') 
	 + isnull(cast([ContactGroupMemberRelatedID] as nvarchar(50)),'-') 
	 + isnull(cast([ContactGroupMemberFromCondition] as nvarchar(50)),'-') 
	 + isnull(cast([ContactGroupMemberFromAccount] as nvarchar(50)),'-')
	 + isnull(cast([ContactGroupMemberFromManual] as nvarchar(50)),'-'))) as nvarchar(50)) HashCode
  FROM KenticoCMS_2.[dbo].[OM_ContactGroupMember]
  union all
  SELECT 'KenticoCMS_3' as DBNAME, [ContactGroupMemberID]
      ,[ContactGroupMemberContactGroupID]
      ,[ContactGroupMemberType]
      ,[ContactGroupMemberRelatedID]
      ,[ContactGroupMemberFromCondition]
      ,[ContactGroupMemberFromAccount]
      ,[ContactGroupMemberFromManual]
	 , cast(hashbytes('SHA1',
	 (isnull(cast(ContactGroupMemberType as nvarchar(50)),'-') 
	 + isnull(cast([ContactGroupMemberRelatedID] as nvarchar(50)),'-') 
	 + isnull(cast([ContactGroupMemberFromCondition] as nvarchar(50)),'-') 
	 + isnull(cast([ContactGroupMemberFromAccount] as nvarchar(50)),'-')
	 + isnull(cast([ContactGroupMemberFromManual] as nvarchar(50)),'-'))) as nvarchar(50)) HashCode
  FROM KenticoCMS_3.[dbo].[OM_ContactGroupMember]

