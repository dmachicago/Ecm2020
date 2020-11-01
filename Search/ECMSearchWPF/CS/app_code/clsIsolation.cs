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

using System.IO;
using System.IO.IsolatedStorage;
//using System.IO.IsolatedStorage.IsolatedStorageFile;
//using System.IO.IsolatedStorage.IsolatedStorageFileStream;

//Imports System.Windows.Browser.HtmlPage

namespace ECMSearchWPF
{
	public class clsIsolation
	{
		
		private IsolatedStorageFile Root;
		private string rName;
		
		public clsIsolation(string RootName)
		{
			rName = RootName;
			Root = IsolatedStorageFile.GetUserStoreForApplication();
			if (! Directory.Exists(RootName))
			{
				Root.CreateDirectory(RootName);
			}
			
		}
		
		public string[] GetFiles(string sPattern)
		{
			string[] returnValue;
			returnValue = Root.GetFileNames(sPattern);
			return returnValue;
		}
		
		public string[] GetDirectories(string sPattern)
		{
			string[] returnValue;
			returnValue = Root.GetDirectoryNames(sPattern);
			return returnValue;
		}
		
		public void CreateDirectories(string dPath)
		{
			Root.CreateDirectory(dPath);
		}
		
		public void DeleteFile(string fPath)
		{
			Root.DeleteFile(fPath);
		}
		
		public void DeleteDirectory(string dPath)
		{
			Root.DeleteDirectory(dPath);
		}
		
		public IsolatedStorageFileStream CreateFile(string FileName, byte[] data = null)
		{
			IsolatedStorageFileStream returnValue;
			returnValue = new IsolatedStorageFileStream(FileName, System.IO.FileMode.Create, System.IO.FileAccess.ReadWrite, Root);
			if (data != null)
			{
				System.IO.IsolatedStorage.IsolatedStorageFile.CreateFile().Write(data, 0, data.Length);
				System.IO.IsolatedStorage.IsolatedStorageFile.CreateFile().Seek(0, System.IO.SeekOrigin.Begin);
			}
			System.IO.IsolatedStorage.IsolatedStorageFile.CreateFile().Close();
			return System.IO.IsolatedStorage.IsolatedStorageFile.CreateFile();
		}
		
		public byte[] ReadFile(string fPath)
		{
			byte[] returnValue;
			if (! File.Exists(fPath))
			{
				return null;
			}
			var p = new IsolatedStorageFileStream(fPath, System.IO.FileMode.Open, System.IO.FileAccess.Read, Root);
			returnValue = new byte[1024];
			p.Read(returnValue, 0, System.Convert.ToInt32(returnValue.Length));
			p.Close();
			return returnValue;
		}
		
		public IsolatedStorageFileStream WriteToFile(string fPath, byte[] data)
		{
			IsolatedStorageFileStream returnValue;
			returnValue = new IsolatedStorageFileStream(fPath, System.IO.FileMode.Open, System.IO.FileAccess.Write, Root);
			returnValue.Write(data, 0, data.Length);
			returnValue.Seek(0, System.IO.SeekOrigin.Begin);
			returnValue.Close();
			return returnValue;
		}
		
	}
	
}
