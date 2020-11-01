using System;
using System.Diagnostics;
using global::System.IO;
using System.Windows.Forms;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public class clsScheduler
    {
        private clsLogging LOG = new clsLogging();

        public void PopulateScheduleGrid(ref DataGridView DG)
        {
            // schtasks /query >c:\temp\X.txt
            string SchedDir = LOG.getTempEnvironDir() + @"\ScheduleProcessDir";
            string CmdFile = SchedDir + @"\ProcessImage.bat";
            string ScheduleCommand = "schtasks /query >" + Conversions.ToString('"') + SchedDir + @"\ExistingSchedules.TXT" + Conversions.ToString('"');
            string QueryFile = SchedDir + @"\ExistingSchedules.TXT";
            try
            {
                if (!Directory.Exists(SchedDir))
                {
                    Directory.CreateDirectory(SchedDir);
                }

                if (File.Exists(CmdFile))
                {
                    File.Delete(CmdFile);
                }

                try
                {
                    var sw = new StreamWriter(CmdFile, false);
                    // Write ANSI strings to the file line by line...
                    sw.WriteLine(@"CD\");
                    sw.WriteLine(ScheduleCommand);
                    sw.Close();
                    ShellandWait(CmdFile);
                    ParseScheduleQueryFile(QueryFile, ref DG);
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("ERROR: ProcessImageAsBatch 200: " + ex.Message);
                    My.MyProject.Forms.frmMain.SB.Text = "Check Logs ERROR: ProcessImageAsBatch 200: " + ex.Message;
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
            }
        }

        public void ShellandWait(string ProcessPath)
        {
            Process objProcess;
            try
            {
                objProcess = new Process();
                objProcess.StartInfo.FileName = ProcessPath;
                Clipboard.Clear();
                Clipboard.SetText(ProcessPath);
                objProcess.StartInfo.WindowStyle = ProcessWindowStyle.Normal;
                objProcess.Start();

                // Wait until the process passes back an exit code
                objProcess.WaitForExit();

                // Free resources associated with this process
                objProcess.Close();
                objProcess.Dispose();
                My.MyProject.Forms.frmMain.SB.Text = "Command success.";
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR ECMArchiver ShellandWait 100 - " + ex.Message + Constants.vbCrLf + "Could not start process " + ProcessPath);
                LOG.WriteToArchiveLog("ERROR: Stack Trace:" + Constants.vbCrLf + ex.StackTrace);
            }
        }

        public void ParseScheduleQueryFile(string FQN, ref DataGridView DG)
        {
            DG.Rows.Clear();
            DG.Columns.Clear();
            DG.Columns.Add("Task Name", "Task Name");
            DG.Columns.Add("Next_Run_Time", "Next_Run_Time");
            DG.Columns.Add("Status", "Status");
            if (!File.Exists(FQN))
            {
                LOG.WriteToArchiveLog("ERROR: ParseScheduleQueryFile 100: File '" + FQN + "' was not found.");
                return;
            }

            string CH = "";
            string TaskName = "";
            string Next_Run_Time = "";
            string Status = "";
            int iTaskName = 0;
            int iNext_Run_Time = 0;
            int iStatus = 0;
            string LineIn = "";
            File oFile;
            StreamReader oRead;

            // TaskName                                 Next Run Time          Status
            oRead = File.OpenText(FQN);
            while (oRead.Peek() != -1)
            {
                LineIn = oRead.ReadLine();
                LineIn = LineIn.Trim();
                if (LineIn.Trim().Length > 0)
                {
                    // If InStr(LineIn, "ECM_", CompareMethod.Text) = 0 Then
                    // GoTo NextLine
                    // End If
                    if (LineIn.Length > "TaskName".Length)
                    {
                        CH = Strings.Mid(LineIn, 1, "TaskName".Length).ToUpper();
                        if (CH.Equals("TASKNAME"))
                        {
                            goto NextLine;
                        }
                    }

                    if (Strings.InStr(LineIn, "Folder:", CompareMethod.Text) > 0)
                    {
                    }
                    // *Do nothing, skip it
                    else if (Strings.InStr(LineIn, "INFO:", CompareMethod.Text) > 0)
                    {
                    }
                    // *Do nothing, skip it
                    else if (Strings.InStr(LineIn, "==========", CompareMethod.Text) > 0)
                    {
                        // Get the processing column lengths
                        for (int i = 1, loopTo = LineIn.Length; i <= loopTo; i++)
                        {
                            CH = Strings.Mid(LineIn, i, 1);
                            if (CH.Equals(" "))
                            {
                                if (iTaskName == 0)
                                {
                                    iTaskName = i + 1;
                                }
                                else if (iNext_Run_Time == 0)
                                {
                                    iNext_Run_Time = i + 1;
                                    iStatus = LineIn.Length;
                                }
                                else if (iStatus == 0)
                                {
                                    iStatus = i + 1;
                                }
                            }
                        }
                    }
                    else
                    {
                        TaskName = "-";
                        Next_Run_Time = "-";
                        Status = "-";
                        if (LineIn.Length > iTaskName)
                        {
                            TaskName = Strings.Mid(LineIn, 1, iTaskName - 1);
                            TaskName = TaskName.Trim();
                        }

                        if (LineIn.Length > iNext_Run_Time - 2)
                        {
                            Next_Run_Time = Strings.Mid(LineIn, iTaskName, iNext_Run_Time - iTaskName);
                            Next_Run_Time = Next_Run_Time.Trim();
                        }

                        if (LineIn.Length > iTaskName + 2)
                        {
                            Status = Strings.Mid(LineIn, iNext_Run_Time);
                            Status = Status.Trim();
                        }

                        int N = 0;
                        string[] a;
                        a = new string[3];
                        if (TaskName is object)
                        {
                        }

                        if (Next_Run_Time is object)
                        {
                        }

                        if (Status is object)
                        {
                        }

                        // dg.Rows.Add()
                        // N = dg.Rows.Count - 1
                        // dg.Rows.Item(N).Cells(0).Value = TaskName
                        // dg.Rows.Item(N).Cells(1).Value = Next_Run_Time
                        // dg.Rows.Item(N).Cells(2).Value = Status

                        var dgvRow = new DataGridViewRow();
                        DataGridViewCell dgvCell;
                        dgvCell = new DataGridViewTextBoxCell();
                        dgvCell.Value = TaskName;
                        dgvRow.Cells.Add(dgvCell);
                        dgvCell = new DataGridViewTextBoxCell();
                        dgvCell.Value = Next_Run_Time;
                        dgvRow.Cells.Add(dgvCell);
                        dgvCell = new DataGridViewTextBoxCell();
                        dgvCell.Value = Status;
                        dgvRow.Cells.Add(dgvCell);
                        DG.Rows.Add(dgvRow);
                    }
                }

                NextLine:
                ;
            }

            oRead.Close();
            DG.Columns[0].Width = Conversions.ToInteger("320");
            DG.Columns[1].Width = Conversions.ToInteger("220");
            DG.Columns[2].Width = Conversions.ToInteger("120");
        }
    }
}