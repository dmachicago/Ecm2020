if (Test-Path  ($i.fullname + "c:\temp\DeDup.txt"))
    {
    Write-Host "File EXists"
    }
    else 
        {
        Write-Host "File DOES NOT EXists"
        }