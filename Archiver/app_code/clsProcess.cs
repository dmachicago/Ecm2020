using System;
using System.Collections.Generic;
using System.Diagnostics;
using global::System.IO;
using global::System.Windows.Forms;
using Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsProcess
    {
        private clsDma DMA = new clsDma();
        private clsLogging LOG = new clsLogging();
        private clsUtility UTIL = new clsUtility();
        private SortedList<int, string> ProcessesToKeep = new SortedList<int, string>();
        private SortedList<int, string> ProcessesAfterRunning = new SortedList<int, string>();
        private SortedList<string, string> ProcessesToTrack = new SortedList<string, string>();

        public clsProcess()
        {
            addProcessesToTrack();
        }

        public void StartProcessFromFilefqn(string fqn)
        {
            modGlobals.FilesToDelete.Add(fqn);
            bool bSuccess = false;
            try
            {
                Process.Start(fqn);
                GC.Collect();
                GC.WaitForFullGCComplete();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("Warning StartProcessFromFilefqn 2006.23.1a - No file type associated with: '" + fqn + "'.");
                MessageBox.Show("Failed to open file for viewing, will attempt to open using Notepad.");
                Process.Start("notepad.exe", fqn);
                bSuccess = false;
            }

            // If Not bSuccess Then
            // log.WriteToArchiveLog("Warning StartProcessFromFilefqn 2006.23.1b - No file type associated with: '" + fqn + "'.")
            // System.Diagnostics.Process.Start("notepad.exe", fqn)
            // End If

        }

        public void addProcessesToTrack()
        {
            ProcessesToTrack.Clear();
            ProcessesToTrack.Add("VISIO", "VISIO");
            ProcessesToTrack.Add("WINWORD", "WINWORD");
            ProcessesToTrack.Add("EXCEL", "EXCEL");
            ProcessesToTrack.Add("POWERPNT", "POWERPNT");
        }

        public int countOutlookInstances()
        {
            int AppCnt = 0;
            string pName = "";
            foreach (Process p in Process.GetProcesses())
            {
                pName = p.ProcessName.ToUpper();
                if (pName.Equals("OUTLOOK"))
                {
                    AppCnt += 1;
                }
            }

            return AppCnt;
        }

        public void getCurrentApplications()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            ZeroizeProcessArrays();
            int AppID = -1;
            string pName = "";
            foreach (Process p in Process.GetProcesses())
            {
                AppID = p.Id;
                // Console.WriteLine(p.ProcessName)
                pName = p.ProcessName.ToUpper();
                if (ProcessesToTrack.ContainsKey(pName))
                {
                    AddProcess(AppID, pName, true);
                }
            }
        }

        public void getProcessesToKill()
        {
            ProcessesAfterRunning.Clear();
            int AppID = -1;
            string pName = "";
            foreach (Process p in Process.GetProcesses())
            {
                AppID = p.Id;
                // Console.WriteLine(p.ProcessName)
                pName = p.ProcessName.ToUpper();
                if (ProcessesToTrack.ContainsKey(pName))
                {
                    if (ProcessesToKeep.ContainsKey(AppID))
                    {
                    }
                    else
                    {
                        AddProcess(AppID, pName, false);
                    }
                }
            }
        }

        public void KillOrphanProcesses()
        {
            string ProcessName = "";
            int ProcessID = 0;
            // Dim IDX As Integer
            try
            {
                int I = 0;
                var loopTo = ProcessesAfterRunning.Count - 1;
                for (I = 0; I <= loopTo; I++)
                {
                    ProcessID = (int)Conversion.Val(ProcessesAfterRunning.Values[I]);
                    // ProcessName  = Val(ProcessesAfterRunning.Se)
                    KillProcess(ProcessID);
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("Warning 64.23.a: clsProcess:KillOrphanProcesses - tried to kill suspected orphan process and failed." + Constants.vbCrLf + ex.Message);
            }
        }

        public void AddProcess(int ID, string pName, bool bKeepProcess)
        {
            try
            {
                bool B = false;
                if (bKeepProcess == true)
                {
                    B = ProcessesToKeep.ContainsKey(ID);
                    if (!B)
                    {
                        ProcessesToKeep.Add(ID, pName);
                    }
                }
                else
                {
                    B = ProcessesAfterRunning.ContainsKey(ID);
                    if (!B)
                    {
                        ProcessesAfterRunning.Add(ID, pName);
                    }
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("Warning 64.23.a: clsProcess:AddProcess - tried to record running process and failed." + Constants.vbCrLf + ex.Message);
            }
        }

        public void ZeroizeProcessArrays()
        {
            ProcessesToKeep.Clear();
            ProcessesAfterRunning.Clear();
        }

        public void getListOfRunningApplications(ref ListBox LB)
        {
            foreach (Process p in Process.GetProcesses())
            {
                Trace.WriteLine(p.ProcessName + ", " + p.Id.ToString());
                // Console.WriteLine(p.ProcessName)
                LB.Items.Add(p.ProcessName + " : " + p.Id.ToString());
            }
        }

        public bool isProcessRunning(string ProcessName)
        {
            string tgtProcess = "";
            foreach (Process p in Process.GetProcesses())
            {
                tgtProcess = p.ProcessName.ToUpper();
                if (tgtProcess.Equals(ProcessName.ToUpper()))
                {
                    return true;
                }
            }

            return false;
        }

        public void KillProcess(string ProcessName)
        {
            var pProcess = Process.GetProcessesByName(ProcessName);
            foreach (Process p in pProcess)
                p.Kill();
        }

        public bool KillProcess(int Handle)
        {
            var pProcess = Process.GetProcessById(Handle);
            if (pProcess is null)
            {
            }
            else
            {
                try
                {
                    pProcess.Kill();
                    return true;
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("Warning 0181.44 - Failed to drop process: " + Handle.ToString());
                    return false;
                }
            }

            return false;
        }

        public void StartProcessFromFilefqnAndWait(string fqn)
        {
            // Dim objProcess As System.Diagnostics.Process
            try
            {
                var myProcess = Process.Start(fqn);
                // wait until it exits
                myProcess.WaitForExit();
                // display results
                MessageBox.Show("Process was closed at: " + myProcess.ExitTime + "." + Environment.NewLine + "Exit Code: " + myProcess.ExitCode);


                myProcess.Close();
                File.Delete(fqn);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Could not start application for " + fqn + Constants.vbCrLf + ex.Message, "Error");
                LOG.WriteToArchiveLog("clsProcess : StartProcessFromFilefqnAndWait : 9 : " + ex.Message);
            }
        }

        public void StartExplorer(string DirName)
        {
            var procstart = new ProcessStartInfo("explorer");
            string winDir = Path.GetDirectoryName(DirName);
            procstart.Arguments = DirName;
            Process.Start(procstart);
        }
    }
}