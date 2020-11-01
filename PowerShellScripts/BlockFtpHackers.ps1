#Script starts the LogParser tool and searches for the response code “530” which means that the login failed; Then it saves all IP addresses and the number of logins in the CSV file in the folder c:\work\tempftp\FTPUserAccountAttempts.csv .
#Script parses the CSV file and extracts the IP addresses and add them to the “Deny” list in “FTP IPv4 Address and Domain Restrictions” module.
#Exits 

#So, what do you need in order to get the script running on your machine?
#1. Enter the correct path to your FTP log files in the “$logpath” variable
#2. Make sure you have “c:\work\temp\ftp” folder created or modify the script.
#3. Edit the “-location” in the add-webconfiguration /system.ftpServer/security/ipSecurity -location "IIS:\Sites\FTP" -value @{ipAddress="$ipban";allowed="false"} -pspath IIS:\
#cmd /c reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\system /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f

Function FTPBlock
{
    #SETTINGS
    $date = Get-date -Format yMMdd
    $date = '150713'
    #u_ex150713
    $logpath = "C:\inetpub\logs\LogFiles\FTPSVC1\u_ex$date.log"
        $logpath = "C:\inetpub\logs\LogFiles\FTPSVC1\u_ex150727.log"

    #END SETTINGS
    $testpath = Test-Path $logpath
    if ($testpath -eq "false")
    {
        write-host "Processing $logpath"
    }
        else {
            write-host $logpath + " MISSING -> Returning "
            $date2 = Get-date -Format MM-dd-yy
            Add-Content c:\work\parse.log "$logpath  MISSING : $date2" 
            return 
        }
    
    
    Import-Module "WebAdministration" -ErrorAction Stop
    $ErrorActionPreference= 'silentlycontinue'
    #.\logparser "select c-ip, count(sc-status) INTO c:\work\tempftp\FTPUserAccountAttempts.csv FROM $logpath where sc-status = '530' group by c-ip HAVING COUNT(*) > 20 order by count(sc-status),c-ip" -e:1 -i w3c -o:CSV
    & "C:\Program Files (x86)\Log Parser 2.2\logparser.exe" "select c-ip, count(sc-status) INTO c:\work\tempftp\FTPUserAccountAttempts.csv FROM $logpath where sc-status = '530' group by c-ip HAVING COUNT(*) > 20 order by count(sc-status),c-ip" -e:1 -i w3c -o:CSV
    $testpath = Test-Path C:\work\tempftp\FTPUserAccountAttempts.csv
    $date2 = Get-date -Format MM-dd-yy
    
    if ($testpath -eq "true")
    {
        $ip = Get-Content C:\work\tempftp\FTPUserAccountAttempts.csv | select -Skip 1
        foreach ($_ in $ip)
        {
            $ip1 = $_.split(",")
                write-host $ip1 
            $ipban = $ip1[0]
            write-host "BLOCKING: " $ipban
            Add-Content c:\work\parse_$date.log "BLOCKING: $ipban : $date2" 
            add-webconfiguration /system.ftpServer/security/ipSecurity -location "IIS:\Sites\FTP" -value @{ipAddress="$ipban";allowed="false"} -pspath IIS:\
        }
    }
    elseif ($testpath -eq "false")
    {
        exit
    }

}
cls
FTPBlock