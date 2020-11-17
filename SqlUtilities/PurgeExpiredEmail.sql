alter procedure PurgeExpiredEmail as
Begin
Update BCC set FromAddr = (select REPLICATE('*',80))
,ToAddr = (select REPLICATE('*',80)) 
 where EmailGuid in (Select EmailGuid from Email where ExpireByDate <= getdate());

Update CC  set FromAddr = (select REPLICATE('*',80)) 
,ToAddr = (select REPLICATE('*',80)) 
where EmailGuid in (Select EmailGuid from Email where ExpireByDate <= getdate());

Update FromEmail  set FromAddr = (select REPLICATE('*',80)) 
,ToAddr = (select REPLICATE('*',80)) 
where EmailGuid in (Select EmailGuid from Email where ExpireByDate <= getdate());

Update SendTO  set FromAddr = (select REPLICATE('*',80)) 
,ToAddr = (select REPLICATE('*',80)) 
where EmailGuid in (Select EmailGuid from Email where ExpireByDate <= getdate());

Update Email set EmailSubject = (select REPLICATE('*',2000))
, EmailBody = (select REPLICATE('*',8000))
, FromEmail = (select REPLICATE('*',250))
, CC = (select REPLICATE('*',2000))
, BCC = (select REPLICATE('*',2000))
, ToEmail = (select REPLICATE('*',2000))
where ExpireByDate <= getdate();
---------------------
DELETE from BCC where EmailGuid in (Select EmailGuid from Email where ExpireByDate <= getdate());
DELETE from CC where EmailGuid in (Select EmailGuid from Email where ExpireByDate <= getdate());
DELETE from FromEmail where EmailGuid in (Select EmailGuid from Email where ExpireByDate <= getdate());
DELETE from SendTO where EmailGuid in (Select EmailGuid from Email where ExpireByDate <= getdate());
DELETE from Email where ExpireByDate <= getdate();
end
exec PurgeExpiredEmails  --  
  --  
GO 
print('***** FROM: PurgeExpiredEmail.sql'); 
GO 

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
