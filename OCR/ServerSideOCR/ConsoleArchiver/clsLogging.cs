using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace ConsoleArchiver
{
    internal class clsLogging
    {
        private string logDir = System.Configuration.ConfigurationManager.AppSettings["LOGDIR"].ToString ();
        private string logFile = "ecm.ocr.log." + DateTime.Today.Month.ToString () + "." + DateTime.Today.Day.ToString () + "." + DateTime.Today.Year.ToString () + ".txt";

        public clsLogging ()
        {
            CkDirExist ();
        }

        public void write (bool traceon, string LogEntry)
        {
            if (traceon == true)
            {
                Console.WriteLine (LogEntry);
            }

            string LogFqn = logDir + @"\" + logFile;
            StreamWriter w = null;
            try
            {
                w = File.AppendText (LogFqn);
                Log (LogEntry, w);
            }
            catch (Exception ex)
            {
                Console.WriteLine ("ERROR: " + ex.Message);
            }
            finally
            {
                w.Close ();
                w.Dispose ();
                GC.Collect ();
                GC.WaitForPendingFinalizers ();
            }
        }

        public void write (string LogEntry)
        {
            string LogFqn = logDir + @"\" + logFile;
            StreamWriter w = null;
            try
            {
                w = File.AppendText (LogFqn);
                Log (LogEntry, w);
            }
            catch (Exception ex)
            {
                Console.WriteLine ("LOG ERROR: " + ex.Message);
            }
            finally
            {
                w.Close ();
                w.Dispose ();
                GC.Collect ();
                GC.WaitForPendingFinalizers ();
            }
        }


        private void Log (string logMessage, TextWriter w)
        {
            w.Write ("{0} {1}", DateTime.Now.ToLongDateString (), DateTime.Now.ToLongTimeString ());
            w.Write ("  :");
            w.WriteLine ("  :{0}", logMessage);
            //w.Write ( "\r\n" );
        }

        private void CkDirExist ()
        {
            if (!Directory.Exists (logDir))
            {
                Directory.CreateDirectory (logDir);
            }
        }
    }
}