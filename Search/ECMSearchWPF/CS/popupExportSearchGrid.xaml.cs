// VBConversions Note: VB project level imports
using System.Windows.Input;
using System.Windows.Data;
using System.Windows.Documents;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Windows.Navigation;
using System.Windows.Media.Imaging;
using System.Windows;
using Microsoft.VisualBasic;
using System.Windows.Media;
using System.Collections;
using System;
using System.Windows.Shapes;
using System.Windows.Controls;
using System.Threading.Tasks;
using System.Linq;
using System.Diagnostics;
// End of VB project level imports

using System.IO.IsolatedStorage;
using System.IO;
using Microsoft.Win32;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using System.Text;
using System.Net;
using System.Reflection;

//Imports C1.Silverlight.FlexGrid
//Imports C1.Silverlight.Pdf
//Imports C1.Silverlight.PdfViewer

namespace ECMSearchWPF
{
	public partial class popupExportSearchGrid
	{
		
		clsIsolatedStorage ISO = new clsIsolatedStorage();
		
		string _UserID;
		//Dim GVAR As App = App.Current
		
		public popupExportSearchGrid(DataGrid _dgGrid)
		{
			InitializeComponent();
			
			dgGrid.ItemsSource = _dgGrid.ItemsSource;
			_UserID = _UserID;
			
		}
		
		public void OKButton_Click(object sender, RoutedEventArgs e)
		{
			this.DialogResult = true;
		}
		
		public void CancelButton_Click(object sender, RoutedEventArgs e)
		{
			this.DialogResult = false;
		}
		
		public void ChildWindow_Unloaded(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			Console.WriteLine("Unloaded");
		}
		
		public void btnGraphic_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			Microsoft.Win32.SaveFileDialog fSave = new Microsoft.Win32.SaveFileDialog();
			fSave.ShowDialog();
			
			if (fSave.SafeFileName.Length == 0)
			{
				MessageBox.Show("No \'SAVE AS\' file name specified, returning.");
				return;
			}
			
			if (fSave.SafeFileName.Length > 0)
			{
				generateTiffFile(fSave.SafeFileName);
			}
			
			fSave = null;
			
			GC.Collect();
		}
		
		public void btnExcel_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			Microsoft.Win32.SaveFileDialog fSave = new Microsoft.Win32.SaveFileDialog();
			fSave.ShowDialog();
			
			if (fSave.SafeFileName.Length == 0)
			{
				MessageBox.Show("No \'SAVE AS\' file name specified, returning.");
				return;
			}
			
			if (fSave.SafeFileName.Length > 0)
			{
				generateCsvFile(fSave.SafeFileName);
			}
			
			fSave = null;
			
			GC.Collect();
			
		}
		
		public void btnHtml_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			Microsoft.Win32.SaveFileDialog fSave = new Microsoft.Win32.SaveFileDialog();
			fSave.Filter = "HTML Format (.html)| *.html";
			fSave.ShowDialog();
			
			if (fSave.SafeFileName.Length == 0)
			{
				MessageBox.Show("No SAVE AS file name specified, returning.");
				return;
			}
			
			string FILENAME = fSave.SafeFileName;
			generateHtmlFile(FILENAME);
			GC.Collect();
		}
		
		public void btnText_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			Microsoft.Win32.SaveFileDialog fSave = new Microsoft.Win32.SaveFileDialog();
			fSave.Filter = "Text Format (.txt)| *.txt";
			fSave.ShowDialog();
			
			if (fSave.SafeFileName.Length == 0)
			{
				MessageBox.Show("No SAVE AS file name specified, returning.");
				return;
			}
			
			string FILENAME = fSave.SafeFileName;
			generateTextFile(FILENAME);
			GC.Collect();
			
		}
		
		
		private void CopyStream(MemoryStream memStream, Stream saveStream)
		{
			try
			{
				const int bufferSize = 1024 * 100;
				int count = 0;
				
				long memLength = memStream.Length;
				byte[] buffer = new byte[memLength - 1+ 1];
				
				memStream.Seek(0, SeekOrigin.Begin);
				count = memStream.Read(buffer, 0, memLength);
				
				while (count > 0)
				{
					saveStream.Write(buffer, 0, count);
					count = memStream.Read(buffer, 0, System.Convert.ToInt32(bufferSize));
				}
			}
			catch (Exception ex)
			{
				Console.WriteLine("ERROR CopyStream 001x: " + ex.Message);
				//MessageBox.Show("ERROR CopyStream 001x: " + ex.Message)
			}
			
			
		}
		
		public void btnPdf_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			Microsoft.Win32.SaveFileDialog fSave = new Microsoft.Win32.SaveFileDialog();
			fSave.Filter = "PDF (.pdf)| *.pdf";
			fSave.ShowDialog();
			
			if (fSave.SafeFileName.Length == 0)
			{
				MessageBox.Show("No SAVE AS file name specified, returning.");
				return;
			}
			
			string FILENAME = fSave.SafeFileName;
			BuildReport(FILENAME);
			StartProcessFromIsolatedStorage(FILENAME);
			
		}
		
		/// <summary>
		/// Builds the PDF report using itextsharp as the PDF builder.
		/// </summary>
		/// <param name="FQN">The Fully Qualified File name.</param>
		public void BuildReport(string FQN)
		{
			
			string S = "";
			FileStream fs = new FileStream(FQN, FileMode.Create, FileAccess.Write, FileShare.None);
			Document doc = new Document();
			PdfWriter PDF = PdfWriter.GetInstance(doc, fs);
			Chunk C1 = new Chunk();
			Phrase P = new Phrase();
			PdfContentByte CB = PDF.DirectContent;
			
			P.Clear();
			
			doc.Open();
			
			int XTotal = 0;
			int X = 0;
			int Y = 0;
			int W = 500;
			int H = 700;
			int LineCount = 0;
			
			int iControl = 0;
			int iLines = 0;
			
			Font fXBold = new Font("Arial", 16);
			Font fBold = new Font("Arial", 12);
			Font fNormal = new Font("Arial", 10);
			
			string NewLine = "";
			int II = 0;
			
			X = 30;
			Y = 10;
			Rect r = new Rect(X, Y, W, H);
			XTotal += X;
			
			Dictionary<string, int> COLS = new Dictionary<string, int>();
			string TypeGrid = "CONTENT";
			int iCol = 0;
			int iTgtCol = -1;
			foreach (DataGridColumn COL in dgGrid.Columns)
			{
				if (COL.Header.ToUpper.Equals("SUBJECT"))
				{
					TypeGrid = "EMAIL";
					iTgtCol = iCol;
				}
				if (COL.Header.ToUpper.Equals("SOURCENAME"))
				{
					TypeGrid = "CONTENT";
					iTgtCol = iCol;
				}
				COLS.Add(COL.Header, iCol);
				iCol++;
			}
			
			string sResponse = "";
			
			
			NewLine = TypeGrid + " Search List " + DateTime.Now.ToString();
			CB.LineTo(5, 50);
			CB.Stroke();
			C1.Append(NewLine);
			
			NewLine = "__________________________________________________________________";
			C1.Append(NewLine);
			doc.Add(C1);
			
			Y += 20;
			
			int iCnt = 0;
			string sTitle = "";
			
			int iRow = 0;
			iCol = 0;
			foreach (DataGridRow DR in dgGrid.Items)
			{
				iCnt++;
				iCol = 0;
				foreach (string sKey in COLS.Keys)
				{
					iCol++;
					if (iCol == 1)
					{
						X = 30;
						Y += 15;
						r.X = X;
						r.Y = Y;
						sTitle = sKey + " / " + DR.Item(sKey).ToString() + " : Item " + iCnt.ToString() + " of " + dgGrid.Items.Count.ToString();
						NewLine = "__________________________________________________________________";
						P.Clear();
						P.Add(NewLine);
						doc.Add(P);
						P.Clear();
					}
					else
					{
						X = 75;
						Y += 15;
						r.X = X;
						r.Y = Y;
						string tVal = DR.Item(sKey).ToString();
						if (tVal.Trim().Length > 65)
						{
							tVal = (string) (tVal.Substring(0, 65) + "...");
						}
						if (tVal.Trim().Length > 0)
						{
							P.Clear();
							NewLine = sKey + " / " + tVal;
							P.Add(NewLine);
							doc.Add(P);
							P.Clear();
						}
					}
				}
			}
			
			
			X = 100;
			Y += 25;
			r.X = X;
			r.Y = Y;
			
			P.Clear();
			NewLine = (string) ("Print Date: " + DateTime.Now.ToShortDateString());
			P.Add(NewLine);
			doc.Add(P);
			P.Clear();
			doc.Add(P);
			
			LineCount++;
			
			doc.Close();
			
			IsolatedStorageFile isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User || IsolatedStorageScope.Assembly, null, null);
			
			using (IsolatedStorageFileStream isoStream = new IsolatedStorageFileStream(FQN, FileMode.CreateNew, isoStore))
			{
				using (StreamWriter writer = new StreamWriter(isoStream))
				{
					writer.WriteLine(doc);
				}
				
			}
			
			
		}
		
		public void btnOpenFile_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			//PdfViewer.Visibility = Visibility.Collapsed
			
		}
		
		protected void generateHtmlFile(string FQN)
		{
			dgGrid.SelectAllCells();
			dgGrid.ClipboardCopyMode = DataGridClipboardCopyMode.IncludeHeader;
			
			ApplicationCommands.Copy.Execute(null, dgGrid);
			dgGrid.UnselectAllCells();
			
			string result = Clipboard.GetData(DataFormats.Html).ToString();
			
			Clipboard.Clear();
			
			System.IO.StreamWriter file = new System.IO.StreamWriter(FQN);
			file.WriteLine(result);
			file.Close();
		}
		
		protected void generateCsvFile(string FQN)
		{
			dgGrid.SelectAllCells();
			dgGrid.ClipboardCopyMode = DataGridClipboardCopyMode.IncludeHeader;
			
			ApplicationCommands.Copy.Execute(null, dgGrid);
			dgGrid.UnselectAllCells();
			
			string result = Clipboard.GetData(DataFormats.CommaSeparatedValue).ToString();
			
			Clipboard.Clear();
			
			System.IO.StreamWriter file = new System.IO.StreamWriter(FQN);
			file.WriteLine(result);
			file.Close();
		}
		protected void generateTextFile(string FQN)
		{
			dgGrid.SelectAllCells();
			dgGrid.ClipboardCopyMode = DataGridClipboardCopyMode.IncludeHeader;
			
			ApplicationCommands.Copy.Execute(null, dgGrid);
			dgGrid.UnselectAllCells();
			
			string result = Clipboard.GetData(DataFormats.UnicodeText).ToString();
			
			Clipboard.Clear();
			
			System.IO.StreamWriter file = new System.IO.StreamWriter(FQN);
			file.WriteLine(result);
			file.Close();
		}
		protected void generateTiffFile(string FQN)
		{
			dgGrid.SelectAllCells();
			dgGrid.ClipboardCopyMode = DataGridClipboardCopyMode.IncludeHeader;
			
			ApplicationCommands.Copy.Execute(null, dgGrid);
			dgGrid.UnselectAllCells();
			
			string result2 = Clipboard.GetData(DataFormats.Bitmap).ToString();
			string result = Clipboard.GetData(DataFormats.Tiff).ToString();
			
			Clipboard.Clear();
			
			System.IO.StreamWriter file = new System.IO.StreamWriter(FQN);
			file.WriteLine(result);
			file.Close();
		}
		
		public void StartProcessFromIsolatedStorage(string isolatedFilePath)
		{
			//System.IO.IsolatedStorage.IsolatedStorageFile isolatedStorageFile = System.IO.IsolatedStorage.IsolatedStorageFile.GetUserStoreForAssembly();
			System.IO.IsolatedStorage.IsolatedStorageFile isolatedStorageFile = System.IO.IsolatedStorage.IsolatedStorageFile.GetUserStoreForDomain();
			
			if (! isolatedStorageFile.FileExists(isolatedFilePath))
			{
				throw (new FileNotFoundException(isolatedFilePath));
			}
			
			Type isolatedStorageType = isolatedStorageFile.GetType();
			System.Reflection.PropertyInfo piRootDirectory = isolatedStorageType.GetProperty("RootDirectory", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);
			string fullPath = System.IO.Path.Combine((string) (piRootDirectory.GetValue(isolatedStorageFile, null).ToString()), isolatedFilePath);
			System.Diagnostics.Process.Start(fullPath);
		}
		
	}
	
}
