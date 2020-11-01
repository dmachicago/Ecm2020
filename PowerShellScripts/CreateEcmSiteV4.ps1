#Author: W. Dale Miller
#Copyright @ March, 2010, all rights reserved.
#Step 1: Create New ECM Directories
#We use the New-Item cmdlet to create the required file system directories. 
#Execute the following commands (use 'md' instead of New-Item if you 
#don't want to specify the -type parameter):


#Load the WEB Assembly
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Web.Administration") 

#Create a new IIS object
$iis = new-object Microsoft.Web.Administration.ServerManager

if ( ! (Test-Path C:\inetpub\wwwroot\AdminSetup))
{
	New-Item C:\inetpub\wwwroot\AdminSetup -type Directory
}

if (! (Test-Path C:\inetpub\wwwroot\Archive))
{
	New-Item C:\inetpub\wwwroot\Archive -type Directory
}
if (! (Test-Path C:\inetpub\wwwroot\ArchiveFS))
{
	New-Item C:\inetpub\wwwroot\ArchiveFS -type Directory
}
if (! (Test-Path C:\inetpub\wwwroot\ArchiverCLC))
{
	New-Item C:\inetpub\wwwroot\ArchiverCLC -type Directory
}
if (! (Test-Path C:\inetpub\wwwroot\AuthenticationSVC))
{
	New-Item C:\inetpub\wwwroot\AuthenticationSVC -type Directory 
}
if (! (Test-Path C:\inetpub\wwwroot\CLC))
{
	New-Item C:\inetpub\wwwroot\CLC -type Directory 
}
if (! (Test-Path C:\inetpub\wwwroot\SVCclcDownload))
{
	New-Item C:\inetpub\wwwroot\SVCclcDownload -type Directory 
}
if (! (Test-Path C:\inetpub\wwwroot\SVCclcDownload))
{
	New-Item C:\inetpub\wwwroot\SVCclcDownload -type Directory 
}
if (! (Test-Path C:\inetpub\wwwroot\ClcDownloader))
{
	New-Item C:\inetpub\wwwroot\ClcDownloader -type Directory 
}
if (! (Test-Path C:\inetpub\wwwroot\EcmAuthenticationApp))
{
	New-Item C:\inetpub\wwwroot\EcmAuthenticationApp -type Directory 
}
if (! (Test-Path C:\inetpub\wwwroot\EcmEncryptor))
{
	New-Item C:\inetpub\wwwroot\EcmEncryptor -type Directory 
}
if (! (Test-Path C:\inetpub\wwwroot\Search))
{
	New-Item C:\inetpub\wwwroot\Search -type Directory 
}
if (! (Test-Path C:\inetpub\wwwroot\SecureAttachAdmin))
{
	New-Item C:\inetpub\wwwroot\SecureAttachAdmin -type Directory 
}
if (! (Test-Path C:\inetpub\wwwroot\SecureAttachAdminSVC))
{
	New-Item C:\inetpub\wwwroot\SecureAttachAdminSVC -type Directory 
}
if (! (Test-Path C:\inetpub\wwwroot\SecureAttachAdminSVC))
{
	New-Item C:\inetpub\wwwroot\SecureAttachAdminSVC -type Directory 
}
if (! (Test-Path C:\inetpub\wwwroot))
{
	New-Item C:\inetpub\wwwroot -type Directory 
}
if (! (Test-Path C:\inetpub\wwwroot\DemoApp))
{
	New-Item C:\inetpub\wwwroot\DemoApp -type Directory 
}
if (! (Test-Path C:\inetpub\wwwroot\DemoVirtualDir1))
{
	New-Item C:\inetpub\wwwroot\DemoVirtualDir1 -type Directory 
}
if (! (Test-Path C:\inetpub\wwwroot\DemoVirtualDir2))
{
	New-Item C:\inetpub\wwwroot\DemoVirtualDir2 -type Directory
}





#Step 2: Copy Content
#Now let's write a simple html file to these directories:

Set-Content C:\inetpub\wwwroot\Identify.htm "C:\inetpub\wwwroot"
Set-Content C:\inetpub\wwwroot\DemoApp\Identify.htm "EcmSite\DemoApp Default Page"
Set-Content C:\inetpub\wwwroot\DemoVirtualDir1\Identify.htm "EcmSite\DemoVirtualDir1 Default Page"
Set-Content C:\inetpub\wwwroot\DemoVirtualDir2\Identify.htm "C:\inetpub\wwwroot\DemoVirtualDir2 Default Page"

Set-Content C:\inetpub\wwwroot\AdminSetup\Identify.htm "C:\inetpub\wwwroot\AdminSetup Default Page"
Set-Content C:\inetpub\wwwroot\Archive\Identify.htm "C:\inetpub\wwwroot\Archive Default Page"
Set-Content C:\inetpub\wwwroot\ArchiveFS\Identify.htm "C:\inetpub\wwwroot\ArchiveFS Default Page"
Set-Content C:\inetpub\wwwroot\ArchiverCLC\Identify.htm "C:\inetpub\wwwroot\ArchiverCLC Default Page"
Set-Content C:\inetpub\wwwroot\AuthenticationSVC\Identify.htm "C:\inetpub\wwwroot\AuthenticationSVC Default Page"
Set-Content C:\inetpub\wwwroot\CLC\Identify.htm "C:\inetpub\wwwroot\CLC Default Page"
Set-Content C:\inetpub\wwwroot\Identify.htm "C:\inetpub\wwwroot\ Default Page"
Set-Content C:\inetpub\wwwroot\SVCclcDownload\Identify.htm "C:\inetpub\wwwroot\SVCclcDownload Default Page"
Set-Content C:\inetpub\wwwroot\ClcDownloader\Identify.htm "C:\inetpub\wwwroot\ClcDownloader Default Page"
Set-Content C:\inetpub\wwwroot\EcmAuthenticationApp\Identify.htm "C:\inetpub\wwwroot\EcmAuthenticationApp Default Page"
Set-Content C:\inetpub\wwwroot\EcmEncryptor\Identify.htm "C:\inetpub\wwwroot\EcmEncryptor Default Page"
Set-Content C:\inetpub\wwwroot\Search\Identify.htm "C:\inetpub\wwwroot\Search Default Page"
Set-Content C:\inetpub\wwwroot\SecureAttachAdmin\Identify.htm "C:\inetpub\wwwroot\Search Default Page"
Set-Content C:\inetpub\wwwroot\SecureAttachAdminSVC\Identify.htm "C:\inetpub\wwwroot\SecureAttachAdminSVC Default Page"


#Step 3: Create New Application Pool
#Create the new Application Pool 'EcmAppPool' for the new site if you deleted the one we created in the previous sample.  

New-Item IIS:\AppPools\EcmAppPool

set-ItemProperty IIS:\AppPools\EcmAppPool managedRuntimeVersion v4.0


#Step 4: Create New Sites, Web Applications and Virtual Directories and Assign to Application Pool
#Here comes the beef. We create EcmSite, DemoApp and two Virtual Directories - DemoVirtualDir1 is 
#directly underneath EcmSite and DemoVirtualDir2 is underneath DemoApp. We are assigning EcmSite 
#and DemoApp to DemoAppPool created in the previous step. EcmSite is assigned to port 8080 to not 
#conflict with the 'Default Web Site'
#[string]$TgtSite = “MyFileServer01"

New-Webapplication -force -Site "Default Web Site" -Name AdminSetup -physicalPath C:\inetpub\wwwroot\AdminSetup -ApplicationPool EcmAppPool

New-Webapplication -force -Site "Default Web Site" Archive -physicalPath C:\inetpub\wwwroot\Archive -ApplicationPool EcmAppPool

New-Webapplication -force -Site "Default Web Site" ArchiveFS -physicalPath C:\inetpub\wwwroot\ArchiveFS -ApplicationPool EcmAppPool

New-Webapplication -force -Site "Default Web Site" ArchiverCLC -physicalPath C:\inetpub\wwwroot\ArchiverCLC -ApplicationPool EcmAppPool

New-Webapplication -force -Site "Default Web Site" AuthenticationSVC -physicalPath C:\inetpub\wwwroot\AuthenticationSVC -ApplicationPool EcmAppPool

New-Webapplication -force -Site "Default Web Site" CLC -physicalPath C:\inetpub\wwwroot\CLC -ApplicationPool EcmAppPool

New-Webapplication -force -Site "Default Web Site" clcDownload -physicalPath C:\inetpub\wwwroot\SVCclcDownLoad -ApplicationPool EcmAppPool

New-Webapplication -force -Site "Default Web Site" clcDownloader -physicalPath C:\inetpub\wwwroot\ClcDownloader -ApplicationPool EcmAppPool

New-Webapplication -force -Site "Default Web Site" EcmAuthenticationApp -physicalPath C:\inetpub\wwwroot\EcmAuthenticationApp -ApplicationPool EcmAppPool

New-Webapplication -force -Site "Default Web Site" EcmEncryptor -physicalPath C:\inetpub\wwwroot\EcmEncryptor -ApplicationPool EcmAppPool

New-Webapplication -force -Site "Default Web Site" Search -physicalPath C:\inetpub\wwwroot\Search -ApplicationPool EcmAppPool

New-Webapplication -force -Site "Default Web Site" SecureAttachAdmin -physicalPath C:\inetpub\wwwroot\SecureAttachAdmin -ApplicationPool EcmAppPool

New-Webapplication -force -Site "Default Web Site" SecureAttachAdminSVC -physicalPath C:\inetpub\wwwroot\SecureAttachAdminSVC -ApplicationPool EcmAppPool

New-Webapplication -force -Site "Default Web Site" SecureLogin -physicalPath C:\inetpub\wwwroot\SecureAttachAdminSVC -ApplicationPool EcmAppPool

New-Webapplication -force -Site "Default Web Site" SVCclcDownload -physicalPath C:\inetpub\wwwroot\SVCclcDownload  -ApplicationPool EcmAppPool
