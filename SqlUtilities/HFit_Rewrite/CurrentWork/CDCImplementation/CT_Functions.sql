select top 10 * from Hfit_CoachingUserCMCondition

-- The tracked change is tagged with the specified context   
DECLARE @min_valid_version bigint, @last_sync_version bigint;  
  
select CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('dbo.Hfit_CoachingUserCMCondition'));  

select CHANGE_TRACKING_CURRENT_VERSION();

SELECT
    count(*)
FROM
    CHANGETABLE(CHANGES Hfit_CoachingUserCMCondition, null) AS CT

SELECT
    sys_change_version
FROM
    CHANGETABLE(CHANGES Hfit_CoachingUserCMCondition, null) AS CT
    order by sys_change_version desc

SELECT
    top 100 CT.*
FROM
    CHANGETABLE(CHANGES Hfit_CoachingUserCMCondition, 299786859) AS CT

select distinct count(*), SYS_CHANGE_OPERATION
FROM
    CHANGETABLE(CHANGES Hfit_CoachingUserCMCondition, 299786859) AS CT
group by SYS_CHANGE_OPERATION


select distinct count(*), SYS_CHANGE_VERSION
FROM
    CHANGETABLE(CHANGES Hfit_CoachingUserCMCondition, null) AS CT
group by SYS_CHANGE_VERSION

select top 20 SYS_CHANGE_VERSION
FROM
    CHANGETABLE(CHANGES Hfit_CoachingUserCMCondition, null) AS CT
order by SYS_CHANGE_VERSION desc