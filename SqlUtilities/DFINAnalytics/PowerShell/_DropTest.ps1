[System.Reflection.Assembly]::LoadWithPartialName(`
    "Microsoft.SqlServer.SMO") 

$Server = new-object `
    Microsoft.SqlServer.Management.Smo.Server `
    ('ALIEN15')
    
$DataBase = $Server.Databases["TReporting"]

if(! $DataBase.StoredProcedures.Contains( `
    "sp_AcuityLevelCount", "dbo"))
{
    $SP = new-object `
        Microsoft.SqlServer.Management.Smo.StoredProcedure `
        ($DataBase, "sp_AcuityLevelCount", "dbo")
    
    $SP.TextMode = $false
    $SP.AnsiNullsStatus = $false
    $SP.QuotedIdentifierStatus = $false
    
    $SP.TextBody = 
        "Insert Into ag_AcuityLevelCount " + `
        "select acuitylevel, " + `
        "count(acuitylevel) AS AcuityLevelCount " + `
        "from f_Visit " + `
        "where acuitylevel > 0 " + `
        "group by acuitylevel " + `
        "order by acuitylevel"

    $SP.Create()
}
$Server.ConnectionContext.Disconnect()