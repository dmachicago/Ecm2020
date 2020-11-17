/****** Script for SelectTopNRows command from SSMS  ******/
SELECT     TOP (1000) TNA_DRF_HR.Horse, TNA_DRF_HR.Date, TNA_DRF_HR.Track, TNA_DRF_HR.Race, TNA_DRF_HR.FirstHorse, TNA_DRF_HR.SecondHorse, 
                      TNA_DRF_HR.ThirdHorse, TNA_DRF_HR.RowGuid, TNA_RaceHandicap.FinishPosition, TNA_RaceHandicap.HandicappedBy
FROM         TNA_DRF_HR INNER JOIN
                      TNA_RaceHandicap ON TNA_DRF_HR.Horse = TNA_RaceHandicap.HorseName AND TNA_DRF_HR.Race = TNA_RaceHandicap.RaceNbr AND 
                      TNA_DRF_HR.Date = TNA_RaceHandicap.RaceDate AND TNA_DRF_HR.Track = TNA_RaceHandicap.RaceTrackAbbrev 
                      AND TNA_DRF_HR.FirstHorse = TNA_RaceHandicap.HorseName
                      AND TNA_RaceHandicap.FinishPosition = 1
                      

SELECT     TOP (1000) TNA_DRF_HR.Horse, TNA_DRF_HR.Date, TNA_DRF_HR.Track, TNA_DRF_HR.Race, TNA_DRF_HR.FirstHorse, TNA_DRF_HR.SecondHorse, 
                      TNA_DRF_HR.ThirdHorse, TNA_DRF_HR.RowGuid, TNA_RaceHandicap.FinishPosition, TNA_RaceHandicap.HandicappedBy
FROM         TNA_DRF_HR INNER JOIN
                      TNA_RaceHandicap ON TNA_DRF_HR.Horse = TNA_RaceHandicap.HorseName AND TNA_DRF_HR.Race = TNA_RaceHandicap.RaceNbr AND 
                      TNA_DRF_HR.Date = TNA_RaceHandicap.RaceDate AND TNA_DRF_HR.Track = TNA_RaceHandicap.RaceTrackAbbrev 
                      AND TNA_DRF_HR.SecondHorse = TNA_RaceHandicap.HorseName
                      AND TNA_RaceHandicap.FinishPosition = 2                      
                      
SELECT     TOP (1000) TNA_DRF_HR.Horse, TNA_DRF_HR.Date, TNA_DRF_HR.Track, TNA_DRF_HR.Race, TNA_DRF_HR.FirstHorse, TNA_DRF_HR.SecondHorse, 
                      TNA_DRF_HR.ThirdHorse, TNA_DRF_HR.RowGuid, TNA_RaceHandicap.FinishPosition, TNA_RaceHandicap.HandicappedBy
FROM         TNA_DRF_HR INNER JOIN
                      TNA_RaceHandicap ON TNA_DRF_HR.Horse = TNA_RaceHandicap.HorseName AND TNA_DRF_HR.Race = TNA_RaceHandicap.RaceNbr AND 
                      TNA_DRF_HR.Date = TNA_RaceHandicap.RaceDate AND TNA_DRF_HR.Track = TNA_RaceHandicap.RaceTrackAbbrev 
                      AND TNA_DRF_HR.ThirdHorse = TNA_RaceHandicap.HorseName
                      AND TNA_RaceHandicap.FinishPosition = 3  

/* How many horses have been handicapped by a specific handicapper */
select distinct HandicappedBy, COUNT(*) from TNA_RaceHandicap
group by HandicappedBy

alter View vHandicapperPerformance 
as
/* How many times was a horse picked to win and it DID show and by whom */					                      
SELECT     1 as show, 0 as noshow, TNA_RaceHandicap.HandicappedBy, TNA_DRF_HR.Horse, TNA_DRF_HR.Date, TNA_DRF_HR.Track, TNA_DRF_HR.Race, TNA_DRF_HR.FirstHorse, TNA_DRF_HR.SecondHorse, 
                      TNA_DRF_HR.ThirdHorse, TNA_DRF_HR.RowGuid, TNA_RaceHandicap.FinishPosition
FROM         TNA_DRF_HR INNER JOIN
                      TNA_RaceHandicap ON TNA_DRF_HR.Horse = TNA_RaceHandicap.HorseName AND TNA_DRF_HR.Race = TNA_RaceHandicap.RaceNbr AND 
                      TNA_DRF_HR.Date = TNA_RaceHandicap.RaceDate AND TNA_DRF_HR.Track = TNA_RaceHandicap.RaceTrackAbbrev 
                      AND (TNA_DRF_HR.FirstHorse= TNA_RaceHandicap.HorseName
                      or TNA_DRF_HR.SecondHorse = TNA_RaceHandicap.HorseName
                      or TNA_DRF_HR.ThirdHorse = TNA_RaceHandicap.HorseName)
					AND (TNA_RaceHandicap.FinishPosition = 1  
					or TNA_RaceHandicap.FinishPosition = 2
					or TNA_RaceHandicap.FinishPosition = 3)
--order by TNA_RaceHandicap.HandicappedBy
union
/* How many times was a horse picked to SHOW and it did not SHOW and by whom */					
SELECT     0 as show, 1 as noshow, TNA_RaceHandicap.HandicappedBy, TNA_DRF_HR.Horse, TNA_DRF_HR.Date, TNA_DRF_HR.Track, TNA_DRF_HR.Race, TNA_DRF_HR.FirstHorse, TNA_DRF_HR.SecondHorse, 
           TNA_DRF_HR.ThirdHorse, TNA_DRF_HR.RowGuid, TNA_RaceHandicap.FinishPosition
FROM       TNA_DRF_HR INNER JOIN
                      TNA_RaceHandicap ON TNA_DRF_HR.Horse = TNA_RaceHandicap.HorseName AND TNA_DRF_HR.Race = TNA_RaceHandicap.RaceNbr AND 
                      TNA_DRF_HR.Date = TNA_RaceHandicap.RaceDate AND TNA_DRF_HR.Track = TNA_RaceHandicap.RaceTrackAbbrev 
                      AND (TNA_DRF_HR.FirstHorse = TNA_RaceHandicap.HorseName
                      or TNA_DRF_HR.SecondHorse = TNA_RaceHandicap.HorseName
                      or TNA_DRF_HR.ThirdHorse = TNA_RaceHandicap.HorseName)
					AND (TNA_RaceHandicap.FinishPosition != 1  
					and TNA_RaceHandicap.FinishPosition != 2
					and TNA_RaceHandicap.FinishPosition != 3)
					
select distinct COUNT(*) as RECS, sum(show) as Show, SUM(noshow) as NoShow, HandicappedBy 
from vHandicapperPerformance					
group by HandicappedBy			