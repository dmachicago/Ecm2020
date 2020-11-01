using System;
using System.Diagnostics;
using global::System.IO;
using Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsFile
    {
        private clsDma DMA = new clsDma();
        private clsLogging LOG = new clsLogging();
        private clsUtility UTIL = new clsUtility();

        public byte[] FileToByte(string fileName)
        {

            // ** Added this second method for Liz - she thought the
            // ** archive process was changing the dates on her files.
            // ** So, I had to prove to her that it was not.
            bool UseMethodOne = true;
            string TempDir = Path.GetTempPath();
            string fName = DMA.getFileName(fileName);
            string TempFile = TempDir + @"\" + fName + ".bak";
            if (UseMethodOne == true)
            {
                TempFile = fileName;
            }
            else
            {
                My.MyProject.Computer.FileSystem.CopyFile(fileName, TempFile, true);
            }

            try
            {
                var fs = new FileStream(TempFile, FileMode.Open, FileAccess.Read);
                var br = new BinaryReader(fs);
                var bArray = br.ReadBytes(Convert.ToInt32(br.BaseStream.Length));
                br.Close();
                if (UseMethodOne == true)
                {
                }
                else
                {
                    // ** Delete the temp copy of the file.
                    My.MyProject.Computer.FileSystem.DeleteFile(TempFile);
                }

                return bArray;
            }
            catch (Exception ex)
            {
                try
                {
                    StopWinWord();
                    var fs = new FileStream(TempFile, FileMode.Open, FileAccess.Read);
                    var br = new BinaryReader(fs);
                    var bArray = br.ReadBytes(Convert.ToInt32(br.BaseStream.Length));
                    br.Close();
                    LOG.WriteToArchiveLog("clsFile : FileToByte : 11a : " + ex.Message + Constants.vbCrLf + " - " + fileName);
                    return bArray;
                }
                catch (Exception ex2)
                {
                    LOG.WriteToArchiveLog("clsFile : FileToByte : 11b : " + ex2.Message + Constants.vbCrLf + " - " + fileName);
                    return null;
                }
            }
        }

        public bool WriteArrayToFile(string FQN, byte[] byteData)
        {
            try
            {
                bool b = true;
                FileStream oFileStream;
                oFileStream = new FileStream(FQN, FileMode.Create);
                oFileStream.Write(byteData, 0, byteData.Length);
                oFileStream.Close();
                return b;
            }
            catch (Exception ex)
            {
                Debug.Print(ex.Message);
                LOG.WriteToArchiveLog("clsFile : WriteArrayToFile : 18 : " + ex.Message);
                return false;
            }
        }

        public void StopWinWord()
        {
            Process[] ProcessList;
            ProcessList = Process.GetProcesses();
            foreach (var Proc in ProcessList)
            {
                if (Proc.ProcessName.Equals("WinWord"))
                {
                    Console.WriteLine("Name {0} ID {1}", Proc.ProcessName, Proc.Id);
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
                LOG.WriteToArchiveLog("ERROR: SaveTextToFile 100 - " + Ex.Message);
                bAns = false;
            }

            return bAns;
        }

        public void AppendToFile(string FQN, string sMsg)
        {
            StreamWriter swriter = null;
            try
            {
                swriter = File.AppendText(FQN);
                swriter.WriteLine(sMsg);
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: SaveTextToFile 100 - " + ex.Message);
            }
            finally
            {
                swriter.Close();
                swriter.Dispose();
            }
        }
    }
}