select count(*) from HFit_PPTEligibility
select * from HFit_PPTEligibility

select * from  FTP_File_Definition

-- drop table FTP_File_Definition
if not exists (Select name from sys.tables where name = 'FTP_File_Definition')
    create table FTP_File_Definition (AcctID nvarchar(50), FTPFileName nvarchar(200), Column_Name nvarchar(200), Data_Type nvarchar(50), Column_Order int, min_len int, max_len int)

-- drop index PK_FTP_File_Definition on FTP_File_Definition 
create unique index PK_FTP_File_Definition on FTP_File_Definition (AcctID , FTPFileName, Column_Name )
create unique index UK_FTP_File_Definition_NBR on FTP_File_Definition (AcctID , FTPFileName,Column_Order  )

truncate table FTP_File_Definition

    insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','PPTID','varchar',0) 
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','ClientID','int',1) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','ClientCode','varchar',2) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','UserID','int',3) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','IDCard','datetime',4) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','FirstName','varchar',5) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','LastName','varchar',6) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','MiddleInit','varchar',7) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','BirthDate','datetime',8) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','Gender','varchar',9) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','AddressLine1','varchar',10) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','AddressLine2','varchar',11) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','City','varchar',12) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','State','varchar',13) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','PostalCode','varchar',14) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','HomePhoneNum','varchar',15) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','WorkPhoneNum','varchar',16) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','MobilePhoneNum','varchar',17) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','EmailAddress','varchar',18) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','MPI','int',19) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','MatchMethodCode','varchar',20) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','SSN','varchar',21) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','PrimarySSN','varchar',2) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','HireDate','datetime',23) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','TermDate','datetime',24) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','RetireeDate','datetime',25) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','PlanName','varchar',26) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','PlanDescription','varchar',27) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','PlanID','varchar',28) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','PlanStartDate','datetime',29) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','PlanEndDate','datetime',30) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','Company','varchar',31) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','CompanyCd','varchar',32) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','LocationName','varchar',33) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','LocationCd','varchar',34) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','DepartmentName','varchar',35) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','DepartmentCd','varchar',36) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','UnionCd','varchar',37) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','BenefitGrp','varchar',38) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','PayGrp','varchar',39) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','Division','varchar',40) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','JobTitle','varchar',41) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','JobCd','varchar',42) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','TeamName','varchar',43) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','MaritalStatus','varchar',44) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','PersonType','varchar',45) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','PersonStatus','varchar',46) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','EmployeeType','varchar',47) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','CoverageType','varchar',48) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','EmployeeStatus','varchar',49) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','PayCd','varchar',50) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','BenefitStatus','varchar',51) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','PlanType','varchar',52) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','ClientPlatformElig','varchar',53) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','ClientHRAElig','varchar',54) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','ClientLMElig','varchar',55) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','ClientIncentiveElig','varchar',56) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','ClientCMElig','varchar',57) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','ClientScreeningElig','varchar',58) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','Custom1','varchar',59) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','Custom2','varchar',60) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','Custom3','varchar',61) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','Custom4','varchar',62) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','Custom5','varchar',63) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','Custom6','varchar',64) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','Custom7','varchar',65) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','Custom8','varchar',66) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','Custom9','varchar',67) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','Custom10','varchar',68) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','Custom11','varchar',69) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','Custom12','varchar',70) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','Custom13','varchar',71) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','Custom14','varchar',72) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','Custom15','varchar',73) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','ChangeStatusFlag','varchar',74) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','Last_Update_Dt','varchar',75) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','FlatFileName','varchar',76) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','ItemGUID','GUID',77) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','Hashbyte_Checksum','binary',78) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','Primary_MPI','int',79) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','MPI_Relationship_Type','varchar',80) ;
      insert into FTP_File_Definition(AcctID , FTPFileName, Column_Name , Data_Type , Column_Order ) values ('PPTLoad','PPT_Test','WorkInd','varchar',81) ;

GO

