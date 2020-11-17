alter table ptms_CourseEvaluation add Comments nvarchar(max) null

update ptms_Participant
set EncryptedPassword = 'GkXH52Yhh038Remo1wUdMQ=='
go
INSERT INTO [PTMS].[dbo].[ptms_CourseLocation]
           ([LocationCode]
           ,[AddrLine1]
           ,[AddrLine2]
           ,[AddrLine3]
           ,[AddrLine4]
           ,[AddrState]
           ,[AddrZip]
           ,[AddrCountry]
           ,[Comment])
     VALUES
           ('NA'
           ,'NA'
           ,'NA'
           ,'NA'
           ,'NA'
           ,'NA'
           ,'NA'
           ,'NA'
           ,'NA')
GO


