
GO

PRINT '****************************************************************************************************************';
PRINT 'FROM: C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\DataUpdates\RejectList';

GO

IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_Insert_EDW_BiometricViewRejectCriteria' )
    BEGIN
        PRINT 'proc_Insert_EDW_BiometricViewRejectCriteria found, updating.';
        DROP PROCEDURE
             proc_Insert_EDW_BiometricViewRejectCriteria;
    END;
ELSE
    BEGIN
        PRINT 'Creating proc_Insert_EDW_BiometricViewRejectCriteria';
    END;
GO

CREATE PROC proc_Insert_EDW_BiometricViewRejectCriteria (
@AccountCD AS nvarchar( 50 )
, @ItemCreatedWhen AS datetime
, @SiteID AS int )
AS
BEGIN

/***********************************************************
Pass in the AccountCD, SiteID and the ItemCreatedWHen date. 
This data will be added to the reject table and the view
will have it available immediately.
***********************************************************/

    IF @SiteID IS NULL
        BEGIN
            SET @SiteID = -1;
        END;

    DECLARE
       @iCnt integer = 0;
    SET @iCnt = ( SELECT
                         COUNT ( * )
                    FROM EDW_BiometricViewRejectCriteria
                    WHERE
                         AccountCD = @AccountCD
                     AND SiteID = @SiteID );
    IF @iCnt <= 0
        BEGIN
            INSERT INTO dbo.EDW_BiometricViewRejectCriteria
            (
                   AccountCD
                   ,ItemCreatedWhen
                   ,SiteID
            )
            VALUES
            ( @AccountCD
            , @ItemCreatedWhen
            , @SiteID
            );
            PRINT 'ADDED ' + @AccountCD + ' to EDW_BiometricViewRejectCriteria.';
        END;
    ELSE
        BEGIN
            PRINT 'Account ' + @AccountCD + ' already defined to EDW_BiometricViewRejectCriteria.';
        END;
END;

GO

--*********************************************************************************

IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_Delete_EDW_BiometricViewRejectCriteria' )
    BEGIN
        PRINT 'proc_Delete_EDW_BiometricViewRejectCriteria found, updating.';
        DROP PROCEDURE
             proc_Delete_EDW_BiometricViewRejectCriteria;
    END;
ELSE
    BEGIN
        PRINT 'Creating proc_Delete_EDW_BiometricViewRejectCriteria';
    END;
GO

/*
 EXEC proc_Insert_EDW_BiometricViewRejectCriteria 'wdm' , '10/20/2014' , -1;	--Adds a test rec
 EXEC proc_Delete_EDW_BiometricViewRejectCriteria 'wdm' , -1;   --should find and remove the record
 EXEC proc_Delete_EDW_BiometricViewRejectCriteria 'sdm' , -1;   --should not find the record
*/
CREATE PROC proc_Delete_EDW_BiometricViewRejectCriteria (
@AccountCD AS nvarchar( 50 )
, @SiteID AS int )
AS
BEGIN

/***********************************************************
Pass in the AccountCD and SiteID. 
This data will be removed from the reject table.
NOTE: John C. did not want this proc published as he felt
someone might execute it by mistake.
***********************************************************/

    IF @SiteID IS NULL
        BEGIN
            SET @SiteID = -1;
        END;

    DECLARE
       @iCnt integer = 0;
    SET @iCnt = ( SELECT
                         COUNT ( * )
                    FROM EDW_BiometricViewRejectCriteria
                    WHERE
                         AccountCD = @AccountCD
                     AND SiteID = @SiteID );
    IF @iCnt > 0
        BEGIN
            DELETE FROM dbo.EDW_BiometricViewRejectCriteria
              WHERE
                   AccountCD = @AccountCD
               AND SiteID = @SiteID;
            PRINT 'REMOVED' + @AccountCD + ' to EDW_BiometricViewRejectCriteria.';
        END;
    ELSE
        BEGIN
            PRINT 'Account ' + @AccountCD + ' does not exist in EDW_BiometricViewRejectCriteria.';
        END;
END;

GO
--********************************************************************************************
-- Set @AddItems to 1 in order to add the supplied initial data. Otherwise, set to 0 to skip.
DECLARE
   @AddItems AS bit = 0;
IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_Insert_EDW_BiometricViewRejectCriteria' )
    BEGIN
        IF @AddItems = 1
            BEGIN
                PRINT 'proc_Insert_EDW_BiometricViewRejectCriteria found, executing updates.';
                EXEC proc_Insert_EDW_BiometricViewRejectCriteria 'brunswic' , '01/20/2015' , -1;
                EXEC proc_Insert_EDW_BiometricViewRejectCriteria 'NWEnergy' , '02/10/15' , -1;
                EXEC proc_Insert_EDW_BiometricViewRejectCriteria 'Fluor' , '02/5/15' , -1;
                EXEC proc_Insert_EDW_BiometricViewRejectCriteria 'Gerdau' , '01/22/2015' , -1;
                EXEC proc_Insert_EDW_BiometricViewRejectCriteria 'trstmark' , '10/31/2013' , -1;
                EXEC proc_Insert_EDW_BiometricViewRejectCriteria 'entergy' , '2/4/2014' , -1;
                EXEC proc_Insert_EDW_BiometricViewRejectCriteria 'mcwp' , '2/1/2014' , -1;
                EXEC proc_Insert_EDW_BiometricViewRejectCriteria 'stateneb' , '4/7/2014' , -1;
                EXEC proc_Insert_EDW_BiometricViewRejectCriteria 'jnj' , '5/13/2014' , -1;
                EXEC proc_Insert_EDW_BiometricViewRejectCriteria 'coopers' , '6/13/2014' , -1;
                EXEC proc_Insert_EDW_BiometricViewRejectCriteria 'cnh' , '7/29/2014' , -1;
                EXEC proc_Insert_EDW_BiometricViewRejectCriteria 'amat' , '7/29/2014' , -1;
                EXEC proc_Insert_EDW_BiometricViewRejectCriteria 'dupont' , '8/7/2014' , -1;
                EXEC proc_Insert_EDW_BiometricViewRejectCriteria 'ejones' , '8/20/2014' , -1;
                EXEC proc_Insert_EDW_BiometricViewRejectCriteria 'avera' , '9/2/2014' , -1;
                EXEC proc_Insert_EDW_BiometricViewRejectCriteria 'sprvalu' , '9/10/2014' , -1;
                EXEC proc_Insert_EDW_BiometricViewRejectCriteria 'firstgrp' , '9/21/2014' , -1;
                EXEC proc_Insert_EDW_BiometricViewRejectCriteria 'rexnord' , '10/20/2014' , -1;
            END;
        ELSE
            BEGIN
                PRINT 'proc_Insert_EDW_BiometricViewRejectCriteria found, updates skipped.';
            END;
    END;
ELSE
    BEGIN
        PRINT 'ERROR - **********************************************************';
        PRINT 'ERROR - proc_Insert_EDW_BiometricViewRejectCriteria NOT FOUND';
        PRINT 'ERROR - **********************************************************';
    END;

GO

--select * from EDW_BiometricViewRejectCriteria