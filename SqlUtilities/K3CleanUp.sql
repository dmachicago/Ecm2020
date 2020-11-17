create procedure sp_PurgeOldData as
select [EmailNbr] from email where ExpireByDate is null and (SELECT DATEDIFF(day,SentDate,getdate())) > 7 ;
select [EmailNbr] email where ExpireByDate <= getdate() ;
select [EmailNbr] CC where CC.emailguid not in (select emailguid from email) ;
select [EmailNbr] BCC where BCC.emailguid not in (select emailguid from email) ;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
