--use K3;
--
-- exec delExpiredEmail 1 ;

ALTER PROCEDURE delExpiredEmail (@dbug int = 0) 
AS
BEGIN

    --declare @dbug int = 1 ;

    --DECLARE @ActiveSession TABLE ([SessionGuid] uniqueidentifier, [LastAcquisitionDate] datetime);
    --DECLARE @SessionKey TABLE ([SessionNBR] int);
    DECLARE
           @CommExpireHours float = 0;
    DECLARE
           @EmailExpireDays int = 0;
    DECLARE
           @sid int = 0;

    SET @CommExpireHours = CAST ((SELECT ParmVal
                                    FROM dbo.SysParm
                                    WHERE ParmName = 'CommExpireHours') AS float) / 24;
    SET @EmailExpireDays = CAST ((SELECT ParmVal
                                    FROM dbo.SysParm
                                    WHERE ParmName = 'EmailExpireDays') AS int) ;

    IF @dbug = 1
        BEGIN
            PRINT @CommExpireHours
        END;
    IF @dbug = 1
        BEGIN
            PRINT @EmailExpireDays
        END;

    UPDATE dbo.BCC
      SET FromAddr = '******************************************************************************'
    WHERE CreateDate < GETDATE () - @EmailExpireDays ;
    UPDATE dbo.CC
      SET FromAddr = '******************************************************************************'
    WHERE CreateDate < GETDATE () - @EmailExpireDays  ;
    UPDATE dbo.SendTO
      SET FromAddr = '******************************************************************************'
    WHERE CreateDate < GETDATE () - @EmailExpireDays  ;
    DELETE FROM dbo.CC
    WHERE CreateDate < GETDATE () - @EmailExpireDays ;
    DELETE FROM dbo.BCC
    WHERE CreateDate < GETDATE () - @EmailExpireDays ;
    DELETE FROM dbo.SendTO
    WHERE CreateDate < GETDATE () - @EmailExpireDays ;

    UPDATE dbo.K3
      SET K1 = NEWID () 
        , K2 = NEWID () 
        , K3 = NEWID () 
        , K4 = NEWID () 
        , K5 = NEWID () 
        , K6 = NEWID () 
        , K7 = NEWID () 
        , K8 = NEWID () 
        , K9 = NEWID () 
        , K10 = NEWID () 
        , K11 = NEWID () 
        , K12 = NEWID () 
        , K13 = NEWID () 
        , K14 = NEWID () 
        , K15 = NEWID () 
        , K16 = NEWID () 
        , K17 = NEWID () 
        , K18 = NEWID () 
        , K19 = NEWID () 
        , K20 = NEWID () 
        , K21 = NEWID () 
        , K22 = NEWID () 
        , K23 = NEWID () 
        , K24 = NEWID () 
        , K25 = NEWID () 
        , K26 = NEWID () 
        , K27 = NEWID () 
        , K28 = NEWID () 
        , K29 = NEWID () 
        , K30 = NEWID () 
        , K31 = NEWID () 
        , K32 = NEWID () 
        , K33 = NEWID () 
        , K34 = NEWID () 
        , K35 = NEWID () 
        , K36 = NEWID () 
        , K37 = NEWID () 
        , K38 = NEWID () 
        , K39 = NEWID () 
        , K40 = NEWID ()
    WHERE CreateDate < GETDATE () - @EmailExpireDays;
    DELETE FROM dbo.K3
    WHERE CreateDate < GETDATE () - @EmailExpireDays;

    UPDATE dbo.Attachment
      SET IV = '***********'
        , VECTOR = 'XXXXXXXXXXXXXXX'
        , CommAesKey = 'ZZZZZZZZZZZZZZZ'
        , fqn = 'ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ'
    WHERE CreateDate < GETDATE () - @EmailExpireDays;
    DELETE FROM dbo.Attachment
    WHERE CreateDate < GETDATE () - @EmailExpireDays;

    DELETE FROM dbo.AttachmentKey
    WHERE CreateDate < GETDATE () - @EmailExpireDays;
    DELETE FROM dbo.Email
    WHERE CreateDate < GETDATE () - @EmailExpireDays;

    DELETE FROM dbo.ActiveSession
    WHERE CreateDate < GETDATE () - @CommExpireHours;
    DELETE FROM dbo.SessionKey
    WHERE CreateDate < GETDATE () - @CommExpireHours;

END; 
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
