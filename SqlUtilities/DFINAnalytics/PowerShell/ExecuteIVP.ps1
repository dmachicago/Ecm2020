
#Here's a powershell function that will take a filename and dump the batches to the pipeline.

function GetBatches ($fileName)
{
   $sb = new-object System.Text.StringBuilder
   $f = new-object System.IO.StreamReader($fileName)
   while ($true)
   {
     $line = $f.ReadLine()
     if ($line -eq $null -or $line.Trim() -eq "GO")
     {
       #output the batch to the pipeline
       $sb.ToString(); 

       #capture the return value because it's not void
       $foo = $sb.Clear();
     }
     else
     {
       #capture the return value because it's not void
       $foo = $sb.AppendLine($line);
     }

     if ($line -eq $null)
     {
       break;
     }
     
   }
    
}

#Which you run something like
cls
$batches = GetBatches("c:\temp\aw.sql");
foreach ($b in $batches)
{
  "-----------"
  $b
  "-----------"
}