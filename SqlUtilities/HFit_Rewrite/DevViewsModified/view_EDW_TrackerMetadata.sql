
print ('Processing: view_EDW_TrackerMetadata ') ;
go

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_TrackerMetadata')
BEGIN
	drop view view_EDW_TrackerMetadata ;
END
GO


CREATE View [dbo].[view_EDW_TrackerMetadata]
as
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
SELECT TableName, ColName, AttrName, AttrVal, CreatedDate, LastModifiedDate, ID, CMS_CLASS.ClassLastModified
FROM     Tracker_EDW_Metadata
join CMS_CLASS on CMS_CLASS.ClassName = TableName


GO


