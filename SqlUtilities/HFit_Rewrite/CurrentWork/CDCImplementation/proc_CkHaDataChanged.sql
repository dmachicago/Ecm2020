
GO
PRINT 'Creating proc_CkHaDataChanged';
PRINT 'FROM proc_CkHaDataChanged.sql';

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_CkHaDataChanged') 
    BEGIN
        DROP PROCEDURE
             proc_CkHaDataChanged;
    END;
GO

/*
 exec proc_CkHaDataChanged 0
declare @i bigint = 0 
exec proc_CkHaDataChanged 12550, @i out
*/
CREATE PROC proc_CkHaDataChanged
     @CTVersionID AS int,@NbrDetectedChanges bigint OUTPUT
AS
BEGIN
/*----------------------------------------
--------------------------------------
Author:	  Dale Miller
Returns:	  @b = 0 - no changes
		  @b = 1 - updates only
		  @b = 2 - deletes only
		  @b = 3 - deletes and updates
		  @b = 4 - inserts only
		  @b = 5 - inserts and updates
		  @b = 6 - inserts and deletes
		  @b = 7 - inserts, updates, and deletes
*/
    DECLARE
    @UpdatesFound TABLE (
                        ChangeType nvarchar (10) NULL) ;
    DECLARE
    @b AS int = 0;

    INSERT INTO @UpdatesFound
    SELECT
           SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES BASE_CMS_Class, @CTVersionID) AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES BASE_CMS_Document, @CTVersionID) AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES BASE_CMS_Site, @CTVersionID) AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES BASE_CMS_Tree, @CTVersionID) AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES BASE_CMS_User, @CTVersionID) AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES BASE_CMS_UserSettings, @CTVersionID) AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES BASE_CMS_UserSite, @CTVersionID) AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES BASE_COM_SKU, @CTVersionID) AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES BASE_HFit_Account, @CTVersionID) AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES BASE_HFit_HACampaign, @CTVersionID) AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentMatrixQuestion, @CTVersionID) AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentMultipleChoiceQuestion, @CTVersionID) AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserAnswers, @CTVersionID) AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserModule, @CTVersionID) AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserQuestion, @CTVersionID) AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserQuestionGroupResults, @CTVersionID) AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserRiskArea, @CTVersionID) AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserRiskCategory, @CTVersionID) AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserStarted, @CTVersionID) AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES BASE_HFit_HealthAssessment, @CTVersionID) AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES BASE_HFit_HealthAssessmentFreeForm, @CTVersionID) AS CT
    UNION ALL
    SELECT
           SYS_CHANGE_OPERATION
           FROM CHANGETABLE (CHANGES BASE_HFit_LKP_EDW_RejectMPI, @CTVersionID) AS CT;

    set @NbrDetectedChanges = @@ROWCOUNT;
    DECLARE @iInsert AS int = 0;
    DECLARE @iUpdate AS int = 0;
    DECLARE @iDel AS int = 0;

    IF @NbrDetectedChanges = 0
        BEGIN
            PRINT 'No changes found';
            SET @b = 0;
        END;
    ELSE
        BEGIN

            SET @iInsert = (SELECT
                                   COUNT (*) 
                                   FROM @UpdatesFound
                                   WHERE ChangeType = 'I');
            SET @iUpdate = (SELECT
                                   COUNT (*) 
                                   FROM @UpdatesFound
                                   WHERE ChangeType = 'U');
            SET @iDel = (SELECT
                                COUNT (*) 
                                FROM @UpdatesFound
                                WHERE ChangeType = 'D');
            
		  PRINT 'Print Total Changes found in version: ' +cast(@CTVersionID as nvarchar(50)) + ' is '  + CAST (@iInsert AS nvarchar (50)) + CAST (@iDel AS nvarchar (50)) + CAST (@iUpdate AS nvarchar (50)) ;
            PRINT CAST (@NbrDetectedChanges AS nvarchar (50)) + ' TOTAL Changes found: proc_CkHaDataChanged';
            PRINT CAST (@iInsert AS nvarchar (50)) + ' : Inserts found';
            PRINT CAST (@iUpdate AS nvarchar (50)) + ' : Updates found';
            PRINT CAST (@iDel AS nvarchar (50)) + ' : Deletes found';

            IF @iInsert > 0
                BEGIN
                    PRINT CAST (@iInsert AS nvarchar (50)) + ' Inserts found: proc_CkHaDataChanged';
                    SET @b = 1;
                END;
            IF @iUpdate > 0
                BEGIN
                    PRINT CAST (@iUpdate AS nvarchar (50)) + ' Updates found: proc_CkHaDataChanged';
                    SET @b = 1;
                END;
            PRINT CAST (@iDel AS nvarchar (50)) + ' Deletes found: proc_CkHaDataChanged';

            IF @iInsert = 0
           AND @iDel = 0
           AND @iUpdate = 0
                BEGIN
                    PRINT '@b = 0 - no changes';
                    SET @b = 0;
                END;
            IF @iInsert = 0
           AND @iDel = 0
           AND @iUpdate > 0
                BEGIN
                    PRINT '@b > 0 - updates only';
                    SET @b = 1;
                END;
            IF @iInsert = 0
           AND @iDel > 0
           AND @iUpdate = 0
                BEGIN
                    SET @b = 2;
                    PRINT '@b = 2 - deletes only';
                END;
            IF @iInsert = 0
           AND @iDel > 0
           AND @iUpdate > 0
                BEGIN
                    SET @b = 3;
                    PRINT '@b = 3 - deletes and updates';
                END;
            IF @iInsert > 0
           AND @iDel = 0
           AND @iUpdate = 0
                BEGIN
                    SET @b = 4;
                    PRINT '@b = 4 - inserts only';
                END;
            IF @iInsert > 0
           AND @iDel = 0
           AND @iUpdate > 0
                BEGIN
                    SET @b = 5;
                    PRINT '@b = 5 - inserts and updates';
                END;
            IF @iInsert > 0
           AND @iDel > 0
           AND @iUpdate = 0
                BEGIN
                    SET @b = 6;
                    PRINT '@b = 6 - inserts and deletes';
                END;
            IF @iInsert > 0
           AND @iDel > 0
           AND @iUpdate > 0
                BEGIN
                    SET @b = 7;
                    PRINT '@b = 7 - inserts, updates, and deletes';
                END;

		  print 'Returned Value: ' + cast(@b as nvarchar(50)) ;

            RETURN @b;
        END;
END;
GO
PRINT 'Created proc_CkHaDataChanged';
GO