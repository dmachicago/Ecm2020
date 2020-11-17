

/*
AUTHOR:	  W. Dale Miller
CONTACT:	  WDaleMiller@gmail.com
DATE:	  12/19/2015
USE:		  Finds all foreign key relationships in the database.
*/

--select 'DROP INDEX ' + name + ' ON CMS_UserSettings '
--from sys.indexes as S
--join information_schema.columns as I
--on I.table_name = S.name


--EXEC sp_helpindex 'CMS_UserSettings'

--EXEC sp_helpindex 'HFit_HealthAssesmentStarted'
--select * from sys.foreign_keys

--EXEC sp_fkeys 'HFit_HealthAssesmentStarted'

SELECT
    ConstrainedTable = FK.TABLE_NAME,
    FK_Column = CU.COLUMN_NAME,
    ParentTable = PK.TABLE_NAME,
    PK_Column = PT.COLUMN_NAME,
    ConstraintName = C.CONSTRAINT_NAME
into TEMP_FK
FROM
    INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS C
INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS FK
    ON C.CONSTRAINT_NAME = FK.CONSTRAINT_NAME
--AND FK.CONSTRAINT_NAME = 'FK_CMS_UserSettings_UserSettingsUserID_CMS_User'
INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS PK
    ON C.UNIQUE_CONSTRAINT_NAME = PK.CONSTRAINT_NAME
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE CU
    ON C.CONSTRAINT_NAME = CU.CONSTRAINT_NAME
INNER JOIN (
            SELECT
                i1.TABLE_NAME,
                i2.COLUMN_NAME
            FROM
                INFORMATION_SCHEMA.TABLE_CONSTRAINTS i1
            INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE i2
                ON i1.CONSTRAINT_NAME = i2.CONSTRAINT_NAME
            WHERE
                i1.CONSTRAINT_TYPE = 'PRIMARY KEY'
           ) PT
    ON PT.TABLE_NAME = PK.TABLE_NAME


select * from TEMP_FK