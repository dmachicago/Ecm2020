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
	public class clsFile
	{
		
		clsDma DMA = new clsDma();
		clsLogging LOG = new clsLogging();
		clsUtility UTIL = new clsUtility();
		
		public byte[] FileToByte(string fileName)
		{
			
			//** Added this second method for Liz - she thought the
			//** archive process was changing the dates on her files.
			//** So, I had to prove to her that it was not.
			bool UseMethodOne = true;
			
			string TempDir = System.IO.Path.GetTempPath();
			string fName = DMA.getFileName(fileName);
			string TempFile = TempDir + "\\" + fName + ".bak";
			
			if (UseMethodOne == true)
			{
				TempFile = fileName;
			}
			else
			{
				(new Microsoft.VisualBasic.Devices.ServerComputer()).FileSystem.CopyFile(fileName, TempFile, true);
			}
			
			try
			{
				System.IO.FileStream fs = new System.IO.FileStream(TempFile, System.IO.FileMode.Open, System.IO.FileAccess.Read);
				System.IO.BinaryReader br = new System.IO.BinaryReader(fs);
				byte[] bArray = br.ReadBytes(Convert.ToInt32(br.BaseStream.Length));
				br.Close();
				if (UseMethodOne == true)
				{
				}
				else
				{
					//** Delete the temp copy of the file.
					(new Microsoft.VisualBasic.Devices.ServerComputer()).FileSystem.DeleteFile(TempFile);
				}
				
				return (bArray);
			}
			catch (Exception ex)
			{
				try
				{
					
					StopWinWord();
					System.IO.FileStream fs = new System.IO.FileStream(TempFile, System.IO.FileMode.Open, System.IO.FileAccess.Read);
					System.IO.BinaryReader br = new System.IO.BinaryReader(fs);
					byte[] bArray = br.ReadBytes(Convert.ToInt32(br.BaseStream.Length));
					br.Close();
					LOG.WriteToArchiveLog((string) ("clsFile : FileToByte : 11a : " + ex.Message + "\r\n" + " - " + fileName));
					return (bArray);
				}
				catch (Exception ex2)
				{
					LOG.WriteToArchiveLog((string) ("clsFile : FileToByte : 11b : " + ex2.Message + "\r\n" + " - " + fileName));
					return null;
				}
			}
			
			
		}
		public bool WriteArrayToFile(string FQN, byte[] byteData)
		{
			try
			{
				bool b = true;
				System.IO.FileStream oFileStream;
				
				oFileStream = new System.IO.FileStream(FQN, System.IO.FileMode.Create);
				oFileStream.Write(byteData, 0, byteData.Length);
				oFileStream.Close();
				
				return b;
			}
			catch (Exception ex)
			{
				Debug.Print(ex.Message);
				LOG.WriteToArchiveLog((string) ("clsFile : WriteArrayToFile : 18 : " + ex.Message));
				return false;
			}
		}
		
		public void StopWinWord()
		{
			System.Diagnostics.Process[] ProcessList;
			ProcessList = System.Diagnostics.Process.GetProcesses();
			
			foreach (System.Diagnostics.Process Proc in ProcessList)
			{
				if (Proc.ProcessName.Equals("WinWord"))
				{
					Console.WriteLine("Name {0} ID {1}".ToCharArray(), int.Parse(Proc.ProcessName), Proc.Id);
					Proc.Kill();
				}
			}
		}
		
		public bool OverwriteFile(string FQN, string SText)
		{
			string Contents;
			bool bAns = false;
			StreamWriter objReader;
			try
			{
				objReader = new StreamWriter(FQN);
				objReader.Write(SText);
				objReader.Close();
				bAns = true;
			}
			catch (Exception Ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: SaveTextToFile 100 - " + Ex.Message));
				bAns = false;
			}
			return bAns;
		}
		
		public void AppendToFile(string FQN, string sMsg)
		{
			
			StreamWriter swriter;
			try
			{
				swriter = File.AppendText(FQN);
				swriter.WriteLine(sMsg);
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: SaveTextToFile 100 - " + ex.Message));
			}
			finally
			{
				swriter.Close();
				swriter.Dispose();
			}
			
		}
		
	}
	
}
