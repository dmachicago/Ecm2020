# Web administration is loaded as a module on Windows 2008 R2 but as a set of snapins
# for Windows 2008 (not R2)

function Load-Web-Administration
{
    $ModuleName = "WebAdministration"
    $ModuleLoaded = $false
    $LoadAsSnapin = $false

    if ($PSVersionTable.PSVersion.Major -ge 2)
    {
        if ((Get-Module -ListAvailable | ForEach-Object {$_.Name}) -contains $ModuleName)
        {
            Import-Module $ModuleName

            if ((Get-Module | ForEach-Object {$_.Name}) -contains $ModuleName)
                { $ModuleLoaded = $true } else { $LoadAsSnapin = $true }
        }
        elseif ((Get-Module | ForEach-Object {$_.Name}) -contains $ModuleName)
            { $ModuleLoaded = $true } else { $LoadAsSnapin = $true }
    }
    else
    { $LoadAsSnapin = $true }

    if ($LoadAsSnapin)
    {
        try
        {
            if ((Get-PSSnapin -Registered | ForEach-Object {$_.Name}) -contains $ModuleName)
            {
                if ((Get-PSSnapin -Name $ModuleName -ErrorAction SilentlyContinue) -eq $null) 
                    { Add-PSSnapin $ModuleName }

                if ((Get-PSSnapin | ForEach-Object {$_.Name}) -contains $ModuleName)
                    { $ModuleLoaded = $true }
            }
            elseif ((Get-PSSnapin | ForEach-Object {$_.Name}) -contains $ModuleName)
                { $ModuleLoaded = $true }
        }

        catch
        {
            Write-Error "`t`t$($MyInvocation.InvocationName): $_"
            Exit
        }
    }
}
Load-Web-Administration