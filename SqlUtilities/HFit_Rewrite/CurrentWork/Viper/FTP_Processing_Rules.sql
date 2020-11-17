

GO
--drop table FTP_Processing_Validation_Rules
--alter table FTP_Processing_Validation_Rules add RuleErrMsg nvarchar (4000)  NULL 
--alter table FTP_Processing_Validation_Rules add FileTypeCode nvarchar (25)  NULL 
CREATE TABLE FTP_Processing_Validation_Rules (RuleName nvarchar (50) NOT NULL , 
                                              RuleDesc nvarchar (4000) NOT NULL , 
									 RuleErrMsg nvarchar (4000) NOT NULL , 									 
                                              CreateDate datetime DEFAULT GETDATE () , 
                                              RowNumber bigint IDENTITY (1 , 1) 
                                                               NOT NULL) ;

CREATE UNIQUE CLUSTERED INDEX PKI_FTP_Processing_Validation_Rules ON FTP_Processing_Validation_Rules (RuleName) ;
GO

INSERT INTO FTP_Processing_Validation_Rules (RuleName , 
                                             RuleDesc, RuleErrMsg ) 
VALUES ('ckGender' , 
        'Validate a GENDER Column to ensure it only contains allowed values of M:Mail,F:Female,U:Unknown,T:Intransition, or NULL' , 
	   'Failed to authenticate gender.') ;
INSERT INTO FTP_Processing_Validation_Rules (RuleName , 
                                             RuleDesc, RuleErrMsg ) 
VALUES ('ckGenericDate' , 
        'Validate a DATE Column to ensure it is a valid date and if so, is between a apecified range.' , 
	   'Invalid date or out of range.') ;
INSERT INTO FTP_Processing_Validation_Rules (RuleName , 
                                             RuleDesc, RuleErrMsg ) 
VALUES ('ckGenericDateNotNUll' , 
        'Validate a DATE Column to ensure it is a valid date and if so, is between a apecified range and cannot be NULL.' , 
	   'Invalid date: out of range or NULL.') ;

INSERT INTO FTP_Processing_Validation_Rules (RuleName , 
                                             RuleDesc, RuleErrMsg ) 
VALUES ('ckBirthDate' , 
        'Validate a BIRTH DATE Column to ensure it is a valid date and if so, is between a apecified range and cannot be NULL.' , 
	   'Invalid birth date: out of range or NULL.') ;

GO
-- drop table File_Validation_Rules
-- truncate table File_Validation_Rules
CREATE TABLE File_Validation_Rules (
    --Associates a set of rules that are to be applied to a FILE.
    RuleName nvarchar (50) NOT NULL , 
    AppliesToColumnName nvarchar (100) NOT NULL default 'NA' , 
    FileID int NOT NULL , 
    CreateDate datetime DEFAULT GETDATE () , 
    RowNumber bigint IDENTITY (1 , 1) NOT NULL) ;
GO
CREATE UNIQUE CLUSTERED INDEX PKI_File_Validation_Rules ON File_Validation_Rules (RuleName , AppliesToColumnName, FileID) ;
GO

INSERT INTO File_Validation_Rules (RuleName , AppliesToColumnName,FileID) 
	   VALUES ('ckGender' , 'GENDER', 2) ;
INSERT INTO File_Validation_Rules (RuleName , AppliesToColumnName,FileID) 
	   VALUES ('ckBirthDate' , 'BirthDate', 2) ;
INSERT INTO File_Validation_Rules (RuleName , AppliesToColumnName,FileID) 
	   VALUES ('ckGenericDate' , 'HireDate', 2) ;
INSERT INTO File_Validation_Rules (RuleName , AppliesToColumnName,FileID) 
	   VALUES ('ckGenericDate' , 'TermDate', 2) ;
INSERT INTO File_Validation_Rules (RuleName , AppliesToColumnName,FileID) 
	   VALUES ('ckGenericDate' , 'RetireeDate', 2) ;
INSERT INTO File_Validation_Rules (RuleName , AppliesToColumnName,FileID) 
	   VALUES ('ckGenericDate' , 'PlanStartDate', 2) ;
INSERT INTO File_Validation_Rules (RuleName , AppliesToColumnName,FileID) 
	   VALUES ('ckGenericDate' , 'PlanEndDate', 2) ;

update File_Validation_Rules 
    set RuleName='ckGenericDate' ,
	   AppliesToColumnName = 'PlanEndDate'
    where RowNumber = 00

GO 

--drop view view_FileRules
CREATE VIEW view_FileRules
AS SELECT FPR.RuleName,
	     FPR.RuleDesc,
          F.[FileName] as ProcessedFile , 
		FVR.AppliesToColumnName ,
          C.FullName as ClientName,
		C.ClientID,
		F.FileID
     FROM
		  FTP_Processing_Validation_Rules as FPR
		  join File_Validation_Rules AS FVR
		  on FPR.RuleName = FVR.RuleName
          JOIN Files AS F
          ON F.FileID = FVR.FileID
          JOIN Client AS C
          ON C.ClientID = F.ClientID;

GO
SELECT *
  FROM FTP_Processing_Validation_Rules;
SELECT *
  FROM File_Validation_Rules;
SELECT *
  FROM view_FileRules;

SELECT distinct RuleName,AppliesToColumnName  FROM view_FileRules where FileID = 2
