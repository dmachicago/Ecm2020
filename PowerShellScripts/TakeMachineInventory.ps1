Get-WmiObject -Class Win32_Product | Select-Object -Property Name > C:\temp\SoftwareInventory.txt

#Select-String -Path C:\temp\SoftwareInventory.txt -Patten "Adobe PDF iFilter 9"

$FileName = "C:\temp\SoftwareInventory.txt" 
$SearchString = "Adobe PDF iFilter 9" 
$Sel = select-string -pattern $SearchString -path $FileName 
If ($Sel -eq $null) 
{ 
    echo "NOT FOUND" 
} 
Else 
{ 
    echo "FOUND" 
}