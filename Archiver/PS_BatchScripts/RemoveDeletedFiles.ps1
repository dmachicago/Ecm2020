$Path ='C:\EcmLibrary'
Get-ChildItem –Path $Path -filter "*Delete.Log*.*" |

Foreach-Object {

    Write-Output $_.FullName 

    Select-String -Path $_.FullName -Pattern '|' |
      ForEach-Object {
            Write-Output $_.Line;
            $i = $_.Line.IndexOf('|')
            Write-Output $i;
            $LineDate = $_.Line.Substring(0,$i-1).Trim();
            $Fqn = $_.Line.Substring($i+1).Trim();
            Write-Output $LineDate;
            Write-Output $Fqn;
            if (Test-Path $Fqn) 
            {
                Write-Output " Removing File: $Fqn ";
                Remove-Item $Fqn
            }
      } 
}