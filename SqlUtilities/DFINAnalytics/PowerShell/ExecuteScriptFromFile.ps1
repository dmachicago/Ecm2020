function ckTempDpProc ($ProcName, $svr, $db, $user,$pwd){
    $index = $ProcName.IndexOf("#");
    if ($index -eq -1){
        $ProcName = "#" + $ProcName ;
    }
    
    $DBQuery = "select isnull(object_id('tempdb..$ProcName'),0) as RC";
    $exists = execSql $svr $db $user $pwd $DBQuery ;
    $RC = $exists.RC;
    return $RC ;
}

function readScriptFile ($ScriptFqn){
    # $ScriptFqn = "D:\temp\TestCmd.sql" ;
    $DBQuery = Get-Content $ScriptFqn ;
    return $DBQuery;
}

function execSql ($svr, $db, $user,$pwd, $DBQuery)
{
    $ReturnObj = invoke-sqlcmd -Query $DBQuery -serverinstance "$svr" -database "$db" -Username $user -Password $pwd;
    return $ReturnObj;
}

$svr = "dfin.database.windows.net,1433";
$db = 'AW2016';
$user = 'wmiller';
$pwd = 'Junebug1';
$ProcName = 'spPrintImmediate';
$ProcFqn = "D:\dev\SQL\DFINAnalytics\PrintImmediate_TempDB.sql"

$rc = ckTempDpProc $ProcName $svr $db $user $pwd;

if ($rc -eq 0){
    $DBQuery = readScriptFile ($ProcFqn) ;
    $DBQuery
    invoke-sqlcmd -Query $DBQuery -serverinstance "$svr" -database "$db" -Username $user -Password $pwd;
}



#invoke-sqlcmd -inputfile "D:\temp\TestCmd.sql" -serverinstance "$svr" -database "$db" -Username $user -Password $pwd;
