using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ArchiverFileMgt;

namespace AFM_Test
{
    
    class mainpgm
    {

        static void Main(string[] args)
        {
            ArchFileMgt.CreateDb();
           
            List<string> files = new List<string>();
            List<string> exts = new List<string>();

            string path = @"d:\dev";
            exts.Add(".vb");
            exts.Add(".cs");
            exts.Add(".doc");
            exts.Add(".docx");
            exts.Add(".xl");
            exts.Add(".xls");
            exts.Add(".txt");

            files = ArchFileMgt.getFilesToArchive(path, true, exts);
        }

    }
}
