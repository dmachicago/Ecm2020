Import-Module SQLServer #Could use SQLPS instead
 
#----------------------------------------------------------------
#Setup variables
#----------------------------------------------------------------
$instance = 'ALIEN15'
$hostname = 'ALIEN15'
$instancename = 'ALIEN15'
$database = 'DFINSAnalytics'
$outputFile = 'D:\Temp\_AlteredStoredProcedures.sql'
 
#----------------------------------------------------------------
#Get all the Stored Procedures
#----------------------------------------------------------------
#$allSPs = Get-ChildItem SQLSERVER:\SQL\$hostname\$instancename\Databases\$database\StoredProcedures
$allSPs = Get-ChildItem SQLSERVER:\SQL\$instancename\Databases\$database\StoredProcedures
 
#----------------------------------------------------------------
#SQL contains conditions we want to filter the stored procedures by..
#...in this case, we are looking for procedures that have "exec" or "sp_execute" in them (dynamic SQL)
#    of if the stored procedure name ends with "_del"
#----------------------------------------------------------------
$sql = "SELECT DISTINCT
               schema_name(o.schema_id) schema_nm,
               o.name AS Object_Name,
               o.type_desc
          FROM sys.sql_modules m
               INNER JOIN
               sys.objects o
                 ON m.object_id = o.object_id
        WHERE o.type_desc = 'SQL_STORED_PROCEDURE'
            ---------------------------------------
            --Change here to suit the conditions you desire
            ---------------------------------------
            AND (m.definition Like '%exec %'
                    or m.definition Like 'UTIL_%');"
 
$filteredSPs = Invoke-Sqlcmd -ServerInstance $instance -Database $database -Query $sql -OutputAs DataTables
 
#----------------------------------------------------------------
#Loop through the SP's we want to alter and alter them
#----------------------------------------------------------------
foreach($sp in $filteredSPs)
{
    $spText = ''
    $spLocated = $null
    $spLocated = ($allSPs |  ? {($_.Schema -eq "$($sp.schema_nm)") -and ($_.Name -eq "$($sp.object_name)")})
 
    if ($spLocated -eq $null)
    {
        Write-Warning "$($sp.schema_nm).$($sp.object_name) was not found!"
    }
    else
    {
        #This gets the script for the stored procedure as CREATE
        $spText = $spLocated.script()
 
        #Do case-insensitive replace
        #----------------------------------------------------------------
        #Replace CREATE with ALTER (+)
        #   Add "EXECUTE AS OWNER" (+)
        #   Replace "SYSTEM_USER" with "ORIGINAL_LOGIN()"
        #   Comment out SET statements
        #----------------------------------------------------------------
        $spText = $spText -ireplace [Regex]::Escape("`nCREATE"), "`nALTER"
        $spText = $spText -ireplace [Regex]::Escape("`nAS"), "`nWITH EXECUTE AS OWNER `nAS"
        $spText = $spText -ireplace [Regex]::Escape("SYSTEM_USER"), "ORIGINAL_LOGIN()"
        $spText = $spText -ireplace [Regex]::Escape("SET ANSI_NULLS ON"), "--SET ANSI_NULLS ON"
        $spText = $spText -ireplace [Regex]::Escape("SET QUOTED_IDENTIFIER ON"), "--SET QUOTED_IDENTIFIER ON"
 
        #Add a GO at the end
        $spText = $spText + "`nGO`n"
 
        $spText | Out-File -LiteralPath $outputFile -Force -Append   
 
    }
 
}
 
#For some reason, if somethings did not get replaced as intended due to lack of
# newline characters at the start for example, replace at the file level
#Replace remnant CREATE's...just replace at the file level
#
(Get-Content $outputFile -Raw).Replace("`nCREATE","`nALTER") |
Set-Content $outputFile -Force