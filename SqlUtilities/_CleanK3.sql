-r
-- DMA, Limited
-- W. Dale Miller
-- July 26, 2015 /g
-R
-- DMA, Limited
-- W. Dale Miller
-- July 26, 2015
-r
-- DMA, Limited
-- W. Dale Miller
-- July 26, 2015
-- DMA, Limited
-- W. Dale Miller
-- July 26, 2015
-- DMA, Limited
-- W. Dale Miller
Mon, Dec 31, 2018  8:05:52 AM
-- DMA, Limited
-- W. Dale Miller
Mon, Dec 31, 2018  8:04:45 AM
-- DMA, Limited
-- W. Dale Miller
Mon, Dec 31, 2018  8:04:35 AM
-- DMA, Limited
-- W. Dale Miller
Mon, Dec 31, 2018  8:02:31 AM
use k3;
go
--Select 'delete from ' + table_name +';' 
--from information_schema.tables 
--where table_type = 'BASE TABLE'
--order by TABLE_NAME

delete from ActiveSession;
delete from Attachment;
delete from BCC;
delete from CC;
delete from CommVector;
delete from CommVectorInit;
delete from Email;
delete from EmailNbr;
delete from EmailSentCnt;
delete from FromEmail;
delete from K3;
delete from MachineID;
--delete from Member;
delete from MemberMachine;
delete from MemberVector;
delete from PgmTrace;
delete from SendTO;
delete from SessionKey;
delete from SysParm;
delete from ToEmail;
delete from Tracking;