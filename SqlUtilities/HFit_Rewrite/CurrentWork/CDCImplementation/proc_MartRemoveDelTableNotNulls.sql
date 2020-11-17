

GO
PRINT 'Executing proc_MartRemoveDelTableNotNulls.sql';
GO

IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_MartRemoveDelTableNotNulls') 
    BEGIN
        DROP PROCEDURE
             proc_MartRemoveDelTableNotNulls;
    END;
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_MartRemoveDelTableNotNullsMASTER') 
    BEGIN
        DROP PROCEDURE
             proc_MartRemoveDelTableNotNullsMASTER;
    END;
GO

-- exec proc_MartRemoveDelTableNotNullsMASTER
CREATE PROCEDURE proc_MartRemoveDelTableNotNullsMASTER
AS
BEGIN

    DECLARE @MySql AS NVARCHAR (MAX) ;
    DECLARE @T AS NVARCHAR (250) = '';
    DECLARE C2 CURSOR
        FOR
            SELECT
                   table_name
            FROM information_schema.tables
            WHERE
                  table_name LIKE 'BASE_%' AND table_name LIKE '%_DEL';

    OPEN C2;

    FETCH NEXT FROM C2 INTO @T;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN

            SET @MySql = 'exec proc_MartRemoveDelTableNotNulls "' + @T + '", 0 ';
		  begin try
			 EXEC (@MySQl) ;
		  end try
		  begin catch 
			 print '*****' ;
			 print 'ERROR: ' + @MySQl
			 print '*****' ;
		  end catch 

            FETCH NEXT FROM C2 INTO @T;
        END;

    CLOSE C2;
    DEALLOCATE C2;
END;

GO

/*************************************************************************
Use KenticoCMS_Datamart_2
exec proc_MartRemoveDelTableNotNulls 'BASE_HFit_TrackerSugaryFoods_DEL', 1
exec proc_MartRemoveDelTableNotNulls 'BASE_Chat_Message_DEL', 1
exec proc_MartRemoveDelTableNotNulls "BASE_Chat_Room_DEL", 0
exec proc_MartRemoveDelTableNotNulls "BASE_Chat_User_DEL", 0
*************************************************************************/
CREATE PROCEDURE proc_MartRemoveDelTableNotNulls (
       @TblName AS NVARCHAR (250) 
     , @PreviewOnly AS BIT = 0) 
AS
BEGIN

    DECLARE @Msg AS NVARCHAR (MAX) = '';
    SET @Msg = 'Processing: ' + @TblName;
    EXEC PrintImmediate @Msg;

    DECLARE @TABLE_NAME NVARCHAR (250) = 'BASE_HFit_TrackerSugaryFoods_DEL';
    DECLARE @column_name NVARCHAR (250) 
          , @data_type NVARCHAR (250) 
          , @CHARACTER_MAXIMUM_LENGTH AS INT;

    --alter table [dbo].[BASE_HFit_TrackerSugaryFoods_DEL] alter column [IsProfessionallyCollected] bit null
    DECLARE @MySql AS NVARCHAR (MAX) ;
    DECLARE @T AS NVARCHAR (250) = '';
    DECLARE C CURSOR
        FOR
            SELECT
                   TABLE_NAME
                 , column_name
                 , data_type
                 , CHARACTER_MAXIMUM_LENGTH
            FROM Information_schema.columns
            WHERE
                   table_name = @TblName AND
			    table_schema = 'dbo' AND
                   IS_NULLABLE = 'NO'
			    and column_name != 'RowNbrIdent' ;

    OPEN C;

    FETCH NEXT FROM C INTO @TABLE_NAME, @column_name , @data_type , @CHARACTER_MAXIMUM_LENGTH;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            IF @CHARACTER_MAXIMUM_LENGTH IS NOT NULL
                BEGIN
				if @CHARACTER_MAXIMUM_LENGTH >= 0 
				    SET @MySql = 'alter table [dbo].[' + @TABLE_NAME + '] alter column [' + @column_name + '] ' + @data_type + ' (' + CAST (@CHARACTER_MAXIMUM_LENGTH AS NVARCHAR (50)) + ') null ';
				if @CHARACTER_MAXIMUM_LENGTH < 0
				    SET @MySql = 'alter table [dbo].[' + @TABLE_NAME + '] alter column [' + @column_name + '] ' + @data_type + ' (MAX) null ';
                END;
            ELSE
                BEGIN
                    SET @MySql = 'alter table [dbo].[' + @TABLE_NAME + '] alter column [' + @column_name + '] ' + @data_type + ' null ';
                END;

            IF @PreviewOnly = 1
                BEGIN
                    PRINT @MySQl;
                END;

            IF @PreviewOnly = 0
                BEGIN
                    BEGIN TRY
                        EXEC (@MySQl) ;
                        PRINT @MySQl;
                        PRINT '.....';
                    END TRY
                    BEGIN CATCH
                        PRINT 'ERROR: ' + @mysql;
                    END CATCH;
                END;

            FETCH NEXT FROM C INTO @TABLE_NAME, @column_name , @data_type , @CHARACTER_MAXIMUM_LENGTH;
        END;

    CLOSE C;
    DEALLOCATE C;

END;


GO
PRINT 'Executed proc_MartRemoveDelTableNotNulls.sql';
GO
PRINT 'Executing proc_MartRemoveDelTableNotNullsMASTER';
GO
exec proc_MartRemoveDelTableNotNullsMASTER
GO