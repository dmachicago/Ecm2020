
/*
--job_VerifySurrogateKeyData

CREATE PROCEDURE [dbo].[proc_UpdateSurrogateKeyDataBetweenParentAndChild] (
       @ParentTable AS NVARCHAR (254) 
     , @ParentSurrogateKeyName AS NVARCHAR (254) 
     , @ChildTable AS NVARCHAR (254) 
     , @ParentColumn AS NVARCHAR (254) 
     , @ChildColumn AS NVARCHAR (254) 
     , @PreviewOnly AS BIT = 1
	, @ResetSurrogateKey as bit = 0 
*/
go

truncate table BASE_HFit_UserGoal ;
exec proc_BASE_HFit_UserGoal_KenticoCMS_1_SYNC 1;
exec proc_BASE_HFit_UserGoal_KenticoCMS_2_SYNC 1;
exec proc_BASE_HFit_UserGoal_KenticoCMS_3_SYNC 1;
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 'BASE_CMS_User', 'SurrogateKey_CMS_User','BASE_HFit_UserGoal','UserID', 'UserID',0,1 ;

exec proc_BASE_HFit_UserGoal_KenticoCMS_1_SYNC 1;
exec proc_BASE_HFit_UserGoal_KenticoCMS_2_SYNC 1;
exec proc_BASE_HFit_UserGoal_KenticoCMS_3_SYNC 1;
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 'BASE_CMS_User', 'SurrogateKey_CMS_User','BASE_HFit_UserGoal','UserID', 'UserID',0,1 ;

truncate table BASE_HFit_UserGoal;
exec proc_BASE_HFit_UserGoal_KenticoCMS_1_SYNC 1
exec proc_BASE_HFit_UserGoal_KenticoCMS_2_SYNC 1
exec proc_BASE_HFit_UserGoal_KenticoCMS_3_SYNC 1
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 'BASE_CMS_User', 'SurrogateKey_CMS_User','BASE_HFit_UserGoal','UserID', 'UserID',0,1 ;

truncate table BASE_HFit_GoalOutcome
exec proc_BASE_HFit_GoalOutcome_KenticoCMS_1_SYNC 1
exec proc_BASE_HFit_GoalOutcome_KenticoCMS_2_SYNC 1
exec proc_BASE_HFit_GoalOutcome_KenticoCMS_3_SYNC 1
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 'BASE_Hfit_UserGoal', 'SurrogateKey_Hfit_UserGoal','BASE_HFit_GoalOutcome','ItemID', 'UserGoalItemID',0 ;

exec proc_GenBaseTableFromView 'KenticoCMS_1', 'View_HFit_Goal_Joined', 'no', 0, 0
exec proc_GenBaseTableFromView 'KenticoCMS_2', 'View_HFit_Goal_Joined', 'no', 1, 0
exec proc_GenBaseTableFromView 'KenticoCMS_3', 'View_HFit_Goal_Joined', 'no', 1, 0

select * from BASE_View_HFit_Goal_Joined
truncate table BASE_View_HFit_Goal_Joined;
exec proc_View_HFit_Goal_Joined_KenticoCMS_1 1
exec proc_View_HFit_Goal_Joined_KenticoCMS_2 1
exec proc_View_HFit_Goal_Joined_KenticoCMS_3 1
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 'BASE_CMS_User', 'SurrogateKey_CMS_User','BASE_HFit_Goal_Joined','UserID', 'UserID',0,1 ;

go
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild "BASE_CMS_Tree", "SurrogateKey_CMS_Tree","BASE_CMS_Class","NodeClassID", "ClassID",1
exec proc_UpdateSurrogateKeyDataBetweenParentAndChild "BASE_CMS_Tree", "SurrogateKey_CMS_Tree","BASE_CMS_Class","NodeClassID", "ClassID",1

exec proc_UpdateSurrogateKeyDataBetweenParentAndChild 'BASE_CMS_User', 'SurrogateKey_CMS_User','BASE_Board_Message','UserID', 'MessageUserID',0, 1

--select 'exec proc_UpdateSurrogateKeyDataBetweenParentAndChild ''BASE_CMS_User'', ''SurrogateKey_CMS_Tree'', ''' + table_name
--+',''SurrogateKey_CMS_Tree'' ' + column_name 
select * 
from information_schema.columns C
join information_schema.tables T
on T.table_name = C.table_name 
and T.table_name not like '%[_]view[_]%'
and T.table_type = 'BASE TABLE'
where column_name like '%UserID%'
and C.table_schema = 'dbo'
and T.table_name not like '%[_]del'
and T.table_name not like '%[_]testdata'
and column_name not like 'CT[_]%'
order by T.table_name

update T
    set T.SurrogateKey_CMS_user = U.SurrogateKey_CMS_user
    from BASE_CMS_User U
    join 
    BASE_HFit_TrackerCardio T 
    on U.DBNAME = T.DBNAME 
    and U.UserID = T.UserID
    and T.SurrogateKey_CMS_user is null

