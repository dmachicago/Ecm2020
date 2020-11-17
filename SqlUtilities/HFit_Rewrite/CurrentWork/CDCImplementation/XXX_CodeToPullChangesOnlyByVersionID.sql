

proc_EDW_PullHA_Temp_Data

PRINT 'Starting the ADD NEW: ' + CONVERT (varchar, SYSDATETIME () , 121) ;
IF @iChgTypes = 1
OR @iChgTypes = 2
    BEGIN
        EXEC proc_CT_HA_AddNewRecs ;
    END;

PRINT 'Starting the MARK DELETES: ' + CONVERT (varchar, SYSDATETIME () , 121) ;
IF @iChgTypes = 2
    BEGIN
        EXEC proc_CT_HA_AddDeletedRecs ;
    END;

PRINT 'Starting the APPY UPDATES: ' + CONVERT (varchar, SYSDATETIME () , 121) ;
IF @iChgTypes = 1
OR @iChgTypes = 2
    BEGIN
        EXEC proc_CT_HA_AddUpdatedRecs ;
    END;
PRINT 'Completed the pull: ' + CONVERT (varchar, SYSDATETIME () , 121) ;
