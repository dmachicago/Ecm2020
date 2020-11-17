

/*
AUTHOR:	  W. Dale Miller
CONTACT:	  WDaleMiller@gmail.com
DATE:	  12/19/2015
USE:		  Finds all foreign key details.
*/

SELECT DISTINCT
       KU.CONSTRAINT_NAME
     , KU.TABLE_NAME
     , KU.COLUMN_NAME
     , KU.ORDINAL_POSITION
       FROM KenticoCMS_PRD_1.INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS TC
                INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KU
                    ON TC.CONSTRAINT_TYPE = 'PRIMARY KEY'
                   AND TC.CONSTRAINT_NAME = KU.CONSTRAINT_NAME
       WHERE
       KU.table_name = 'HFit_HealthAssesmentUserModule'
       ORDER BY
                KU.TABLE_NAME , KU.ORDINAL_POSITION ASC;

SELECT
       s.name as SchemaName
     , t.name AS TableName
     , fk.name AS FkName
     , c1.name AS ColName
       FROM sys.foreign_key_columns AS fkc
                INNER JOIN sys.foreign_keys AS fk
                    ON fkc.constraint_object_id = fk.object_id
                INNER JOIN sys.tables AS t
                    ON fkc.parent_object_id = t.object_id
                INNER JOIN sys.schemas AS s
                    ON t.schema_id = s.schema_id
                INNER JOIN sys.columns AS c1
                    ON c1.object_id = fkc.referenced_object_id
                   AND c1.column_id = fkc.referenced_column_id
                   AND c1.name = N'ItemID'
       WHERE
       fkc.referenced_object_id = OBJECT_ID ('dbo.HFit_HealthAssesmentUserModule') ;

DECLARE
@sql1 NVARCHAR (MAX) = N''
, @sql2 NVARCHAR (MAX) = N'ALTER TABLE dbo.HFit_HealthAssesmentUserModule DROP CONSTRAINT FK_HAModuleItemID;'
, @sql3 NVARCHAR (MAX) = N'';

SELECT
       @sql1 += N'
ALTER TABLE ' + QUOTENAME (s.name) + '.' + QUOTENAME (t.name) + ' DROP CONSTRAINT ' + QUOTENAME (fk.name) + ';'
     , @sql3 += N'
ALTER TABLE ' + QUOTENAME (s.name) + '.' + QUOTENAME (t.name) + ' ADD CONSTRAINT ' + QUOTENAME (fk.name) + ' FOREIGN KEY ' + '(' + QUOTENAME (c2.name) + ') REFERENCES dbo.HFit_HealthAssesmentUserModule(ItemID);'
       FROM sys.foreign_key_columns AS fkc
                INNER JOIN sys.foreign_keys AS fk
                    ON fkc.constraint_object_id = fk.object_id
                INNER JOIN sys.tables AS t
                    ON fkc.parent_object_id = t.object_id
                INNER JOIN sys.schemas AS s
                    ON t.schema_id = s.schema_id
                INNER JOIN sys.columns AS c1
                    ON c1.object_id = fkc.referenced_object_id
                   AND c1.column_id = fkc.referenced_column_id
                   AND c1.name = N'ItemID'
                INNER JOIN sys.columns AS c2
                    ON c2.object_id = fkc.parent_object_id
                   AND c2.column_id = fkc.parent_column_id
       WHERE
       fkc.referenced_object_id = OBJECT_ID ('dbo.HFit_HealthAssesmentUserModule') ;

PRINT @sql1;
PRINT @sql2;
PRINT @sql3;