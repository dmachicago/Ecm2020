
-- use KenticoCMS_Datamart_2
go
print 'Executing proc_SetBadDataIdentifiers.sql'
go
if exists (Select name from sys.procedures where name = 'proc_SetBadDataIdentifiers')
    drop procedure proc_SetBadDataIdentifiers;
go
-- exec proc_SetBadDataIdentifiers
CREATE PROCEDURE proc_SetBadDataIdentifiers 
AS
BEGIN
    IF
           (SELECT
                   count (*) 
            FROM dbo.BASE_cms_user
            WHERE USerID = -1) = 0
        BEGIN
            INSERT INTO dbo.BASE_cms_user
            (
                   UserName
                 , LastName
                 , FullName
                 , UserPassword
                 , UserID
                 , UserGUID
                 , SVR
                 , DBNAME
                 , UserEnabled
                 , UserIsEditor
                 , UserLastModified
                 , SYS_CHANGE_VERSION
                 , UserIsGlobalAdministrator) 
            VALUES
            ('BadData'
            , 'BadData'
            , 'BadData'
            , 'NA'
            , -1
            , newid () 
            , @@SERVERNAME
            , 'KenticoCMS_1' , 1 , 0 , getdate () , 0 , 0) ;
        END;

    IF
           (SELECT
                   count (*) 
            FROM dbo.BASE_cms_user
            WHERE USerID = 0) = 0
        BEGIN
            INSERT INTO dbo.BASE_cms_user
            (
                   UserName
                 , LastName
                 , FullName
                 , UserPassword
                 , UserID
                 , UserGUID
                 , SVR
                 , DBNAME
                 , UserEnabled
                 , UserIsEditor
                 , UserLastModified
                 , SYS_CHANGE_VERSION
                 , UserIsGlobalAdministrator) 
            VALUES
            ('BadData'
            , 'BadData'
            , 'BadData'
            , 'NA'
            , 0
            , newid () 
            , @@SERVERNAME
            , 'KenticoCMS_1' , 1 , 0 , getdate () , 0 , 0) ;
        END;

END;
go
print 'Executed proc_SetBadDataIdentifiers.sql'
go
