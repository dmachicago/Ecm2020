using System;
using System.Collections.Generic;
using System.IO;
using ServerSideOCR;

namespace ConsoleArchiver
{
    internal class MainPage
    {
        clsEncrypt enc = new clsEncrypt ();

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
        private static bool addGateway = false;
        private static string csOcr = "";

        private static List<string> ListOfGatewayId = new List<string>() ;

        private static clsDatabase db = new clsDatabase ();
        private static clsOcr ocr = new clsOcr ();
        private static clsPdf pdf = new clsPdf ();
        private static clsLogging log = new clsLogging ();
        private static bool rc = false;

        private static string TempDir = System.Configuration.ConfigurationManager.AppSettings["TEMPDIR"].ToString ();

        private static void Main ( string[] args )
        {
        
            string RetMsg = "";
            bool bUseDeault = true;

            log.write("Start @ " + DateTime.Now.ToString());

            if (!Directory.Exists ( TempDir ))
            {
                Directory.CreateDirectory ( TempDir );
            }

            for (int i = 0; i < args.Length; i++)
            {
                bUseDeault = false;
                ListOfArgs.Add ( args[i].ToString () );
                argKey = args[i].ToLower ().Trim ().ToString ();
                if (argKey.Equals ( "?" ) | argKey.Equals ( "-?" ))
                {
                    Console.WriteLine ( "Version 3.1.2" );
                    Console.WriteLine ( "-g <content GUID>" );
                    Console.WriteLine ( "-t <content TYPE either a 'C' (doc) or an 'A' (email attachment)>" );
                    Console.WriteLine ( "-c <DB Connection String and if left blank, the default in the appconfig will be used>" );
                    Console.WriteLine ( "-i DB ID from the default GateWay found within the config app file. " );
                    Console.WriteLine ( " " );
                    Console.WriteLine ( "NOTE: Leave all parameters blank to use the default database and process ALL awaiting files." );
                    Console.WriteLine ( " " );
                    Console.WriteLine ( "Press any key to exit " );
                    Console.ReadKey ();                    
                }
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
                if (addGateway == true)
                {
                    string gid = args[i].ToString ();
                    if (!ListOfGatewayId.Contains ( gid ))
                    {
                        ListOfGatewayId.Add ( gid );
                    }
                    addGateway = false;
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
                if (argKey.Equals ( "-i" ))
                {
                    addType = false;
                    addGateway = true;
                }
            }

            if ((cs.Length == 0 || bUseDeault == true) && ListOfGatewayId.Count == 0)
            {               
                cs = System.Configuration.ConfigurationManager.ConnectionStrings["ECMFS"].ConnectionString;
                db.getConnectionString = cs;
                db.getAllOcrRequiredContent (cs, ref ListOfGuids, "C", ref RetMsg );
                db.getAllOcrRequiredContent (cs, ref ListOfGuids, "A", ref RetMsg );
                log.write ( "Processing CS: " + " #recs: " + ListOfGuids.Count.ToString () );
            }

            //csOcr = System.Configuration.ConfigurationManager.ConnectionStrings["ECMOCR"].ConnectionString;
            foreach (string sId in ListOfGatewayId)
            {                
                Console.WriteLine ( "Processing Gateway ID: " + sId );
                ListOfGuids.Clear ();
                cs = db.getEncCS ( sId );
                db.getConnectionString = cs;
                db.getAllOcrRequiredContent (cs, ref ListOfGuids, "C", ref RetMsg );
                db.getAllOcrRequiredContent (cs, ref ListOfGuids, "A", ref RetMsg );
                if (ListOfGuids.Count > 0)
                {
                    ProcessGuids ( cs, ListOfGuids );
                }
                log.write ( "Processing ID: " + sId + ", #recs: " + ListOfGuids.Count.ToString() );
            }

            Console.WriteLine ( "Complete...");
            log.write("END @ " + DateTime.Now.ToString());

        }

        private static void ProcessGuids(string cs, Dictionary<string, string> ListOfIDS)
        {
            int ii = 0;
            string RetMsg = "";
            foreach (string sKey in ListOfIDS.Keys)
            {
                ii++;
                string FileName = "";
                CurrGuid = sKey;
                CurrType = ListOfIDS[CurrGuid];

                byte[] buffer = db.getContent (cs, CurrGuid, CurrType, ref FileName, ref RetMsg );
                string xFileName = FileName.Replace ( "'", "" );
                if (xFileName.Contains ( ":" ))
                {
                    FileInfo fi = new FileInfo (xFileName);
                    xFileName = fi.Name;
                    fi = null;                    
                }
                FileName = xFileName;
                string TempFile = TempDir + @"\" + CurrGuid + "." + FileName;

                if (buffer != null)
                {
                    BinaryWriter fileCreate = null;
                    try
                    {
                        fileCreate = new BinaryWriter ( File.Open ( TempFile, FileMode.Create ) );
                        fileCreate.Write ( buffer );
                        fileCreate.Close ();
                    }
                    catch (Exception ex)
                    {
                        log.write ( "ERROR 10055: " + ex.Message );
                    }
                    finally
                    {
                        try
                        {
                            if (fileCreate != null)
                            {
                                fileCreate.Dispose ();
                            }                            
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine ( "File Exception: " + ex.Message );
                        }
                        
                        string ocrText = "";
                        FileInfo fi = new FileInfo ( TempFile );
                        string fileext = fi.Extension.ToLower ();
                        string fName = fi.Name;

                        fi = null;

                        if (fName.Contains ( "." ))
                        {
                            int x = fName.IndexOf ( '.' );
                            fName = fName.Substring ( x + 1 );
                        }

                        GC.Collect ();
                        GC.WaitForPendingFinalizers ();
                        Console.WriteLine ( "#" + ii.ToString () + " of " + ListOfIDS.Count.ToString () + " / " + fName );
                        if (fileext.Equals ( ".pdf" ))
                        {
                            //See if it is already searchable, if so - ignore.
                            if (!pdf.ckPdfSearchable ( TempFile ))
                            {
                                //if not, make it so.                                
                                ocrText = pdf.OcrPdfImages ( TempDir, TempFile );
                                if (ocrText.Length == 0)
                                {
                                    Console.WriteLine ( "   ERROR: Failed to OCR - " + fName );
                                    db.markOcrCompleteWithError (cs, CurrGuid, CurrType, ref RetMsg );
                                }
                                else
                                {
                                    //Update OCR Text
                                    Console.WriteLine ( "     success" );
                                }
                            }
                            else
                            {
                                db.markPdfSearchable (cs, CurrGuid, CurrType, "Y", ref RetMsg );
                                Console.WriteLine ( "     success" );
                            }

                            if (File.Exists ( TempFile ))
                            {
                                try
                                {
                                    File.Delete ( TempFile );
                                }
                                catch
                                {
                                    log.write ( "ERROR: Failed to remove - " + fName );
                                    Console.WriteLine ( "ERROR: Failed to remove - " + fName );
                                }
                            }
                        }
                        else
                        {
                            ocrText = ocr.OcrImage (TempFile, ref rc, ref RetMsg );
                            if (ocrText.Length == 0)
                            {
                                Console.WriteLine ( "     x x x" );
                                db.markOcrCompleteWithError ( cs, CurrGuid, CurrType, ref RetMsg );
                            }
                            else
                            {
                                Console.WriteLine ( "     success" );
                            }
                        }

                        if (ocrText.Length > 0)
                        {
                            db.updateOcrText (cs, CurrGuid, CurrType, ocrText, ref RetMsg );
                        }

                        if (File.Exists ( TempFile ))
                        {
                            try
                            {
                                File.Delete ( TempFile );
                            }
                            catch
                            {
                                log.write ( "ERROR: Failed to remove - " + fName );
                                Console.WriteLine ( "ERROR: Failed to remove - " + fName );
                            }
                        }
                    }
                }
            }
        }
    }
}