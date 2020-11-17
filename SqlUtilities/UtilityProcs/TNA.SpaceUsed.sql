/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [TNA_DRF_U]
where RCDate between '10/22/2011' and '10/22/2011'

--truncate table TNA_RaceSchedule
--truncate table [TNA_RaceHandicap] 

select COUNT(*) from TNA_RaceSchedule

select * from TNA_RaceSchedule
select * from TNA_DRF_U
where RowGuid = '09E2D84D-7676-42AC-92AE-222560120E9C'
  
exec sp_spaceused '[TNA_RaceSchedule]'
exec sp_spaceused '[TNA_RaceHandicap]'
exec sp_spaceused 'TNA_DRF_U'

select top 100 * from TNA_DRF_U

Select RCTrack, RCDate, ProgNum, PostPosition, Horse, Jockey, MLOdds, Rowguid 
from TNA_DRF_U
where RowGuid not in (Select DRF_HR_Guid from TNA_RaceSchedule)

select * from TNA_DRF_HR --Has the Finishing Order of Win, Place, Show


alter Table TNA_RaceSchedule add ProgNum varchar(10)

truncate table TNA_RaceSchedule