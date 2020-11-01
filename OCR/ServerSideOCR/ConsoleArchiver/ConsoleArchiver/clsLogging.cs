using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace ConsoleArchiver
{
    class clsLogging
    {
        string logDir = System.Configuration.ConfigurationManager.AppSettings["LOGDIR"].ToString ();
        string logFile = "ecm.log." + DateTime.Today.Month.ToString () + "." + DateTime.Today.Day.ToString () + "." + DateTime.Today.Year.ToString () + ".txt";
        
        public clsLogging()
        {
            CkDirExist ();
        }

        public void write(string LogEntry)
        {
            string LogFqn = logDir + @"\" + logFile;
            StreamWriter w = null;
            try
            {
                
                w = File.AppendText ( LogFqn );
                Log ( LogEntry, w );              
            }
            catch (Exception ex)
            {
                Console.WriteLine ( "ERROR: " + ex.Message );
            }
            finally
            {
                w.Close ();
                w.Dispose ();
                GC.Collect ();
                GC.WaitForPendingFinalizers ();
            }           
        }

        void Log ( string logMessage, TextWriter w )
        {            
            w.Write ( "{0} {1}", DateTime.Now.ToLongDateString () , DateTime.Now.ToLongTimeString ());
            w.Write( "  :" );
            w.WriteLine ( "  :{0}", logMessage );
            //w.Write ( "\r\n" );
        }

        void CkDirExist()
        {
            if (!Directory.Exists ( logDir ))
            {
                Directory.CreateDirectory ( logDir );
            }
        }
    }
}
