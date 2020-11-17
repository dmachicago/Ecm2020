DBCC FREESYSTEMCACHE ('ALL');
DBCC FREESESSIONCACHE;
DBCC FREEPROCCACHE

/*
select top 100 * from dbo.DIM_EDW_HealthAssessment
    where AccountID = 2
select top 100 * from HFit_HealthAssesmentUserQuestion where userid = 711
select * from HFit_Account
select * from HFit_Account_BACKUP 
select * into HFit_Account_BACKUP from HFit_Account
*/

update HFit_HealthAssesmentUserQuestion
    set HAQuestionWeight = -1
    where UserID = 711 and HAQuestionWeight = 0 

UPDATE HFit_Account
  SET
      AccountCD = UPPER( AccountCD )
  WHERE
        FaceToFaceAdvising = 1;

UPDATE HFit_Account
  SET AccountCD = UPPER( AccountCD )
  WHERE
        FaceToFaceAdvising = 1;
UPDATE HFit_Account
  SET AccountName = 'TEST_CT', AccountCD = 'TESTCT'
  WHERE
        AccountID = 2 and SiteID = 9 

--******************************************************
exec proc_STAGING_EDW_HA_Changes 0
--******************************************************

update HFit_HealthAssesmentUserQuestion
    set HAQuestionWeight = 0
    where UserID = 711 and HAQuestionWeight = -1 
UPDATE HFit_Account
  SET
      AccountCD = lower( AccountCD )
  WHERE
        FaceToFaceAdvising = 1;

UPDATE HFit_Account
  SET AccountName = 'TrustMark', AccountCD = 'trstmark'
  WHERE
        AccountID = 2 and SiteID = 9 

--select * from information_schema.columns where column_name = 'Title'
