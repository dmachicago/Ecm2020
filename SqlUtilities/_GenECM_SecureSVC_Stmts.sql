select 'gFunc.LoadDictVals(("'+ column_name +'",ENC.EncryptTripleDES(gvar.g'+COLUMN_NAME +'))' from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'SecureAttach'

gvar.gServerName = cbServers.Text
select 'gvar.g'+ column_name +' = ' + column_name +'.text'  from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'SecureAttach'

select 'gvar.g'+ column_name +' = ' + column_name +'.text'  from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'SecureAttach'

Public Shared gWinAuth As String = ""
select 'Public Shared g'+ column_name +'  as string'  from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'SecureAttach'

Dim LoginID As String = tDict("LoginID")
select 'Dim '+ column_name +'  as string As String = tDict("' + column_name + '")'  from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'SecureAttach'
