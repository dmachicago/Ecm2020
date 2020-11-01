--select top 18 * from INFORMATION_SCHEMA.COLUMNS

DECLARE @cols NVARCHAR(2000)= 'AttachmentName, RowID, EmailGuid';

SELECT 'DIM ' + column_name + ' = New DataColumn("' + column_name + '", Type.GetType("System.' + data_type + '"))'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE column_name IN('AttachmentName', 'RowID', 'EmailGuid')
AND table_name = 'EmailAttachment';

SELECT 'DIM s' + column_name + ' as ' + data_type + ' = nothing '
FROM INFORMATION_SCHEMA.COLUMNS
WHERE column_name IN('AttachmentName', 'RowID', 'EmailGuid')
AND table_name = 'EmailAttachment';

SELECT 'DT.Columns.Add(' + column_name + ')'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE column_name IN('AttachmentName', 'RowID', 'EmailGuid')
AND table_name = 'EmailAttachment';

SELECT 's' + column_name + ' = Obj.' + column_name + ' _'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE column_name IN('AttachmentName', 'RowID', 'EmailGuid')
AND table_name = 'EmailAttachment';

SELECT ', s' + column_name + ' as ' + data_type + ' _'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE column_name IN('AttachmentName', 'RowID', 'EmailGuid')
AND table_name = 'EmailAttachment';

SELECT 'DR("' + column_name + '") = ' + column_name
FROM INFORMATION_SCHEMA.COLUMNS
WHERE column_name IN('AttachmentName', 'RowID', 'EmailGuid')
AND table_name = 'EmailAttachment';