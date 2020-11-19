--D. Miller March 2015
SELECT 
    t.name AS TableName, 
    c.name AS FTCatalogName ,
    i.name AS UniqueIdxName,
    cl.name AS ColumnName,
    cdt.name AS DataTypeColumnName
FROM 
    sys.tables t 
INNER JOIN 
    sys.fulltext_indexes fi 
ON 
    t.[object_id] = fi.[object_id] 
INNER JOIN 
    sys.fulltext_index_columns ic
ON 
    ic.[object_id] = t.[object_id]
INNER JOIN
    sys.columns cl
ON 
    ic.column_id = cl.column_id
    AND ic.[object_id] = cl.[object_id]
INNER JOIN 
    sys.fulltext_catalogs c 
ON 
    fi.fulltext_catalog_id = c.fulltext_catalog_id
INNER JOIN 
    sys.indexes i
ON 
    fi.unique_index_id = i.index_id
    AND fi.[object_id] = i.[object_id]
LEFT JOIN 
    sys.columns cdt
ON 
    ic.type_column_id = cdt.column_id
    AND fi.object_id = cdt.object_id;

/*

DataSource	ftCatalog	PK_DataSource	SourceName	NULL
DataSource	ftCatalog	PK_DataSource	SourceImage	SourceTypeCode
DataSource	ftCatalog	PK_DataSource	Description	NULL
DataSource	ftCatalog	PK_DataSource	KeyWords	NULL
DataSource	ftCatalog	PK_DataSource	Notes	NULL
DataSource	ftCatalog	PK_DataSource	OcrText	NULL
Email	ftEmailCatalog	PK__Email__24383F235DE40451	SUBJECT	NULL
Email	ftEmailCatalog	PK__Email__24383F235DE40451	Body	NULL
Email	ftEmailCatalog	PK__Email__24383F235DE40451	EmailImage	SourceTypeCode
Email	ftEmailCatalog	PK__Email__24383F235DE40451	ShortSubj	NULL
Email	ftEmailCatalog	PK__Email__24383F235DE40451	Description	NULL
Email	ftEmailCatalog	PK__Email__24383F235DE40451	KeyWords	NULL
Email	ftEmailCatalog	PK__Email__24383F235DE40451	notes	NULL
EmailAttachment	ftEmailCatalog	PK__EmailAtt__B975DD8289908A26	Attachment	AttachmentCode
EmailAttachment	ftEmailCatalog	PK__EmailAtt__B975DD8289908A26	AttachmentName	NULL
EmailAttachment	ftEmailCatalog	PK__EmailAtt__B975DD8289908A26	OcrText	NULL

*/