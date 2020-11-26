
IF EXISTS ( SELECT 1
            FROM sys.procedures
            WHERE name = 'spBuildLoadProfile'
          ) 
    BEGIN
        DROP PROCEDURE spBuildLoadProfile;
END;
GO

CREATE PROCEDURE spBuildLoadProfile
AS
    BEGIN
        DROP TABLE IF EXISTS #tmp;
        CREATE TABLE #tmp ( 
                     COMPONENTTYPE NVARCHAR(100) , 
                     COMPONENTname NVARCHAR(100) , 
                     clsid         NVARCHAR(100) , 
                     fullpath      NVARCHAR(100) , 
                     version       NVARCHAR(100) , 
                     Manufacturer  NVARCHAR(100)
                          );
        INSERT INTO #tmp
        EXEC sp_help_fulltext_system_components 'filter';
        DELETE FROM loadprofile
        WHERE ProfileName = 'All Filters';
        INSERT INTO loadprofile ( ProfileName , ProfileDesc
                                ) 
        VALUES ( 'All Filters' , 'All filters registered on the current server'
               );
        DELETE FROM LoadProfileItem
        WHERE ProfileName = 'All Filters';
        DELETE FROM sourcetype
        WHERE SourceTypeCode IN ( SELECT LOWER(ComponentName)
                                  FROM #tmp
                                );
        INSERT INTO sourcetype ( SourceTypeCode , SourceTypeDesc
                               ) 
               SELECT DISTINCT 
                      ComponentName , Manufacturer
               FROM #tmp;
        INSERT INTO LoadProfileItem ( ProfileName , SourceTypeCode
                                    ) 
               SELECT DISTINCT 
                      'All Filters' , LOWER(ComponentName)
               FROM #tmp;
        --select * from sourcetype
        --select * from LoadProfileItem
        DROP TABLE IF EXISTS #tmpGraphic;
        CREATE TABLE #tmpGraphic ( 
                     GraphicFileTypeExt NVARCHAR(50)
                                 );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.AI'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.BMP'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.EPS'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.GIF'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.HEIF'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.INDD'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.JFI'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.JFIF'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.JIF'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.JPE'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.JPEG'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.JPEG 2000'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.JPG'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.PNG'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.PSD'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.RAW'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.SVG'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.TIF'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.TIFF'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.TRF'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.WEBP'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.jfi'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.jfif'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.jif'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.jpe'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.webp'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.psd'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.k25'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.nrw'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.cr2'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.arw'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.dib'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.heic'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.heif'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.indt'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.indd'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.ind'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.mj2'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.jpm'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.jpx'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.jpf'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.j2k'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.jp2'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.svgz'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.svg'
               );
        INSERT INTO #tmpGraphic ( GraphicFileTypeExt
                                ) 
        VALUES ( '.eps'
               );
        DELETE FROM GraphicFileType
        WHERE GraphicFileTypeExt IN ( SELECT DISTINCT 
                                             GraphicFileTypeExt
                                      FROM #tmpGraphic
                                    );
        INSERT INTO GraphicFileType ( GraphicFileTypeExt
                                    ) 
               SELECT GraphicFileTypeExt
               FROM #tmpGraphic
               EXCEPT
               SELECT GraphicFileTypeExt
               FROM GraphicFileType;
    END;