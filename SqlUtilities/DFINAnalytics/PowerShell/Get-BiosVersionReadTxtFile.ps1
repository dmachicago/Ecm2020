#Get-BiosVersionReadTxtFile.ps1

$computers = Get-Content -Path D:\dev\SQL\DFINAnalytics\PowerShell\ServerList.txt

Get-WmiObject -Class win32_bios -cn $computers -EA silentlyContinue |

Format-table __Server, Manufacturer, Version –AutoSize