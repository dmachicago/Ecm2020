/*
This one command will give you details about the current size of 
all of your database transaction logs as well as the percent 
currently in use.  Running this command on a periodic basis will 
give you a good idea of how the transaction logs are being used 
and also give you an idea on how large they should really be. 
*/
DBCC SQLPERF(logspace)


/*
The next command to look at is DBCC LOGINFO. This will give you 
information about your virtual logs inside your transaction log.  
The primary thing to look at here is the Status column.  Since 
this file is written sequentially and then looped back to the 
beginning, you want to take a look at where the value of "2" is 
in the output.  This will tell you what portions of the log are 
in use and which are not in use Status = 0.  Another thing to 
keep an eye on is the FSeqNo column. This is the virtual log 
sequence number and the latest is the last log.  If you keep 
running this command as you are issuing transactions you will see 
these numbers keep changing.
*/

DBCC LOGINFO


/*
Another command to look at is DBCC OPENTRAN. This will show you if 
you have any open transactions in your transaction log that have not 
completed or have not been committed.  These may be active transactions 
or transactions that for some reason never completed.  This can provide 
additional information as to why your transaction log is so big or why 
you may not be able to shrink the transaction log file.  This will show 
you both open transactions as well any un-replicated transactions if 
the database is published.
*/

DBCC OPENTRAN

go

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
