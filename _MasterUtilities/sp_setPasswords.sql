
/*
W. Dale Miller
April 18, 2020

Expect the following at least once during the execution - it represents no problem.
	Msg 8146, Level 16, State 2, Procedure sp_setPasswords, Line 0 [Batch Start Line 223]
	Procedure sp_setPasswords has no parameters and arguments were supplied.

SET THE Passwords AS NEEDED : see below, and then save this file for future use.

Run this set of commands whenever it is deemed necessary to set user's passwords to what is provided below.

*/

USE [master];
GO

IF OBJECT_ID('tempdb..#pw') IS NOT NULL
        BEGIN
                DROP TABLE #pw;
        END;
CREATE TABLE #pw ( 
                UserID		NVARCHAR(250) , 
                pw			NVARCHAR(250) ,
				EnableUser	int 
                    );
CREATE INDEX pwtemp ON #pw (UserID);

/* SET THE FOLLOWING Passwords here AS NEEDED */
INSERT INTO #pw		   VALUES ( 'ecmtech' , 'Junebug0', 1);
INSERT INTO #pw        VALUES ( 'ECMLibrary' , 'Junebug1', 1);
INSERT INTO #pw        VALUES ( 'ecmocr' , 'Junebug2', 1);
INSERT INTO #pw        VALUES ( 'ecmuser' , 'Junebug3', 1);
INSERT INTO #pw        VALUES ( 'ecmadmin' , 'Junebug4', 1);
INSERT INTO #pw        VALUES ( 'ecmsys' , 'Junebug5', 1);
INSERT INTO #pw        VALUES ( 'wmiller' , 'Junebug6', 1);
INSERT INTO #pw        VALUES ( 'ecmlogin' , 'Junebug7', 1);
INSERT INTO #pw        VALUES ( 'dbmgr' , 'Junebug8', 1);
INSERT INTO #pw        VALUES ( '##MS_PolicyTsqlExecutionLogin##' , 'Junebug9', 1);
INSERT INTO #pw        VALUES ( '##MS_PolicyEventProcessingLogin##' , 'Junebug10', 1);

IF EXISTS ( SELECT *
            FROM sys.objects
            WHERE object_id = OBJECT_ID(N'[dbo].[sp_getPw]')
                  AND 
                  type IN ( N'FN' , N'IF' , N'TF' , N'FS' , N'FT'
                          )
          ) 
    BEGIN
        DROP FUNCTION [dbo].sp_getPw
END;
GO

CREATE FUNCTION sp_getPw ( 
                @PwID NVARCHAR(250)
                         ) 
RETURNS NVARCHAR(250)
AS
     BEGIN
         DECLARE @pw NVARCHAR(250)= '';
         DECLARE @cmd NVARCHAR(200)= '';

         /***********************************************/
         /* SET THESE VARIABLES TO THE PERMANENT VALUES */
         /***********************************************/

         DECLARE @ECMLibrary NVARCHAR(250)= 'Junebug1';
         DECLARE @ecmocr NVARCHAR(250)= 'Junebug1';
         DECLARE @ecmuser NVARCHAR(250)= 'Junebug1';
         DECLARE @ecmadmin NVARCHAR(250)= 'ecmadmin';
         DECLARE @ecmsys NVARCHAR(250)= 'ecmsys';
         DECLARE @wmiller NVARCHAR(250)= 'wmiller';

         /* This ID is used by ECM Library when troubleshooting is needed */

         DECLARE @ecmtech NVARCHAR(250)= 'ecmtech';

         /* This ID is used by ECM Library when troubleshooting is needed */

         DECLARE @ecmlogin NVARCHAR(250)= 'ecmlogin';
         DECLARE @dbmgr NVARCHAR(250)= 'dbmgr';
         DECLARE @##MS_PolicyTsqlExecutionLogin## NVARCHAR(250)= '##MS_PolicyTsqlExecutionLogin##';
         DECLARE @##MS_PolicyEventProcessingLogin## NVARCHAR(250)= '##MS_PolicyEventProcessingLogin##';

         IF ( @PwID = 'ecmuser' ) 
             BEGIN
                 SET @pw = @ecmuser;
         END;
         IF ( @PwID = 'ecmocr' ) 
             BEGIN
                 SET @pw = @ecmocr;
         END;
         IF ( @PwID = 'ECMLibrary' ) 
             BEGIN
                 SET @pw = @ECMLibrary;
         END;
         RETURN @pw;
     END;
GO

USE [master];
GO

IF EXISTS ( SELECT 1
            FROM sys.procedures
            WHERE name = 'sp_setPasswords'
          ) 
    BEGIN
        DROP PROCEDURE sp_setPasswords;
END;
GO

/*
	Set @preview = 1 to only show the commands that will be executed.
	Set @preview = 0 to show the commands that will be executed adn then execute them.
*/
CREATE PROCEDURE sp_setPasswords (@preview int = 1)
AS
    BEGIN
        
        DECLARE @cmd NVARCHAR(200)= '';
        --DECLARE @ECMLibraryPW NVARCHAR(250)= ( SELECT pw
        --                                       FROM #pw
        --                                       WHERE UserID = 'ECMLibraryPW'
        --                                     );
        --DECLARE @ecmocr NVARCHAR(250)= ( SELECT pw
        --                                 FROM #pw
        --                                 WHERE UserID = 'ecmocr'
        --                               );
        --DECLARE @ecmuser NVARCHAR(250)= ( SELECT pw
        --                                  FROM #pw
        --                                  WHERE UserID = 'ecmuser'
        --                                );
        --DECLARE @ecmadmin NVARCHAR(250)= ( SELECT pw
        --                                   FROM #pw
        --                                   WHERE UserID = 'ecmadmin'
        --                                 );
        --DECLARE @ecmsys NVARCHAR(250)= ( SELECT pw
        --                                 FROM #pw
        --                                 WHERE UserID = 'ecmsys'
        --                               );
        --DECLARE @wmiller NVARCHAR(250)= ( SELECT pw
        --                                  FROM #pw
        --                                  WHERE UserID = 'wmiller'
        --                                );
        --DECLARE @ecmlogin NVARCHAR(250)= ( SELECT pw
        --                                   FROM #pw
        --                                   WHERE UserID = '@ecmlogin'
        --                                 );
        --DECLARE @dbmgr NVARCHAR(250)= ( SELECT pw
        --                                FROM #pw
        --                                WHERE UserID = 'dbmgr'
        --                              );

        --DECLARE @MS_PolicyTsqlExecutionLogin NVARCHAR(250)= ( SELECT pw
        --                                                      FROM #pw
        --                                                      WHERE UserID = '##MS_PolicyTsqlExecutionLogin##'
        --                                                    );
        --DECLARE @MS_PolicyEventProcessingLogin NVARCHAR(250)= ( SELECT pw
        --                                                        FROM #pw
        --                                                        WHERE UserID = '##MS_PolicyEventProcessingLogin##'
        --                                                      );
        
		DECLARE @UserID NVARCHAR(250);
        DECLARE @pw NVARCHAR(250);
        DECLARE db_cursor CURSOR
			FOR SELECT UserID , pw, EnableUser
				FROM #pw
				order by UserID;

		print '*** PROCESSING DATABASE: ' + db_name();

		declare @EnableUser int = 0 ; 
		declare @CurrDB nvarchar(254) = db_name();
        OPEN db_cursor;
        FETCH NEXT FROM db_cursor INTO @UserID , @pw, @EnableUser;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                PRINT '*** DB: ' + DB_NAME() + ' / UserID: ' + @UserID + ' / PW: ' + @pw;
                IF SUSER_ID(@UserID) IS NULL
                    BEGIN
                        --SET @cmd = 'CREATE USER ' + @UserID + ' FOR LOGIN ' + @UserID + ';';
						SET @cmd = 'CREATE LOGIN '+@UserID+' WITH PASSWORD = N'''+@pw+''' , DEFAULT_DATABASE = ['+db_name()+'] , DEFAULT_LANGUAGE = [us_english] , CHECK_EXPIRATION = OFF , CHECK_POLICY = ON; ' ;
                        PRINT @cmd;
						exec sp_executesql @cmd ;
                END;
				else begin
					PRINT '*** USER EXISITS IN DB: ' + DB_NAME() + ' / UserID: ' + @UserID + ' / PW: ' + @pw;
				end ;
                SET @cmd = 'ALTER LOGIN ' + @UserID + ' WITH PASSWORD = ''' + @pw + '''';
				if (@preview = 1)
					PRINT @cmd;
				if (@preview = 0)
				begin
					PRINT @cmd;
					exec sp_executesql @cmd ;
				end

				if (@EnableUser = 1)
				begin
					set @cmd = 'ALTER LOGIN '+@UserID+' ENABLE;'
					PRINT @cmd;
					if (@preview = 0)
						exec sp_executesql @cmd ;
				end
				if (@EnableUser = 0)
				begin
					set @cmd = 'ALTER LOGIN '+@UserID+' DISABLE;'
					PRINT @cmd;
					if (@preview = 0)
						exec sp_executesql @cmd ;
				end

                FETCH NEXT FROM db_cursor INTO @UserID , @pw, @EnableUser;
            END;
        CLOSE db_cursor;
        DEALLOCATE db_cursor;
		print '=====  Proc Completed... for database: ' + db_name() ;
    END;
GO

/*******************************************************************************************/
DECLARE @command NVARCHAR(MAX)= '';
set @command = 'IF ''?'' NOT IN(''master'', ''model'', ''msdb'', ''tempdb'', ''ReportServer'', ''ReportServerTempDB'') 
BEGIN 
	USE [?] 
	print ''******  Processing: '' + db_name();
END' ;
EXEC sp_MSforeachdb @command;

print '----------------------------------------------';
go
/*
	Set @preview = 1 to only show the commands that will be executed.
	Set @preview = 0 to show the commands that will be executed and then execute them.
*/
DECLARE @command NVARCHAR(MAX)= '';
set @command = 'IF ''?'' NOT IN(''master'', ''model'', ''msdb'', ''tempdb'', ''ReportServer'', ''ReportServerTempDB'') 
BEGIN 
	USE [?] ;
	exec sp_setPasswords @preview = 1 
END' ;
print @command;
EXEC sp_MSforeachdb @command;

go
