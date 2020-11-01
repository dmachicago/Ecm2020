// VBConversions Note: VB project level imports
using System.Collections.Generic;
using System;
using System.Drawing;
using System.Linq;
using System.Diagnostics;
using System.Data;
using Microsoft.VisualBasic;
using MODI;
using System.Xml.Linq;
using System.Collections;
using System.Windows.Forms;
// End of VB project level imports

using System.IO;


namespace EcmArchiveClcSetup
{
	public class clsScheduler
	{
		
		clsLogging LOG = new clsLogging();
		
		public void PopulateScheduleGrid(ref DataGridView DG)
		{
			//schtasks /query >c:\temp\X.txt
			string SchedDir = LOG.getTempEnvironDir() + "\\ScheduleProcessDir";
			string CmdFile = SchedDir + "\\ProcessImage.bat";
			string ScheduleCommand = (string) ("schtasks /query >" + '\u0022' + SchedDir + "\\ExistingSchedules.TXT" + '\u0022');
			string QueryFile = SchedDir + "\\ExistingSchedules.TXT";
			try
			{
				
				Directory D;
				if (! D.Exists(SchedDir))
				{
					D.CreateDirectory(SchedDir);
				}
				
				File F;
				if (F.Exists(CmdFile))
				{
					F.Delete(CmdFile);
				}
				
				try
				{
					StreamWriter sw = new StreamWriter(CmdFile, false);
					// Write ANSI strings to the file line by line...
					sw.WriteLine("CD\\");
					sw.WriteLine(ScheduleCommand);
					sw.Close();
					
					ShellandWait(CmdFile);
					
					ParseScheduleQueryFile(QueryFile, DG);
					
					
				}
				catch (Exception ex)
				{
					LOG.WriteToArchiveLog((string) ("ERROR: ProcessImageAsBatch 200: " + ex.Message));
					frmMain.Default.SB.Text = (string) ("Check Logs ERROR: ProcessImageAsBatch 200: " + ex.Message);
				}
				
			}
			catch (Exception)
			{
			}
			finally
			{
			}
			
		}
		
		public void ShellandWait(string ProcessPath)
		{
			System.Diagnostics.Process objProcess;
			try
			{
				objProcess = new System.Diagnostics.Process();
				objProcess.StartInfo.FileName = ProcessPath;
				Clipboard.Clear();
				Clipboard.SetText(ProcessPath);
				objProcess.StartInfo.WindowStyle = ProcessWindowStyle.Normal;
				objProcess.Start();
				
				//Wait until the process passes back an exit code
				objProcess.WaitForExit();
				
				//Free resources associated with this process
				objProcess.Close();
				objProcess.Dispose();
				frmMain.Default.SB.Text = "Command success.";
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR ECMArchiveer ShellandWait 100 - " + ex.Message + "\r\n" + "Could not start process " + ProcessPath));
				
			}
		}
		
		public void ParseScheduleQueryFile(string FQN, DataGridView DG)
		{
			
			DG.Rows.Clear();
			DG.Columns.Clear();
			DG.Columns.Add("Task Name", "Task Name");
			DG.Columns.Add("Next_Run_Time", "Next_Run_Time");
			DG.Columns.Add("Status", "Status");
			
			File F;
			if (! F.Exists(FQN))
			{
				LOG.WriteToArchiveLog("ERROR: ParseScheduleQueryFile 100: File \'" + FQN + "\' was not found.");
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
			System.IO.File oFile;
			System.IO.StreamReader oRead;
			
			//TaskName                                 Next Run Time          Status
			oRead = oFile.OpenText(FQN);
			while (oRead.Peek() != -1)
			{
				LineIn = oRead.ReadLine();
				LineIn = LineIn.Trim();
				if (LineIn.Trim().Length > 0)
				{
					//If InStr(LineIn, "ECM_", CompareMethod.Text) = 0 Then
					//    GoTo NextLine
					//End If
					if (LineIn.Length > "TaskName".Length)
					{
						CH = LineIn.Substring(0, "TaskName".Length).ToUpper();
						if (CH.Equals("TASKNAME"))
						{
							goto NextLine;
						}
					}
					if (LineIn.IndexOf("Folder:") + 1 > 0)
					{
						//*Do nothing, skip it
					}
					else if (LineIn.IndexOf("INFO:") + 1 > 0)
					{
						//*Do nothing, skip it
					}
					else if (LineIn.IndexOf("==========") + 1 > 0)
					{
						//Get the processing column lengths
						for (int i = 1; i <= LineIn.Length; i++)
						{
							CH = LineIn.Substring(i - 1, 1);
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
							TaskName = LineIn.Substring(0, iTaskName - 1);
							TaskName = TaskName.Trim();
						}
						if (LineIn.Length > iNext_Run_Time - 2)
						{
							Next_Run_Time = LineIn.Substring(iTaskName - 1, iNext_Run_Time - iTaskName);
							Next_Run_Time = Next_Run_Time.Trim();
						}
						if (LineIn.Length > iTaskName + 2)
						{
							Status = LineIn.Substring(iNext_Run_Time - 1);
							Status = Status.Trim();
						}
						int N = 0;
						string[] a;
						a = new string[3];
						
						if (TaskName != null)
						{
						}
						if (Next_Run_Time != null)
						{
						}
						if (Status != null)
						{
						}
						
						//dg.Rows.Add()
						//N = dg.Rows.Count - 1
						//dg.Rows.Item(N).Cells(0).Value = TaskName
						//dg.Rows.Item(N).Cells(1).Value = Next_Run_Time
						//dg.Rows.Item(N).Cells(2).Value = Status
						
						DataGridViewRow dgvRow = new DataGridViewRow();
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
				1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
			}
			
			oRead.Close();
			
			DG.Columns[0].Width = int.Parse("320");
			DG.Columns[1].Width = int.Parse("220");
			DG.Columns[2].Width = int.Parse("120");
			
		}
		
	}
	
}
