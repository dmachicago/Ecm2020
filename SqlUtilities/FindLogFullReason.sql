--This query will give you a rough overview of your databases, what recovery model they are using, 
--why the log is full, and when your last FULL and LOG backups were run.
/*
Look at the column marked log_reuse_wait_description. Most likely it says BACKUP. Next most likely cause is TRANSACTION.

If it is BACKUP here is some info:

Basically, for your SIMPLE databases, run a FULL backup every day. For your FULL databases, run a FULL backup every day, and a LOG backup every hour. Adjust the frequency of your LOG databases to match your ability to lose data while keeping your job.

If you see TRANSACTION as the reason, try running:

dbcc opentran
And track down whoever is has the open transactions.
*/
-- checkpoint
-- last FULL backup
;with FULLBUs 
as (
    select d.name, max(b.backup_finish_date) as 'Last FULL Backup'
    from sys.databases d
        join msdb.dbo.backupset b
            on d.name = b.database_name
    where b.type = 'D'
    group by d.name
),

-- last LOG backup for FULL and BULK_LOGGED databases
LOGBUs
as (
    select d.name, max(b.backup_finish_date) as 'Last LOG Backup'
    from sys.databases d
        join msdb.dbo.backupset b
            on d.name = b.database_name
    where d.recovery_model_desc <> 'SIMPLE'
        and b.type = 'L'
    group by d.name
)

-- general overview of databases, recovery model, and what is filling the log, last FULL, last LOG
select d.name, d.state_desc, d.recovery_model_desc, d.log_reuse_wait_desc, f.[Last FULL Backup], l.[Last LOG Backup]
from sys.databases d
    left outer join FULLBUs f
        on d.name = f.name
    left outer join LOGBUs l
        on d.name = l.name
where d.name not in ('model', 'TempDB')
order by d.name
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
