<#
W. Dale Miller
July 26, 2017
DMA, Limited

However, there are side effects: since jobs are executed in separate applications, data has 
to be transferred back and forth using XML serialization. The more data a job returns, the 
more time it takes, and sometimes this overhead overweighs the advantages.

A better way would be to run jobs in separate threads inside your own PowerShell instance. 
The below code allows just this. It adds a new command called “Start-MemoryJob” which can 
replace “Start-Job”. The remaining code stays exactly the same.

With Start-MemoryJob, there is no need anymore for object serialization. Your jobs run fast 
and smoothly, regardless of amount of data returned. Plus, you now receive the original 
objects. No longer do you have to deal with stripped serialization objects.
#>

$code = @'
using System;
using System.Collections.Generic;
using System.Text;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
namespace InProcess
{
 public class InMemoryJob : System.Management.Automation.Job
 {
 public InMemoryJob(ScriptBlock scriptBlock, string name)
 {
 _PowerShell = PowerShell.Create().AddScript(scriptBlock.ToString());
 SetUpStreams(name);
 }
 public InMemoryJob(PowerShell PowerShell, string name)
 {
 _PowerShell = PowerShell;
 SetUpStreams(name);
 }
 private void SetUpStreams(string name)
 {
 _PowerShell.Streams.Verbose = this.Verbose;
 _PowerShell.Streams.Error = this.Error;
 _PowerShell.Streams.Debug = this.Debug;
 _PowerShell.Streams.Warning = this.Warning;
 _PowerShell.Runspace.AvailabilityChanged +=
 new EventHandler<RunspaceAvailabilityEventArgs>(Runspace_AvailabilityChanged);
 int id = System.Threading.Interlocked.Add(ref InMemoryJobNumber, 1);
 if (!string.IsNullOrEmpty(name))
 {
 this.Name = name;
 }
 else
 {
 this.Name = "InProcessJob" + id;
 }
 }
 void Runspace_AvailabilityChanged(object sender, RunspaceAvailabilityEventArgs e)
 {
 if (e.RunspaceAvailability == RunspaceAvailability.Available)
 {
 this.SetJobState(JobState.Completed);
 }
 }
 PowerShell _PowerShell;
 static int InMemoryJobNumber = 0;
 public override bool HasMoreData
 {
 get {
 return (Output.Count > 0);
 }
 }
 public override string Location
 {
 get { return "In Process"; }
 }
 public override string StatusMessage
 {
 get { return "A new status message"; }
 }
 protected override void Dispose(bool disposing)
 {
 if (disposing)
 {
 if (!isDisposed)
 {
 isDisposed = true;
 try
 {
 if (!IsFinishedState(JobStateInfo.State))
 {
 StopJob();
 }
 foreach (Job job in ChildJobs)
 {
 job.Dispose();
 }
 }
 finally
 {
 base.Dispose(disposing);
 }
 }
 }
 }
 private bool isDisposed = false;
 internal bool IsFinishedState(JobState state)
 {
 return (state == JobState.Completed || state == JobState.Failed || state ==
JobState.Stopped);
 }
 public override void StopJob()
 {
 _PowerShell.Stop();
 _PowerShell.EndInvoke(_asyncResult);
 SetJobState(JobState.Stopped);
 }
 public void Start()
 {
 _asyncResult = _PowerShell.BeginInvoke<PSObject, PSObject>(null, Output);
 SetJobState(JobState.Running);
 }
 IAsyncResult _asyncResult;
 public void WaitJob()
 {
 _asyncResult.AsyncWaitHandle.WaitOne();
 }
 public void WaitJob(TimeSpan timeout)
 {
 _asyncResult.AsyncWaitHandle.WaitOne(timeout);
 }
 }
}
'@

Add-Type -TypeDefinition $code
function Start-JobInProcess
{
  [CmdletBinding()]
  param
  (
    [scriptblock] $ScriptBlock,
    $ArgumentList,
    [string] $Name
  )
  function Get-JobRepository
  {
    [cmdletbinding()]
    param()
    $pscmdlet.JobRepository
  }
  function Add-Job
  {
    [cmdletbinding()]
    param
    (
      $job
    )
    $pscmdlet.JobRepository.Add($job)
  }
  if ($ArgumentList)
  {
    $PowerShell = [PowerShell]::Create().AddScript($ScriptBlock).AddArgument($argumentlist)
    $MemoryJob = New-Object InProcess.InMemoryJob $PowerShell, $Name
  }
  else
  {
    $MemoryJob = New-Object InProcess.InMemoryJob $ScriptBlock, $Name
  }
  $MemoryJob.Start()
  Add-Job $MemoryJob
  $MemoryJob
}