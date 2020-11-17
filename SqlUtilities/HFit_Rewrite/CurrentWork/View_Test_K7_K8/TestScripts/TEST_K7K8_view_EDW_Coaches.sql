use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_Coaches' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_Coaches
END
GO


--****************************************************
Select distinct top 1000 
     UserGUID
    ,SiteGUID
    ,AccountID
    ,AccountCD
    ,CoachID
    ,LastName
    ,FirstName
    ,StartDate
    ,Phone
    ,email
    ,Supervisor
    ,SuperCoach
    ,MaxParticipants
    ,Inactive
    ,MaxRiskLevel
    ,Locked
    ,TimeLocked
    ,terminated
    ,APMaxParticipants
    ,RNMaxParticipants
    ,RNPMaxParticipants
    ,Change_Type
    ,Last_Update_Dt
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_Coaches
FROM
view_EDW_Coaches  where UserGUID is not null and TimeLocked is not null;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_Coaches' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_Coaches
END
GO


--****************************************************
Select distinct top 1000 
     UserGUID
    ,SiteGUID
    ,AccountID
    ,AccountCD
    ,CoachID
    ,LastName
    ,FirstName
    ,StartDate
    ,Phone
    ,email
    ,Supervisor
    ,SuperCoach
    ,MaxParticipants
    ,Inactive
    ,MaxRiskLevel
    ,Locked
    ,TimeLocked
    ,terminated
    ,APMaxParticipants
    ,RNMaxParticipants
    ,RNPMaxParticipants
    ,Change_Type
    ,Last_Update_Dt
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_Coaches
FROM
view_EDW_Coaches where UserGUID is not null and TimeLocked is not null;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_Coaches order by UserGUID;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_Coaches order by UserGUID;
