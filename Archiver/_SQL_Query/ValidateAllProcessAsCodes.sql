
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'spValidateAllProcessAsCodes'
)
    DROP PROCEDURE spValidateAllProcessAsCodes;
GO
-- exec spValidateAllProcessAsCodes
CREATE PROCEDURE spValidateAllProcessAsCodes
AS
	--WDM 12-05-2015
    BEGIN
        DELETE FROM DataSource
        WHERE SourceName = ''
              OR SourceName IS NULL;
        UPDATE datasource
          SET 
              SourceTypeCode = P.ProcessExtCode
        FROM datasource D
             JOIN ProcessFileAs P ON P.ExtCode = D.OriginalFileType
        WHERE OriginalFileType IN
        (
            SELECT ExtCode
            FROM ProcessFileAs
        );
    END;