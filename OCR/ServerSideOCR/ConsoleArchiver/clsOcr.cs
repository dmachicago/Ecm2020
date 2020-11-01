using System;
using System.IO;

namespace ConsoleArchiver
{
    internal class clsOcrModi
    {

        bool traceon = MainPage.traceon;

        clsLogging log = new clsLogging ();

        public string OcrImageMODI ( string FQN, ref bool rc, ref string RetMsg )
        {
            rc = true;
            string strText = "";
            try
            {
                if (File.Exists ( FQN ))
                {
                    MODI.Document md = new MODI.Document ();
                    md.Create ( FQN );
                    md.OCR ( MODI.MiLANGUAGES.miLANG_ENGLISH, true, true );
                    MODI.Image image = (MODI.Image)md.Images[0];

                    strText = image.Layout.Text;

                    md.Close();
                    md = null;
                }
                else
                {
                    log.write (traceon, "ERROR 1133: File Missing: " + FQN );
                }
            }
            catch (Exception exc)
            {
                RetMsg = "OCR Failed: " + exc.Message;
                rc = false;
            }
            finally
            {
                GC.Collect ();
                GC.WaitForPendingFinalizers ();                            
            }
            return strText;
        }
    }
}