
/****** Object:  View [dbo].[view_EDW_TrackerMetadata]    Script Date: 7/31/2014 8:18:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


alter View [dbo].[view_EDW_TrackerMetadata]
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
--******************************************************************************************************
SELECT TableName, ColName, AttrName, AttrVal, CreatedDate, LastModifiedDate, ID, CMS_CLASS.ClassLastModified
FROM     Tracker_EDW_Metadata
join CMS_CLASS on CMS_CLASS.ClassName = TableName

GO



-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
