

GO
PRINT 'Executing proc_TableDefaultConstraintExists.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_TableDefaultConstraintExists') 
    BEGIN
        DROP PROCEDURE
             dbo.proc_TableDefaultConstraintExists;
    END;
GO
CREATE PROCEDURE proc_TableDefaultConstraintExists (
       @SchemaName AS NVARCHAR (250) 
     , @TblName AS NVARCHAR (250) 
     , @ConstraintName AS NVARCHAR (250)) 
AS
BEGIN

/*---------------------------------------------------------------------
AUTHOR:	  W. Dale Miller
CONTACT:	  WDaleMiller@gmail.com
DATE:	  09/01/2012
USE:		  Determine if a tbale has a specified default constraint or not.
			 Passes back a zero if none found.
*/

    --set @SchemaName = 'dbo'; 
    --set @TblName = 'HFit_HealthAssesmentUserRiskCategory' ;
    --set @ConstraintName  = 'DEFAULT_HFit_HealthAssesmentUserRiskCategory_HARiskCategoryNodeGUID' ;

    RETURN (SELECT
                   COUNT (*) 
                   FROM sys.objects
                   WHERE
                   type_desc LIKE '%CONSTRAINT' AND
                   SCHEMA_NAME (schema_id) = @SchemaName AND
                   OBJECT_NAME (OBJECT_ID) = @ConstraintName AND
                   OBJECT_NAME (parent_object_id) = @TblName) ;

END;
GO
PRINT 'Executed proc_TableDefaultConstraintExists.sql';
GO
