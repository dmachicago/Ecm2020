# NOTE* It is always best to test any process on a single dev or test server before trying it on ALL production databases!
# ----------------------------------------------
Import-Module SqlPs -DisableNameChecking #may only need this line for SQL 2012 +
 
# $databases grabs list of production databases from the SQL_DATABASES table on your Database
$databases = invoke-sqlcmd -ServerInstance ALIEN15 -Database AW2016 -Query "SELECT INSTANCE ,DATABASENAME FROM Database.dbo.SQL_DATABASES WHERE REGION = 'PROD'"
 
 
foreach ($database in $databases) #for each separate server / database pair in $databases
{
    # This lets us pick out each instance ($inst) and database ($name) as we iterate through each pair of server / database.
    $Inst = $database.INSTANCE #instance from the select query
    $DBname = $database.DATABASENAME #databasename from the select query
 
 
    #generate the output file name for each server/database pair
    $filepath = "C:\DBA_SCRIPTS\DB_Permissions\"
    $filename = $Inst +"_"+ $DBname +"_security.sql"
  
    # This line can be used if there are named instances in your environment.
    #$filename = $filename.Replace("\","$") # Replaces all "\" with "$" so that instance name can be used in file names.
  
    $outfile = ($filepath + $filename) #create out-file file name
 
 
    #connect to each instance\database and generate security script and output to files
    invoke-sqlcmd -ServerInstance ${Inst} -Database ${DBname} -InputFIle "C:\DBA_SCRIPTS\DB_Permissions\SQL_ScriptDBPermissions_V2.sql" | out-file -filepath ($outfile)
  
} #end foreach loop