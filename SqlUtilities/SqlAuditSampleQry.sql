select top 100 * from HFIT_PPTEligibility
update HFIT_PPTEligibility set FirstName = 'dale' where FirstName = 'Dale' 
update HFIT_PPTEligibility set FirstName = 'Dale' where FirstName = 'Dale' 

SELECT * FROM sys.fn_get_audit_file ('Y:\Log\*', null, null)

SELECT * FROM sys.fn_get_audit_file
('C:\Audit\*', null, null)
GO

--To read all audit files with a specified name (for example from an audit called ‘test_audit’) from a specified location (for example ‘C:\Audit\’):

SELECT * FROM sys.fn_get_audit_file
('C:\Audit\test_audit_*.sqlaudit', null, null)
GO

--To read all information from a specific audit file (for example ‘C:\Audit\test_audit_file_name.sqlaudit’):

SELECT * FROM sys.fn_get_audit_file
('C:\Audit\test_audit_file_name.sqlaudit', null, null)
GO

--You can create your own query that returns only information that you need from the audit files. For example:

SELECT
[event_time], [session_id], [object_id], [session_server_principal_name], [server_principal_name],
[database_principal_name], [server_instance_name], [database_name],
[object_name], [file_name], [statement]
FROM sys.fn_get_audit_file
('C:\Audit\*', null, null)
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
