#Invoke commands in a script file and save the output in a text file
Invoke-Sqlcmd -InputFile "C:\ScriptFolder\TestSqlCmd.sql" | Out-File -FilePath "C:\ScriptFolder\TestSqlCmd.rpt"


#Invoke a script and pass in variable values from a string
$StringArray = "MYVAR1='String1'", "MYVAR2='String2'"
Invoke-Sqlcmd -Query "SELECT `$(MYVAR1) AS Var1, `$(MYVAR2) AS Var2" -Variable $StringArray


