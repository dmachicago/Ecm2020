using ECMLibraryOCR;
using IronOcr;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using System.IO;

namespace ConsoleArchiver
{
    internal class MainPage
    {
        public static bool traceon = false;
        private static string cs = "";
        private static List<string> ListOfArgs = new List<string>();
        private static List<string> FilesToRemove = new List<string>();
        private static Dictionary<string, string> ListOfGuids = new Dictionary<string, string>();
        private static Dictionary<string, string> ListOfAttachmentGuids = new Dictionary<string, string>();
        private static string argKey = "";
        private static string CurrGuid = "";
        private static string CurrType = "";
        private static bool addGuid = false;
        private static bool addType = false;
        private static bool addConn = false;

        private static clsDatabaseOCR DBOCR = new clsDatabaseOCR();
        private static clsOcrModi ocr = new clsOcrModi();
        private static IOcrEngine msocr = new OnenoteOcrEngine();
        private static clsPdf pdf = new clsPdf();
        private static clsLogging log = new clsLogging();
        private static bool rc = false;

        private static string TempDir = System.Configuration.ConfigurationManager.AppSettings["TEMPDIR"].ToString();
        private static string sTraceON = System.Configuration.ConfigurationManager.AppSettings["TraceON"].ToString();
        
        public static string OcrMethod = "";
        public static bool bUseDefaults = true;

        private static void Main(string[] args)
        {
            if (sTraceON == "1")
            {
                traceon = true;
            }
            else
                traceon = false;

            OcrMethod = System.Configuration.ConfigurationManager.AppSettings["OcrMethod"].ToString();
            string RetMsg = "";

            if (OcrMethod.Equals("ONENOTE")){
                try
                {
                    Process.Start("onenote");
                    Console.WriteLine("NOTICE: OneNote STARTED...");
                    log.write(traceon, "NOTICE: OneNote STARTED...");
                }
                catch (Exception ex1)
                {
                    Console.WriteLine("ATTENTION: OneNote already open, standby... : " + ex1.Message);
                    log.write(traceon, "ATTENTION: OneNote already open : " + ex1.Message);
                    System.Threading.Thread.Sleep(5000);
                }
            }

            log.write(traceon, "Start @ " + DateTime.Now.ToString());
            log.write(traceon, "OCR Method @ " + OcrMethod);

            if (!Directory.Exists(TempDir))
            {
                Directory.CreateDirectory(TempDir);
            }

            for (int i = 0; i < args.Length; i++)
            {
                bUseDefaults = false;
                ListOfArgs.Add(args[i].ToString());
                argKey = args[i].ToLower().Trim().ToString();
                if (argKey.Equals("?") | argKey.Equals("-?"))
                {
                    Console.WriteLine("Version 3.1.17");
                    Console.WriteLine("-g <content GUID - adds a specific content guid requiring OCR to the processing. Add as many as needed sepatrated by a -g.>");
                    Console.WriteLine("-t <content TYPE either a 'C' (process documents) or an 'A' (process email attachments)>");
                    Console.WriteLine("-c <DB Connection String and if left blank, the default in the appconfig will be used. Edit the CONFIG file's connection string as needed.>");
                    Console.WriteLine("-a display OCR activity during execution and record into LOG");
                    Console.WriteLine(" ");
                    Console.WriteLine("NOTE: Leave all parameters blank to use the default database and process ALL awaiting files.");
                    Console.WriteLine(" ");
                    Console.WriteLine("Press any key to exit ");
                    Console.ReadKey();
                }
                if (addConn == true)
                {
                    bool bGoodConn = DBOCR.ckDbConnection();
                    if (!bGoodConn)
                    {
                        Console.WriteLine("ERROR: FAILED to connect to repository... aborting");
                        log.write(traceon, "getAllOcrRequiredContent: 01");
                    }
                }
                if (addType == true)
                {
                    ListOfGuids.Add(CurrGuid, args[i].ToString());
                    addType = false;
                    addGuid = false;
                }
                if (addGuid == true)
                {
                    CurrGuid = args[i].ToString();
                    addGuid = false;
                }

                if (argKey.Equals("-a"))
                {
                    traceon = true;
                }
                if (argKey.Equals("-t"))
                {
                    addType = true;
                }
                if (argKey.Equals("-g"))
                {
                    addGuid = true;
                }
                if (argKey.Equals("-c"))
                {
                    addType = false;
                    addConn = true;
                }
            }

            Console.WriteLine("Fetching Content requiring OCR: ");
            ListOfGuids.Clear();

            DBOCR.getAllOcrRequiredContent(ref ListOfGuids, "C", ref RetMsg);
            DBOCR.getAllOcrRequiredContent(ref ListOfGuids, "A", ref RetMsg);

            Console.WriteLine("Total OCR Docs: " + ListOfGuids.Count.ToString());

            log.write(traceon, "Processing CS: " + " #recs: " + ListOfGuids.Count.ToString());

            if (ListOfGuids.Count > 0)
            {
                ProcessGuids(cs, ListOfGuids);
            }
            else
            {
                Console.WriteLine("No content to OCR found.");
            }

            System.IO.DirectoryInfo DIR = new System.IO.DirectoryInfo(TempDir);
            DeletingFiles(DIR);

            try
            {
                Process[] p = Process.GetProcessesByName("onenote");
                p[0].Kill();
                Console.WriteLine("NOTICE: OneNote closed...");
            }
            catch (Exception ex1)
            {
                Console.WriteLine("NOTICE: OneNote remains open..." + ex1.Message);
            }

            Console.WriteLine("Complete...");
            log.write(traceon, "END @ " + DateTime.Now.ToString());
        }

        private static void ProcessGuids(string cs, Dictionary<string, string> ListOfIDS)
        {
            string dDebug = System.Configuration.ConfigurationManager.AppSettings["DebugOn"].ToString();
            int ii = 0;
            string RetMsg = "";
            string TypeDoc = "";
            foreach (string sKey in ListOfIDS.Keys)
            {
                ii++;
                TypeDoc = ListOfIDS[sKey].ToUpper();
                bool b = DBOCR.validateOcrSize(sKey, TypeDoc);
                if (b.Equals(true))
                {
                    if (ii % 50 == 0 && FilesToRemove.Count > 0)
                    {
                        int z = 0;
                        foreach (string strx in FilesToRemove)
                        {
                            z++;
                            Console.Write(z.ToString() + ",");
                            try
                            {
                                bool isLocked = IsFileLocked(strx);
                                if (File.Exists(strx) && !isLocked)
                                {
                                    File.Delete(strx);
                                }
                            }
                            catch (Exception ex)
                            {
                                Console.WriteLine(ex.Message);
                            }
                        }
                        FilesToRemove.Clear();
                    }

                    string FileName = "";
                    CurrGuid = sKey;
                    CurrType = ListOfIDS[CurrGuid];

                    byte[] buffer = DBOCR.getContent(cs, CurrGuid, CurrType, ref FileName, ref RetMsg);
                    string xFileName = FileName.Replace("'", "");
                    if (xFileName.Contains(":"))
                    {
                        FileInfo fi = new FileInfo(xFileName);
                        xFileName = fi.Name;
                        fi = null;
                    }

                    FileName = xFileName;
                    string TempFile = TempDir + @"\" + CurrGuid + "." + FileName;

                    if (dDebug.Equals("1"))
                    {
                        string idstr = "I=" + ii.ToString() + " : '" + CurrGuid + "' @ " + FileName;
                        Console.WriteLine(idstr);
                        log.write(traceon, idstr);
                        idstr = "";
                    }


                    if (buffer != null)
                    {
                        BinaryWriter fileCreate = null;
                        try
                        {
                            fileCreate = new BinaryWriter(File.Open(TempFile, FileMode.Create));
                            fileCreate.Write(buffer);
                            fileCreate.Close();
                            fileCreate.Dispose();
                        }
                        catch (Exception ex)
                        {
                            log.write(traceon, "ERROR 10055: File: " + TempFile + " -- " + ex.Message);
                        }
                        finally
                        {
                            string ocrText = "";
                            FileInfo fi = new FileInfo(TempFile);
                            string fileext = fi.Extension.ToLower();
                            string fName = fi.Name;

                            fi = null;

                            if (fName.Contains("."))
                            {
                                int x = fName.IndexOf('.');
                                fName = fName.Substring(x + 1);
                            }

                            GC.Collect();
                            GC.WaitForPendingFinalizers();
                            Console.WriteLine("#" + ii.ToString() + " of " + ListOfIDS.Count.ToString() + " / " + fName);
                            log.write(traceon, "#" + ii.ToString() + " of " + ListOfIDS.Count.ToString() + " / " + fName);
                            if (fileext.Equals(".pdf"))
                            {
                                //See if it is already searchable, if so - ignore.
                                if (!pdf.ckPdfSearchable(TempFile))
                                {
                                    //if not, make it so.
                                    /******************************* OCR PDF HERE **********************/
                                    ocrText = pdf.OcrPdfImages(TempDir, TempFile);
                                    /******************************* OCR HERE **********************/
                                    if (ocrText.Length == 0)
                                    {
                                        Console.WriteLine("NOTICE: Failed to OCR - " + fName);
                                        log.write(traceon, "NOTICE: Failed to OCR - " + fName);
                                        DBOCR.markOcrCompleteWithError(cs, CurrGuid, CurrType, ref RetMsg);
                                    }
                                    else
                                    {
                                        //Update OCR Text
                                        Console.WriteLine("     success");
                                    }
                                }
                                else
                                {
                                    DBOCR.markPdfSearchable(CurrGuid, CurrType, "Y", ref RetMsg);
                                    Console.WriteLine("     success");
                                }

                                if (File.Exists(TempFile))
                                {
                                    try
                                    {
                                        bool filelocked = IsFileLocked(TempFile);
                                        if (!filelocked)
                                        {
                                            File.Delete(TempFile);
                                        }
                                        else
                                        {
                                            FilesToRemove.Add(TempFile);
                                        }
                                    }
                                    catch
                                    {
                                        log.write(traceon, "ERROR XA1: Failed to remove - " + fName);
                                        Console.WriteLine("ERROR XA1: Failed to remove - " + fName);
                                    }
                                }
                            }
                            else
                            {
                                log.write(traceon, "Start OCR: " + fName);
                                ocrText = "";
                                /******************************* OCR IMAGE HERE **********************/
                                if (OcrMethod.Equals("MODI"))
                                {
                                    try
                                    {
                                        ocrText = ocr.OcrImageMODI(TempFile, ref rc, ref RetMsg);
                                    }
                                    catch (Exception ex)
                                    {
                                        ocrText = "";
                                        RetMsg = ex.Message;
                                        log.write(traceon, fName + " : " + ex.Message);
                                        rc = false;
                                    }
                                }
                                else if (OcrMethod.Equals("ONENOTE"))
                                {
                                    try
                                    {
                                        Image img = Image.FromFile(TempFile) as Bitmap;
                                        ocrText = msocr.Recognize(img);

                                        img = null;
                                        //msocr = null;
                                    }
                                    catch (Exception ex)
                                    {
                                        ocrText = "";
                                        RetMsg = ex.Message;
                                        log.write(traceon, fName + " : " + ex.Message);
                                        rc = false;
                                    }
                                }
                                else if (OcrMethod.Equals("IRON"))
                                    //D:\dev\OCR_IronOcr\bin\IronOcr.dll
                                    try
                                    {
                                        ocrText = ocrfile(TempFile);
                                        RetMsg = "Success";
                                    }
                                    catch (Exception ex)
                                    {
                                        RetMsg = ex.Message;
                                        log.write(traceon, fName + " : " + ex.Message);
                                        rc = false;
                                    }
                                /*********************************************************************/
                                if (ocrText == null)
                                {
                                    ocrText = "";
                                    DBOCR.markOcrCompleteWithError(cs, CurrGuid, CurrType, ref RetMsg);
                                }
                                if (ocrText.Length == 0)
                                {
                                    DBOCR.markOcrCompleteWithError(cs, CurrGuid, CurrType, ref RetMsg);
                                    log.write(traceon, "A00 - NO OCR Text Found: " + fName);
                                }
                                else
                                {
                                    log.write(traceon, "OCR Text Found: " + fName);
                                }
                            }

                            if (ocrText.Length > 0)
                            {
                                log.write(traceon, "OCR Added to DB: " + fName);
                                DBOCR.updateOcrText(cs, CurrGuid, CurrType, ocrText, ref RetMsg);
                                DBOCR.markOcrComplete(cs, CurrGuid, CurrType, ref RetMsg);
                            }
                            else
                            {
                                DBOCR.markOcrCompleteWithError(cs, CurrGuid, CurrType, ref RetMsg);
                                log.write(traceon, "A01 - NO OCR Text Found: " + fName);
                            }

                            if (File.Exists(TempFile))
                            {
                                try
                                {
                                    bool filelocked = IsFileLocked(TempFile);

                                    if (File.Exists(TempFile) && !filelocked)
                                    {
                                        File.Delete(TempFile);
                                    }
                                    else
                                    {
                                        FilesToRemove.Add(TempFile);
                                    }
                                    log.write(traceon, "Temp File set to be removed: " + TempFile);
                                }
                                catch (Exception ex)
                                {
                                    FilesToRemove.Add(TempFile);
                                    log.write(traceon, "ERROR XA2: Failed to remove - " + TempFile + " / " + ex.Message);
                                    Console.WriteLine("ERROR XA2: Failed to remove - " + TempFile + " / " + ex.Message);
                                }
                            }
                        }
                    }
                }
                else
                {
                    log.write(traceon, "*** ERROR: " + sKey + " too large to OCR, skipping.");
                    log.write(traceon, "Update DataSource set OcrPerformed = 1 where SourceGuid = '" + sKey + "';");
                    Console.WriteLine("*** ERROR: " + sKey + " too large to OCR, skipping.");
                }
            }
            System.IO.DirectoryInfo dInfo = new System.IO.DirectoryInfo(TempDir);
            foreach (System.IO.FileInfo file in dInfo.GetFiles())
            {
                try
                {
                    bool bFile = IsFileLocked(file.FullName);
                    if (!bFile)
                    {
                        file.Delete();
                    }
                    else
                    {
                        Console.WriteLine("NOTICE: " + file.Name + " will be deleted later.");
                    }
                }
                catch (Exception ex)
                {
                    log.write(traceon, "NOTICE: " + file.Name + " will be deleted later / " + ex.Message);
                    Console.WriteLine("NOTICE: " + file.Name + " will be deleted later.");
                }

            }
        }

        private static bool IsFileLocked(string fqn)
        {
            FileInfo finfo = new FileInfo(fqn);
            try
            {
                using (FileStream stream = finfo.Open(FileMode.Open, FileAccess.Read, FileShare.None))
                {
                    stream.Close();
                }
            }
            catch (IOException)
            {
                finfo = null;
                //the file is unavailable because it is:
                //still being written to
                //or being processed by another thread
                //or does not exist (has already been processed)
                return true;
            }
            finfo = null;
            //file is not locked
            return false;
        }

        private static void DeletingFiles(System.IO.DirectoryInfo directory)
        {
            string fqn = "";
            //delete files:
            foreach (System.IO.FileInfo file in directory.GetFiles())
            {

                try
                {
                    fqn = file.FullName;
                    bool FileLocked = IsFileLocked(fqn);
                    if (!FileLocked)
                    {
                        file.Delete();
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("FAILED: Deleting File 022: " + fqn + " -- " + ex.Message);
                    log.write(traceon, "FAILED: Deleting File 022: " + fqn + "-- " + ex.Message);
                }

            }

            ////delete directories in this directory:
            //foreach (System.IO.DirectoryInfo subDirectory in directory.GetDirectories ())
            //    directory.Delete (true);
        }

        private static string ocrfile(string fqn)
        {
            var Ocr = new AdvancedOcr()
            {
                CleanBackgroundNoise = true,
                EnhanceContrast = true,
                EnhanceResolution = true,
                Language = IronOcr.Languages.English.OcrLanguagePack,
                Strategy = IronOcr.AdvancedOcr.OcrStrategy.Advanced,
                ColorSpace = AdvancedOcr.OcrColorSpace.Color,
                DetectWhiteTextOnDarkBackgrounds = true,
                InputImageType = AdvancedOcr.InputTypes.AutoDetect,
                RotateAndStraighten = true,
                ReadBarCodes = true,
                ColorDepth = 4
            };
            //var Ocr = new AutoOcr ();
            var Result = Ocr.Read(fqn);
            return Result.Text;
        }
    }
}