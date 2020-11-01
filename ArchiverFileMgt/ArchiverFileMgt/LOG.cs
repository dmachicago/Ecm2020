using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ArchiverFileMgt
{
    public static class LOG
    {
        /// <summary>
        /// Writes to archive log. Each day generates a new log file and it is stored in c:\temp\EcmLogs directory
        /// </summary>
        /// <param name="msg">The MSG to write to the log file.</param>
        public static void WriteToArchiveLog(string msg)
        {
            if (!Directory.Exists(@"c:\temp\EcmLogs"))
            {
                Directory.CreateDirectory(@"c:\temp\EcmLogs");
            }
            string fqn = "EcmLog-" + DateTime.Now.Year.ToString() + "-" + DateTime.Now.Month.ToString();
            fqn += DateTime.Now.Day.ToString() + ".log";

            using (StreamWriter output = File.AppendText(fqn))
            {
                output.WriteLine(msg);
            }
        }
    }
}
