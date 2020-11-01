using System;
using System.IO;
using O2S.Components.PDF4NET;
using O2S.Components.PDF4NET.PDFFile;

namespace ConsoleArchiver
{    
    internal class clsPdf 
    {
        private clsLogging log = new clsLogging ();
        clsOcr OCR = new clsOcr ();

        private bool rc = false;
        private string RetMsg = "";

        private string TempDir = System.Configuration.ConfigurationManager.AppSettings["TEMPDIR"].ToString ();

        public bool ckPdfSearchable ( string PdfFQN )
        {
            bool B = false;
            string EntireFile = "";
            StreamReader   oRead = new StreamReader ( PdfFQN );
            EntireFile = oRead.ReadToEnd ();

            if (EntireFile.Contains ( "FontName" ))
            {
                B = true;
            }

            EntireFile = "";
            oRead.Close ();
            oRead.Dispose ();

            GC.Collect ();
            GC.WaitForPendingFinalizers ();

            return B;
        }

        public string OcrPdfImages ( string WorkingDir, string PdfFQN )
        {
            string ocrText = "";
            try
            {
                Console.WriteLine ( "DD=01" );
                string fqnTempPdfImage = "";

                fqnTempPdfImage = Path.GetFileNameWithoutExtension ( PdfFQN );

                fqnTempPdfImage = WorkingDir + @"\" + fqnTempPdfImage + ".jpg";

                int iCnt = 0;
                string fName = "";

                if (File.Exists ( PdfFQN ))
                {
                    FileInfo fi = new FileInfo ( PdfFQN );
                    fName = fi.Name;
                    fi = null;
                }
                else
                {
                    return "";
                }
                Console.WriteLine ( "DD=02" );
                if (!Directory.Exists ( TempDir ))
                {
                    Directory.CreateDirectory ( TempDir );
                }

                //PdfImages.Clear();
                PDFDocument doc = null;
                Console.WriteLine ( "DD=03" );
                try
                {
                    Console.WriteLine ( "DD=04" );
                    doc = new PDFDocument ( PdfFQN );
                }
                catch (Exception ex)
                {
                    log.write ( "ERROR PDF Load - " + ex.Message );
                    Console.WriteLine ( "ERROR PDF Load - " + ex.Message );
                    return "";
                }

                Console.WriteLine ( "DD=05" );
                string pdfText = "";
                try
                {
                    ocrText = "";
                    Console.WriteLine ( "DD=06" );
                    
                    doc.SerialNumber = "PDF4NET-H7WXK-B98L9-AOP4W-XLTFH-DRBS6";
                    for (int i = 0; i < doc.Pages.Count; i++)
                    {
                        iCnt++;
                        try
                        {
                            Console.WriteLine ( "PDF: " + iCnt.ToString () + " of " + doc.Pages.Count.ToString () );
                            // Convert the pages to PDFImportedPage to get access to ExtractImages method.
                            Console.WriteLine ( "DD=07" );
                            PDFImportedPage ip = doc.Pages[i] as PDFImportedPage;
                            if (iCnt == 1)
                            {
                                pdfText = ip.ExtractText ();
                                ocrText += pdfText + " ";
                            }
                            System.Drawing.Bitmap[] images = ip.ExtractImages ();
                            // Save the page images to disk, if there are any.
                            for (int j = 0; j < images.Length; j++)
                            {
                                string JpgName = fqnTempPdfImage + "." + i.ToString () + ".jpg";
                                images[j].Save ( JpgName, System.Drawing.Imaging.ImageFormat.Jpeg );
                                pdfText = OCR.OcrImage ( JpgName, ref rc, ref RetMsg );
                                ocrText += pdfText + " ";
                                if (File.Exists ( JpgName ))
                                {
                                    File.Delete ( JpgName );
                                }
                            }
                        }
                        catch (Exception ex2)
                        {
                            Console.WriteLine ( "ERROR 22X1: " + ex2.Message );
                        }                        
                    }
                }
                catch (Exception ex)
                {
                    log.write ( "ERROR/PDF 2044: " + ex.Message );
                }
                finally
                {
                    doc.Dispose ();
                    GC.Collect ();
                    GC.WaitForPendingFinalizers ();
                }
            }
            catch (Exception ex1)
            {
                Console.WriteLine ( "PDF ERROR: " + " - " + ex1.Message );
                log.write ( "PDF ERROR: " + PdfFQN + " - " + ex1.Message );
            }

            return ocrText.Trim ();
        }

        ~clsPdf ()
        {
        OCR = null ;
            GC.Collect();
            GC.WaitForPendingFinalizers();
        }
    }
}