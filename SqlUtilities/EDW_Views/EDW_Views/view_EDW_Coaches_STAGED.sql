

go
print ('Creating view_EDW_Coaches_STAGED');
go
if exists (select name from sys.views where name = 'view_EDW_Coaches_STAGED')
begin
    drop view view_EDW_Coaches_STAGED;
end
go

create view view_EDW_Coaches_STAGED
as
SELECT [UserGUID]
      ,[SiteGUID]
      ,[AccountID]
      ,[AccountCD]
      ,[CoachID]
      ,[LastName]
      ,[FirstName]
      ,[StartDate]
      ,[Phone]
      ,[email]
      ,[Supervisor]
      ,[SuperCoach]
      ,[MaxParticipants]
      ,[Inactive]
      ,[MaxRiskLevel]
      ,[Locked]
      ,[TimeLocked]
      ,[terminated]
      ,[APMaxParticipants]
      ,[RNMaxParticipants]
      ,[RNPMaxParticipants]
      ,[Change_Type]
      ,[Last_Update_Dt]
      ,[HashCode]
      ,[LastModifiedDate]
      ,[RowNbr]
      ,[DeletedFlg]
  FROM [dbo].[STAGING_EDW_Coaches]
GO
print ('Created view_EDW_Coaches_STAGED');
go


