using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using Tesseract;
using System.Diagnostics;

/*
 * Location of the Language Data Files:
 * https://github.com/tesseract-ocr/tesseract/wiki/Data-Files#data-files-for-version-302
 * 
*/

namespace OCR_Tesseret
{
    public partial class Form1 : Form
    {
        string fqn = string.Empty;
        string OCrTxt = "";
        bool ParseBlocksBIt = false;

        public Form1 ()
        {
            InitializeComponent ();
        }

        public string ocrGraphic (string fn) {
            int fCount = Directory.GetFiles (@"./tessdata", "*", SearchOption.TopDirectoryOnly).Length;
            var ocr = new TesseractEngine (@"./tessdata", "eng", EngineMode.Default);
            try
            {
                using (var engine = new TesseractEngine (@"./tessdata", "eng", EngineMode.Default))
                {
                    using (var img = Pix.LoadFromFile (fqn))
                    {

                        using (var page = engine.Process (img))
                        {
                            var text = page.GetText ();
                            Console.WriteLine ("Mean confidence: {0}", page.GetMeanConfidence ());
                            OCrTxt = "Mean confidence: " + page.GetMeanConfidence ().ToString ();
                            Console.WriteLine ("Text (GetText): \r\n{0}", text);
                            OCrTxt += Environment.NewLine + text;
                            if (ParseBlocksBIt)
                            {
                                using (var iter = page.GetIterator ())
                                {
                                    iter.Begin ();
                                    do
                                    {
                                        do
                                        {
                                            do
                                            {
                                                do
                                                {
                                                    if (iter.IsAtBeginningOf (PageIteratorLevel.Block))
                                                    {
                                                        Console.WriteLine ("<BLOCK>");
                                                    }

                                                    Console.Write (iter.GetText (PageIteratorLevel.Word));
                                                    Console.Write (" ");

                                                    if (iter.IsAtFinalOf (PageIteratorLevel.TextLine, PageIteratorLevel.Word))
                                                    {
                                                        Console.WriteLine ();
                                                    }
                                                } while (iter.Next (PageIteratorLevel.TextLine, PageIteratorLevel.Word));

                                                if (iter.IsAtFinalOf (PageIteratorLevel.Para, PageIteratorLevel.TextLine))
                                                {
                                                    Console.WriteLine ();
                                                }
                                            } while (iter.Next (PageIteratorLevel.Para, PageIteratorLevel.TextLine));
                                        } while (iter.Next (PageIteratorLevel.Block, PageIteratorLevel.Para));
                                    } while (iter.Next (PageIteratorLevel.Block));
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Trace.TraceError (ex.ToString ());
                Console.WriteLine ("Unexpected Error: " + ex.Message);
                Console.WriteLine ("Details: ");
                Console.WriteLine (ex.ToString ());
            }
            Console.Write ("Press any key to continue . . . ");
            return OCrTxt;
        }

        private void btnOcr_Click (object sender, EventArgs e)
        {
            string txt = ocrGraphic (fqn);
            System.IO.File.WriteAllText (@"C:\temp\ocr\OcrTesseract.txt", txt);
        }

        private void btnImage_Click (object sender, EventArgs e)
        {

            // open file dialog   
            OpenFileDialog open = new OpenFileDialog ();
            // image filters  
            open.Filter = "Image Files(*.jpg; *.jpeg; *.gif; *.bmp)|*.jpg; *.jpeg; *.gif; *.bmp";
            if (open.ShowDialog () == DialogResult.OK)
            {
                fqn = open.FileName;
                // display image in picture box  
                pictureBox1.Image = new Bitmap (open.FileName);
            }
        }

        private void Form1_Load (object sender, EventArgs e)
        {

        }
    }
}
