#Add-Type -AssemblyName "Microsoft.SqlServer.Smo"
#load assemblies
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SMO") | Out-Null
#Need SmoExtended for backup
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SmoExtended") | Out-Null


$inst = 'Alien15';
# Connect to the specified instance
$s = new-object ('Microsoft.SqlServer.Management.Smo.Server') $inst
 
# Get the specified database where the changes will be made
$db = $s.Databases[$database]
 
$procs = $db.StoredProcedures
foreach ($proc in $procs) {
    if($proc.IsSystemObject -eq $False) {
        $txt = $proc.TextBody
        $chgd = $False 
        # Check to see if the text of the proc contains the search string and replace it if so
        if ($txt.Contains($srch) -eq $True) {
            $txt = $txt.Replace($srch,$repl)
            $chgd = $True
        }
 
        # If a change occurred, set the updated TextBody property and alter the proc
        if ($chgd = $True) {
            $proc.TextBody = $txt
            $proc.Alter()
        }
    }
}
