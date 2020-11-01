
    #Place this at the top of your script. It will cause the script to prompt the user for a password. The resulting password can then be used elsewhere in your script via $pw.

   Param(
     [Parameter(Mandatory=$true, Position=0, HelpMessage="Password?")]
     [SecureString]$password
   )

   $pw = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

   write-host $pw