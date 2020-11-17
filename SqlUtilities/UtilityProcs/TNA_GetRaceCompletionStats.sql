
SELECT distinct [FirstHorse],[SecondHorse],[ThirdHorse]    
select *  
FROM [dbo].[TNA_DRF_HR]
where 
RCTrack = 'BEL'  
and [Date]='2011-10-15'
and cast(RCRace as decimal) = 4


select * from TNA_DRF_U
where
RCTrack = 'PM'
and cast(RCRace as decimal) = 4
and RCDate = '10/24/2011'

alter table TNA_DRF_U add intRCRace int null

update TNA_DRF_U set intRCRace = CAST(RCRace as decimal)

alter table TNA_DRF_U alter column RCRace decimal