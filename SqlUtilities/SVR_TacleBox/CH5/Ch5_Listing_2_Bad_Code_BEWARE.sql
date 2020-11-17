BEGIN Tran T_Time

DECLARE @SQL_Alphabet varchar(26)
SET @SQL_Alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
DECLARE @rnd_seed int
SET @rnd_seed = 26
DECLARE @DT datetime
SET @DT = '05/21/1969'
DECLARE @counter int
SET @counter = 1
DECLARE @tempVal NCHAR(40)

WHILE @counter < 100
    BEGIN
		SET @tempVal = SUBSTRING(@SQl_alphabet, Cast(RAND() * @rnd_seed as int) + 1, CAST(RAND() * @rnd_seed as int) + 1)

        Insert  Into Important_Data WITH ( XLOCK )
        Values  (
                  @tempVal,
                  DATEDIFF(d, cast(RAND() * 10000 as int) + 1, @DT),
                  NewID()
                ) 
        WAITFOR DELAY '00:00:01'
        SET @counter = @counter + 1
        
       
    END 
   Exec  xp_cmdshell 'C:\Windows\notepad.exe'
    
Commit Tran T_Time
