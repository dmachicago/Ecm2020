/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [LastName]
      ,[FirstName]
      ,[MiddleName]
      ,[SuffixName]
      ,[PrimaryAddress1]
      ,[PrimaryCity]
      ,[PrimaryState]
      ,[PrimaryZip]
      ,[PartyCode]      
  FROM [EmailAddr].[dbo].[PA_ALL_Tags]
  group by
  [LastName]
      ,[FirstName]
      ,[MiddleName]
      ,[SuffixName]
      ,[PrimaryAddress1]
      ,[PrimaryCity]
      ,[PrimaryState]
      ,[PrimaryZip]
      ,[PartyCode]
having count(*) > 1

select [LastName]
      ,[FirstName]
      ,[MiddleName]
      ,[SuffixName]
      ,[PrimaryAddress1]
      ,[PrimaryCity]
      ,[PrimaryState]
      ,[PrimaryZip]
      ,[PartyCode]
FROM [EmailAddr].[dbo].[PA_ALL_Tags]
where LastNAme = 'ABSHER'
and FirstName = 'JAMES'
and middleName = 'D'
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
