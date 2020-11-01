#Read-Host is a simple option for getting string input from a user.
$name = Read-Host 'What is your username?'

#To hide passwords you can use:
$pass = Read-Host 'What is your password?' -AsSecureString

#To convert the password to plain text:
[Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($pass))



#Place this at the top of your script. It will cause the script to prompt the user for a password. The resulting password can then be used elsewhere in your script via $pw.
   Param(
     [Parameter(Mandatory=$true, Position=0, HelpMessage="Password?")]
     [SecureString]$password
   )

   $pw = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

   write-host $pw