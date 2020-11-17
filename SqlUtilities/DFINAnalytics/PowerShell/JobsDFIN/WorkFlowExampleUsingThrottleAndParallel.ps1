workflow wf1{
Param([System.Data.DataTable]$instance)

ForEach -Parallel -ThrottleLimit 10 ($i in $instance) {
   InlineScript{
      $t = $using:i
      Write-Verbose "$t['CmsSrvName']"
       }
    }
}

wf1 -Verbose $DbInstances 