using System.Collections.Generic;

namespace ConsoleArchiver
{
    internal class Program
    {
        private static string cs = "";
        private static List<string> ListOfArgs = new List<string> ();
        private static Dictionary<string, string> ListOfGuids = new Dictionary<string, string> ();
        private static string argKey = "";
        private static string argVal = "";
        private static string CurrGuid = "";
        private static string CurrType = "";
        private static bool addGuid = false;
        private static bool addVal = false;
        private static bool addType = false;
        private static bool addConn = false;

        private static void Main ( string[] args )
        {
            clsDatabase db = new clsDatabase ();
            //Console.WriteLine ( "Number of command line parameters = {0}", args.Length );
            for (int i = 0; i < args.Length; i++)
            {
                ListOfArgs.Add ( args[i].ToString () );
                argKey = args[i].ToLower ().Trim ().ToString ();
                //Console.WriteLine ( "Arg[{0}] = [{1}]", i, args[i] );
                if (addConn == true)
                {
                    cs = args[i].ToString ();
                    db.getConnectionString = cs;
                }
                if (addType == true)
                {
                    ListOfGuids.Add ( CurrGuid, args[i].ToString () );
                    addType = false;
                    addGuid = false;
                }
                if (addGuid == true)
                {
                    CurrGuid = args[i].ToString ();
                    addGuid = false;
                }
                if (argKey.Equals ( "-t" ))
                {
                    addType = true;
                }
                if (argKey.Equals ( "-g" ))
                {
                    addGuid = true;
                }
                if (argKey.Equals ( "-c" ))
                {
                    addType = false;
                    addConn = true;
                }
            }

            foreach (string sKey in ListOfGuids.Keys)
            {
                string FileName = "";
                string RetMsg = "";
                CurrGuid = sKey;
                CurrType = ListOfGuids[CurrGuid];

                byte[] buffer = db.getContent ( CurrGuid, CurrType, ref FileName, ref RetMsg );
            }
        }
    }
}