
-- Check if procedure is already running
CREATE PROCEDURE proc_SessionLockDemo
AS
BEGIN

    DECLARE
          @ret int , 
          @lockresource sysname;

    SELECT @lockresource = OBJECT_NAME (@@procid) ;

    BEGIN TRY
        EXEC @ret = sp_getapplock @lockresource , @LockMode = 'Exclusive' , @LockOwner = 'Session' , @LockTimeout = 5;

        IF @ret <> 0
            BEGIN
                RAISERROR ('Another instance of procedure is already running' , 16 , 1) ;
                RETURN;
            END;

        -- Do stuff

        EXEC sp_releaseapplock @lockresource , 'Session';
    END TRY
    BEGIN CATCH
        IF @@trancount > 0
            BEGIN
                ROLLBACK TRANSACTION
            END;
        EXEC sp_releaseapplock @lockresource , 'Session';
    END CATCH;
END;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
