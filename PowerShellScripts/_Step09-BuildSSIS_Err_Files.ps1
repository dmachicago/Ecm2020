#*************************************************************************************************************
#Last Modification Date: Jul, 18, 2015
#Developed by W. Dale Miller
#Search for "Enter Execution Variables Here" and fill in the execution variables and execute the program.
#Changes:
#2/1/2013 -  None to date
#*************************************************************************************************************

try{
    Set-ExecutionPolicy RemoteSigned
}
catch {
    echo ("Caught the exception")
    echo ($Error[0].Exception)
    echo "Continuing..."
}

$path = "C:\Temp"
If(!(test-path $path))
{
	New-Item -ItemType Directory -Force -Path $path
}


$path = "C:\Temp\ErrEmail"
If(!(test-path $path))
{
	New-Item -ItemType File -Force -Path $path -value " "
}


$path = "C:\Temp\DocErr.txt"
If(!(test-path $path))
{
	New-Item -ItemType File -Force -Path $path -value " "
}


$path = "C:\Temp\ERR_EmailArchParms.txt"
If(!(test-path $path))
{
	New-Item -ItemType File -Force -Path $path -value " "
}


$path = "C:\Temp\ERR_EmailAttachmentSearchList.txt"
If(!(test-path $path))
{
	New-Item -ItemType File -Force -Path $path -value " "
}


$path = "C:\Temp\ERR_EmailFolder.txt"
If(!(test-path $path))
{
	New-Item -ItemType File -Force -Path $path -value " "
}

$path = "C:\Temp\ERR_UserGroup.txt"
If(!(test-path $path))
{
	New-Item -ItemType File -Force -Path $path -value " "
}

$path = "C:\Temp\ERR_Machine.txt"
If(!(test-path $path))
{
	New-Item -ItemType File -Force -Path $path -value " "
}


$path = "C:\Temp\ERR_EmailAttachment.txt"
If(!(test-path $path))
{
	New-Item -ItemType File -Force -Path $path -value " "
}

$path = "C:\Temp\ERR_LoadProfile.txt"
If(!(test-path $path))
{
	New-Item -ItemType File -Force -Path $path -value " "
}

$path = "C:\Temp\ERR_MachineRegistered.txt"
If(!(test-path $path))
{
	New-Item -ItemType File -Force -Path $path -value " "
}