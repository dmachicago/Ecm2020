
/*
AUTHOR:	  W. Dale Miller
CONTACT:	  WDaleMiller@gmail.com
DATE:	  12/19/2015
USE:		  The output of the stored procedure will be saved to a table.
*/

IF OBJECT_ID('TEMP_TableFKeys') IS NOT NULL
    DROP TABLE TEMP_TableFKeys ;

create table TEMP_TableFKeys
(
    PKTable_Qualifier nvarchar(200) null,
    PKTable_Owner nvarchar(200) null,
    PKTable_Name nvarchar(200) null,
    PKColumn_Name nvarchar(200) null,
    FKTable_Qualifier nvarchar(200) null,
    FKTable_Owner nvarchar(200) null,
    FKTable_Name nvarchar(200) null,
    FKColumn_Name nvarchar(200) null,
    KEY_SEQ int null,
    UPDATE_RULE int null,
    DELETE_RULE int null,
    FK_Name nvarchar(200) null,
    pK_Name nvarchar(200) null,
    DEFERRABILITY int null
)

INSERT INTO TEMP_TableFKeys
EXEC sp_fkeys 'HFit_HealthAssesmentUserQuestion' ;

-- select * from TEMP_TableFKeys