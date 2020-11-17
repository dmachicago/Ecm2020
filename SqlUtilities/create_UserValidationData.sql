USE viper
GO

create table ValidationSynonyms (TgtWord nvarchAR(100), SynWord nvarchAR(100)) ;
create unique clustered index PK_ValidationSynonyms on ValidationSynonyms (TgtWord , SynWord ) ;

create table StandardizationSynonyms (TgtWord nvarchAR(100), SynWord nvarchAR(100)) ;
create unique clustered index PK_Standardization on StandardizationSynonyms (TgtWord , SynWord ) ;


SELECT [UserID]
      ,[FirstName]
      ,[LastName]
      ,[MiddleInit]
      ,[BirthDate]
      ,[Gender]
      ,[MPI]
      ,[SSN]
      ,[PrimarySSN]
      ,[Primary_MPI] 
into UserValidationData	     
  FROM KenticoCMS_1.[dbo].[HFit_PPTEligibility]
GO

create index IDX_ValidationData_UserID on UserValidationData (UserID) ;
go
create index IDX_ValidationData_MPI on UserValidationData (MPI, Primary_MPI) ;
go
create index IDX_ValidationData_SSN on UserValidationData (SSN, PrimarySSN) ;
go
create index IDX_ValidationData_Names on UserValidationData ([LastName], [FirstName],[MiddleInit], [Gender], [BirthDate]) ;
go
create index IDX_ValidationData_BirthDate on UserValidationData ([BirthDate]) ;
go
create index IDX_ValidationData_UserID on UserValidationData (UserID) ;
go

select count(*) from UserValidationData where UserID = 1 ;

select count(*) from UserValidationData where FirstName = 'XX' and LastName = 'XX'
select count(*) from UserValidationData where FirstName = 'XX' and LastName = 'XX' and MiddleInit = 'xx'
select count(*) from UserValidationData where FirstName = 'Edwin' and LastName = 'Lynch' and Birthdate = '1950-07-17 00:00:00.0000000'

select count(*) from UserValidationData where [MPI] = 0
select count(*) from UserValidationData where SSN  = 'XX' and LastName = 'XX' 

select count(*) from UserValidationData where MPI  = 0 or Primary_MPI = 0 

select top 100 * from UserValidationData

[UserID]
      ,[FirstName]
      ,[LastName]
      ,[MiddleInit]
      ,[BirthDate]
      ,[Gender]
      ,[MPI]
      ,[SSN]
      ,[PrimarySSN]
      ,[Primary_MPI] 
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
