SELECT * FROM sys.sysprocesses WHERE blocked <> 0
            --Get the SPID from blocked column
            DBCC inputbuffer (SPID)
            sp_who2
            sp_lock2
            
            DBCC inputbuffer (184)
            DBCC inputbuffer (75)
            
            KILL 184
            GO
            KILL 75
            GO
