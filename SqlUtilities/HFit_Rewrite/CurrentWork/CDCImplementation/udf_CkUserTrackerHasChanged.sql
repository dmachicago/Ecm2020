
go

--select udf_CkUserTrackerHasChanged()

CREATE FUNCTION udf_CkUserTrackerHasChanged (
                @TF bit) 
RETURNS int
AS
BEGIN

    DECLARE
           @UpdatesFOund AS nvarchar (10) = '';
    DECLARE
           @b AS bit = 0;

    SET @UpdatesFOund = (
                        SELECT
                           SYS_CHANGE_OPERATION
                               FROM CHANGETABLE (CHANGES HFit_UserTracker , NULL) AS CT
                        UNION
                        SELECT
                           SYS_CHANGE_OPERATION
                               FROM CHANGETABLE (CHANGES CMS_Site , NULL) AS CT
                        UNION
                        SELECT
                           SYS_CHANGE_OPERATION
                               FROM CHANGETABLE (CHANGES CMS_UserSettings , NULL) AS CT
                        UNION
                        SELECT
                           SYS_CHANGE_OPERATION
                               FROM CHANGETABLE (CHANGES CMS_UserSettings , NULL) AS CT
                        UNION
                        SELECT
                           SYS_CHANGE_OPERATION
                               FROM CHANGETABLE (CHANGES HFit_Account , NULL) AS CT
                        UNION
                        SELECT
                           SYS_CHANGE_OPERATION
                               FROM CHANGETABLE (CHANGES HFit_TrackerCollectionSource , NULL) AS CT
                        );

    IF @UpdatesFOund IS NULL
        BEGIN
            SET @b = 0;
        END
    ELSE
        BEGIN
            SET @b = 1;
        END;

    RETURN @b;

END; 