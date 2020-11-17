
PRINT 'Processing: view_EDW_TrackerMetadata ';
GO

IF EXISTS( SELECT
                  TABLE_NAME
             FROM INFORMATION_SCHEMA.VIEWS
             WHERE TABLE_NAME = 'view_EDW_TrackerMetadata' )
    BEGIN
        DROP VIEW
             view_EDW_TrackerMetadata;
    END;
GO


CREATE VIEW dbo.view_EDW_TrackerMetadata
AS
--******************************************************************************************************
--TableName - this is the CMS_CLASS ClassName and is used to identify the needed metadata. 
--ColumnName - Each Class has a set of columns. This is the name of the column as contained
--				within the CLASS.
--AttrName - The name of the attribute as it applies to the column (e.g. column type 
--				describes the datatype of the column (ColName) within the CLASS (ClassName).
--AttrVal - the value assigned to the AttrName.
--CreatedDate - the date this row of metadata was created.
--LastModifiedDate - the date this row of metadata was last changed in the Tracker_EDW_Metadata table.
--ID - An identity field within the Tracker_EDW_Metadata table.
--ClassLastModified - The last date the CLASS within CMS_CLASS was changed.
--09.11.2014 : (wdm) Verified last mod date available to EDW 
--******************************************************************************************************
SELECT
       TableName , 
       ColName , 
       AttrName , 
       AttrVal , 
       cast(CreatedDate as datetime ) as CreatedDate , 
       cast(LastModifiedDate  as datetime ) as LastModifiedDate  , 
       ID , 
       cast(CMS_CLASS.ClassLastModified as datetime ) as ClassLastModified 
  FROM
       Tracker_EDW_Metadata JOIN CMS_CLASS
       ON CMS_CLASS.ClassName = TableName;


GO


--  
--  
GO 
PRINT '***** FROM: view_EDW_TrackerMetadata.sql'; 
GO 
