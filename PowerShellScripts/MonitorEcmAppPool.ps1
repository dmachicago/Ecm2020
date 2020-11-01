
import-module webadministration
 
	function main{
	#get-command -module webadministration will show all the IIS stuff
	$appPoolName = "ECM"
    $logFileName = "C:\temp\MonitorEcmAppPool.txt" ;	
	$dt = get-date
	$ComputerName = $env:computername
	If((get-WebAppPoolState -name $appPoolName).Value -eq "Stopped")
	{
        $log = "ECM App Pool Crashed: ";
        $log += Get-Date;
        $log += "; restarting `n";
         Add-Content $logFileName  $log;

		write-host "Failure detected, attempting to start it"
		start-webAppPool -name $appPoolName
		start-sleep -s 15
		
		If((get-WebAppPoolState -name $appPoolName).Value -eq "Stopped")
		{
			write-host "Tried to restart, but it didn't work!"
            $log = "Restart Failed: ";
            $log += Get-Date;
            $log += "`n";
            $log += "`n";
            Add-Content $logFileName  $log;
			sendmail "AppPoolRestart Failed" "App Pool $appPoolName restart on $ComputerName failed - this will effect search `n $dt"
			#log to event log
		}
		else
		{
			write-host "Looks like the app pool restarted ok"
			$log = "Restart Success: ";
            $log += Get-Date;
            $log += "`n";
            $log += "`n";
            Add-Content $logFileName  $log;
			$subjectString = "AppPool Restart was needed"
			$body = "A routine check of the App Pool $appPoolName on $ComputerName found that it was not running, it has been restarted. `n $dt"
			sendmail $subjectString $body
			#log to event log?
		}
	}
	else
	 {
	 write-host "app pool $appPoolName is running"
	 }
 } #end main function
 
 function sendmail($subject, $body)
 {
    
    write-host "in Sendmail with subject: $subject, and body: $body"
	
    $From = "support@EcmLibrary.com"
    $To = "wdalemiller@gmail.com;jegwynn@msn.com;jmgurba@bulovatech.com"
    $SMTPServer = "smtp.gmail.com"
    $SMTPPort = "587"
    $Username = "wdalemiller@gmail.com"
    $Password = "aunnie@01"
    #$subject = "Email Subject"
    #$body = "Insert body text here"

    $smtp = New-Object System.Net.Mail.SmtpClient($SMTPServer, $SMTPPort);

    $smtp.EnableSSL = $true
    $smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
    $smtp.Send($From, $To, $subject, $body);

 }
 
 #call main function
 main