IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'az_foreach_worker'
)
    BEGIN
        DROP PROCEDURE az_foreach_worker;
END;
GO
CREATE PROC [dbo].[az_foreach_worker] @command1    NVARCHAR(2000), 
                                        @replacechar NCHAR(1)       = N'?', 
                                        @command2    NVARCHAR(2000) = NULL, 
                                        @command3    NVARCHAR(2000) = NULL, 
                                        @worker_type INT            = 1
AS
    BEGIN
        CREATE TABLE #qtemp
        (

        /* Temp command storage */

        qnum  INT NOT NULL, 
        qchar NVARCHAR(2000) COLLATE database_default NULL
        );
        SET NOCOUNT ON;
        DECLARE @name NVARCHAR(517), @namelen INT, @q1 NVARCHAR(2000), @q2 NVARCHAR(2000);
        DECLARE @q3 NVARCHAR(2000), @q4 NVARCHAR(2000), @q5 NVARCHAR(2000);
        DECLARE @q6 NVARCHAR(2000), @q7 NVARCHAR(2000), @q8 NVARCHAR(2000), @q9 NVARCHAR(2000), @q10 NVARCHAR(2000);
        DECLARE @cmd NVARCHAR(2000), @replacecharindex INT, @useq TINYINT, @usecmd TINYINT, @nextcmd NVARCHAR(2000);
        DECLARE @namesave NVARCHAR(517), @nametmp NVARCHAR(517), @nametmp2 NVARCHAR(258);
        DECLARE @local_cursor CURSOR;
        IF @worker_type = 1
            BEGIN
                SET @local_cursor = hCForEachDatabase;
        END;
            ELSE
            BEGIN
                SET @local_cursor = hCForEachTable;
        END;
        OPEN @local_cursor;
        FETCH @local_cursor INTO @name;
        WHILE
              (@@fetch_status >= 0
              )
            BEGIN
                SELECT @namesave = @name;
                SELECT @useq = 1, 
                       @usecmd = 1, 
                       @cmd = @command1, 
                       @namelen = DATALENGTH(@name);
                WHILE(@cmd IS NOT NULL)
                    BEGIN

                        /* Generate @q* for exec() */

                        SELECT @replacecharindex = CHARINDEX(@replacechar, @cmd);
                        WHILE
                              (@replacecharindex <> 0
                              )
                            BEGIN

                                /* 7.0, if name contains ' character, and the name has been single quoted in command, double all of them in dbname */
                                /* if the name has not been single quoted in command, do not doulbe them */
                                /* if name contains ] character, and the name has been [] quoted in command, double all of ] in dbname */

                                SELECT @name = @namesave;
                                SELECT @namelen = DATALENGTH(@name);
                                DECLARE @tempindex INT;
                                IF
                                   (SUBSTRING(@cmd, @replacecharindex - 1, 1) = N''''
                                   )
                                    BEGIN

                                        /* if ? is inside of '', we need to double all the ' in name */

                                        SELECT @name = REPLACE(@name, N'''', N'''''');
                                END;
                                    ELSE
                                    BEGIN
                                        IF
                                           (SUBSTRING(@cmd, @replacecharindex - 1, 1) = N'['
                                           )
                                            BEGIN

                                                /* if ? is inside of [], we need to double all the ] in name */

                                                SELECT @name = REPLACE(@name, N']', N']]');
                                        END;
                                            ELSE
                                            BEGIN
                                                IF((@name LIKE N'%].%]')
                                                   AND
                                                   (SUBSTRING(@name, 1, 1) = N'['
                                                   ))
                                                    BEGIN

                                                        /* ? is NOT inside of [] nor '', and the name is in [owner].[name] format, handle it */
                                                        /* !!! work around, when using LIKE to find string pattern, can't use '[', since LIKE operator is treating '[' as a wide char */

                                                        SELECT @tempindex = CHARINDEX(N'].[', @name);
                                                        SELECT @nametmp = SUBSTRING(@name, 2, @tempindex - 2);
                                                        SELECT @nametmp2 = SUBSTRING(@name, @tempindex + 3, LEN(@name) - @tempindex - 3);
                                                        SELECT @nametmp = REPLACE(@nametmp, N']', N']]');
                                                        SELECT @nametmp2 = REPLACE(@nametmp2, N']', N']]');
                                                        SELECT @name = N'[' + @nametmp + N'].[' + @nametmp2 + ']';
                                                END;
                                                    ELSE
                                                    BEGIN
                                                        IF((@name LIKE N'%]')
                                                           AND
                                                           (SUBSTRING(@name, 1, 1) = N'['
                                                           ))
                                                            BEGIN

                                                                /* ? is NOT inside of [] nor '', and the name is in [name] format, handle it */
                                                                /* j.i.c., since we should not fall into this case */
                                                                /* !!! work around, when using LIKE to find string pattern, can't use '[', since LIKE operator is treating '[' as a wide char */

                                                                SELECT @nametmp = SUBSTRING(@name, 2, LEN(@name) - 2);
                                                                SELECT @nametmp = REPLACE(@nametmp, N']', N']]');
                                                                SELECT @name = N'[' + @nametmp + N']';
                                                        END;
                                                END;
                                        END;
                                END;

                                /* Get the new length */

                                SELECT @namelen = DATALENGTH(@name);

                                /* start normal process */

                                IF
                                   (DATALENGTH(@cmd) + @namelen - 1 > 2000
                                   )
                                    BEGIN

                                        /* Overflow; put preceding stuff into the temp table */

                                        IF
                                           (@useq > 9
                                           )
                                            BEGIN
                                                CLOSE @local_cursor;
                                                IF @worker_type = 1
                                                    BEGIN
                                                        DEALLOCATE hCForEachDatabase;
                                                END;
                                                    ELSE
                                                    BEGIN
                                                        DEALLOCATE hCForEachTable;
                                                END;
                                                RETURN 1;
                                        END;
                                        IF
                                           (@replacecharindex < @namelen
                                           )
                                            BEGIN

                                                /* If this happened close to beginning, make sure expansion has enough room. */
                                                /* In this case no trailing space can occur as the row ends with @name. */

                                                SELECT @nextcmd = SUBSTRING(@cmd, 1, @replacecharindex);
                                                SELECT @cmd = SUBSTRING(@cmd, @replacecharindex + 1, 2000);
                                                SELECT @nextcmd = STUFF(@nextcmd, @replacecharindex, 1, @name);
                                                SELECT @replacecharindex = CHARINDEX(@replacechar, @cmd);
                                                INSERT INTO #qtemp
                                                VALUES
                                                (
                                                       @useq
                                                     , @nextcmd
                                                );
                                                SELECT @useq = @useq + 1;
                                                CONTINUE;
                                        END;

                                        /* Move the string down and stuff() in-place. */
                                        /* Because varchar columns trim trailing spaces, we may need to prepend one to the following string. */
                                        /* In this case, the char to be replaced is moved over by one. */

                                        INSERT INTO #qtemp
                                        VALUES
                                        (
                                               @useq
                                             , SUBSTRING(@cmd, 1, @replacecharindex - 1)
                                        );
                                        IF
                                           (SUBSTRING(@cmd, @replacecharindex - 1, 1) = N' '
                                           )
                                            BEGIN
                                                SELECT @cmd = N' ' + SUBSTRING(@cmd, @replacecharindex, 2000);
                                                SELECT @replacecharindex = 2;
                                        END;
                                            ELSE
                                            BEGIN
                                                SELECT @cmd = SUBSTRING(@cmd, @replacecharindex, 2000);
                                                SELECT @replacecharindex = 1;
                                        END;
                                        SELECT @useq = @useq + 1;
                                END;
                                SELECT @cmd = STUFF(@cmd, @replacecharindex, 1, @name);
                                SELECT @replacecharindex = CHARINDEX(@replacechar, @cmd);
                            END;

                        /* Done replacing for current @cmd.  Get the next one and see if it's to be appended. */

                        SELECT @usecmd = @usecmd + 1;
                        SELECT @nextcmd = CASE(@usecmd)
                                              WHEN 2
                                              THEN @command2
                                              WHEN 3
                                              THEN @command3
                                              ELSE NULL
                                          END;
                        IF(@nextcmd IS NOT NULL
                           AND SUBSTRING(@nextcmd, 1, 2) = N'++')
                            BEGIN
                                INSERT INTO #qtemp
                                VALUES
                                (
                                       @useq
                                     , @cmd
                                );
                                SELECT @cmd = SUBSTRING(@nextcmd, 3, 2000), 
                                       @useq = @useq + 1;
                                CONTINUE;
                        END;

                        /* Now exec() the generated @q*, and see if we had more commands to exec().  Continue even if errors. */
                        /* Null them first as the no-result-set case won't. */

                        SELECT @q1 = NULL, 
                               @q2 = NULL, 
                               @q3 = NULL, 
                               @q4 = NULL, 
                               @q5 = NULL, 
                               @q6 = NULL, 
                               @q7 = NULL, 
                               @q8 = NULL, 
                               @q9 = NULL, 
                               @q10 = NULL;
                        SELECT @q1 = qchar
                        FROM #qtemp
                        WHERE qnum = 1;
                        SELECT @q2 = qchar
                        FROM #qtemp
                        WHERE qnum = 2;
                        SELECT @q3 = qchar
                        FROM #qtemp
                        WHERE qnum = 3;
                        SELECT @q4 = qchar
                        FROM #qtemp
                        WHERE qnum = 4;
                        SELECT @q5 = qchar
                        FROM #qtemp
                        WHERE qnum = 5;
                        SELECT @q6 = qchar
                        FROM #qtemp
                        WHERE qnum = 6;
                        SELECT @q7 = qchar
                        FROM #qtemp
                        WHERE qnum = 7;
                        SELECT @q8 = qchar
                        FROM #qtemp
                        WHERE qnum = 8;
                        SELECT @q9 = qchar
                        FROM #qtemp
                        WHERE qnum = 9;
                        SELECT @q10 = qchar
                        FROM #qtemp
                        WHERE qnum = 10;
                        TRUNCATE TABLE #qtemp;
                        EXEC (@q1+@q2+@q3+@q4+@q5+@q6+@q7+@q8+@q9+@q10+@cmd);
                        SELECT @cmd = @nextcmd, 
                               @useq = 1;
                    END;
                FETCH @local_cursor INTO @name;
            END;

        /* while FETCH_SUCCESS */

        CLOSE @local_cursor;
        IF @worker_type = 1
            BEGIN
                DEALLOCATE hCForEachDatabase;
        END;
            ELSE
            BEGIN
                DEALLOCATE hCForEachTable;
        END;
        RETURN 0;
    END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'az_foreachtable'
)
    BEGIN
        DROP PROCEDURE az_foreachtable;
END;
GO
CREATE PROC [dbo].[az_foreachtable]
(@command1    NVARCHAR(2000), 
 @replacechar NCHAR(1)       = N'?', 
 @command2    NVARCHAR(2000) = NULL, 
 @command3    NVARCHAR(2000) = NULL, 
 @whereand    NVARCHAR(2000) = NULL, 
 @precommand  NVARCHAR(2000) = NULL, 
 @postcommand NVARCHAR(2000) = NULL
)
AS
    BEGIN
        DECLARE @mscat NVARCHAR(12);
        SELECT @mscat = LTRIM(STR(CONVERT(INT, 0x0002)));
        IF(@precommand IS NOT NULL)
            BEGIN
                EXEC (@precommand);
        END;
        EXEC (N'declare hCForEachTable cursor global for select ''['' + REPLACE(schema_name(syso.schema_id), N'']'', N'']]'') + '']'' + ''.'' + ''['' + REPLACE(object_name(o.id), N'']'', N'']]'') + '']'' from dbo.sysobjects o join sys.all_objects syso on o.id = syso.object_id '+N' where OBJECTPROPERTY(o.id, N''IsUserTable'') = 1 '+N' and o.category & '+@mscat+N' = 0 '+@whereand);
        DECLARE @retval INT;
        SELECT @retval = @@error;
        IF
           (@retval = 0
           )
            BEGIN
                EXEC @retval = dbo.az_foreach_worker 
                     @command1, 
                     @replacechar, 
                     @command2, 
                     @command3, 
                     0;
        END;
        IF(@retval = 0
           AND @postcommand IS NOT NULL)
            BEGIN
                EXEC (@postcommand);
        END;
        RETURN @retval;
    END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'az_foreachdb'
)
    BEGIN
        DROP PROCEDURE az_foreachdb;
END;
GO
SET ANSI_NULLS ON; 
GO
SET QUOTED_IDENTIFIER OFF; 
GO

/* 
* The following table definition will be created by SQLDMO at start of each connection. 
* We don't create it here temporarily because we need it in Exec() or upgrade won't work. 
*/

CREATE PROCEDURE [az_foreachdb]
(@command1    NVARCHAR(2000), 
 @replacechar NCHAR(1)       = N'?', 
 @command2    NVARCHAR(2000) = NULL, 
 @command3    NVARCHAR(2000) = NULL, 
 @precommand  NVARCHAR(2000) = NULL, 
 @postcommand NVARCHAR(2000) = NULL
)
AS
    BEGIN
        SET DEADLOCK_PRIORITY low;

        /* This proc returns one or more rows for each accessible db, with each db defaulting to its own result set */
        /* @precommand and @postcommand may be used to force a single result set via a temp table. */
        /* Preprocessor won't replace within quotes so have to use str(). */

        DECLARE @inaccessible NVARCHAR(12), @invalidlogin NVARCHAR(12), @dbinaccessible NVARCHAR(12);
        SELECT @inaccessible = LTRIM(STR(CONVERT(INT, 0x03e0), 11));
        SELECT @invalidlogin = LTRIM(STR(CONVERT(INT, 0x40000000), 11));
        SELECT @dbinaccessible = N'0x80000000';

        /* SQLDMODbUserProf_InaccessibleDb; the negative number doesn't work in convert() */

        IF(@precommand IS NOT NULL)
            BEGIN
                EXEC (@precommand);
        END;
        DECLARE @origdb NVARCHAR(128);
        SELECT @origdb = DB_NAME();

        /* If it's a single user db and there's an entry for it in sysprocesses who isn't us, we can't use it. */
        /* Create the select */

        EXEC (N'declare hCForEachDatabase cursor global for select name from master.dbo.sysdatabases d '+N' where (d.status & '+@inaccessible+N' = 0)'+N' and (DATABASEPROPERTY(d.name, ''issingleuser'') = 0 and (has_dbaccess(d.name) = 1))');
        DECLARE @retval INT;
        SELECT @retval = @@error;
        IF
           (@retval = 0
           )
            BEGIN
                EXEC @retval = dbo.az_foreach_worker 
                     @command1, 
                     @replacechar, 
                     @command2, 
                     @command3, 
                     1;
        END;
        IF(@retval = 0
           AND @postcommand IS NOT NULL)
            BEGIN
                EXEC (@postcommand);
        END;
        DECLARE @tempdb NVARCHAR(258);
        SELECT @tempdb = REPLACE(@origdb, N']', N']]');
        EXEC (N'use '+N'['+@tempdb+N']');
        RETURN @retval;
    END;