$Servers = 'SVR1', 'SVR2', 'SVR3';

workflow pbatch {
    param ([string[]] $Servers)

    foreach -parallel ($job in $Jobs){
        #check schedule
        #execute job if it is time
    }
}


#***************************************************
<#
In this case, the foreach -Parallel construction specifies that we'll hit all 
target computers simultaneously. However, the sequence keyword ensures that 
the Get-CimInstance fires first, and then the Get-Service.

This is powerful stuff, especially when we consider certain operations that 
must complete before others to fulfill dependencies.
#>
workflow Start-ConfigWF2 {
    param ([string[]]$computername)
    foreach -Parallel ($computer in $computername) {
        sequence {
            Get-CimInstance -ClassName Win32_BIOS -PSComputerName $computer
            Get-Service -Name *svchost* -PSComputerName $computer
        }
    }
}
Start-ConfigWF2 -computername 'dc1','mem1'