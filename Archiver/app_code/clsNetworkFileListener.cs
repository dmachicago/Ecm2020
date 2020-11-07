using global::System;
using global::System.IO;
using System.Windows.Forms;
using MODI;

namespace EcmArchiver
{
    public class clsNetworkFileListener
    {
        public string networkDir = "";

        private void SetListener()
        {
            var watcher = new FileSystemWatcher(networkDir, "*.*");
            watcher.Created += OnCreated;
            watcher.IncludeSubdirectories = true;
            watcher.InternalBufferSize = 25 * 4096;
            watcher.NotifyFilter = NotifyFilters.FileName;
            watcher.EnableRaisingEvents = true;
            MessageBox.Show("Close to End Listener");

            // While Console.ReadLine() <> "x"
            // End While

            watcher.Dispose();
        }

        private static void OnCreated(object source, FileSystemEventArgs e)
        {
            Console.WriteLine("File: " + e.FullPath + " " + ((int)e.ChangeType).ToString());
        }
    }
}