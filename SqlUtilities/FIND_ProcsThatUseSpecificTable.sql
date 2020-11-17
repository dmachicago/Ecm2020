SELECT Name
FROM sys.procedures
WHERE OBJECT_DEFINITION(OBJECT_ID) LIKE '%HoldingsLoad%'


select distinct [Table Name] = o.Name, [Found In] = sp.Name, sp.type_desc
  from sys.objects o inner join sys.sql_expression_dependencies  sd on o.object_id = sd.referenced_id
                inner join sys.objects sp on sd.referencing_id = sp.object_id
                    and sp.type in ('P', 'FN')
  where o.name = 'HoldingsLoad'
  order by sp.Name

select distinct [Table Name] = o.Name, [Found In] = sp.Name, sp.type_desc
  from sys.objects o inner join sys.sql_expression_dependencies  sd on o.object_id = sd.referenced_id
                inner join sys.objects sp on sd.referencing_id = sp.object_id
                    and sp.type in ('P', 'FN')
  where o.name in ('NativeHoldingsRawData',
					'NativeHoldingsImport',
					'HoldingsLoad',
					'NativeHoldingsImportArchive',
					'NativeClassBalance_Import',
					'NativeClassBalance_ImportArchive',
					'ClassBalanceFile_Import',
					'ClassBalance_ImportArchive',
					'SecurityBalance_Import',
					'AutomatedClassBalance_Import',
					'SecurityCaption',
					'SecurityCaptionFile_Import',
					'NativeFundBalance_Import',
					'FundFile_Import')
  order by sp.Name

